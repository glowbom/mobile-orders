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
import com.glowbom.mobileorders.model.Item
import kotlinx.android.synthetic.main.item_list.view.*

class ListAdapter(val list: ArrayList<Item>) : RecyclerView.Adapter<ListAdapter.ItemViewHolder>(),
    ItemClickListener {

    fun updateList(newList: List<Item>) {
        list.clear()
        list.addAll(newList)
        notifyDataSetChanged()
    }

    class ItemViewHolder(var view: ItemListBinding) : RecyclerView.ViewHolder(view.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = DataBindingUtil.inflate<ItemListBinding>(inflater, R.layout.item_list, parent, false)
        return ItemViewHolder(
            view
        )
    }

    override fun getItemCount() = list.size

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        holder.view.item = list[position]
        holder.view.listener = this
    }

    override fun onItemClicked(v: View) {
        val action = ListFragmentDirections.actionDetailFragment();
        action.itemUid = v.itemId.text.toString().toInt()
        Navigation.findNavController(v).navigate(action)
    }

}