package com.pyro.sms_telephony_fallback

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class TelephonyFallbackPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "net.pyro.telephony/sms_fallback")
        channel.setMethodCallHandler(this)
        SmsFallbackReceiver.messenger = binding.binaryMessenger
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val ctx = context
        if (ctx == null) {
            result.error("NO_CONTEXT", "Application context is null", null)
            return
        }

        when (call.method) {
            "isSmsPermissionGranted" -> {
                val granted = ContextCompat.checkSelfPermission(
                    ctx,
                    Manifest.permission.RECEIVE_SMS
                ) == PackageManager.PERMISSION_GRANTED
                result.success(granted)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        SmsFallbackReceiver.messenger = null
        context = null
    }
}
