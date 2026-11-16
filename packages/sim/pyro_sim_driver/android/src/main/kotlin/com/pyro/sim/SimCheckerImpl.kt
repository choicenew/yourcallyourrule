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
            try {
                val activeList = subscriptionManager.activeSubscriptionInfoList
                if (!activeList.isNullOrEmpty()) {
                    for (info in activeList) {
                        val simPhoneNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            try { subscriptionManager.getPhoneNumber(info.subscriptionId) } catch (_: Exception) { info.number }
                        } else {
                            info.number
                        }

                        val isRoaming = telephonyManager?.isNetworkRoaming ?: false
                        val slotState = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && telephonyManager != null) {
                            try { telephonyManager.getSimState(info.simSlotIndex) } catch (_: Exception) { telephonyManager.simState }
                        } else {
                            telephonyManager?.simState ?: TelephonyManager.SIM_STATE_READY
                        }
                        val stateStr = when (slotState) {
                            TelephonyManager.SIM_STATE_READY -> "ready"
                            TelephonyManager.SIM_STATE_ABSENT -> "absent"
                            TelephonyManager.SIM_STATE_PIN_REQUIRED,
                            TelephonyManager.SIM_STATE_PUK_REQUIRED,
                            TelephonyManager.SIM_STATE_NETWORK_LOCKED -> "locked"
                            else -> "not_ready"
                        }

                        val simMap = mapOf(
                            "subscriptionId" to info.subscriptionId,
                            "simSlotIndex" to info.simSlotIndex,
                            "carrierName" to (info.carrierName?.toString()?.ifBlank { "No Service" } ?: "No Service"),
                            "displayName" to (info.displayName?.toString()?.ifBlank { "SIM ${info.simSlotIndex + 1}" } ?: "SIM ${info.simSlotIndex + 1}"),
                            "countryIso" to (info.countryIso ?: ""),
                            "iccId" to (info.iccId ?: ""),
                            "mccString" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) (info.mccString ?: "") else info.mcc.toString(),
                            "mncString" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) (info.mncString ?: "") else info.mnc.toString(),
                            "simPhoneNumber" to (simPhoneNumber ?: ""),
                            "isDataRoaming" to info.dataRoaming,
                            "isNetworkRoaming" to isRoaming,
                            "state" to stateStr
                        )
                        simList.add(simMap)
                    }
                }
            } catch (_: Exception) {}
        }

        // 检查物理卡槽，兼容处于 NOT_PROVISIONED / 无服务 / 欠费状态的 SIM 卡
        if (telephonyManager != null) {
            val slotCount = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                telephonyManager.activeModemCount
            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                telephonyManager.phoneCount
            } else {
                1
            }

            for (slotIndex in 0 until slotCount) {
                val alreadyAdded = simList.any { (it["simSlotIndex"] as? Int) == slotIndex }
                if (alreadyAdded) continue

                val slotSimState = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    try { telephonyManager.getSimState(slotIndex) } catch (_: Exception) { telephonyManager.simState }
                } else {
                    telephonyManager.simState
                }

                if (slotSimState != TelephonyManager.SIM_STATE_ABSENT) {
                    val fallbackStateStr = when (slotSimState) {
                        TelephonyManager.SIM_STATE_READY -> "ready"
                        TelephonyManager.SIM_STATE_PIN_REQUIRED,
                        TelephonyManager.SIM_STATE_PUK_REQUIRED,
                        TelephonyManager.SIM_STATE_NETWORK_LOCKED -> "locked"
                        else -> "not_ready"
                    }

                    val simMap = mapOf(
                        "subscriptionId" to slotIndex,
                        "simSlotIndex" to slotIndex,
                        "carrierName" to (telephonyManager.simOperatorName?.ifBlank { "No Service" } ?: "No Service"),
                        "displayName" to "SIM ${slotIndex + 1}",
                        "countryIso" to (telephonyManager.simCountryIso ?: ""),
                        "iccId" to (try { telephonyManager.simSerialNumber ?: "" } catch (_: Exception) { "" }),
                        "mccString" to getMcc(telephonyManager.simOperator),
                        "mncString" to getMnc(telephonyManager.simOperator),
                        "simPhoneNumber" to (try { telephonyManager.line1Number ?: "" } catch (_: Exception) { "" }),
                        "isDataRoaming" to false,
                        "isNetworkRoaming" to telephonyManager.isNetworkRoaming,
                        "state" to fallbackStateStr
                    )
                    simList.add(simMap)
                }
            }
        }

        if (simList.isEmpty() && telephonyManager != null && telephonyManager.simState != TelephonyManager.SIM_STATE_ABSENT) {
            val simMap = mapOf(
                "subscriptionId" to 0,
                "simSlotIndex" to 0,
                "carrierName" to "No Service",
                "displayName" to "SIM 1",
                "countryIso" to (telephonyManager.simCountryIso ?: ""),
                "iccId" to "",
                "mccString" to "",
                "mncString" to "",
                "simPhoneNumber" to "",
                "isDataRoaming" to false,
                "isNetworkRoaming" to telephonyManager.isNetworkRoaming,
                "state" to "not_ready"
            )
            simList.add(simMap)
        }

        return simList
    }

    fun hasSimCard(context: Context): Boolean {
        val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as? SubscriptionManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1 && subscriptionManager != null) {
            try {
                val list = subscriptionManager.activeSubscriptionInfoList
                if (!list.isNullOrEmpty()) return true
            } catch (_: Exception) {}
        }
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager ?: return false
        val slotCount = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            telephonyManager.activeModemCount
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            telephonyManager.phoneCount
        } else {
            1
        }
        for (slotIndex in 0 until slotCount) {
            val state = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                try { telephonyManager.getSimState(slotIndex) } catch (_: Exception) { telephonyManager.simState }
            } else {
                telephonyManager.simState
            }
            if (state != TelephonyManager.SIM_STATE_ABSENT) {
                return true
            }
        }
        return telephonyManager.simState != TelephonyManager.SIM_STATE_ABSENT
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
