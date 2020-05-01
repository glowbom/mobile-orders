/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.list

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle
import android.view.*
import android.webkit.WebChromeClient
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.palette.graphics.Palette
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.databinding.FragmentDetailBinding
import com.glowbom.mobileorders.databinding.SendSmsDialogBinding
import com.glowbom.mobileorders.model.AppManager
import com.glowbom.mobileorders.model.Item
import com.glowbom.mobileorders.model.ItemPalette
import com.glowbom.mobileorders.model.SmsInfo
import com.glowbom.mobileorders.util.getProgressDrawable
import com.glowbom.mobileorders.util.loadImage
import com.glowbom.mobileorders.view.MainActivity
import com.glowbom.mobileorders.viewmodel.DetailViewModel
import kotlinx.android.synthetic.main.fragment_detail.*

class DetailFragment : Fragment() {

    private lateinit var viewModel: DetailViewModel
    private var itemUid = 0

    private lateinit var dataBinding: FragmentDetailBinding
    private var sendSmsStarted = false
    private var currentItem: Item? = null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        setHasOptionsMenu(true)
        dataBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_detail, container, false)
        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            itemUid = DetailFragmentArgs.fromBundle(it).itemUid
        }

        viewModel = ViewModelProvider(this).get(DetailViewModel::class.java)
        viewModel.fetch(itemUid)


        orderButton.setOnClickListener() {
            currentItem.let {
                AppManager.instance.addOrder(currentItem!!)
                updateTotalOrders()
            }
        }

        updateTotalOrders()
        observeViewModel()
    }

    private fun updateTotalOrders() {
        total.text =
            String.format(getString(R.string.total_format), AppManager.instance.getTotal());
    }

    private fun observeViewModel() {
        viewModel.liveData.observe(viewLifecycleOwner, Observer { item ->
            item?.let {



                //webview.settings.javaScriptEnabled = true
                webview.settings.useWideViewPort = true
                webview.settings.loadWithOverviewMode = true
                webview.goBack()
                webview.webChromeClient = WebChromeClient()

                currentItem = item
                dataBinding.item = it
                context?.let {
                    image.loadImage(item.imageUrl, getProgressDrawable(it))

                    item.imageUrl?.let {
                        if (item.imageUrl.contains("youtube")) {
                            startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(item.imageUrl)))

                            val imageUrl = item.imageUrl.replace("https://www.youtube.com/embed/", "https://img.youtube.com/vi/") + "/0.jpg";
                            webview.loadUrl(imageUrl)
                        } else {
                            webview.loadUrl(item.imageUrl)
                        }


                    }




                }

                it.imageUrl?.let {
                    //setupBackgroundColor(it)
                }
            }
        })
    }

    private fun setupBackgroundColor(url: String) {
        Glide.with(this)
            .asBitmap()
            .load(url)
            .into(object : CustomTarget<Bitmap>() {
                override fun onLoadCleared(placeholder: Drawable?) {
                }

                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                    Palette.from(resource).generate { palette ->
                        val intColor = palette?.lightMutedSwatch?.rgb ?: 0
                        val newPalette = ItemPalette(intColor)
                        dataBinding.palette = newPalette
                    }
                }

            })
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater.inflate(R.menu.detail_menu, menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.action_send_text -> {
                sendSmsStarted = true
                (activity as MainActivity).checkSmsPermission()
            }
            R.id.action_share -> {
                val intent = Intent(Intent.ACTION_SEND)
                intent.type = "text/plain"
                intent.putExtra(Intent.EXTRA_SUBJECT, "Look what I found")
                intent.putExtra(Intent.EXTRA_TEXT, "${currentItem?.title} is for ${currentItem?.video}")
                //intent.putExtra(Intent.EXTRA_STREAM, currentItem?.imageUrl)
                startActivity(Intent.createChooser(intent, "Share with"))
            }
        }

        return super.onOptionsItemSelected(item)
    }

    fun onPermissionResult(permissionGranted: Boolean) {
        if (sendSmsStarted && permissionGranted) {
            context?.let {
                val smsInfo = SmsInfo(
                    "",
                    "${currentItem?.title} is for ${currentItem?.video}",
                    currentItem?.imageUrl
                )
                val dialogBinding = DataBindingUtil.inflate<SendSmsDialogBinding>(
                    LayoutInflater.from(it),
                    R.layout.send_sms_dialog,
                    null,
                    false
                )

                AlertDialog.Builder(it)
                    .setView(dialogBinding.root)
                    .setPositiveButton("Send SMS") { dialog, which ->
                        if (!dialogBinding.smsDestination.text.isNullOrEmpty()) {
                            smsInfo.to = dialogBinding.smsDestination.text.toString()
                            sendSms(smsInfo)
                        }
                    }
                    .setNegativeButton("Cancel") {dialog, which ->  }
                    .show()

                dialogBinding.smsInfo = smsInfo
            }
        }
    }

    private fun sendSms(smsInfo: SmsInfo) {
        /*
        val intent = Intent(context, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)
        val sms = SmsManager.getDefault()
        sms.sendTextMessage(smsInfo.to, null, smsInfo.text, pendingIntent, null)
         */
    }
}
