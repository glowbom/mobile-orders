/*
 * Created on 4/28/20 3:12 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.model

import io.reactivex.Single
import retrofit2.http.GET

interface ItemsApi {
    @GET("macros/s/AKfycbzpcDZYAP71FNvU8kHQG_KBd624DnYrcJfPvKJUCYpDyJEyejs/exec")
    fun getItems(): Single<Data>
}