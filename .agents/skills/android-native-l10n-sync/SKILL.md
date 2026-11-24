---
name: android-native-l10n-sync
description: 规定 Flutter ARB 多语言与 Android 原生资源 (strings.xml) 自动全量同步规范、AAPT 资源展平 (flattening) 转义安全标准与无特例零硬编码机制。
---

# Android 原生多语言同步规范 (Android Native L10n Sync Specification)

本规范定义了从 Flutter 官方多语言资源文件（`lib/l10n/app_*.arb`）到 Android 原生资源（`android/app/src/main/res/values-*/strings.xml`）的自动化全量同步标准，完全对齐标准化 `mix` 架构。

---

## 1. 核心架构与设计原则

1. **单一事实来源 (Single Source of Truth)**
   - Flutter 端的 ARB 文件（`lib/l10n/app_*.arb` 47+ 种语言）为整个工程的多语言唯一维护源头。
   - 严禁在 Android 原生层手工散乱维护、新增生造非标准资源词条（全面废除 `widget_*` 等孤岛前缀）。
   - Android 原生端（Kotlin 代码、Glance 小组件、XML 布局文件、AndroidManifest）直接使用 ARB 中转为 `snake_case` 的标准键名：
     - `syncNow` -> `R.string.sync_now` (`@string/sync_now`)
     - `lastSyncLabel` -> `R.string.last_sync_label` (`@string/last_sync_label`)
     - `totalBlocked` -> `R.string.total_blocked` (`@string/total_blocked`)
     - `unblocked` -> `R.string.unblocked` (`@string/unblocked`)
     - `communityVotes` -> `R.string.community_votes` (`@string/community_votes`)
     - `communityImpact` -> `R.string.community_impact` (`@string/community_impact`)
     - `saveSettings` -> `R.string.save_settings` (`@string/save_settings`)

2. **100% 数据驱动导出 (Data-Driven Export)**
   - 同步脚本 `tools/sync_l10n.dart` 不维护任何特殊映射表，纯净直出：
     - 自动扫描解析全量 ARB 资产文件。
     - 遍历所有 Key 并将 camelCase 转换为 snake_case。
     - 为 Android 48 门语言目录全量生成合规的 `strings.xml`。

3. **目录自动映射 (Dynamic Locales)**
   - 自动映射到 Android 国际化 values 目录：
     - `en` -> `values/strings.xml`（Android 默认兜底基准）
     - `zh` -> `values-zh/strings.xml`
     - `zh_CN` -> `values-zh-rCN/strings.xml`
     - `zh_HK` -> `values-zh-rHK/strings.xml`
     - `zh_TW` -> `values-zh-rTW/strings.xml`
     - `fil` -> `values-fil/strings.xml`
     - 其余所有语言代码均自动对齐对应 `values-{locale}` 规范目录。

---

## 2. AAPT 资源转义安全标准

1. **递归清除冗余转义**
   - 字符串在写入 XML 前，先循环消除多重裸反斜杠（`\'`、`\"`、`\\`）。
2. **标准 XML 实体转义**
   - 遵照 AAPT 规范：`&` -> `&amp;`，`<` -> `&lt;`，`>` -> `&gt;`，`"` -> `&quot;`，`'` -> `\'`。
   - 绝不产生非法的多重转义反斜杠，彻底杜绝 AAPT flatten 报错。

---

## 3. 标准同步命令

项目根目录中常驻同步脚本：`tools/sync_l10n.dart`。

```bash
dart tools/sync_l10n.dart
```
