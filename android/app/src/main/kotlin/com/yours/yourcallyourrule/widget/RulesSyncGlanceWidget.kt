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
 * 规则与数据库同步状态 Jetpack Glance Compose 桌面小组件
 * 依 Elite Home UI 设计：包含静态雷达科技盾牌 (ProfessionalShieldRadar 静态拟态)
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
        provideContent {
            GlanceTheme {
                RulesSyncWidgetContent()
            }
        }
    }

    @Composable
    private fun RulesSyncWidgetContent() {
        val context = LocalContext.current
        val state = currentState<Preferences>()
        val size = LocalSize.current

        val totalRules = state[KEY_TOTAL_RULES] ?: 0
        val lastSync = state[KEY_LAST_SYNC] ?: "--"
        val serviceType = state[KEY_SERVICE_TYPE] ?: "WebDAV"
        val fontScale = state[KEY_FONT_SCALE]?.toFloat() ?: 1.0f

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
                .padding(12.dp)
                .clickable(deepLinkAction),
            verticalAlignment = Alignment.CenterVertically,
            horizontalAlignment = Alignment.Start
        ) {
            if (isCompact) {
                // 紧凑形态，配静态雷达盾牌图标
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Image(
                        provider = ImageProvider(R.drawable.ic_shield_radar),
                        contentDescription = "Shield Radar",
                        modifier = GlanceModifier.size(20.dp)
                    )
                    Spacer(modifier = GlanceModifier.width(4.dp))
                    Text(
                        text = context.getString(R.string.app_name),
                        style = TextStyle(
                            fontSize = (12f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(4.dp))
                Text(
                    text = "$totalRules ${context.getString(R.string.widget_total_rules)} | 🟢 ONLINE",
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
                        text = context.getString(R.string.widget_rules_sync_title),
                        style = TextStyle(
                            fontSize = (14f * fontScale).sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Text(
                        text = "🟢 ONLINE",
                        style = TextStyle(
                            fontSize = (10f * fontScale).sp,
                            fontWeight = FontWeight.Medium,
                            color = GlanceTheme.colors.primary
                        )
                    )
                }
                Spacer(modifier = GlanceModifier.height(8.dp))
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Column(modifier = GlanceModifier.defaultWeight()) {
                        Text(
                            text = "${context.getString(R.string.widget_total_rules)}: $totalRules",
                            style = TextStyle(
                                fontSize = (12f * fontScale).sp,
                                fontWeight = FontWeight.Bold,
                                color = GlanceTheme.colors.onSurface
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = "服务: $serviceType",
                            style = TextStyle(
                                fontSize = (11f * fontScale).sp,
                                color = GlanceTheme.colors.onSurfaceVariant
                            )
                        )
                    }
                    Column(modifier = GlanceModifier.defaultWeight()) {
                        Text(
                            text = "${context.getString(R.string.widget_last_sync)}:",
                            style = TextStyle(
                                fontSize = (11f * fontScale).sp,
                                color = GlanceTheme.colors.onSurfaceVariant
                            )
                        )
                        Spacer(modifier = GlanceModifier.height(2.dp))
                        Text(
                            text = lastSync,
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
                    text = "🔄 ${context.getString(R.string.widget_sync_now)} ➔",
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
        val KEY_TOTAL_RULES = intPreferencesKey("widget_total_rules")
        val KEY_LAST_SYNC = stringPreferencesKey("widget_last_sync")
        val KEY_SERVICE_TYPE = stringPreferencesKey("widget_service_type")
        val KEY_FONT_SCALE = stringPreferencesKey("widget_font_scale")
    }
}

class RulesSyncGlanceReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = RulesSyncGlanceWidget()
}
