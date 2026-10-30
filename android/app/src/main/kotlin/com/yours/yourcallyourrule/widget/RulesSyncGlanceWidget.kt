package com.yours.yourcallyourrule.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.res.Configuration
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.Preferences
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalContext
import androidx.glance.LocalSize
import androidx.glance.action.ActionParameters
import androidx.glance.action.actionParametersOf
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.state.PreferencesGlanceStateDefinition
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import com.yours.yourcallyourrule.MainActivity
import com.yours.yourcallyourrule.R
import com.yours.yourcallyourrule.utils.LocaleUtils

/**
 * 规则与数据库同步状态美学 Bento 卡片小组件
 * 1. 深度复刻 Elite Home UI 视觉语言（绿盾雷达 + 多巴胺流线微胶囊）
 * 2. 右上角集成 ⚙️ 专属独立 Setting 配置向导按钮
 * 3. 100% LocaleUtils 动态切语言跟治刷新
 */
class RulesSyncGlanceWidget : GlanceAppWidget() {

    override val stateDefinition: GlanceStateDefinition<*> = PreferencesGlanceStateDefinition

    override val sizeMode: SizeMode = SizeMode.Responsive(
        setOf(
            DpSize(100.dp, 50.dp),  // 紧凑形态
            DpSize(250.dp, 100.dp) // 展开形态
        )
    )

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val appWidgetId = GlanceAppWidgetManager(context).getAppWidgetId(id)
        val widgetPrefs = context.getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)

        val globalAlpha = widgetPrefs.getInt("widget_global_alpha", 100)
        val alphaVal = if (widgetPrefs.contains("widget_${appWidgetId}_alpha")) {
            widgetPrefs.getInt("widget_${appWidgetId}_alpha", globalAlpha)
        } else {
            globalAlpha
        }

        val globalTheme = widgetPrefs.getString("widget_global_theme", "auto") ?: "auto"
        val themeMode = if (widgetPrefs.contains("widget_${appWidgetId}_theme")) {
            widgetPrefs.getString("widget_${appWidgetId}_theme", globalTheme) ?: globalTheme
        } else {
            globalTheme
        }

        val globalFontScale = widgetPrefs.getFloat("widget_global_font_scale", 1.0f)
        val fontScale = if (widgetPrefs.contains("widget_${appWidgetId}_font_scale")) {
            widgetPrefs.getFloat("widget_${appWidgetId}_font_scale", globalFontScale)
        } else {
            globalFontScale
        }

        val showDetail = widgetPrefs.getBoolean("widget_${appWidgetId}_show_detail", true)

        provideContent {
            GlanceTheme {
                RulesSyncWidgetRender(
                    appWidgetId = appWidgetId,
                    alphaVal = alphaVal,
                    themeMode = themeMode,
                    fontScale = fontScale,
                    showDetail = showDetail
                )
            }
        }
    }

    @Composable
    private fun RulesSyncWidgetRender(
        appWidgetId: Int,
        alphaVal: Int,
        themeMode: String,
        fontScale: Float,
        showDetail: Boolean
    ) {
        val rawContext = LocalContext.current
        val localizedContext = LocaleUtils.getLocalizedContext(rawContext)
        val state = currentState<Preferences>()
        val size = LocalSize.current

        val totalRules = state[KEY_TOTAL_RULES] ?: 0
        val lastSync = state[KEY_LAST_SYNC] ?: "--"
        val serviceType = state[KEY_SERVICE_TYPE] ?: "--"

        val alphaFloat = alphaVal.coerceIn(0, 100) / 100f
        val isDark = if (themeMode == "light") false else (if (themeMode == "dark") true else ((rawContext.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES))

        val cardBgColor = ColorProvider(
            day = Color(0xF8FAFCFF).copy(alpha = alphaFloat),
            night = Color(0xEC18181B).copy(alpha = alphaFloat)
        )
        val innerBentoBg = ColorProvider(
            day = Color(0x15F1F5F9),
            night = Color(0x2527272A)
        )
        val textPrimary = ColorProvider(
            day = Color(0xFF0F172A),
            night = Color(0xFFFAFAFA)
        )
        val textSecondary = ColorProvider(
            day = Color(0xFF64748B),
            night = Color(0xFFA1A1AA)
        )
        val emeraldColor = ColorProvider(Color(0xFF10B981))

        val isCompact = size.width < 180.dp

        val deepLinkAction = actionStartActivity(
            MainActivity::class.java,
            actionParametersOf(
                ActionParameters.Key<String>("deep_link") to "yourcallrule://cloudSettings"
            )
        )

        val configAction = actionStartActivity(
            WidgetConfigActivity::class.java,
            actionParametersOf(
                ActionParameters.Key<Int>(AppWidgetManager.EXTRA_APPWIDGET_ID) to appWidgetId
            )
        )

        Column(
            modifier = GlanceModifier
                .fillMaxSize()
                .background(cardBgColor)
                .cornerRadius(16.dp)
                .padding(12.dp)
                .clickable(deepLinkAction),
            verticalAlignment = Alignment.CenterVertically,
            horizontalAlignment = Alignment.Start
        ) {
            if (isCompact) {
                // 紧凑微型 Bento 胶囊
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(20.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = localizedContext.getString(R.string.app_name),
                        style = TextStyle(
                            fontSize = (12f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = textPrimary
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "⚙️",
                        style = TextStyle(fontSize = 12.sp),
                        modifier = GlanceModifier.clickable(configAction)
                    )
                }
                Spacer(modifier = GlanceModifier.height(4.dp))
                Box(
                    modifier = GlanceModifier
                        .background(ColorProvider(Color(0x2010B981)))
                        .cornerRadius(8.dp)
                        .padding(horizontal = 8.dp, vertical = 3.dp)
                ) {
                    Text(
                        text = "$totalRules ${localizedContext.getString(R.string.widget_total_rules)}",
                        style = TextStyle(
                            fontSize = (10f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = emeraldColor
                        )
                    )
                }
            } else {
                // 展开多巴胺 Bento 美学双栏层级看板
                Row(
                    modifier = GlanceModifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(22.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = localizedContext.getString(R.string.widget_rules_sync_title),
                        style = TextStyle(
                            fontSize = (13f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = textPrimary
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Box(
                        modifier = GlanceModifier
                            .background(ColorProvider(Color(0x2510B981)))
                            .cornerRadius(8.dp)
                            .padding(horizontal = 8.dp, vertical = 3.dp)
                    ) {
                        Text(
                            text = "🟢 ONLINE",
                            style = TextStyle(
                                fontSize = (9.5f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = emeraldColor
                            )
                        )
                    }
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = "⚙️",
                        style = TextStyle(fontSize = 14.sp),
                        modifier = GlanceModifier.clickable(configAction)
                    )
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                // 中部双栏 Bento 盒
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    // 左侧 Bento 盒：规则总数大字焦点
                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(8.dp)
                    ) {
                        Text(
                            text = localizedContext.getString(R.string.widget_total_rules),
                            style = TextStyle(
                                fontSize = (9.5f * fontScale).sp,
                                color = textSecondary
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = "$totalRules",
                            style = TextStyle(
                                fontSize = (20f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = textPrimary
                            )
                        )
                    }

                    Spacer(modifier = GlanceModifier.width(8.dp))

                    // 右侧 Bento 盒：服务与同步时间
                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(8.dp)
                    ) {
                        if (showDetail) {
                            Text(
                                text = "${localizedContext.getString(R.string.widget_service_label)}: $serviceType",
                                style = TextStyle(
                                    fontSize = (10.5f * fontScale).sp,
                                    fontWeight = FontWeight.Bold,
                                    color = textPrimary
                                )
                            )
                            Spacer(modifier = GlanceModifier.height(3.dp))
                        }
                        Text(
                            text = "${localizedContext.getString(R.string.widget_last_sync)}: $lastSync",
                            style = TextStyle(
                                fontSize = (9.5f * fontScale).sp,
                                color = textSecondary
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                // 底栏：流线型动作响应按钮
                Row(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .background(ColorProvider(Color(0x1810B981)))
                        .cornerRadius(10.dp)
                        .padding(horizontal = 10.dp, vertical = 6.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "🔄 ${localizedContext.getString(R.string.widget_sync_now)}",
                        style = TextStyle(
                            fontSize = (11f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = emeraldColor
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "➔",
                        style = TextStyle(
                            fontSize = (11f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = emeraldColor
                        )
                    )
                }
            }
        }
    }

    companion object {
        val KEY_TOTAL_RULES = androidx.datastore.preferences.core.intPreferencesKey("widget_total_rules")
        val KEY_LAST_SYNC = androidx.datastore.preferences.core.stringPreferencesKey("widget_last_sync")
        val KEY_SERVICE_TYPE = androidx.datastore.preferences.core.stringPreferencesKey("widget_service_type")
    }
}

class RulesSyncGlanceReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = RulesSyncGlanceWidget()
}
