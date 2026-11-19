package com.pyro.sim

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class SimDriverPlugin : FlutterPlugin, SimHostApi {
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        SimHostApi.setUp(binding.binaryMessenger, this)
    }

    override fun getActiveSimCards(): List<PigeonSimCard> {
        val ctx = applicationContext ?: return emptyList()
        val rawList = SimCheckerImpl.getActiveSimCards(ctx)
        return rawList.map { map ->
            PigeonSimCard(
                subscriptionId = (map["subscriptionId"] as? Number)?.toLong(),
                simSlotIndex = (map["simSlotIndex"] as? Number)?.toLong(),
                carrierName = map["carrierName"] as? String,
                displayName = map["displayName"] as? String,
                countryIso = map["countryIso"] as? String,
                iccId = map["iccId"] as? String,
                mccString = map["mccString"] as? String,
                mncString = map["mncString"] as? String,
                simPhoneNumber = map["simPhoneNumber"] as? String,
                isDataRoaming = map["isDataRoaming"] as? Boolean,
                isNetworkRoaming = map["isNetworkRoaming"] as? Boolean,
                state = map["state"] as? String
            )
        }
    }

    override fun hasSimCard(): Boolean {
        val ctx = applicationContext ?: return false
        return SimCheckerImpl.hasSimCard(ctx)
    }

    override fun getNetworkInfo(): PigeonNetworkInfo? {
        val ctx = applicationContext ?: return null
        val map = SimCheckerImpl.getNetworkInfo(ctx)
        return PigeonNetworkInfo(
            networkOperatorName = map["networkOperatorName"] as? String,
            networkOperator = map["networkOperator"] as? String,
            networkType = map["networkType"] as? String,
            isNetworkAvailable = map["isNetworkAvailable"] as? Boolean,
            isRoaming = map["isRoaming"] as? Boolean
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        SimHostApi.setUp(binding.binaryMessenger, null)
        applicationContext = null
    }
}
