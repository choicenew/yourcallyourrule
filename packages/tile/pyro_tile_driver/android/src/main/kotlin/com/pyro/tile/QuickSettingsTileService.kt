package com.pyro.tile

import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

@RequiresApi(Build.VERSION_CODES.N)
class QuickSettingsTileService : TileService() {

    companion object {
        const val CHANNEL = "net.pyro.telephony/tile"
        @Volatile var messenger: BinaryMessenger? = null
        @Volatile var instance: QuickSettingsTileService? = null

        fun updateTile(stateStr: String, subtitleStr: String?) {
            val service = instance ?: return
            val tile = service.qsTile ?: return
            val isActive = stateStr.equals("active", ignoreCase = true)
            tile.state = if (isActive) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && subtitleStr != null) {
                tile.subtitle = subtitleStr
            }
            tile.updateTile()
        }
    }

    override fun onStartListening() {
        super.onStartListening()
        instance = this
    }

    override fun onStopListening() {
        super.onStopListening()
        if (instance == this) instance = null
    }

    override fun onClick() {
        super.onClick()
        val tile = qsTile ?: return
        val isActive = tile.state == Tile.STATE_ACTIVE
        val newState = if (isActive) Tile.STATE_INACTIVE else Tile.STATE_ACTIVE
        
        tile.state = newState
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            tile.subtitle = if (newState == Tile.STATE_ACTIVE) "Active" else "Paused"
        }
        tile.updateTile()

        val msger = messenger ?: return
        val stateName = if (newState == Tile.STATE_ACTIVE) "active" else "inactive"
        MethodChannel(msger, CHANNEL).invokeMethod("onTileClicked", mapOf("state" to stateName))
    }
}
