package com.yours.yourcallyourrule

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telecom.TelecomManager
import android.telephony.TelephonyManager


class CallStateReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == TelephonyManager.ACTION_PHONE_STATE_CHANGED) {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            val number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
            
            when (state) {
                TelephonyManager.EXTRA_STATE_RINGING -> handleRinging(context, number)
                TelephonyManager.EXTRA_STATE_OFFHOOK -> handleOffhook(context, number)
            }
        }
    }

    private fun handleRinging(context: Context, number: String?) {
        if (shouldAnswerCall(context, number)) {
            answerCall(context)
        }
    }

    private fun handleOffhook(context: Context, number: String?) {
        if (shouldHangupCall(context, number)) {
            hangupCall(context)
        }
    }

    private fun shouldAnswerCall(context: Context, number: String?): Boolean {
        val prefs = context.getSharedPreferences("call_pref", Context.MODE_PRIVATE)
        val numberToAnswer = prefs.getString("number_to_answer", "")
        return number == numberToAnswer
    }

    private fun shouldHangupCall(context: Context, number: String?): Boolean {
        val prefs = context.getSharedPreferences("call_pref", Context.MODE_PRIVATE)
        val numberToHangup = prefs.getString("number_to_hangup", "")
        return number == numberToHangup
    }

    @SuppressLint("MissingPermission")
    private fun answerCall(context: Context) {
        val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
        telecomManager.acceptRingingCall()
    }

    @SuppressLint("MissingPermission")
    private fun hangupCall(context: Context) {
        val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
        telecomManager.endCall()
    }
}