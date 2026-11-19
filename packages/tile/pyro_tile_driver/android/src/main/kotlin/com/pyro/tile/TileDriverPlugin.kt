package com.pyro.tile

import android.app.StatusBarManager
import android.content.ComponentName
import android.content.Context
import android.graphics.drawable.Icon
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin

class TileDriverPlugin : FlutterPlugin, TileHostApi {
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        TileHostApi.setUp(binding.binaryMessenger, this)
        QuickSettingsTileService.messenger = binding.binaryMessenger
    }

    override fun updateTileState(request: TileStateRequest, callback: (Result<Boolean>) -> Unit) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            QuickSettingsTileService.updateTile(request.state, request.subtitle)
        }
        callback(Result.success(true))
    }

    override fun requestAddTile(request: AddTileRequest, callback: (Result<Boolean>) -> Unit) {
        val ctx = applicationContext
        if (ctx != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            try {
                val statusBarManager = ctx.getSystemService(StatusBarManager::class.java)
                val componentName = ComponentName(ctx, QuickSettingsTileService::class.java)
                val resId = ctx.resources.getIdentifier("tile_expected_call", "string", ctx.packageName)
                val defaultLabel = if (resId != 0) ctx.getString(resId) else ctx.applicationInfo.loadLabel(ctx.packageManager).toString()
                val label = request.label ?: defaultLabel
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
                    callback(Result.success(success))
                }
            } catch (e: Exception) {
                callback(Result.success(false))
            }
        } else {
            callback(Result.success(false))
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        TileHostApi.setUp(binding.binaryMessenger, null)
        QuickSettingsTileService.messenger = null
        applicationContext = null
    }
}

