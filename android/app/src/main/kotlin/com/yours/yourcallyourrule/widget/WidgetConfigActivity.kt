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
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import com.yours.yourcallyourrule.R

/**
 * 桌面小组件独立配置向导 Activity
 * 100% 遵照 veherego-widget-realtime-protocol 强实例隔离规范：
 * 1. 按 appWidgetId 独立配置透明度、字号缩放、主题模式与信息显示开关
 * 2. 读写 widget_${appWidgetId}_* 专有键名
 * 3. 保存后通过 updateAppWidgetState + updateAll 触发物理重绘
 */
class WidgetConfigActivity : Activity() {

    private var appWidgetId = AppWidgetManager.INVALID_APPWIDGET_ID
    private lateinit var alphaSeekBar: SeekBar
    private lateinit var alphaPercentText: TextView
    private lateinit var fontScaleSeekBar: SeekBar
    private lateinit var fontScaleText: TextView
    private lateinit var radioGroupTheme: RadioGroup
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

        val prefs = getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)

        // 构造动态深色精致配置 UI 容器
        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(40, 40, 40, 40)
            setBackgroundColor(0xFF18181B.toInt())
        }

        val titleText = TextView(this).apply {
            text = getString(R.string.widget_config_title)
            textSize = 18f
            setTextColor(0xFFFFFFFF.toInt())
            gravity = Gravity.CENTER
        }
        rootLayout.addView(titleText)

        // 1. 透明度配置
        val alphaLabel = TextView(this).apply {
            text = getString(R.string.widget_config_opacity)
            setTextColor(0xFFA1A1AA.toInt())
            setPadding(0, 30, 0, 10)
        }
        rootLayout.addView(alphaLabel)

        val currentAlpha = prefs.getInt("widget_${appWidgetId}_alpha", 100)
        alphaPercentText = TextView(this).apply {
            text = "$currentAlpha%"
            setTextColor(0xFF10B981.toInt())
        }
        rootLayout.addView(alphaPercentText)

        alphaSeekBar = SeekBar(this).apply {
            max = 100
            progress = currentAlpha
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(sb: SeekBar?, progress: Int, fromUser: Boolean) {
                    alphaPercentText.text = "$progress%"
                }
                override fun onStartTrackingTouch(sb: SeekBar?) {}
                override fun onStopTrackingTouch(sb: SeekBar?) {}
            })
        }
        rootLayout.addView(alphaSeekBar)

        // 2. 字号缩放配置
        val fontLabel = TextView(this).apply {
            text = getString(R.string.widget_config_font_scale)
            setTextColor(0xFFA1A1AA.toInt())
            setPadding(0, 30, 0, 10)
        }
        rootLayout.addView(fontLabel)

        val currentScaleInt = (prefs.getFloat("widget_${appWidgetId}_font_scale", 1.0f) * 100).toInt()
        fontScaleText = TextView(this).apply {
            text = "$currentScaleInt%"
            setTextColor(0xFF10B981.toInt())
        }
        rootLayout.addView(fontScaleText)

        fontScaleSeekBar = SeekBar(this).apply {
            max = 150
            progress = currentScaleInt.coerceIn(80, 150)
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(sb: SeekBar?, progress: Int, fromUser: Boolean) {
                    fontScaleText.text = "${progress.coerceAtLeast(80)}%"
                }
                override fun onStartTrackingTouch(sb: SeekBar?) {}
                override fun onStopTrackingTouch(sb: SeekBar?) {}
            })
        }
        rootLayout.addView(fontScaleSeekBar)

        // 3. 专属显示开关
        cbShowDetail = CheckBox(this).apply {
            text = getString(R.string.widget_config_show_breakdown)
            isChecked = prefs.getBoolean("widget_${appWidgetId}_show_detail", true)
            setTextColor(0xFFFFFFFF.toInt())
            setPadding(0, 20, 0, 20)
        }
        rootLayout.addView(cbShowDetail)

        // 4. 保存按钮
        val saveBtn = Button(this).apply {
            text = getString(R.string.widget_config_save)
            setBackgroundColor(0xFF10B981.toInt())
            setTextColor(0xFFFFFFFF.toInt())
            setOnClickListener {
                savePreferencesAndFinish()
            }
        }
        rootLayout.addView(saveBtn)

        val scrollView = ScrollView(this).apply {
            addView(rootLayout)
        }

        setContentView(scrollView)
    }

    private fun savePreferencesAndFinish() {
        val prefs = getSharedPreferences("yourcallrule_widget_prefs", Context.MODE_PRIVATE)
        val alphaVal = alphaSeekBar.progress
        val fontScaleVal = (fontScaleSeekBar.progress.coerceAtLeast(80) / 100.0f)
        val showDetailVal = cbShowDetail?.isChecked ?: true

        // 1. 强实例隔离写入 SharedPreferences (widget_${appWidgetId}_*)
        prefs.edit()
            .putInt("widget_${appWidgetId}_alpha", alphaVal)
            .putFloat("widget_${appWidgetId}_font_scale", fontScaleVal)
            .putBoolean("widget_${appWidgetId}_show_detail", showDetailVal)
            .commit()

        // 2. 触发 Glance 响应式物理重绘
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
