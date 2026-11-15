# 🛡️ 全量页面与 7 大微包 (7 Micro-Packages vs Elite UI) 深度物理级对照缺陷与补齐报告

> **版本 (Version)**: 4.26.0  
> **分支 (Branch)**: `pak-dev`  
> **更新时间 (Date)**: 2026-11-15  
> **对比标准**: 7 大微包 (`@phone_sim_slot_rules`, `@phone_subscription`, `@phone_marking`, `@phone_contacts`, `@phone_call_history`, `@phone_rules`, `@phone_lookup_plugin`) 页面对比原版 Elite UI 的全量富 UI 元素、交互完整度与数据闭环检查。

---

## 目录
1. [1. 双卡槽规则页面 (`@phone_sim_slot_rules`) 缺陷与补齐](#1-双卡槽规则页面-phone_sim_slot_rules-缺陷与补齐)
2. [2. 规则订阅与 Store 页面 (`@phone_subscription`) 缺陷与补齐](#2-规则订阅与-store-页面-phone_subscription-缺陷与补齐)
3. [3. 号码标记管理页面 (`@phone_marking`) 缺陷与补齐](#3-号码标记管理页面-phone_marking-缺陷与补齐)
4. [4. 通讯录管理页面 (`@phone_contacts`) 缺陷与补齐](#4-通讯录管理页面-phone_contacts-缺陷与补齐)
5. [5. 通话记录时间轴页面 (`@phone_call_history`) 缺陷与补齐](#5-通话记录时间轴页面-phone_call_history-缺陷与补齐)
6. [6. 规则库与正则拦截页面 (`@phone_rules`) 缺陷与补齐](#6-规则库与正则拦截页面-phone_rules-缺陷与补齐)
7. [7. 插件管理与调试页面 (`@phone_lookup_plugin`) 缺陷与补齐](#7-插件管理与调试页面-phone_lookup_plugin-缺陷与补齐)

---

## 1. 双卡槽规则页面 (`@phone_sim_slot_rules`) 缺陷与补齐

### 缺陷 1.1: 缺失双卡 Slot 1 / Slot 2 标签页切换器 (TabBar) 与卡槽运营商信息 Header
- **真机/代码现状**: `SimSlotRuleFilterPage` 仅通过静态路由传参 `simSlotIndex: 0` 打开单卡槽，无法在页面内一键切换 SIM 1 与 SIM 2；缺失卡槽运营商名称（Carrier Name）、网络类型（5G/LTE）与手机号卡槽 Header 卡片。
- **关联文件**: `lib/features/call_filter/presentation/pages/sim_slot_rule_filter_page.dart` & `lib/features/sim_slot_rules/widgets/sim_slot_rule_widget.dart`
- **Missing vs Elite UI**:
  - 缺失顶栏 `TabBar([Text('SIM 1'), Text('SIM 2')])` 动态分卡槽滑块选项卡；
  - 缺失运营商名卡片 `SimCarrierHeaderCard`（展示网络运营商、SIM 槽状态、逻辑电话号码）；
  - 缺失当前卡槽独占的 Filter 选项开关（基础拦截、频次拦截、云端风险）控制组；
  - 缺失右下角 `+` 新增当前卡槽独占拦截规则的悬浮按键 (FAB) 与 Dialog。

---

## 2. 规则订阅与 Store 页面 (`@phone_subscription`) 缺陷与补齐

### 缺陷 2.1: `PhoneSubscriptionPage` 缺少规则 Store 推荐分类列表、同步更新状态与 URL 手动订阅入口
- **真机/代码现状**: `PhoneSubscriptionPageRefactored` 仅拉取已保存的简单 Payload 列表；当用户在 `InitialSetupPage` / `Rule Store` 中成功订阅后，缺乏实时交互更新；且无法手动输入自定义 HTTPS/CDN 规则订阅源 URL。
- **关联文件**: `lib/features/phone_subscription/pages/phone_subscription_page_refactored.dart`
- **Missing vs Elite UI**:
  - 缺失顶部推荐分类 Banner（官方精选反诈库、区域黑名单、社区黑名单推荐）；
  - 缺失订阅卡片中的规则总条数 (Rule Count)、上次同步时间 (Last Sync Time) 与“一键立即更新”状态按钮；
  - 缺失右下角 `+` 手动输入订阅源 URL 的 FAB 按钮与弹窗（支持 URL 校验与请求头配置）；
  - 缺失顶部“一键全部更新 (Update All)”广播按钮。

---

## 3. 号码标记管理页面 (`@phone_marking`) 缺陷与补齐

### 缺陷 3.1: 缺失标记分类筛选 Chips (Tags Filter)、批量导出/删除工具栏
- **真机/代码现状**: `MarkPhoneManagementPage` 仅提供了简单的搜索框与列表，缺失顶部多标签分类筛选 Chips；批量删除缺乏全选与选中计数 Header。
- **关联文件**: `lib/features/labels/pages/mark_phone_management_page.dart` & `label_management_page.dart`
- **Missing vs Elite UI**:
  - 缺失可横向滚动的标记分类 Chips（全部、骚扰电话、诈骗电话、快递外卖、推销中介、自定义标签）；
  - 缺失标记统计摘要卡片 (`MarkStatisticsHeaderCard`)：展示总标记量、最高风险标记占比与云端 CDC 同步状态；
  - 缺失多选模式下的全选/反选与批量导出为 CSV/JSON 工具栏。

---

## 4. 通讯录管理页面 (`@phone_contacts`) 缺陷与补齐

### 缺陷 4.1: 缺失 A-Z 字母表快速检索滚动条、联系人分组 Chips 与 VCF 导入导出卡片
- **真机/代码现状**: `ContactsManagementPage` 仅显示简单列表，缺乏字母表索引定位；空数据时缺少 VCF/JSON 通讯录备份恢复引导卡片。
- **关联文件**: `lib/features/contacts/pages/contacts_management_page.dart`
- **Missing vs Elite UI**:
  - 缺失右侧 A-Z 字母快滑索引条 (Alphabet Index Scroller)；
  - 缺失顶部联系人分组 Chips（白名单联系人、黑名单联系人、星标联系人）；
  - 缺失 VCF 导入/导出面板卡片（支持从手机系统通讯录或本地 `.vcf` 一键导入）；
  - 缺失右下角 `+` 快捷新建联系人悬浮按钮 (FAB) 与联系人详情 BottomSheet。

---

## 5. 通话记录时间轴页面 (`@phone_call_history`) 缺陷与补齐

### 缺陷 5.1: 缺失通话类型筛选 Tab（全部/已接/拨出/未接/已拦截）与一键快捷动作按钮
- **真机/代码现状**: `CallHistoryPage` 仅渲染简单卡片列表，无呼叫类型分类；卡片上缺乏直接拉起拦截、添加到规则或拨号的快捷 Action。
- **关联文件**: `lib/features/call_history/pages/call_history_page.dart`
- **Missing vs Elite UI**:
  - 缺失顶部呼叫类型 Segmented 控制栏（`全部` | `来电` | `去电` | `未接` | `已拦截`）；
  - 缺失时间轴节点视觉线（Timeline Node Line）；
  - 缺失卡片右侧一键快捷动作组：【一键加入规则】、【一键标记号码】、【一键回拨】；
  - 缺失顶部今日通话拦截统计小 Banner（今日来电总数、拦截占比、识别响应时延）。

---

## 6. 规则库与正则拦截页面 (`@phone_rules`) 缺陷与补齐

### 缺陷 6.1: 缺失 Allow / Block / Regex 规则分类切换器、Regex 在线测试工作台与规则导入导出
- **真机/代码现状**: 规则管理页面（`AllowedBlockedPage`、`RuleManagementPage`、`RegexRulePage`）分散拆分，缺乏统一的工作台控制面板与实时正则表达式测试工具。
- **关联文件**: `lib/features/phone_rules/pages/` (全量规则页面)
- **Missing vs Elite UI**:
  - 缺失统一的规则切换 Segmented Control（`放行白名单` | `拦截黑名单` | `正则表达式模式`）；
  - 缺失 `Regex Test Workbench` 在线正则测试卡片：允许用户输入测试号码，实时高亮匹配结果与拦截动作；
  - 缺失规则批量导入/导出（Import Rules from JSON/TXT / Export Rules）；
  - 缺失每条规则的优先级 (Priority Order) 拖拽排序与单条一键开启/关闭 Switch 开关。

---

## 7. 插件管理与调试页面 (`@phone_lookup_plugin`) 缺陷与补齐

### 缺陷 7.1: 缺失 JS/API 插件在线沙盒测试工具、社区插件市场列表与 Isolate 执行控制台
- **真机/代码现状**: `PluginManagementPage` 仅列出了已安装插件，缺失插件代码沙盒测试、日志输出与社区插件市场一键安装。
- **关联文件**: `lib/features/phone_plugin/pages/plugin_management_page.dart`
- **Missing vs Elite UI**:
  - 缺失 `Plugin Sandbox Tester` 插件测试器：可输入测试号码并点击“测试运行”，查看 JS/REST API 的实际 Response JSON；
  - 缺失社区插件推荐市场 (Community Plugin Market)：包括 Truecaller 插件、CleverDialer 插件、ShouldIAnswer 插件一键挂载；
  - 缺失后台 Isolate 线程执行耗时 (ms) 与内存占用 Console 日志面板；
  - 缺失插件权限控制与优先级配置。

---

## 总结整改行动路线 (Action Plan)

1. **第一阶段 (UI 补齐)**：在 7 大微包页面中补齐 Tabs、Segmented Controls、快捷动作组与搜索筛选 Chips；
2. **第二阶段 (交互闭环)**：补齐全量右下角 `+` 悬浮 FAB 按钮与一键导入导出/测试弹窗；
3. **第三阶段 (100% 单元测试覆盖)**：为这 7 大微包页面编写专篇 UI 与数据流单元测试，确保无 NoSuchMethodError 崩溃、100% PASS 绿灯落盘。
