/*
 * Created on 5/1/20 4:25 PM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.model

class AppManager (
    var settings: Settings?,
    var name: String,
    var phone: String,
    var address: String,
    private val data: MutableList<Item>,
    private var total: Float
) {
    companion object {
        val instance = AppManager( null,"", "", "", mutableListOf(), 0f)
    }

    fun addOrder(order: Item) {
       data.add(order);
        order.let {
            order.price.let {
                total += order.price!!
            }
        }
    }

    fun clear() {
        total = 0f
        data.clear()
    };

    fun getTotal() : Float {
        return total;
    };

    fun getData() : MutableList<Item> {
        return data;
    };
}