package com.pyro.tile

import android.app.StatusBarManager
import android.content.ComponentName
import android.content.Context
import android.graphics.drawable.Icon
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class TileDriverPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, QuickSettingsTileService.CHANNEL)
        channel.setMethodCallHandler(this)
        QuickSettingsTileService.messenger = binding.binaryMessenger
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "updateTileState" -> {
                val state = call.argument<String>("state") ?: "active"
                val subtitle = call.argument<String>("subtitle")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    QuickSettingsTileService.updateTile(state, subtitle)
                }
                result.success(true)
            }
            "requestAddTile" -> {
                val ctx = applicationContext
                if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    try {
                        val statusBarManager = ctx.getSystemService(StatusBarManager::class.java)
                        val componentName = ComponentName(ctx, QuickSettingsTileService::class.java)
                        val appLabel = ctx.applicationInfo.loadLabel(ctx.packageManager).toString()
                        val label = call.argument<String>("label") ?: appLabel
                        val iconResId = ctx.applicationInfo.icon
                        val icon = Icon.createWithResource(ctx, if (iconResId != 0) iconResId else android.R.drawable.ic_dialog_info)

                        statusBarManager?.requestAddTileService(
                            componentName,
                            label,
                            icon,
                            ctx.mainExecutor
                        ) { resultCode ->
                            val success = resultCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED ||
                                    resultCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED
                            result.success(success)
                        }
                    } catch (e: Exception) {
                        result.success(false)
                    }
                } else {
                    result.success(false)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        QuickSettingsTileService.messenger = null
        applicationContext = null
    }
}

