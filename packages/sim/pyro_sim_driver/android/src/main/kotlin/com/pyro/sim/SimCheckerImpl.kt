package com.pyro.sim

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager

object SimCheckerImpl {

    @SuppressLint("MissingPermission", "HardwareIds")
    fun getActiveSimCards(context: Context): List<Map<String, Any?>> {
        val simList = mutableListOf<Map<String, Any?>>()
        val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as? SubscriptionManager
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1 && subscriptionManager != null) {
            val activeList = subscriptionManager.activeSubscriptionInfoList
            if (activeList != null) {
                for (info in activeList) {
                    val simPhoneNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        try { subscriptionManager.getPhoneNumber(info.subscriptionId) } catch (_: Exception) { info.number }
                    } else {
                        info.number
                    }

                    val isRoaming = telephonyManager?.isNetworkRoaming ?: false

                    val simMap = mapOf(
                        "subscriptionId" to info.subscriptionId,
                        "simSlotIndex" to info.simSlotIndex,
                        "carrierName" to (info.carrierName?.toString() ?: ""),
                        "displayName" to (info.displayName?.toString() ?: ""),
                        "countryIso" to (info.countryIso ?: ""),
                        "iccId" to (info.iccId ?: ""),
                        "mccString" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) (info.mccString ?: "") else info.mcc.toString(),
                        "mncString" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) (info.mncString ?: "") else info.mnc.toString(),
                        "simPhoneNumber" to (simPhoneNumber ?: ""),
                        "isDataRoaming" to info.dataRoaming,
                        "isNetworkRoaming" to isRoaming,
                        "state" to "ready"
                    )
                    simList.add(simMap)
                }
                return simList
            }
        }

        // Fallback for older API levels or single SIM devices
        if (telephonyManager != null) {
            val simMap = mapOf(
                "subscriptionId" to 0,
                "simSlotIndex" to 0,
                "carrierName" to (telephonyManager.simOperatorName ?: ""),
                "displayName" to (telephonyManager.simOperatorName ?: ""),
                "countryIso" to (telephonyManager.simCountryIso ?: ""),
                "iccId" to (try { telephonyManager.simSerialNumber } catch (_: Exception) { "" }),
                "mccString" to getMcc(telephonyManager.simOperator),
                "mncString" to getMnc(telephonyManager.simOperator),
                "simPhoneNumber" to (try { telephonyManager.line1Number } catch (_: Exception) { "" }),
                "isDataRoaming" to false,
                "isNetworkRoaming" to telephonyManager.isNetworkRoaming,
                "state" to if (telephonyManager.simState == TelephonyManager.SIM_STATE_READY) "ready" else "absent"
            )
            simList.add(simMap)
        }

        return simList
    }

    fun hasSimCard(context: Context): Boolean {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager ?: return false
        return telephonyManager.simState == TelephonyManager.SIM_STATE_READY
    }

    @SuppressLint("MissingPermission")
    fun getNetworkInfo(context: Context): Map<String, Any?> {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
            ?: return mapOf("isNetworkAvailable" to false)

        val operatorName = telephonyManager.networkOperatorName ?: ""
        val operatorCode = telephonyManager.networkOperator ?: ""
        val netType = getNetworkTypeName(try { telephonyManager.networkType } catch (_: Exception) { TelephonyManager.NETWORK_TYPE_UNKNOWN })
        val isRoaming = telephonyManager.isNetworkRoaming

        return mapOf(
            "networkOperatorName" to operatorName,
            "networkOperator" to operatorCode,
            "networkType" to netType,
            "isNetworkAvailable" to operatorCode.isNotEmpty(),
            "isRoaming" to isRoaming
        )
    }

    private fun getMcc(simOperator: String?): String {
        return if (simOperator != null && simOperator.length >= 3) simOperator.substring(0, 3) else ""
    }

    private fun getMnc(simOperator: String?): String {
        return if (simOperator != null && simOperator.length > 3) simOperator.substring(3) else ""
    }

    private fun getNetworkTypeName(networkType: Int): String {
        return when (networkType) {
            TelephonyManager.NETWORK_TYPE_GPRS -> "GPRS"
            TelephonyManager.NETWORK_TYPE_EDGE -> "EDGE"
            TelephonyManager.NETWORK_TYPE_UMTS -> "UMTS"
            TelephonyManager.NETWORK_TYPE_HSDPA -> "HSDPA"
            TelephonyManager.NETWORK_TYPE_HSUPA -> "HSUPA"
            TelephonyManager.NETWORK_TYPE_HSPA -> "HSPA"
            TelephonyManager.NETWORK_TYPE_CDMA -> "CDMA"
            TelephonyManager.NETWORK_TYPE_EVDO_0 -> "EVDO_0"
            TelephonyManager.NETWORK_TYPE_EVDO_A -> "EVDO_A"
            TelephonyManager.NETWORK_TYPE_EVDO_B -> "EVDO_B"
            TelephonyManager.NETWORK_TYPE_1xRTT -> "1xRTT"
            TelephonyManager.NETWORK_TYPE_LTE -> "LTE"
            TelephonyManager.NETWORK_TYPE_NR -> "5G"
            else -> "UNKNOWN"
        }
    }
}
