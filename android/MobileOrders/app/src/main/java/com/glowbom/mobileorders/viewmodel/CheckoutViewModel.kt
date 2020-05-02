/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.glowbom.mobileorders.model.AppManager
import com.glowbom.mobileorders.model.Item

class CheckoutViewModel : ViewModel() {

    val items = MutableLiveData<List<Item>>()

    private val _text = MutableLiveData<String>().apply {
        value = String.format("Total Ordered: \$%,.2f", AppManager.instance.getTotal())
    }
    val text: MutableLiveData<String> = _text

    private val _name = MutableLiveData<String>().apply {
        value = AppManager.instance.name
    }
    val name: MutableLiveData<String> = _name

    fun refresh() {
        name.value = AppManager.instance.name
        text.value = String.format("Total Ordered: \$%,.2f", AppManager.instance.getTotal())
        items.value = AppManager.instance.getData()
    }
}