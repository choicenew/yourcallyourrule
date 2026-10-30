package com.yours.yourcallyourrule.widget

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.Gravity
import android.view.View
import android.widget.*
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.state.updateAppWidgetState
import androidx.glance.state.PreferencesGlanceStateDefinition
import androidx.datastore.preferences.core.stringPreferencesKey
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import com.yours.yourcallyourrule.R
import com.yours.yourcallyourrule.utils.LocaleUtils

/**
 * 桌面小组件独立配置向导 Activity
 * 100% 照搬 veherego 的 WidgetConfigActivity 布局结构与深浅色模式算色
 */
class WidgetConfigActivity : Activity() {

    private var appWidgetId = AppWidgetManager.INVALID_APPWIDGET_ID
    private lateinit var alphaSeekBar: SeekBar
    private lateinit var alphaPercentText: TextView
    private lateinit var fontScaleSeekBar: SeekBar
    private lateinit var fontScaleText: TextView
    private var cbShowDetail: CheckBox? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setResult(RESULT_CANCELED)

        val extras = intent.extras
        if (extras != null) {
            appWidgetId = extras.getInt(
                AppWidgetManager.EXTRA_APPWIDGET_ID,
                AppWidgetManager.INVALID_APPWIDGET_ID
            )
        }

        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        val localizedContext = LocaleUtils.getLocalizedContext(this)
        val prefs = getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)

        // 100% 照搬 veherego 的深浅色模式与背景色设置
        val isNight = (resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK) == android.content.res.Configuration.UI_MODE_NIGHT_YES
        val bgDark = Color.parseColor("#0F172A")
        val bgLight = Color.parseColor("#F8FAFC")
        val cardBgDark = Color.parseColor("#1E293B")
        val cardBgLight = Color.parseColor("#FFFFFF")

        val txtMainColor = if (isNight) Color.WHITE else Color.parseColor("#0F172A")
        val txtMutedColor = if (isNight) Color.parseColor("#94A3B8") else Color.parseColor("#64748B")
        val accentColor = Color.parseColor("#10B981")
        val bgColor = if (isNight) bgDark else bgLight
        val cardBg = if (isNight) cardBgDark else cardBgLight

        window.statusBarColor = bgColor
        window.navigationBarColor = bgColor
        window.decorView.setBackgroundColor(bgColor)

        fun dp(dpVal: Float): Int = (dpVal * resources.displayMetrics.density).toInt()

        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(20f), dp(20f), dp(20f), dp(48f))
            setBackgroundColor(bgColor)
        }

        // 标题区
        val headerLayout = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            setPadding(0, 0, 0, dp(16f))
        }

        val titleText = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_title)
            textSize = 20f
            setTextColor(txtMainColor)
        }
        headerLayout.addView(titleText)
        rootLayout.addView(headerLayout)

        // 1. 不透明度控制卡片
        val alphaCard = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(16f), dp(14f), dp(16f), dp(14f))
            setBackgroundColor(cardBg)
        }

        val alphaLabelRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }

        val alphaLabel = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_opacity)
            textSize = 14f
            setTextColor(txtMutedColor)
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f)
        }
        alphaLabelRow.addView(alphaLabel)

        val currentAlpha = prefs.getInt("widget_${appWidgetId}_alpha", 100)
        alphaPercentText = TextView(this).apply {
            text = "$currentAlpha%"
            textSize = 15f
            setTextColor(accentColor)
        }
        alphaLabelRow.addView(alphaPercentText)
        alphaCard.addView(alphaLabelRow)

        alphaSeekBar = SeekBar(this).apply {
            max = 100
            progress = currentAlpha
            setPadding(0, dp(12f), 0, dp(4f))
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(sb: SeekBar?, progress: Int, fromUser: Boolean) {
                    alphaPercentText.text = "$progress%"
                }
                override fun onStartTrackingTouch(sb: SeekBar?) {}
                override fun onStopTrackingTouch(sb: SeekBar?) {}
            })
        }
        alphaCard.addView(alphaSeekBar)
        rootLayout.addView(alphaCard)

        val spacer1 = View(this).apply {
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, dp(12f))
        }
        rootLayout.addView(spacer1)

        // 2. 字号缩放控制卡片
        val fontCard = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(16f), dp(14f), dp(16f), dp(14f))
            setBackgroundColor(cardBg)
        }

        val fontLabelRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }

        val fontLabel = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_font_scale)
            textSize = 14f
            setTextColor(txtMutedColor)
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f)
        }
        fontLabelRow.addView(fontLabel)

        val currentScaleInt = (prefs.getFloat("widget_${appWidgetId}_font_scale", 1.0f) * 100).toInt()
        fontScaleText = TextView(this).apply {
            text = "$currentScaleInt%"
            textSize = 15f
            setTextColor(accentColor)
        }
        fontLabelRow.addView(fontScaleText)
        fontCard.addView(fontLabelRow)

        fontScaleSeekBar = SeekBar(this).apply {
            max = 150
            progress = currentScaleInt.coerceIn(80, 150)
            setPadding(0, dp(12f), 0, dp(4f))
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(sb: SeekBar?, progress: Int, fromUser: Boolean) {
                    fontScaleText.text = "${progress.coerceAtLeast(80)}%"
                }
                override fun onStartTrackingTouch(sb: SeekBar?) {}
                override fun onStopTrackingTouch(sb: SeekBar?) {}
            })
        }
        fontCard.addView(fontScaleSeekBar)
        rootLayout.addView(fontCard)

        val spacer2 = View(this).apply {
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, dp(12f))
        }
        rootLayout.addView(spacer2)

        // 3. 显示选项 CheckBox
        cbShowDetail = CheckBox(this).apply {
            text = localizedContext.getString(R.string.widget_config_show_breakdown)
            isChecked = prefs.getBoolean("widget_${appWidgetId}_show_detail", true)
            textSize = 14f
            setTextColor(txtMainColor)
            setPadding(dp(8f), dp(12f), dp(8f), dp(12f))
        }
        rootLayout.addView(cbShowDetail)

        val spacer3 = View(this).apply {
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, dp(16f))
        }
        rootLayout.addView(spacer3)

        // 4. 保存按钮
        val saveBtn = Button(this).apply {
            text = localizedContext.getString(R.string.widget_config_save)
            textSize = 15f
            setTextColor(Color.WHITE)
            setBackgroundColor(accentColor)
            setPadding(0, dp(16f), 0, dp(16f))
            setOnClickListener {
                savePreferencesAndFinish()
            }
        }
        rootLayout.addView(saveBtn)

        val scrollView = ScrollView(this).apply {
            isFillViewport = true
            setBackgroundColor(bgColor)
            addView(rootLayout)
        }

        setContentView(scrollView)
    }

    private fun savePreferencesAndFinish() {
        val prefs = getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)
        val alphaVal = alphaSeekBar.progress
        val fontScaleVal = (fontScaleSeekBar.progress.coerceAtLeast(80) / 100.0f)
        val showDetailVal = cbShowDetail?.isChecked ?: true

        // 强实例隔离写入
        prefs.edit()
            .putInt("widget_${appWidgetId}_alpha", alphaVal)
            .putFloat("widget_${appWidgetId}_font_scale", fontScaleVal)
            .putBoolean("widget_${appWidgetId}_show_detail", showDetailVal)
            .commit()

        val context = this
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val glanceManager = GlanceAppWidgetManager(context)
                val rulesGlanceId = glanceManager.getGlanceIdBy(appWidgetId)
                if (rulesGlanceId != null) {
                    updateAppWidgetState(context, PreferencesGlanceStateDefinition, rulesGlanceId) { state ->
                        state.toMutablePreferences().also {
                            it[stringPreferencesKey("widget_font_scale")] = fontScaleVal.toString()
                        }
                    }
                    RulesSyncGlanceWidget().update(context, rulesGlanceId)
                    DashboardOverviewGlanceWidget().update(context, rulesGlanceId)
                    CommunityJudgeGlanceWidget().update(context, rulesGlanceId)
                }
            } catch (_: Exception) {
            }
        }

        val resultValue = Intent()
        resultValue.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
        setResult(RESULT_OK, resultValue)
        finish()
    }
}
