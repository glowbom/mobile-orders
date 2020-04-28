/*
 * Created on 4/28/20 3:12 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

data class Data(
    @SerializedName("data")
    val data: List<Item>
) {

}

@Entity
data class Item(
    @ColumnInfo(name = "item_id")
    @SerializedName("id")
    val itemId: String?,

    @ColumnInfo(name = "title")
    @SerializedName("product")
    val title: String?,

    @ColumnInfo(name = "video")
    @SerializedName("video")
    var video: String?,

    @ColumnInfo(name = "subtitle")
    @SerializedName("subtitle")
    val subtitle: String?,

    @SerializedName("description")
    val description: String?,

    @SerializedName("group")
    val group: String?,

    @SerializedName("price")
    val price: Float?,

    @SerializedName("count")
    val count: Int?,

    @ColumnInfo(name = "image_url")
    @SerializedName("media")
    val imageUrl: String?
) {
    @PrimaryKey(autoGenerate = true)
    var uuid: Int = 0
}

data class ItemPalette (var color: Int)

data class SmsInfo(
    var to: String,
    var text: String,
    var imageUrl: String?
)