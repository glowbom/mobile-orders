/*
 * Created on 4/28/20 3:12 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.model

import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Query

const val EXTRA_URL = "macros/s/AKfycbwcZDPrkc3UrVpLGr8yo6IJBf2IaP5_nmz8FS_deLnY50U4MQoO/exec"

interface ItemsApi {

    @GET(EXTRA_URL)
    fun getItems(): Single<Data>

    @GET(EXTRA_URL)
    fun addOrder(@Query("data") data : String): Single<Success>
}