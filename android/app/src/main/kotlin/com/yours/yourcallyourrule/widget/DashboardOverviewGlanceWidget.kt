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
 * Dashboard 防护战报美学 Bento 卡片小组件
 * 1:1 像素级复刻 Elite Home UI（截图4）：
 * 1. 移除 ⚙️ 齿轮图标，保持极简大方
 * 2. 复刻红色“立即挂断”大字 + 拦截总数
 * 3. 20.dp 通透卡片圆角
 */
class DashboardOverviewGlanceWidget : GlanceAppWidget() {

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

        val showSim = widgetPrefs.getBoolean("widget_${appWidgetId}_show_sim", true)

        provideContent {
            GlanceTheme {
                DashboardOverviewRender(
                    alphaVal = alphaVal,
                    themeMode = themeMode,
                    fontScale = fontScale,
                    showSim = showSim
                )
            }
        }
    }

    @Composable
    private fun DashboardOverviewRender(
        alphaVal: Int,
        themeMode: String,
        fontScale: Float,
        showSim: Boolean
    ) {
        val rawContext = LocalContext.current
        val localizedContext = LocaleUtils.getLocalizedContext(rawContext)
        val state = currentState<Preferences>()
        val size = LocalSize.current

        val blockedCallsCount = state[KEY_BLOCKED_CALLS_COUNT] ?: 0
        val sim1Count = state[KEY_SIM1_COUNT] ?: 0
        val sim2Count = state[KEY_SIM2_COUNT] ?: 0
        val peakHours = state[KEY_PEAK_HOURS] ?: "--"

        val alphaFloat = alphaVal.coerceIn(0, 100) / 100f
        val isDark = if (themeMode == "light") false else (if (themeMode == "dark") true else ((rawContext.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES))

        val baseColor = if (isDark) Color(0xFF18181B) else Color(0xFFFFFFFF)
        val cardBgColor = if (alphaFloat <= 0.01f) Color.Transparent else baseColor.copy(alpha = alphaFloat)
        val primaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFFAFAFA) else Color(0xFF0F172A)
        val secondaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFA1A1AA) else Color(0xFF64748B)
        val innerBentoBg = if (isDark) Color(0x2527272A) else Color(0x10000000)
        val redColor = Color(0xFFEF4444)
        val blueColor = Color(0xFF3B82F6)

        val isCompact = size.width < 180.dp

        val deepLinkAction = actionStartActivity(
            MainActivity::class.java,
            actionParametersOf(
                ActionParameters.Key<String>("deep_link") to "yourcallrule://callHistory"
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
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(20.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = localizedContext.getString(R.string.widget_blocked_today),
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
                        .background(Color(0x20EF4444))
                        .cornerRadius(8.dp)
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                ) {
                    Text(
                        text = "$blockedCallsCount ${localizedContext.getString(R.string.widget_times_unit)}",
                        style = TextStyle(
                            fontSize = (10f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(redColor)
                        )
                    )
                }
            } else {
                // 1:1 复刻截图 4 的 Elite 防护指挥舱表头
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
                        text = localizedContext.getString(R.string.widget_dashboard_overview_title),
                        style = TextStyle(
                            fontSize = (14f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(primaryTextColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Box(
                        modifier = GlanceModifier
                            .background(Color(0x203B82F6))
                            .cornerRadius(12.dp)
                            .padding(horizontal = 10.dp, vertical = 4.dp)
                    ) {
                        Text(
                            text = "🛡️ ${localizedContext.getString(R.string.widget_smart_mode)}",
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = ColorProvider(blueColor)
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(10.dp))

                // 中部 Bento 盒
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(10.dp)
                    ) {
                        Text(
                            text = localizedContext.getString(R.string.widget_blocked_today),
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                color = ColorProvider(secondaryTextColor)
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Row(verticalAlignment = Alignment.Bottom) {
                            Text(
                                text = "$blockedCallsCount",
                                style = TextStyle(
                                    fontSize = (22f * fontScale).sp,
                                    fontWeight = FontWeight.Bold,
                                    color = ColorProvider(redColor)
                                )
                            )
                            Spacer(modifier = GlanceModifier.width(3.dp))
                            Text(
                                text = localizedContext.getString(R.string.widget_times_unit),
                                style = TextStyle(
                                    fontSize = (10f * fontScale).sp,
                                    color = ColorProvider(secondaryTextColor)
                                )
                            )
                        }
                    }

                    Spacer(modifier = GlanceModifier.width(8.dp))

                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(10.dp)
                    ) {
                        if (showSim) {
                            Text(
                                text = "SIM1 [$sim1Count] · SIM2 [$sim2Count]",
                                style = TextStyle(
                                    fontSize = (11f * fontScale).sp,
                                    fontWeight = FontWeight.Bold,
                                    color = ColorProvider(primaryTextColor)
                                )
                            )
                            Spacer(modifier = GlanceModifier.height(4.dp))
                        }
                        Text(
                            text = "⏰ $peakHours",
                            style = TextStyle(
                                fontSize = (10f * fontScale).sp,
                                color = ColorProvider(secondaryTextColor)
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(10.dp))

                // 底栏：宝蓝色跳转动作胶囊
                Row(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .background(Color(0x183B82F6))
                        .cornerRadius(12.dp)
                        .padding(horizontal = 12.dp, vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "📜 ${localizedContext.getString(R.string.widget_view_logs)}",
                        style = TextStyle(
                            fontSize = (11.5f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(blueColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "➔",
                        style = TextStyle(
                            fontSize = (11.5f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(blueColor)
                        )
                    )
                }
            }
        }
    }

    companion object {
        val KEY_BLOCKED_CALLS_COUNT = androidx.datastore.preferences.core.intPreferencesKey("widget_blocked_calls_count")
        val KEY_SIM1_COUNT = androidx.datastore.preferences.core.intPreferencesKey("widget_sim1_count")
        val KEY_SIM2_COUNT = androidx.datastore.preferences.core.intPreferencesKey("widget_sim2_count")
        val KEY_PEAK_HOURS = androidx.datastore.preferences.core.stringPreferencesKey("widget_peak_hours")
    }
}

class DashboardOverviewGlanceReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = DashboardOverviewGlanceWidget()
}
