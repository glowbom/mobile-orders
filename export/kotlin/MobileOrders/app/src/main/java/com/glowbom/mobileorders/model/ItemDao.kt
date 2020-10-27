/*
 * Created on 4/28/20 3:12 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.model

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query

@Dao
interface ItemDao {
    @Insert
    suspend fun insertAll(vararg items: Item): List<Long>

    @Query("SELECT * FROM item")
    suspend fun getAllItems(): List<Item>

    @Query("SELECT * FROM item WHERE uuid = :itemId")
    suspend fun getItem(itemId: Int): Item

    @Query("DELETE FROM item")
    suspend fun deleteAllItems()
}