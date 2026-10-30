package com.yours.yourcallyourrule.widget

import android.content.Context
import android.util.Log
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.updateAll
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * 小组件语言切换与全量重绘独立管理器 (独立单例/工具类)
 * 100% 对齐 veherego 架构：
 * 1. 独立解耦，不与 MainActivity 杂写
 * 2. 接收 Flutter setSystemLanguage 通道广播
 * 3. 强落盘 app_locale 并通过 updateIfInstalled 遍历全量已安装小组件唤醒 Glance 重绘
 */
object WidgetLanguageManager {

    private const val TAG = "WidgetLanguageManager"

    private suspend fun GlanceAppWidget.updateIfInstalled(context: Context) {
        try {
            val glanceIds = GlanceAppWidgetManager(context).getGlanceIds(this::class.java)
            if (glanceIds.isNotEmpty()) {
                this.updateAll(context)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Widget update failed: ${e.message}")
        }
    }

    fun handleSetSystemLanguage(context: Context, call: MethodCall, result: MethodChannel.Result) {
        val localeCode = call.argument<String>("locale") ?: "system"
        val prefs = context.getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)
        
        // 1. 强行落盘 app_locale
        prefs.edit().putString("app_locale", localeCode).commit()

        // 2. 协程并发唤醒全量已安装小组件重绘上屏
        val appContext = context.applicationContext
        CoroutineScope(Dispatchers.Main).launch {
            try {
                RulesSyncGlanceWidget().updateIfInstalled(appContext)
                DashboardOverviewGlanceWidget().updateIfInstalled(appContext)
                CommunityJudgeGlanceWidget().updateIfInstalled(appContext)
            } catch (e: Exception) {
                Log.e(TAG, "Batch widget update failed: ${e.message}")
            }
        }

        result.success(true)
    }
}
