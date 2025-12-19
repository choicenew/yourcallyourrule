package com.yours.live_updates

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.graphics.Bitmap // <--- 在这里添加了缺失的导入

import android.content.Intent
import android.graphics.BitmapFactory
import android.graphics.drawable.Icon
import android.os.Build
import android.util.Log
import android.util.TypedValue
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import androidx.core.app.Person
import io.flutter.plugin.common.MethodCall

class LiveUpdateManager(private val context: Context) {

    private val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    companion object {
        const val CHANNEL_ID = "live_updates_channel"
        private const val CHANNEL_NAME = "Live Updates"
    }

    fun initialize() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH).apply {
                description = "Channel for live updates notifications"
                setSound(null, null)
                enableVibration(false)
            }
            notificationManager.createNotificationChannel(channel)
        }
    }

    fun showLayoutNotification(call: MethodCall) {
        val notificationId = call.argument<Int>("notificationId") ?: 0
        val layoutName = call.argument<String>("layoutName") ?: ""
        val viewData = call.argument<Map<String, Map<String, Any>>>("viewData") ?: emptyMap()
        val ongoing = call.argument<Boolean>("ongoing") ?: true
        val payload = call.argument<String>("payload")
        val smallIconName = call.argument<String>("smallIconName")
        val title = call.argument<String>("title") ?: ""
        
        val layoutId = context.resources.getIdentifier(layoutName, "layout", context.packageName)
        if (layoutId == 0) {
            android.util.Log.e("LiveUpdateManager", "Layout resource '$layoutName' not found")
            return
        }
        val remoteViews = RemoteViews(context.packageName, layoutId)
        val displayMetrics = context.resources.displayMetrics

        for ((viewIdName, data) in viewData) {
            val viewResId = context.resources.getIdentifier(viewIdName, "id", context.packageName)
            if (viewResId == 0) continue
            
            // 坐标 (x, y) 已经是相对于可用区域的，所以直接应用
            (data["x"] as? Number)?.let {
                val translationX = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, it.toFloat(), displayMetrics)
                remoteViews.setFloat(viewResId, "setTranslationX", translationX)
            }
            (data["y"] as? Number)?.let {
                val translationY = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, it.toFloat(), displayMetrics)
                remoteViews.setFloat(viewResId, "setTranslationY", translationY)
            }

            when (data["type"] as? String) {
                "textView" -> {
                    (data["text"] as? String)?.let { remoteViews.setTextViewText(viewResId, it) }
                    (data["textColor"] as? Number)?.toInt()?.let { remoteViews.setTextColor(viewResId, it) }
                    (data["textSize"] as? Number)?.toFloat()?.let { remoteViews.setFloat(viewResId, "setTextSize", it) }
                }
                
                "imageView" -> {
                             // ==================== 重要的修正从这里开始 ====================

                    val imageBytes = data["imageBytes"] as? ByteArray
                    val widthDp = (data["width"] as? Number)?.toFloat()
                    val heightDp = (data["height"] as? Number)?.toFloat()

                    if (imageBytes != null && widthDp != null && heightDp != null) {
                        // 1. 将从 Flutter 传来的 dp 单位转换为 Android 需要的真实像素 (px)
                        val targetWidthPx = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, widthDp, displayMetrics).toInt()
                        val targetHeightPx = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, heightDp, displayMetrics).toInt()

                        // 2. 解码原始的 Bitmap
                        val originalBitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)

                        if (originalBitmap != null) {
                            // 3. [核心步骤] 创建一个严格按照目标像素尺寸缩放的新 Bitmap
                            val scaledBitmap = Bitmap.createScaledBitmap(originalBitmap, targetWidthPx, targetHeightPx, true)

                            // 4. 将这个尺寸完美的 Bitmap 设置给 ImageView
                            remoteViews.setImageViewBitmap(viewResId, scaledBitmap)

                            Log.d("LiveUpdateManager", "[$viewIdName] Rescaled and set bitmap to ${targetWidthPx}x${targetHeightPx}px.")
                        } else {
                             Log.e("LiveUpdateManager", "[$viewIdName] Failed to decode bitmap from byte array.")
                        }

                    } else if (imageBytes != null) {
                        // 如果没有提供宽高，则按原样显示（作为备用方案）
                        val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
                        remoteViews.setImageViewBitmap(viewResId, bitmap)
                        Log.d("LiveUpdateManager", "[$viewIdName] Set original bitmap without scaling.")
                    }                                              
                                                                                                                                                                  
                                                                                                            
                 }

  
  
  
  
  
  

  
  
  


            }
        }

        val intent = Intent(context, NotificationClickReceiver::class.java).apply { 
            putExtra("payload", payload)
            // 添加唯一的 data URI，强制 Android 认为这是不同的 Intent
            data = android.net.Uri.parse("live_updates://notification/$notificationId?t=${System.currentTimeMillis()}")
        }
        val pendingIntent = PendingIntent.getBroadcast(context, notificationId, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        val smallIconId = smallIconName?.let { context.resources.getIdentifier(it, "drawable", context.packageName) } ?: android.R.drawable.ic_dialog_info

        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(if (smallIconId != 0) smallIconId else android.R.drawable.ic_dialog_info)
                 .setContentTitle(title)
                 
            .setCustomContentView(remoteViews)
            .setCustomBigContentView(remoteViews)
            .setStyle(NotificationCompat.DecoratedCustomViewStyle())
      
            .setOngoing(ongoing)
            .setAutoCancel(!ongoing)
            .setContentIntent(pendingIntent)
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setCategory(NotificationCompat.CATEGORY_CALL)
        





        notificationManager.notify(notificationId, builder.build())
    }

    fun showNotification(call: MethodCall) {
        val notificationId = call.argument<Int>("notificationId") ?: 0
        val title = call.argument<String>("title") ?: ""
        val text = call.argument<String>("text") ?: ""
        val ongoing = call.argument<Boolean>("ongoing") ?: true
        val payload = call.argument<String>("payload")
        val style = call.argument<String>("style")

        val intent = Intent(context, NotificationClickReceiver::class.java).apply { 
            putExtra("payload", payload)
            // 添加唯一的 data URI，确保每次通知的 payload 都能正确传递
            data = android.net.Uri.parse("live_updates://notification/$notificationId?t=${System.currentTimeMillis()}")
        }
        val pendingIntent = PendingIntent.getBroadcast(context, notificationId, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        val progressSegments = call.argument<List<Map<String, Any>>>("progressSegments")
        if (style == "progress" && Build.VERSION.SDK_INT >= 35 && progressSegments != null && progressSegments.isNotEmpty()) {
            val nativeBuilder = Notification.Builder(context, CHANNEL_ID)
                .setContentTitle(title)
                .setContentText(text)
                .setSmallIcon(android.R.drawable.ic_dialog_info)
                .setOngoing(ongoing)
                .setContentIntent(pendingIntent)
                
                .setPriority(Notification.PRIORITY_HIGH) // <-- 在这里添加！确保通知能弹出

            val progress = (call.argument<Number>("progress") ?: 0).toInt()
            val progressPoints = call.argument<List<Map<String, Any>>>("progressPoints")
            val progressTrackerIcon = call.argument<ByteArray>("progressTrackerIcon")

            val progressStyle = Notification.ProgressStyle()
            progressStyle.setProgress(progress)
            if (progressTrackerIcon != null) {
                val bitmap = BitmapFactory.decodeByteArray(progressTrackerIcon, 0, progressTrackerIcon.size)
                progressStyle.setProgressTrackerIcon(Icon.createWithBitmap(bitmap))
            }
            val segments = progressSegments.map { segmentMap ->
                val segment = Notification.ProgressStyle.Segment((segmentMap["progress"] as Number).toInt())
                (segmentMap["color"] as? Long)?.toInt()?.let { color -> segment.setColor(color) }
                segment
            }
            progressStyle.setProgressSegments(segments)
            if (progressPoints != null) {
                val points = progressPoints.map { pointMap ->
                   val point = Notification.ProgressStyle.Point((pointMap["progress"] as Number).toInt())
                   (pointMap["color"] as? Long)?.toInt()?.let { color -> point.setColor(color) }
                   point
                }
                progressStyle.setProgressPoints(points)
            }
            nativeBuilder.setStyle(progressStyle)
            notificationManager.notify(notificationId, nativeBuilder.build())
            return
        }
        
        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setContentTitle(title)
            .setContentText(text)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setOngoing(ongoing)
            .setAutoCancel(!ongoing)
            .setContentIntent(pendingIntent)
          

        when (style) {
            "progress" -> {
                builder.setCategory(NotificationCompat.CATEGORY_PROGRESS)
                val progress = call.argument<Int>("progress") ?: 0
                val progressMax = call.argument<Int>("progressMax") ?: 100
                val progressIndeterminate = call.argument<Boolean>("progressIndeterminate") ?: false
                builder.setProgress(progressMax, progress, progressIndeterminate)
            }
            "call" -> {
                builder.setCategory(NotificationCompat.CATEGORY_CALL)
                builder.setPriority(NotificationCompat.PRIORITY_MAX)
                
                val person = Person.Builder().setName(title).build()
                val declineIntent = PendingIntent.getBroadcast(context, notificationId + 2, Intent(context, NotificationClickReceiver::class.java).setAction("DECLINE"), PendingIntent.FLAG_IMMUTABLE)
                val answerIntent = PendingIntent.getBroadcast(context, notificationId + 3, Intent(context, NotificationClickReceiver::class.java).setAction("ANSWER"), PendingIntent.FLAG_IMMUTABLE)
                builder.setStyle(NotificationCompat.CallStyle.forIncomingCall(person, declineIntent, answerIntent))
                





            }
            else -> {
                builder.setCategory(NotificationCompat.CATEGORY_SERVICE)
                builder.setStyle(NotificationCompat.BigTextStyle().bigText(text))
            }
        }

        if (Build.VERSION.SDK_INT >= 34) {
            builder.extras.putBoolean("android.isPromotedOngoing", true)
        }

        notificationManager.notify(notificationId, builder.build())
    }

    fun cancelNotification(notificationId: Int) {
        notificationManager.cancel(notificationId)
    }
}