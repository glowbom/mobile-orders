/*
 * Created on 5/11/20 5:39 PM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.orders

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager

import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.viewmodel.OrderViewModel
import kotlinx.android.synthetic.main.fragment_checkout.*

class OrderFragment : Fragment() {

    private val listAdapter =
        ListAdapter(arrayListOf())

    private lateinit var viewModel: OrderViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel = ViewModelProvider(this).get(OrderViewModel::class.java)

        return inflater.inflate(R.layout.fragment_order, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        listAdapter.clickable = false
        list.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = listAdapter
        }

        observeViewModel()

        viewModel.refresh(requireContext())
    }

    private fun observeViewModel() {
        viewModel.items.observe(viewLifecycleOwner, Observer { items ->
            items?.let {
                list.visibility = View.VISIBLE
                listAdapter.updateList(items)
            }
        })
    }

}
