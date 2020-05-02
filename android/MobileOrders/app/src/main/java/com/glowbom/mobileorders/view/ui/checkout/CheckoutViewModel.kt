/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.checkout

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.model.AppManager

class CheckoutViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = String.format("Total Ordered: \$%,.2f", AppManager.instance.getTotal());
    }
    val text: MutableLiveData<String> = _text
}