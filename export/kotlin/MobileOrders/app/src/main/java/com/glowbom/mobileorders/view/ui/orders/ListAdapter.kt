/*
 * Created on 5/1/20 8:10 PM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.orders

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.databinding.ItemListBinding
import com.glowbom.mobileorders.model.AppManager
import com.glowbom.mobileorders.model.Item
import kotlinx.android.synthetic.main.item_list.view.*
import kotlinx.android.synthetic.main.item_list_header.view.*

class ListItem(
    var item: Item?,
    var title: String?
) {

}

private val ITEM_VIEW_TYPE_HEADER = 0
private val ITEM_VIEW_TYPE_ITEM = 1

class ListAdapter(val list: ArrayList<ListItem>) : RecyclerView.Adapter<RecyclerView.ViewHolder>(),
    ItemClickListener {

    var clickable: Boolean = true

    fun updateList(newList: List<Item>) {
        list.clear()

        val dictionary = HashMap<String, MutableList<Item>>()

        newList.forEach {
            val currentItem = it
            it.category?.let {
                if (dictionary.containsKey(it)) {
                    val value = dictionary[it]
                    value!!.add(currentItem)
                } else {
                    val value = mutableListOf<Item>()
                    value.add(currentItem)
                    dictionary.put(it, value)
                }
            }
        }


        dictionary.keys.forEach {
            list.add(ListItem(null, it))
            dictionary[it]?.forEach {
                list.add(ListItem(it, null))
            }
        }

        if (list.size == 0) {
            newList.forEach {
                list.add(ListItem(it, null))
            }
        }

        notifyDataSetChanged()
    }

    class ItemViewHolder(var view: ItemListBinding) : RecyclerView.ViewHolder(view.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val inflater = LayoutInflater.from(parent.context)

        if (viewType == ITEM_VIEW_TYPE_ITEM) {
            val view = DataBindingUtil.inflate<ItemListBinding>(inflater, R.layout.item_list, parent, false)
            return ItemViewHolder(
                view
            )
        } else {
            return TextViewHolder.from(parent)
        }
    }

    class TextViewHolder(view: View): RecyclerView.ViewHolder(view) {
        companion object {
            fun from(parent: ViewGroup): TextViewHolder {
                val layoutInflater = LayoutInflater.from(parent.context)
                val view = layoutInflater.inflate(R.layout.item_list_header, parent, false)
                return TextViewHolder(view)
            }
        }
    }

    override fun getItemViewType(position: Int): Int {
        list[position].item?.let {
            return ITEM_VIEW_TYPE_ITEM
        }

        return ITEM_VIEW_TYPE_HEADER
    }

    override fun getItemCount() = list.size

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ItemViewHolder) {
            holder.view.item = list[position].item
            holder.view.listener = this

            AppManager.instance.settings?.let {
                if (it.thumnails != null && it.thumnails) {
                    holder.view.imageView.visibility = View.VISIBLE
                }
            }
        } else if (holder is TextViewHolder) {
            holder.itemView.header.text = list[position].title
        }


    }

    override fun onItemClicked(v: View) {
        if (clickable) {
            val action = ListFragmentDirections.actionDetailFragment();
            action.itemUid = v.itemId.text.toString().toInt()
            Navigation.findNavController(v).navigate(action)
        }
    }

}