package com.yours.yourcallyourrule.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
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
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.provideContent
import androidx.glance.currentState
import androidx.glance.layout.Alignment
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
import com.yours.yourcallyourrule.MainActivity
import com.yours.yourcallyourrule.R

/**
 * Dashboard 防护战报与数据看板 Jetpack Glance Compose 桌面小组件
 * 包含来自 Elite Home UI 的静态雷达盾牌图标 (ic_shield_radar)
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
        provideContent {
            GlanceTheme {
                DashboardOverviewContent()
            }
        }
    }

    @Composable
    private fun DashboardOverviewContent() {
        val context = LocalContext.current
        val state = currentState<Preferences>()
        val size = LocalSize.current

        val blockedCallsCount = state[KEY_BLOCKED_CALLS_COUNT] ?: 0
        val sim1Count = state[KEY_SIM1_COUNT] ?: 0
        val sim2Count = state[KEY_SIM2_COUNT] ?: 0
        val peakHours = state[KEY_PEAK_HOURS] ?: "--"
        val fontScale = state[KEY_FONT_SCALE]?.toFloat() ?: 1.0f

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
                .padding(12.dp)
                .clickable(deepLinkAction),
            verticalAlignment = Alignment.CenterVertically,
            horizontalAlignment = Alignment.Start
        ) {
            if (isCompact) {
                // 紧凑形态，配静态雷达盾牌
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(20.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(4.dp))
                    Text(
                        text = context.getString(R.string.widget_blocked_today),
                        style = TextStyle(
                            fontSize = (12f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(4.dp))
                Text(
                    text = "$blockedCallsCount 次",
                    style = TextStyle(
                        fontSize = (11f * fontScale).sp,
                        color = GlanceTheme.colors.onSurfaceVariant
                    )
                )
            } else {
                // 展开全量看板，包含静态雷达盾牌 Icon
                Row(
                    modifier = GlanceModifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(24.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = context.getString(R.string.widget_dashboard_overview_title),
                        style = TextStyle(
                            fontSize = (14f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(8.dp))
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Column(modifier = GlanceModifier.defaultWeight()) {
                        Text(
                            text = "${context.getString(R.string.widget_blocked_today)}: $blockedCallsCount",
                            style = TextStyle(
                                fontSize = (12f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = GlanceTheme.colors.onSurface
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = "${context.getString(R.string.widget_peak_hours)}: $peakHours",
                            style = TextStyle(
                                fontSize = (11f * fontScale).sp,
                                color = GlanceTheme.colors.onSurfaceVariant
                            )
                        )
                    }
                    Column(modifier = GlanceModifier.defaultWeight()) {
                        Text(
                            text = "${context.getString(R.string.widget_sim_distribution)}:",
                            style = TextStyle(
                                fontSize = (11f * fontScale).sp,
                                color = GlanceTheme.colors.onSurfaceVariant
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = "SIM1 [$sim1Count] | SIM2 [$sim2Count]",
                            style = TextStyle(
                                fontSize = (11f * fontScale).sp,
                                fontWeight = FontWeight.Medium,
                                color = GlanceTheme.colors.onSurface
                            )
                        )
                    }
                }
                Spacer(modifier = GlanceModifier.height(8.dp))
                Text(
                    text = "📜 ${context.getString(R.string.widget_view_logs)} ➔",
                    style = TextStyle(
                        fontSize = (11f * fontScale).sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.primary
                    )
                )
            }
        }
    }

    companion object {
        val KEY_BLOCKED_CALLS_COUNT = intPreferencesKey("widget_blocked_calls_count")
        val KEY_SIM1_COUNT = intPreferencesKey("widget_sim1_count")
        val KEY_SIM2_COUNT = intPreferencesKey("widget_sim2_count")
        val KEY_PEAK_HOURS = stringPreferencesKey("widget_peak_hours")
        val KEY_FONT_SCALE = stringPreferencesKey("widget_font_scale")
    }
}

class DashboardOverviewGlanceReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = DashboardOverviewGlanceWidget()
}
