package com.pyro.sim

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SimDriverPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "com.yours.yourcallyourrule/sim")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val ctx = applicationContext
        if (ctx == null) {
            result.error("CONTEXT_NULL", "Application context is null", null)
            return
        }

        when (call.method) {
            "getActiveSimCards" -> {
                val simCards = SimCheckerImpl.getActiveSimCards(ctx)
                result.success(simCards)
            }
            "hasSimCard" -> {
                val hasSim = SimCheckerImpl.hasSimCard(ctx)
                result.success(hasSim)
            }
            "getNetworkInfo" -> {
                val netInfo = SimCheckerImpl.getNetworkInfo(ctx)
                result.success(netInfo)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }
}
