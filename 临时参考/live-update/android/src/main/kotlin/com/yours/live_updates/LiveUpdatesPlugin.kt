package com.yours.live_updates

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

class LiveUpdatesPlugin : FlutterPlugin, MethodCallHandler, StreamHandler {
    private lateinit var channel: MethodChannel
    private lateinit var payloadChannel: EventChannel
    private lateinit var liveUpdateManager: LiveUpdateManager

    companion object {
        private var eventSink: EventChannel.EventSink? = null
        private var methodChannel: MethodChannel? = null
        
        @JvmStatic
        fun sendPayload(payload: String?) {
            Handler(Looper.getMainLooper()).post {
                eventSink?.success(payload)
            }
        }

        @JvmStatic
        fun onNotificationTapped(payload: String?) {
            Handler(Looper.getMainLooper()).post {
                methodChannel?.invokeMethod("onNotificationTapped", payload)
            }
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "live_updates")
        channel.setMethodCallHandler(this)
        methodChannel = channel
        
        payloadChannel = EventChannel(flutterPluginBinding.binaryMessenger, "live_updates/payload")
        payloadChannel.setStreamHandler(this)
        
        liveUpdateManager = LiveUpdateManager(flutterPluginBinding.applicationContext)
        liveUpdateManager.initialize()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        try {
            when (call.method) {
                "showLayoutNotification" -> {
                    liveUpdateManager.showLayoutNotification(call)
                    result.success(null)
                }
                "showNotification" -> {
                    liveUpdateManager.showNotification(call)
                    result.success(null)
                }
                "cancelNotification" -> {
                    val notificationId = call.argument<Int>("notificationId") ?: 0
                    liveUpdateManager.cancelNotification(notificationId)
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        } catch (e: Exception) {
            result.error("NATIVE_ERROR", e.message, e.stackTraceToString())
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        methodChannel = null
        payloadChannel.setStreamHandler(null)
    }
    
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }
    
    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}