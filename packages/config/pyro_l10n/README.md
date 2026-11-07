# 🌐 PyroL10n - Dynamic Localizer, Fallback Cascade & Formatting Package

`pyro_l10n` 是遵循 **“能用原生就用原生、零硬编码”** 铁律打造的 Flutter 原生 App Locale 状态管理、动态文本长词优先转译引擎 (`DynamicTextTranslator`)、句式范式转译器 (`PatternLocalizer`)、多级语言降级决议器 (`LocaleFallbackResolver`) 与格式化胶水微包。

100% 绑定 Flutter 官方原生 `gen-l10n` (`AppLocalizations` / `.arb` 字典包)、Riverpod 3.0 动态 Locale 切换与非 UI 跨层 Access，消除任何写死语言代码列表与动态第三方 API/算法数据无法国际化的痛点。

---

## 🌟 核心功能一览

1. **动态长文本转译引擎 (`DynamicTextTranslator`)**：按词条 Key 字符长度降序排列 (Greedy Longest-Match)，优先匹配长词，防止短词切碎误改；原生中文 (`zh`) 自动直通零 CPU/内存开销。
2. **结构化句式范式转译器 (`PatternLocalizer`)**：智能处理“第 X 章/页”、“共 X 页/集”等带有数字与单位的动态组合句式。
3. **零硬编码原生 RTL 布局**：通过 Flutter 原生 `Directionality.of(context)` 动态识别 `TextDirection` 与 `isRtl`。
4. **多级语言降级决议器 (`LocaleFallbackResolver`)**：支持 `zh_HK` ➔ `zh_TW` / `zh_Hant` ➔ `zh` ➔ `en` 多级智能降级配对。
5. **语言 (UI Language) 与 格式化地区 (Regional Formatting) 解耦**：允许用户 UI 界面使用英文（`en`），但货币、日期、数字等格式使用中国大陆/德国格式（`zh_CN` / `de_DE`）。
6. **非 UI / 跨层访问单例通道 (`PyroL10nGlobal`)**：支持 `PyroL10nGlobal.translateDynamicText(rawText)`，在 Toast/Dialog 数据模型、Notifier、后台服务中无 `BuildContext` 也能直接进行动态文本转译。
7. **本地化格式化扩展糖 (`PyroLocaleFormattingX`)**：支持货币格式化、数字格式化、相对时间格式化（“刚刚”、“5分钟前”）与 `context.translateDynamicText(rawText)`。
8. **SharedPreferences 自动持久化 & 防闪烁预加载**：用户手动选择的语言配置重启后自动恢复。

---

## 🚀 快速使用代码示例

### 1. 动态文本与长词优先替换 (`DynamicTextTranslator`)

```dart
// 在 UI 页面或小组件中使用拓展糖：
final translatedTitle = context.translateDynamicText('今日宜扫舍，宜出行');

// 非 UI 场景 / 后台 Service / Notifier 中直接调用：
final dynamicResult = PyroL10nGlobal.translateDynamicText('连载中 - 第 12 章');
```

### 2. 配置 MaterialApp (`gen-l10n` 原生集成 & 级联降级)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_l10n/pyro_l10n.dart';
import 'l10n/generated/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocale = ref.watch(appLocaleProvider);

    return MaterialApp(
      title: 'Pyro App',
      locale: userLocale,
      localizationsDelegates: PyroL10nHelper.combineDelegates(
        AppLocalizations.delegate,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (requested, supported) {
        return PyroL10nHelper.resolveLocale(requested, supported);
      },
      home: const HomeScreen(),
    );
  }
}
```
