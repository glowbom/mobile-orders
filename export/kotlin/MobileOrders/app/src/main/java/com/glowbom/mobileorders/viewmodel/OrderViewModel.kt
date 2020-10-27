/*
 * Created on 5/11/20 5:44 PM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.viewmodel

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.glowbom.mobileorders.model.CheckoutDatabase
import com.glowbom.mobileorders.model.Item
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class OrderViewModel : ViewModel() {
    val items = MutableLiveData<List<Item>>()

    fun refresh(context: Context) {
        GlobalScope.launch {
            val newItems = CheckoutDatabase(context).itemDao().getAllItems()
            items.postValue(newItems)
        }
    }
}
