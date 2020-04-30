/*
 * Created on 4/28/20 3:14 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.viewmodel

import android.app.Application
import android.widget.Toast
import androidx.lifecycle.MutableLiveData
import com.glowbom.mobileorders.model.Data
import com.glowbom.mobileorders.model.Item
import com.glowbom.mobileorders.model.ItemDatabase
import com.glowbom.mobileorders.model.ItemsApiService
import com.glowbom.mobileorders.util.NotificationsHelper
import com.glowbom.mobileorders.util.SharedPreferencesHelper
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.launch
import java.lang.NumberFormatException

class ListViewModel(application: Application) : BaseViewModel(application) {

    private var prefHelper = SharedPreferencesHelper(getApplication())
    private var refreshTime = 5 * 60 * 1000 * 1000 * 1000L // 5 min in nano sec

    private val itemsService = ItemsApiService()
    private val disposable = CompositeDisposable()

    val items = MutableLiveData<List<Item>>()
    val itemsLoadError = MutableLiveData<Boolean>()
    val loading = MutableLiveData<Boolean>()

    fun refresh() {
        checkCacheDuration()
        val updateTime = prefHelper.getUpdateTime()
        if (updateTime != null && updateTime != 0L && System.nanoTime() - updateTime < refreshTime) {
            fetchFromDatabase()
        } else {
            fetchFromRemote()
        }
    }

    private fun checkCacheDuration() {
        val cachePreference = prefHelper.getCacheDuration()

        try {
            val cachePreferenceInt = cachePreference?.toInt() ?: 5*60
            refreshTime = cachePreferenceInt.times(1000 * 1000 * 1000L)
        } catch (e: NumberFormatException) {
            e.printStackTrace()
        }
    }

    fun refreshBypassCache() {
        fetchFromRemote()
    }

    private fun fetchFromDatabase() {
        loading.value = true
        launch {
            val items = ItemDatabase(getApplication()).itemDao().getAllItems()
            itemsRetrieved(items)
            Toast.makeText(getApplication(), "Items retrieved from database", Toast.LENGTH_SHORT).show()
        }
    }

    private fun fetchFromRemote() {
        loading.value = true
        disposable.add(
            itemsService.getItems()
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(object: DisposableSingleObserver<Data>() {
                    override fun onSuccess(newItems: Data) {
                        storeItemsLocally(newItems.data)
                        Toast.makeText(getApplication(), "Items retrieved from endpoint", Toast.LENGTH_SHORT).show()
                        NotificationsHelper(getApplication()).createNotification()
                    }

                    override fun onError(e: Throwable) {
                        itemsLoadError.value = true
                        loading.value = false
                        e.printStackTrace()
                    }

                })
        )
    }

    private fun storeItemsLocally(newItems: List<Item>) {
        launch {
            val dao = ItemDatabase(getApplication()).itemDao()
            dao.deleteAllItems()
            val result: List<Long> = dao.insertAll(*newItems.toTypedArray())
            var i = 0
            while (i < newItems.size) {
                newItems[i].uuid = result[i].toInt()

                //if (newItems[i].imageUrl?.contains("youtube") == true) {
                //    newItems[i].video = newItems[i].imageUrl;
                //}
                ++i;
            }
            itemsRetrieved(newItems)
        }
        prefHelper.saveUpdateTime(System.nanoTime())
    }

    private fun itemsRetrieved(newItems: List<Item>) {
        items.value = newItems
        itemsLoadError.value = false
        loading.value = false
    }

    override fun onCleared() {
        super.onCleared()
        disposable.clear()
    }
}