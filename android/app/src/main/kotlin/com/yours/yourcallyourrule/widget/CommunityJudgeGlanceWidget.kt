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
 * 社区判官与威胁治理美学 Bento 卡片小组件
 * 100% 照搬 veherego 的 Glance ColorProvider(Color) 调色范式与深浅色模式计算
 */
class CommunityJudgeGlanceWidget : GlanceAppWidget() {

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

        val showRisk = widgetPrefs.getBoolean("widget_${appWidgetId}_show_risk", true)

        provideContent {
            GlanceTheme {
                CommunityJudgeRender(
                    alphaVal = alphaVal,
                    themeMode = themeMode,
                    fontScale = fontScale,
                    showRisk = showRisk
                )
            }
        }
    }

    @Composable
    private fun CommunityJudgeRender(
        alphaVal: Int,
        themeMode: String,
        fontScale: Float,
        showRisk: Boolean
    ) {
        val rawContext = LocalContext.current
        val localizedContext = LocaleUtils.getLocalizedContext(rawContext)
        val state = currentState<Preferences>()
        val size = LocalSize.current

        val voteCount = state[KEY_VOTE_COUNT] ?: 0
        val highRisk = state[KEY_HIGH_RISK] ?: 0
        val mediumRisk = state[KEY_MEDIUM_RISK] ?: 0
        val lowRisk = state[KEY_LOW_RISK] ?: 0
        val hotNumber = state[KEY_HOT_NUMBER] ?: "--"
        val hotTag = state[KEY_HOT_TAG] ?: "--"

        // 100% 照搬 veherego 的深浅色与透明度 ColorProvider 计算规范
        val alphaFloat = alphaVal.coerceIn(0, 100) / 100f
        val isDark = if (themeMode == "light") false else (if (themeMode == "dark") true else ((rawContext.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES))

        val baseColor = if (isDark) Color(0xFF18181B) else Color(0xFFF8FAFC)
        val cardBgColor = if (alphaFloat <= 0.01f) Color.Transparent else baseColor.copy(alpha = alphaFloat)
        val primaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFFAFAFA) else Color(0xFF0F172A)
        val secondaryTextColor = if (isDark || alphaFloat <= 0.3f) Color(0xFFA1A1AA) else Color(0xFF64748B)
        val innerBentoBg = if (isDark) Color(0x2527272A) else Color(0x15F1F5F9)
        val amberColor = Color(0xFFF59E0B)
        val redColor = Color(0xFFEF4444)
        val greenColor = Color(0xFF10B981)

        val isCompact = size.width < 180.dp

        val deepLinkAction = actionStartActivity(
            MainActivity::class.java,
            actionParametersOf(
                ActionParameters.Key<String>("deep_link") to "yourcallrule://deletionProposal"
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
                // 紧凑形态
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(20.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = "⚖️ $hotNumber",
                        style = TextStyle(
                            fontSize = (12f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(primaryTextColor)
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(4.dp))
                Box(
                    modifier = GlanceModifier
                        .background(Color(0x25F59E0B))
                        .cornerRadius(8.dp)
                        .padding(horizontal = 8.dp, vertical = 3.dp)
                ) {
                    Text(
                        text = "🏷️ $hotTag",
                        style = TextStyle(
                            fontSize = (10f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(amberColor)
                        )
                    )
                }
            } else {
                // 展开多巴胺美学 Bento 层级看板
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
                        text = localizedContext.getString(R.string.widget_community_judge_title),
                        style = TextStyle(
                            fontSize = (13f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(primaryTextColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Box(
                        modifier = GlanceModifier
                            .background(Color(0x25F59E0B))
                            .cornerRadius(8.dp)
                            .padding(horizontal = 8.dp, vertical = 3.dp)
                    ) {
                        Text(
                            text = localizedContext.getString(R.string.widget_participants, voteCount),
                            style = TextStyle(
                                fontSize = (9.5f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = ColorProvider(amberColor)
                            )
                        )
                    }
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                // 中部双栏 Bento 盒
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    // 左 Bento：号码与标记
                    Column(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .background(innerBentoBg)
                            .cornerRadius(12.dp)
                            .padding(8.dp)
                    ) {
                        Text(
                            text = "📱 $hotNumber",
                            style = TextStyle(
                                fontSize = (11.5f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = ColorProvider(primaryTextColor)
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(3.dp))
                        Text(
                            text = "🏷️ $hotTag",
                            style = TextStyle(
                                fontSize = (9.5f * fontScale).sp,
                                color = ColorProvider(secondaryTextColor)
                            )
                        )
                    }

                    Spacer(modifier = GlanceModifier.width(8.dp))

                    // 右 Bento：红黄绿三色风险 Bento 盒
                    if (showRisk) {
                        Column(
                            modifier = GlanceModifier
                                .defaultWeight()
                                .background(innerBentoBg)
                                .cornerRadius(12.dp)
                                .padding(8.dp)
                        ) {
                            Text(
                                text = "⚠️ ${localizedContext.getString(R.string.widget_risk_bento)}",
                                style = TextStyle(
                                    fontSize = (9.5f * fontScale).sp,
                                    color = ColorProvider(secondaryTextColor)
                                )
                            )
                            Spacer(modifier = GlanceModifier.height(3.dp))
                            Row {
                                Text(
                                    text = "🔴$highRisk",
                                    style = TextStyle(
                                        fontSize = (9.5f * fontScale).sp,
                                        fontWeight = FontWeight.Bold,
                                        color = ColorProvider(redColor)
                                    )
                                )
                                Spacer(modifier = GlanceModifier.width(4.dp))
                                Text(
                                    text = "🟡$mediumRisk",
                                    style = TextStyle(
                                        fontSize = (9.5f * fontScale).sp,
                                        fontWeight = FontWeight.Bold,
                                        color = ColorProvider(amberColor)
                                    )
                                )
                                Spacer(modifier = GlanceModifier.width(4.dp))
                                Text(
                                    text = "🟢$lowRisk",
                                    style = TextStyle(
                                        fontSize = (9.5f * fontScale).sp,
                                        fontWeight = FontWeight.Bold,
                                        color = ColorProvider(greenColor)
                                    )
                                )
                            }
                        }
                    }
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                // 底栏：橙色动作胶囊
                Row(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .background(Color(0x18F59E0B))
                        .cornerRadius(10.dp)
                        .padding(horizontal = 10.dp, vertical = 6.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "🗳️ ${localizedContext.getString(R.string.widget_vote_now)}",
                        style = TextStyle(
                            fontSize = (11f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(amberColor)
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "➔",
                        style = TextStyle(
                            fontSize = (11f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = ColorProvider(amberColor)
                        )
                    )
                }
            }
        }
    }

    companion object {
        val KEY_VOTE_COUNT = androidx.datastore.preferences.core.intPreferencesKey("widget_vote_count")
        val KEY_HIGH_RISK = androidx.datastore.preferences.core.intPreferencesKey("widget_high_risk")
        val KEY_MEDIUM_RISK = androidx.datastore.preferences.core.intPreferencesKey("widget_medium_risk")
        val KEY_LOW_RISK = androidx.datastore.preferences.core.intPreferencesKey("widget_low_risk")
        val KEY_HOT_NUMBER = androidx.datastore.preferences.core.stringPreferencesKey("widget_hot_number")
        val KEY_HOT_TAG = androidx.datastore.preferences.core.stringPreferencesKey("widget_hot_tag")
    }
}

class CommunityJudgeGlanceReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = CommunityJudgeGlanceWidget()
}
