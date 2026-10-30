package com.yours.yourcallyourrule.widget

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
 * 1:1 像素级复刻 Elite Home UI（截图4）的高保真美学小组件：
 * 1. 彻底移除右上角杂乱的 ⚙️ 图标，恢复极简透亮顶栏
 * 2. 复刻 Elite Home "● 已启用" 翡翠绿胶囊
 * 3. 复刻内嵌 Bento 盒与多巴胺渐变响应按钮
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

        val baseColor = if (isDark) Color(0xFF18181B) else Color(0xFFFFFFFF)
        val cardBgColor = if (alphaFloat <= 0.01f) Color.Transparent else baseColor.copy(alpha = alphaFloat)
        val primaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFFAFAFA) else Color(0xFF0F172A)
        val secondaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFA1A1AA) else Color(0xFF64748B)
        val innerBentoBg = if (isDark) Color(0x2527272A) else Color(0x10000000)
        val emeraldColor = Color(0xFF10B981)

        val isCompact = size.width < 180.dp

        val deepLinkAction = actionStartActivity(
            MainActivity::class.java,
            actionParametersOf(
                ActionParameters.Key<String>("deep_link") to "yourcallrule://cloudSettings"
            )
        )

        Column(
            modifier = GlanceModifier
                .fillMaxSize()
                .background(cardBgColor)
                .cornerRadius(20.dp)
                .padding(14.dp)
                .clickable(deepLinkAction),
            verticalAlignment = Alignment.CenterVertically,
            horizontalAlignment = Alignment.Start
        ) {
            if (isCompact) {
                // 紧凑卡片（复刻 1:1 Elite 盾牌标志）
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
                            color = ColorProvider(primaryTextColor)
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(6.dp))
                Box(
                    modifier = GlanceModifier
                        .background(Color(0x2010B981))
                        .cornerRadius(8.dp)
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                ) {
                    Text(
                        text = "$totalRules ${localizedContext.getString(R.string.widget_total_rules)}",
                        style = TextStyle(
                            fontSize = (10f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(emeraldColor)
                        )
                    )
                }
            } else {
                // 1:1 复刻截图 4 的 Elite Home 顶部极简干净表头 (无丑陋 ⚙️ 图标)
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
                        text = localizedContext.getString(R.string.app_name),
                        style = TextStyle(
                            fontSize = (14f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(primaryTextColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    // 1:1 复刻截图 4 的 "● 已启用" 翡翠绿胶囊
                    Box(
                        modifier = GlanceModifier
                            .background(Color(0x2010B981))
                            .cornerRadius(12.dp)
                            .padding(horizontal = 10.dp, vertical = 4.dp)
                    ) {
                        Text(
                            text = "● 已启用",
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = ColorProvider(emeraldColor)
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(10.dp))

                // 中部内嵌 Bento 盒（复刻截图 4 的智能防护信息区）
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(10.dp)
                    ) {
                        Text(
                            text = localizedContext.getString(R.string.widget_total_rules),
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                color = ColorProvider(secondaryTextColor)
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = "$totalRules",
                            style = TextStyle(
                                fontSize = (22f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = ColorProvider(primaryTextColor)
                            )
                        )
                    }

                    Spacer(modifier = GlanceModifier.width(8.dp))

                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(10.dp)
                    ) {
                        if (showDetail) {
                            Text(
                                text = "${localizedContext.getString(R.string.widget_service_label)}: $serviceType",
                                style = TextStyle(
                                    fontSize = (11f * fontScale).sp,
                                    fontWeight = FontWeight.Bold,
                                    color = ColorProvider(primaryTextColor)
                                )
                            )
                            Spacer(modifier = GlanceModifier.height(4.dp))
                        }
                        Text(
                            text = "${localizedContext.getString(R.string.widget_last_sync)}: $lastSync",
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                color = ColorProvider(secondaryTextColor)
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(10.dp))

                // 底栏：1:1 复刻截图 4 的多巴胺翡翠绿响应胶囊
                Row(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .background(Color(0x1810B981))
                        .cornerRadius(12.dp)
                        .padding(horizontal = 12.dp, vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "🔄 ${localizedContext.getString(R.string.widget_sync_now)}",
                        style = TextStyle(
                            fontSize = (11.5f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(emeraldColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "➔",
                        style = TextStyle(
                            fontSize = (11.5f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(emeraldColor)
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
