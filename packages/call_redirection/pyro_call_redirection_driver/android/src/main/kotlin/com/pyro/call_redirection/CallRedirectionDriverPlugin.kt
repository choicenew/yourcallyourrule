package com.pyro.call_redirection

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class CallRedirectionDriverPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "com.yours.yourcallyourrule/call_redirection")
    channel.setMethodCallHandler(this)
    CallRedirectionServiceImpl.messenger = binding.binaryMessenger
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "isServiceActive") {
      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    CallRedirectionServiceImpl.messenger = null
  }
}
