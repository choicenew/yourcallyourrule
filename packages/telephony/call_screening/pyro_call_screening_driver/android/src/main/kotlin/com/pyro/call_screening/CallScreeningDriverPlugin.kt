package com.pyro.call_screening

import android.app.Activity
import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class CallScreeningDriverPlugin : FlutterPlugin, CallScreeningHostApi, ActivityAware {
    private var context: Context? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        CallScreeningHostApi.setUp(binding.binaryMessenger, this)
        CallScreeningServiceImpl.messenger = binding.binaryMessenger
    }

    override fun isServiceActive(): Boolean = true

    override fun isRoleGranted(): Boolean {
        val ctx = context
        return if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val roleManager = ctx.getSystemService(RoleManager::class.java)
            roleManager?.isRoleHeld(RoleManager.ROLE_CALL_SCREENING) == true
        } else {
            false
        }
    }

    override fun requestRole(): Boolean {
        val act = activity
        val ctx = context
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val roleManager = (act?.getSystemService(Context.ROLE_SERVICE) as? RoleManager)
                ?: (ctx?.getSystemService(Context.ROLE_SERVICE) as? RoleManager)
            if (roleManager != null && !roleManager.isRoleHeld(RoleManager.ROLE_CALL_SCREENING)) {
                val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_CALL_SCREENING)
                if (act != null) {
                    act.startActivity(intent)
                } else if (ctx != null) {
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    ctx.startActivity(intent)
                }
            }
        }
        return true
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        CallScreeningHostApi.setUp(binding.binaryMessenger, null)
        CallScreeningServiceImpl.messenger = null
        context = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
