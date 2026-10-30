package com.yours.yourcallyourrule.widget

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
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
 * Elite 桌面小组件独立配置向导 Activity
 * 100% 对齐 Elite Home UI 精致深色卡片质感，解决底部空白与未对齐问题
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

        val intent = intent
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

        // 精致 Material 3 深色全屏容器
        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 48, 48, 48)
            setBackgroundColor(0xFF121214.toInt())
        }

        // 顶栏 Header
        val headerLayout = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            setPadding(0, 0, 0, 32)
        }

        val titleText = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_title)
            textSize = 20f
            setTextColor(0xFFFFFFFF.toInt())
            paint.isFakeBoldText = true
        }
        headerLayout.addView(titleText)
        rootLayout.addView(headerLayout)

        // 1. 不透明度控制卡片
        val alphaCard = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(32, 28, 32, 28)
            setBackgroundColor(0xFF1E1E22.toInt())
        }

        val alphaLabelRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }

        val alphaLabel = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_opacity)
            textSize = 14f
            setTextColor(0xFFA1A1AA.toInt())
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f)
        }
        alphaLabelRow.addView(alphaLabel)

        val currentAlpha = prefs.getInt("widget_${appWidgetId}_alpha", 100)
        alphaPercentText = TextView(this).apply {
            text = "$currentAlpha%"
            textSize = 15f
            setTextColor(0xFF10B981.toInt())
            paint.isFakeBoldText = true
        }
        alphaLabelRow.addView(alphaPercentText)
        alphaCard.addView(alphaLabelRow)

        alphaSeekBar = SeekBar(this).apply {
            max = 100
            progress = currentAlpha
            setPadding(0, 24, 0, 8)
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
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 24)
        }
        rootLayout.addView(spacer1)

        // 2. 字号按比例缩放控制卡片
        val fontCard = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(32, 28, 32, 28)
            setBackgroundColor(0xFF1E1E22.toInt())
        }

        val fontLabelRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }

        val fontLabel = TextView(this).apply {
            text = localizedContext.getString(R.string.widget_config_font_scale)
            textSize = 14f
            setTextColor(0xFFA1A1AA.toInt())
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f)
        }
        fontLabelRow.addView(fontLabel)

        val currentScaleInt = (prefs.getFloat("widget_${appWidgetId}_font_scale", 1.0f) * 100).toInt()
        fontScaleText = TextView(this).apply {
            text = "$currentScaleInt%"
            textSize = 15f
            setTextColor(0xFF10B981.toInt())
            paint.isFakeBoldText = true
        }
        fontLabelRow.addView(fontScaleText)
        fontCard.addView(fontLabelRow)

        fontScaleSeekBar = SeekBar(this).apply {
            max = 150
            progress = currentScaleInt.coerceIn(80, 150)
            setPadding(0, 24, 0, 8)
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
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 24)
        }
        rootLayout.addView(spacer2)

        // 3. 显示选项 CheckBox
        cbShowDetail = CheckBox(this).apply {
            text = localizedContext.getString(R.string.widget_config_show_breakdown)
            isChecked = prefs.getBoolean("widget_${appWidgetId}_show_detail", true)
            textSize = 14f
            setTextColor(0xFFFFFFFF.toInt())
            setPadding(16, 24, 16, 24)
        }
        rootLayout.addView(cbShowDetail)

        val spacer3 = View(this).apply {
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 32)
        }
        rootLayout.addView(spacer3)

        // 4. 精致保存按钮
        val saveBtn = Button(this).apply {
            text = localizedContext.getString(R.string.widget_config_save)
            textSize = 15f
            setTextColor(0xFFFFFFFF.toInt())
            setBackgroundColor(0xFF10B981.toInt())
            setPadding(0, 32, 0, 32)
            setOnClickListener {
                savePreferencesAndFinish()
            }
        }
        rootLayout.addView(saveBtn)

        val scrollView = ScrollView(this).apply {
            isFillViewport = true
            setBackgroundColor(0xFF121214.toInt())
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
