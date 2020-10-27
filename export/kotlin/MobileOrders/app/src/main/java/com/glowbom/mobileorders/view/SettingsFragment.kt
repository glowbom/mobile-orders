/*
 * Created on 4/28/20 3:14 AM
 *
 * Copyright 2020 Glowbom, Inc.
 */

package com.glowbom.mobileorders.view

import android.os.Bundle
import androidx.preference.PreferenceFragmentCompat

import com.glowbom.mobileorders.R

class SettingsFragment : PreferenceFragmentCompat() {

    override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
        setPreferencesFromResource(R.xml.preferences, rootKey)
    }

}
