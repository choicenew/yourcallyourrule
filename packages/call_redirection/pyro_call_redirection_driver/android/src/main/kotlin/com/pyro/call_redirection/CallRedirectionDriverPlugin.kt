package com.pyro.call_redirection

import android.app.Activity
import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class CallRedirectionDriverPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var context: Context? = null
  private var activity: Activity? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "net.pyro.telephony/call_redirection")
    channel.setMethodCallHandler(this)
    CallRedirectionServiceImpl.messenger = binding.binaryMessenger
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isServiceActive" -> {
        result.success(true)
      }
      "isRoleGranted" -> {
        val ctx = context
        if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
          val roleManager = ctx.getSystemService(RoleManager::class.java)
          val isGranted = roleManager?.isRoleHeld(RoleManager.ROLE_CALL_REDIRECTION) == true
          result.success(isGranted)
        } else {
          result.success(false)
        }
      }
      "requestRole" -> {
        val act = activity
        val ctx = context
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
          val roleManager = (act?.getSystemService(Context.ROLE_SERVICE) as? RoleManager)
            ?: (ctx?.getSystemService(Context.ROLE_SERVICE) as? RoleManager)
          if (roleManager != null && !roleManager.isRoleHeld(RoleManager.ROLE_CALL_REDIRECTION)) {
            val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_CALL_REDIRECTION)
            if (act != null) {
              act.startActivity(intent)
            } else if (ctx != null) {
              intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
              ctx.startActivity(intent)
            }
          }
        }
        result.success(true)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    CallRedirectionServiceImpl.messenger = null
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

