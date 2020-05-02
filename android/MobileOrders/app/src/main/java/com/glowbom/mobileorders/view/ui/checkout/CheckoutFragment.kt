/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.checkout

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.model.AppManager
import kotlinx.android.synthetic.main.fragment_checkout.*

class CheckoutFragment : Fragment() {

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

        clearButton.setOnClickListener() {
            AppManager.instance.clear()
            checkoutViewModel.text.value = String.format("Total Ordered: \$%,.2f", AppManager.instance.getTotal())
        }
    }
}
