/*
 * Created on 4/28/20 3:14 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.viewmodel

import android.app.Application
import androidx.lifecycle.MutableLiveData
import com.glowbom.mobileorders.model.Item
import com.glowbom.mobileorders.model.ItemDatabase
import kotlinx.coroutines.launch

class DetailViewModel(application: Application): BaseViewModel(application) {

    val liveData = MutableLiveData<Item>()

    fun fetch(uuid: Int) {
        launch {
            val item = ItemDatabase(getApplication()).itemDao().getItem(uuid)
            liveData.value = item
        }
    }
}