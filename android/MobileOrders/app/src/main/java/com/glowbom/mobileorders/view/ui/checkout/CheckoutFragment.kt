/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.checkout

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.model.AppManager
import com.glowbom.mobileorders.view.ui.orders.ListAdapter
import com.glowbom.mobileorders.viewmodel.CheckoutViewModel
import kotlinx.android.synthetic.main.fragment_checkout.*


class CheckoutFragment : Fragment() {

    private val listAdapter =
        ListAdapter(arrayListOf())

    private lateinit var checkoutViewModel: CheckoutViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        checkoutViewModel =
            ViewModelProvider(this).get(CheckoutViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_checkout, container, false)
        val textView: TextView = root.findViewById(R.id.text_total_ordered)
        checkoutViewModel.text.observe(viewLifecycleOwner, Observer {
            textView.text = it
        })
        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        listAdapter.clickable = false
        list.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = listAdapter
        }

        nameInput.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable) {}
            override fun beforeTextChanged(
                s: CharSequence, start: Int,
                count: Int, after: Int
            ) {
            }

            override fun onTextChanged(
                s: CharSequence, start: Int,
                before: Int, count: Int
            ) {
                if (s.length != 0) {
                    AppManager.instance.name = nameInput.text.toString()
                }
            }
        })

        clearButton.setOnClickListener() {
            AppManager.instance.clear()
            checkoutViewModel.refresh()
        }

        observeViewModel()

        checkoutViewModel.refresh()
    }

    private fun observeViewModel() {
        checkoutViewModel.items.observe(viewLifecycleOwner, Observer { items ->
            items?.let {
                list.visibility = View.VISIBLE
                listAdapter.updateList(items)
            }
        })

        checkoutViewModel.name.observe(viewLifecycleOwner, Observer { name ->
            name?.let {
                nameInput.setText(name)
            }
        })
    }
}
