package com.pyro.sms_telephony_fallback

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin

class TelephonyFallbackPlugin : FlutterPlugin, TelephonyFallbackHostApi {
    private var context: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        TelephonyFallbackHostApi.setUp(binding.binaryMessenger, this)
        SmsFallbackReceiver.messenger = binding.binaryMessenger
    }

    override fun isSmsPermissionGranted(): Boolean {
        val ctx = context ?: return false
        return ContextCompat.checkSelfPermission(
            ctx,
            Manifest.permission.RECEIVE_SMS
        ) == PackageManager.PERMISSION_GRANTED
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        TelephonyFallbackHostApi.setUp(binding.binaryMessenger, null)
        SmsFallbackReceiver.messenger = null
        context = null
    }
}
