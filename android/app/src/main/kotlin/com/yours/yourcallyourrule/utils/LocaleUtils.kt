package com.yours.yourcallyourrule.utils

import android.content.Context
import android.content.res.Configuration
import android.os.Build
import java.util.Locale

/**
 * 语言与 Context 本地化适配工具类 (完全对齐 veherego 架构)
 * 100% 解决 App 内部切换语言后桌面小组件不根治/不刷新的问题
 */
object LocaleUtils {
    fun getLocalizedContext(context: Context): Context {
        val prefs = context.getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)
        val rawLocale = prefs.getString("app_locale", "system") ?: "system"

        val targetLocale = if (rawLocale == "system" || rawLocale.isEmpty()) {
            val sysLocale = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                context.resources.configuration.locales.get(0)
            } else {
                @Suppress("DEPRECATION")
                context.resources.configuration.locale
            }
            sysLocale ?: Locale.getDefault()
        } else {
            when (rawLocale.lowercase()) {
                "zh", "zh_cn", "zh_hk", "zh_tw" -> Locale.SIMPLIFIED_CHINESE
                "en" -> Locale.ENGLISH
                "es" -> Locale("es")
                else -> Locale(rawLocale)
            }
        }

        val config = Configuration(context.resources.configuration)
        config.setLocale(targetLocale)
        return context.createConfigurationContext(config)
    }
}
