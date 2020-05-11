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

data class Success(
    @SerializedName("success")
    val success: Boolean
) {

}

data class Data(
    @SerializedName("data")
    val data: List<Item>,
    @SerializedName("settings")
    val settings: Settings
) {

}

data class Settings(
    @SerializedName("thumnails")
    val thumnails: Boolean?,
    @SerializedName("name")
    val name: Boolean?,
    @SerializedName("address")
    val address: Boolean?,
    @SerializedName("phonenumber")
    val phonenumber: Boolean?,
    @SerializedName("pastorders")
    val pastorders: Boolean?,
    @SerializedName("notifications")
    val notifications: Boolean?,
    @SerializedName("categories")
    val categories: Boolean?,
    @SerializedName("choice1")
    val choice1: Boolean?,
    @SerializedName("choice2")
    val choice2: Boolean?
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
    val video: String?,

    @ColumnInfo(name = "subtitle")
    @SerializedName("subtitle")
    val subtitle: String?,

    @SerializedName("desciption")
    val description: String?,

    @SerializedName("group")
    val group: String?,

    @SerializedName("price")
    val price: Float?,

    @SerializedName("count")
    val count: Int?,

    @ColumnInfo(name = "image_url")
    @SerializedName("media")
    val imageUrl: String?,

    @SerializedName("choice1")
    var choice1: String?,

    @SerializedName("choice2")
    var choice2: String?,

    @SerializedName("category")
    val category: String?
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