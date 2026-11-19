package com.pyro.stir

import io.flutter.embedding.engine.plugins.FlutterPlugin

class StirDriverPlugin : FlutterPlugin, StirHostApi {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        StirHostApi.setUp(binding.binaryMessenger, this)
    }

    override fun checkStirStatus(phoneNumber: String): StirCheckResponse {
        val res = StirCheckerImpl.getLatestStirResult(phoneNumber)
        return StirCheckResponse(
            phoneNumber = (res["phoneNumber"] as? String) ?: phoneNumber,
            status = (res["status"] as? String) ?: "NOT_AVAILABLE",
            isVerified = (res["isVerified"] as? Boolean) ?: false,
            isFailed = (res["isFailed"] as? Boolean) ?: false
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        StirHostApi.setUp(binding.binaryMessenger, null)
    }
}
