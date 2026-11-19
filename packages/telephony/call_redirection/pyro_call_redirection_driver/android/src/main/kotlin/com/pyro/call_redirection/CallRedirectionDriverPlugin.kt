package com.pyro.call_redirection

import android.app.Activity
import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class CallRedirectionDriverPlugin: FlutterPlugin, CallRedirectionHostApi, ActivityAware {
  private var context: Context? = null
  private var activity: Activity? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    CallRedirectionHostApi.setUp(binding.binaryMessenger, this)
    CallRedirectionServiceImpl.messenger = binding.binaryMessenger
  }

  override fun isServiceActive(): Boolean = true

  override fun isRoleGranted(): Boolean {
    val ctx = context
    return if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      val roleManager = ctx.getSystemService(RoleManager::class.java)
      roleManager?.isRoleHeld(RoleManager.ROLE_CALL_REDIRECTION) == true
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
    return true
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    CallRedirectionHostApi.setUp(binding.binaryMessenger, null)
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
