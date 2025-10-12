// CustomLiveActivityManager.kt

package com.yours.yourcallyourrule

import android.app.Notification
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import com.example.live_activities.LiveActivityManager // 确保这个 import 路径与插件一致

/**
 * 自定义的 Live Activity 逻辑管理器。
 * 这个类严格按照 live_activities 插件官方文档的示例进行编写。
 */
class CustomLiveActivityManager(context: Context) : LiveActivityManager(context) {

    // --- 100% 遵从文档：在构造函数中初始化 context ---
    // 我们需要自己的 context 实例来创建 RemoteViews 和 PendingIntent。
    private val context: Context = context.applicationContext

    // --- 100% 遵从文档：创建点击通知时返回App的 PendingIntent ---
    private val pendingIntent = PendingIntent.getActivity(
        context, 
        200, // requestCode
        Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
        }, 
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

    /**
     * 这是插件调用的核心方法，必须重写。
     * 严格按照官方文档的模式实现。
     */
    override suspend fun buildNotification(
        notification: Notification.Builder,
        event: String,
        data: Map<String, Any>
    ): Notification {
        // 1. 严格按照文档，在这里创建 RemoteViews 实例。
        val remoteViews = RemoteViews(context.packageName, R.layout.live_activity)

        // 2. 调用我们的核心配置函数，用 Flutter 传来的数据去“填充” RemoteViews。
        configureView(remoteViews, data)

        // 3. 严格按照文档，对插件传入的 notification Builder 进行最终配置。
        //    *** 我删除了所有我自己添加的、导致错误的垃圾代码，比如 .setStyle() ***
        return notification
            .setSmallIcon(R.drawable.ic_notification) // 必须在 res/drawable 目录下提供这个图标
            .setOngoing(true)
            .setContentIntent(pendingIntent)
            .setCustomContentView(remoteViews)      // 设置折叠视图
            .setCustomBigContentView(remoteViews)   // 设置展开视图
            .build()
    }

    /**
     * 真正执行视图配置的核心函数。
     */
    private fun configureView(remoteViews: RemoteViews, data: Map<String, Any>) {
        
        val density = context.resources.displayMetrics.density
        fun dpToPx(dp: Double?): Int {
            if (dp == null) return 0
            return (dp * density).toInt()
        }

        // --- 辅助函数：配置 TextView ---
        fun configureTextView(id: Int, textKey: String, xKey: String, yKey: String, colorKey: String, sizeKey: String) {
            (data[textKey] as? String)?.let { text ->
                if (text.isNotEmpty()) {
                    remoteViews.setViewVisibility(id, android.view.View.VISIBLE)
                    remoteViews.setTextViewText(id, text)
                    remoteViews.setViewPadding(id, dpToPx(data[xKey] as? Double), dpToPx(data[yKey] as? Double), 0, 0)
                    (data[colorKey] as? Long)?.toInt()?.let { color -> remoteViews.setTextColor(id, color) }
                    (data[sizeKey] as? Double)?.let { size -> remoteViews.setFloat(id, "setTextSize", size.toFloat()) }
                } else {
                    remoteViews.setViewVisibility(id, android.view.View.GONE)
                }
            } ?: remoteViews.setViewVisibility(id, android.view.View.GONE)
        }
        
        // --- 辅助函数：配置 ImageView ---
        fun configureImageView(id: Int, imageKey: String, xKey: String, yKey: String, sizeKey: String) {
            (data[imageKey] as? ByteArray)?.let { bytes ->
                if (bytes.isNotEmpty()) {
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    remoteViews.setViewVisibility(id, android.view.View.VISIBLE)
                    
                    val size = dpToPx(data[sizeKey] as? Double)
                    val finalBitmap = if (size > 0) {
                        Bitmap.createScaledBitmap(bitmap, size, size, true)
                    } else {
                        bitmap
                    }
                    remoteViews.setImageViewBitmap(id, finalBitmap)
                    remoteViews.setViewPadding(id, dpToPx(data[xKey] as? Double), dpToPx(data[yKey] as? Double), 0, 0)
                } else {
                    remoteViews.setViewVisibility(id, android.view.View.GONE)
                }
            } ?: remoteViews.setViewVisibility(id, android.view.View.GONE)
        }

        // --- 开始配置所有XML中定义的槽位 (100% 完整) ---
        (data["backgroundColor"] as? Long)?.toInt()?.let {
            remoteViews.setInt(R.id.notification_container, "setBackgroundColor", it)
        }
        configureImageView(R.id.avatar, "avatarImage", "avatarX", "avatarY", "avatarSize")
        configureTextView(R.id.name, "nameText", "nameX", "nameY", "nameColor", "nameFontSize")
        configureTextView(R.id.number, "numberText", "numberX", "numberY", "numberColor", "numberFontSize")
        configureTextView(R.id.location, "locationText", "locationX", "locationY", "locationColor", "locationFontSize")
        configureTextView(R.id.carrier, "carrierText", "carrierX", "carrierY", "carrierColor", "carrierFontSize")
        configureTextView(R.id.countryName, "countryNameText", "countryNameX", "countryNameY", "countryNameColor", "countryNameFontSize")
        configureTextView(R.id.labels, "labelsText", "labelsX", "labelsY", "labelsColor", "labelsFontSize")
        configureTextView(R.id.count, "countText", "countX", "countY", "countColor", "countFontSize")
        configureTextView(R.id.numberType, "numberTypeText", "numberTypeX", "numberTypeY", "numberTypeColor", "numberTypeFontSize")
        configureTextView(R.id.stir, "stirText", "stirX", "stirY", "stirColor", "stirFontSize")
        configureTextView(R.id.simCard, "simCardText", "simCardX", "simCardY", "simCardColor", "simCardFontSize")
        configureImageView(R.id.callType, "callTypeImage", "callTypeX", "callTypeY", "callTypeSize")
        
        configureTextView(R.id.securityMessage, "securityMessageText", "securityMessageX", "securityMessageY", "securityMessageColor", "securityMessageFontSize")
        remoteViews.setBoolean(R.id.securityMessage, "setSelected", true)
    }
}