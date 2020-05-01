/*
 * Created on 4/28/20 3:13 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view.ui.list

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.Navigation
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.glowbom.mobileorders.R
import com.glowbom.mobileorders.view.ListAdapter
import com.glowbom.mobileorders.viewmodel.ListViewModel
import kotlinx.android.synthetic.main.fragment_list.*


/*
 * Created on 4/4/20 12:11 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */
class ListFragment : Fragment() {

    private lateinit var viewModel : ListViewModel
    private val listAdapter = ListAdapter(arrayListOf())

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        setHasOptionsMenu(true)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(ListViewModel::class.java)
        viewModel.refresh()

        list.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = listAdapter
        }

        refreshLayout.setOnRefreshListener {
            list.visibility = View.GONE
            listError.visibility = View.GONE
            loadingView.visibility = View.VISIBLE
            viewModel.refreshBypassCache()
            refreshLayout.isRefreshing = false
        }

        list.addItemDecoration(
            DividerItemDecoration(
                list.context,
                DividerItemDecoration.VERTICAL
            )
        )

        observeViewModel()
    }

    private fun observeViewModel() {
        viewModel.items.observe(viewLifecycleOwner, Observer { items ->
            items?.let {
                list.visibility = View.VISIBLE
                listAdapter.updateList(items)
            }
        })

        viewModel.itemsLoadError.observe(viewLifecycleOwner, Observer { isError ->
            isError?.let {
                listError.visibility = if(it) View.VISIBLE else View.GONE;
            }
        })

        viewModel.loading.observe(viewLifecycleOwner, Observer { isLoading ->
            isLoading?.let {
                loadingView.visibility = if(it) View.VISIBLE else View.GONE;
                if(it) {
                    listError.visibility = View.GONE
                    list.visibility = View.GONE
                }
            }
        })
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater.inflate(R.menu.list_menu, menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when(item.itemId) {
            R.id.actionSettings -> {
                view?.let { Navigation.findNavController(it).navigate(ListFragmentDirections.actionSettings()) }
            }
        }

        return super.onOptionsItemSelected(item)
    }
}
