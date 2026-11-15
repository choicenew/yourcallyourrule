# `packages` 子系统与开源 Reference 参考库物理源码全量比对核查报告

## 一、 报告执行说明与核查原则

本报告**100% 摒弃了表面 Readme/文档说明**（Readme 往往存在功能遗漏或滞后），**严格基于对 11 个开源参考项目**（`CallShield`、`saracroche-android`、`Silence`、`SpamBlocker`/`SpamBlocker-Extended`、`web26-050-call-blocker`、`OpenCallShield`、`JemRec`、`Corta-Spam`、`SpamSniper`、`CallerID`/`calltelemetry`、`yourcallrule`）的**物理源码文件（Kotlin / Java / Dart / Swift）**的深度审计。

将参考库中的每一个**物理代码实际功能**，与我们工程的子包目录（`packages/*`）以及主 App 目录（`lib/*`）的实现现状进行了精准的四态分类比对：

- 🟢 **状态一【Package 和主 App 均已实现并集成】**：Package 子模块与主 App (`lib/features`) 均已完整落地并联调。
- 🟡 **状态二【Package 已实现，但主 App 未接入/未接满】**：Package 已具备对应 Dart/Native 驱动或接口，但主 App 界面或 Coordinator 尚未组装或暴露配置。
- 🟠 **状态三【Package 未独立抽包，主 App 直接做了部分】**：Package 缺失独立子包，主 App 代码库中直接硬编码/编写了部分替代逻辑。
- 🔴 **状态四【Package 和主 App 均未实现 / 完全缺失】**：参考库中有明确代码实现，但我们的 Package 和主 App 均完全缺失。

---

## 二、 全量参考库物理源码功能比对核查矩阵 (41 项完整功能)

| 序号 | 所属参考库与物理源码类名/文件 | 参考库实际功能与代码工作机制 | 本工程集成状态 | 代码事实对比与缺失/差距说明 |
| :--- | :--- | :--- | :--- | :--- |
| **1** | **`CallShield`**<br>`CategoryCallPolicy.kt`<br>`CallCategoryResolver.kt` | **按 Label 标签重定向/覆写最终处置行为**：根据数据库 Tag (FCC/FTC)/ML/特征推导 Label (催收/政治/诈骗/营销等)，并根据用户对该 Label 配置的 4 态动作 (`Inherit`/`Allow`/`Silence`/`Block`) 强行覆写最终拦截行为。 | 🟡 **Package已实现基础<br>缺失覆写引擎** | `packages/phone_call_interception_policy` 仅有动作枚举，缺少 Label 推导与策略覆写逻辑；主 App 缺少 Label 策略矩阵控制 Sheet。 |
| **2** | **`CallShield`**<br>`CallRedirectionService.kt` | **呼出防诈重定向与确认**：利用 `ROLE_CALL_REDIRECTION` 在外拨前拦截高危/付费/诈骗号码，挂起拨号并弹窗确认 "Call Anyway"。 | 🔴 **完全缺失** | `packages/telephony` 仅有角色状态查询，无 Kotlin `CallRedirectionService` 服务实现，主 App 亦无呼出确认通知。 |
| **3** | **`CallShield`**<br>`ExpectingCallTileService.kt` | **“期待电话”降级放行 Tile**：Quick Settings 快捷开关，临时开启 1h/3h/午夜豁免期，放行未知号码响铃但保持黑名单阻断。 | 🟡 **Package已实现<br>主App未接满** | `packages/tile/pyro_tile_driver` 已有 `QuickSettingsTileService.kt`，但主 App `lib/features/home` 未暴露倒计时与临时放行面板。 |
| **4** | **`CallShield` / `saracroche`**<br>`NotificationListenerService.kt` | **免 SMS 权限通知级消息拦截**：监听默认短信、WhatsApp、Telegram 等通知，匹配垃圾规则时调用 `cancelNotification` 消除通知。 | 🟡 **Package已实现<br>主App未接满** | `packages/sms` 实现了通知监听与清除，但主 App 未在设置中暴露针对第三方 IM（RCS/WhatsApp）通知拦截的开关与策略。 |
| **5** | **`CallShield`**<br>`SpamMLScorer.kt` | **端侧 20 维 GBT 机器学习打分**：纯 Kotlin 使用 20 个本地特征（免费前缀/连号比例/叫号时刻 sin/cos 编码等）运行梯度提升树 (GBT) 模型。 | 🔴 **完全缺失** | `packages/phone_call_filter` 仅依赖正则与硬编码规则，缺少端侧 ML 概率打分模型与特征提取器。 |
| **6** | **`CallShield`**<br>`SmsContentAnalyzer.kt` | **短彩信钓鱼短链与高危 TLD 分析**：提取文本中的短链 (`bit.ly` 等) 解包与高危 TLD (`.xyz`/`.icu`)，结合 PhishTank/OpenPhish 校验。 | 🔴 **完全缺失** | `packages/phone_remote_filter` 有远程查号，但无短链展开 (Unroller) 与 TLD 安全解析库。 |
| **7** | **`CallShield`**<br>`BacktrackingPaths.kt` | **防 ReDoS 正则算力树**：计算正则表达式回溯路径数，拒绝算力过大 ($>10^6$) 或包含 `(a+)+` 灾难性回溯的恶劣正则，防止主线程卡死。 | 🔴 **完全缺失** | `packages/phone_rules` 依赖 Dart/Kotlin 标准正则，未加回溯深度校验与回溯死锁防御算力树。 |
| **8** | **`CallShield`**<br>`AndroidManifest.xml` | **开机锁屏前直接防护 (`directBootAware`)**：声明 `directBootAware="true"`，手机重启未解锁 PIN 码前即可加载黑名单防护服务。 | 🔴 **完全缺失** | `packages/phone_call_monitor` 与主 App AndroidManifest 均未为 `MyCallScreeningService` 开启 `directBootAware="true"`。 |
| **9** | **`CallShield` / `SpamBlocker`**<br>`CallScreeningService.kt` | **接通即挂断 + 麦克风静音保护**：执行 `ANSWER_THEN_HANGUP` 时，提前设置 `isMicrophoneMute = true`，挂断后恢复，防止泄漏环境音。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_call_interception_policy` 已定义该策略，但 Native `MyCallScreeningService.kt` 缺乏麦克风静音保护与延时调节。 |
| **10** | **`CallShield`**<br>`StirChecker.kt` | **STIR/SHAKEN 源头验真**：解析 Telecom 传递的 STIR/SHAKEN 验真结果 (`VERIFICATION_STATUS_PASSED`) 并发送给上层。 | 🟢 **均已实现并集成** | `packages/stir` 与 `lib/features/verification` 均已完整实现与联动。 |
| **11** | **`CallShield` / `CallerID`**<br>`OverlayService.kt` | **悬浮窗 Caller ID 展示**：来电时弹出可拖拽置顶悬浮窗展示归属地、风险标记与控制按钮。 | 🟢 **均已实现并集成** | `packages/phone_call_overlay` 与 `lib/features/call/call_overlay` 均已完整实现。 |
| **12** | **`saracroche`**<br>`PhoneNumberMatcher.kt` | **Long 型超高速通配符匹配引擎**：将号码规整为 `Long` 数字，以 `#` 为尾随通配符（如 `33162######`）进行高速整数哈希匹配。 | 🔴 **完全缺失** | `packages/phone_rules` 使用 Dart 字符串正则匹配，未针对海量数据做数字型 Long/通配位运算优化。 |
| **13** | **`saracroche`**<br>`restrictions.xml` | **企业 MDM 管理配置下发**：支持通过 Android App Restrictions 进行企业与家长控制配置集中下发。 | 🔴 **完全缺失** | 我们的工程缺少 MDM `APP_RESTRICTIONS` 解析与配置下发支持。 |
| **14** | **`Silence`**<br>`SimScreen.kt` / `SimChecker.kt` | **多 SIM 卡槽独立策略控制**：读取卡槽，为 SIM 1 与 SIM 2 分别提供独立策略开关与规则组。 | 🟢 **均已实现并集成** | `packages/phone_sim_slot_rules` 与 `lib/features/sim_slot_rules` 均已完整实现。 |
| **15** | **`Silence`**<br>`PanicResponderActivity.kt` | **Panic 紧急一键销毁/重置广播**：响应 Guardian Project 紧急广播，瞬间清空/抹除本地敏感规则，防止危机时刻泄密。 | 🔴 **完全缺失** | 我们未接入 Panic 紧急销毁广播响应逻辑。 |
| **16** | **`SpamBlocker`**<br>`ComplementNaiveBayes.kt` | **端侧 Complement Naive Bayes 增量 ML**：纯 Kotlin 实现的朴素贝叶斯模型，支持本地增量学习 (`addSample`/`removeSample`)。 | 🔴 **完全缺失** | 缺少端侧增量朴素贝叶斯文本/号码分类模型。 |
| **17** | **`SpamBlocker`**<br>`Triggers.kt` / `Actions.kt` | **自动化工作流 Bot 引擎**：允许自定义触发器节点与联动动作（自动发 SMS、创建日历事件、修改系统设置）。 | 🔴 **完全缺失** | 缺少 Bot 自动化工作流与节点联动引擎。 |
| **18** | **`SpamBlocker`**<br>`AllowedNotificationAlert.kt` | **放行通知硬件级强提醒 Alert**：拦截放行重要通知时，触发自定义闪光灯闪烁、震动模式、亮屏与循环提醒。 | 🔴 **完全缺失** | 缺少硬件级闪光灯 (Camera Flashlight) 与震动 Pattern 控制器。 |
| **19** | **`SpamBlocker`**<br>`PushAlertChecker.kt` | **Push Alert 动态通知放行**：检测到特定 App（如外卖/打车）通知后，临时放行接下来打入的未知派送员电话。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_count_filter` 有频次过滤，但 `lib/features/call_filter` 未接入第三方 App 通知监听与临时放行。 |
| **20** | **`SpamBlocker`**<br>`RecentApps.kt` | **结合最近使用 App 自动临时豁免**：使用 `PACKAGE_USAGE_STATS` 检测最近 15 分钟使用过的 App（如美团/滴滴），自动放行呼叫。 | 🔴 **完全缺失** | 缺少 `PACKAGE_USAGE_STATS` 使用记录检测与临时放行逻辑。 |
| **21** | **`SpamBlocker`**<br>`MeetingModeRegistry.kt` | **动态会议模式 (Meeting Mode)**：通过 `READ_CALENDAR` 自动检测当前是否有在线视频会议（Zoom/Teams）并自动开启高强度阻断。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_time_interceptor` 支持定时勿扰，但 `lib/features/time_interceptor` 未接入日历事件实时联动。 |
| **22** | **`SpamBlocker`**<br>`ConfigImportExport.kt` | **单条规则与配置 JSON 导出分享**：支持单条正则/规则直接导出为 JSON 分享给他人，及 AES 加密全量备份恢复。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_rules` 支持序列化，但主 App 缺少单条规则 JSON 分享 Sheet 与 AES 加密。 |
| **23** | **`web26-050`**<br>`PhoneStateReceiver.kt` | **Android 9~17 双通道兼容**：同时实现 `PhoneStateReceiver` 与 `CallScreeningService` 确保全版本兼容。 | 🟢 **均已实现并集成** | `packages/phone_call_monitor` 与 `lib/features/call_monitor` 均已完整覆盖。 |
| **24** | **`web26-050`**<br>`AndroidManifest.xml` | **`specialUse` 前台服务保活**：声明 `foregroundServiceType="specialUse"` (Subtype: `callBlocking`) 防止被系统杀死。 | 🟢 **均已实现并集成** | Manifest 中已为 Overlay 及 Monitor 服务配置 `specialUse` 声明。 |
| **25** | **`web26-050`**<br>`BackupEncryption.kt` | **AES-256-GCM 密码保护备份文件 (`.cbbk`)**：备份文件支持输入密码采用 AES-256-GCM 高强度加密。 | 🔴 **完全缺失** | 主 App 仅支持明文 JSON 备份，缺少 AES-256-GCM 密码加密与 `.cbbk` 扩展名解析。 |
| **26** | **`OpenCallShield`**<br>`GitHubSync.kt` | **跨国社区开源 JSON 订阅同步**：从 GitHub RAW 直链定时拉取并解包 `spam_numbers.json`。 | 🟢 **均已实现并集成** | `packages/phone_subscription` 与 `lib/features/phone_subscription` 均已完整实现。 |
| **27** | **`OpenCallShield`**<br>`Countries.kt` | **国旗一键按国家整体阻断 (Block by Country)**：点击国旗直接添加该国家/地区所有区号的阻断规则。 | 🟢 **均已实现并集成** | `packages/phone_country_sync` 与 `lib/features/sync_country` 均已实现。 |
| **28** | **`OpenCallShield`**<br>`GitHubContributor.kt` | **GitHub Device Flow 免后端众包 Issue 提交**：内置 OAuth Device Flow / PAT 登录，一键将本地标记的垃圾号打包为 GitHub Issue 提交。 | 🔴 **完全缺失** | `packages/phone_marking` 仅支持本地标记，缺少免后端的 GitHub OAuth Issue 众包贡献管线。 |
| **29** | **`JemRec`**<br>`CaptureDaemon.kt` / `AdbTransport.kt` | **无需 Root/电脑 ADB 无线调试自配对录音与答录机**：App 与本地 `127.0.0.1` ADB 无线调试配对，启动 Shell 录音进程实现双向通话录音。 | 🔴 **完全缺失** | 我们的工程完全缺少 ADB 端口自配对与 Shell 层录音守护进程。 |
| **30** | **`JemRec`**<br>`VoipApps.kt` | **IM 软件通话识别与录音 (WhatsApp/Telegram/Meet)**：Android 14+ 识别 VoIP 通话通知并触发音频抓取。 | 🔴 **完全缺失** | 我们缺少针对 IM 软件音频抓取与记录的能力。 |
| **31** | **`JemRec`**<br>`AnsweringMachine.kt` | **自动应答留言答录机 (Answering Machine)**：无人接听/阻断时自动接听，播放自定义 Greeting 语音，并录制对方留言 (60s)。 | 🔴 **完全缺失** | 主 App 无自动接听播放 Greeting 与留言录音功能。 |
| **32** | **`JemRec`**<br>`WhenOffScreen.kt` | **银行 App 避坑防调试伪装**：关闭录音/防护时自动关闭 USB/无线调试与开发者选项，防止银行 App 拒绝启动。 | 🔴 **完全缺失** | 缺少自动隐藏/关闭开发者调试选项的避坑伪装模块。 |
| **33** | **`Corta-Spam`**<br>`StallPolicy.kt` / `StallLines.kt` | **"Waste Their Time" 骚扰电话调戏机器人**：自动接听阻断电话，开启扬声器播放随机 TTS 多语言台词拖延骚扰者时间。 | 🔴 **完全缺失** | 缺少自动接听+TTS 调戏拖延骚扰电话 Bot。 |
| **34** | **`Corta-Spam`**<br>`EmergencyCallPolicy.kt` | **紧急呼叫后 30 分钟全局豁免**：拨打 911/112 紧急电话后 30 分钟内，强制放行所有打入电话（超越黑名单/勿扰/定时）。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_call_interception_policy` 有紧急豁免标志，但主 App 缺少 30 分钟系统定时器精准倒计时控制。 |
| **35** | **`Corta-Spam`**<br>`InCallActivity.kt` | **通话中键盘 DTMF 音频发送**：在通话界面提供 DTMF 键盘，支持向 IVR 语音菜单发送按键音 ("按 1 转人工")。 | 🔴 **完全缺失** | 主 App 通话悬浮窗与通话界面缺少 DTMF 按键音发送器。 |
| **36** | **`Corta-Spam`**<br>`BlockAndEndAction.kt` | **通话中/响铃中一键挂断并自动拉黑**：响铃或通话中提供 secondary 按钮，一键挂断同时将该号码写入黑名单。 | 🟡 **Package已实现<br>主App未接满** | `packages/phone_call_overlay` 有拉黑按钮，但主 App 通话界面缺少“挂断并拉黑 (Decline & Block)”二合一动作。 |
| **37** | **`Corta-Spam`**<br>`ProximityPolicy.kt` | **Proximity 距离传感器贴耳熄屏保活**：通话中获取 `PROXIMITY_SCREEN_OFF_WAKE_LOCK`，贴耳时自动熄屏防误触。 | 🔴 **完全缺失** | Native 通话界面与服务中缺少 Proximity 距离传感器熄屏锁。 |
| **38** | **`SpamSniper`**<br>`SpamSniperCallBlocker` | **iOS Call Directory Extension 系统级阻断**：利用 AppGroup 共享 SQLite 数据库，将合并后的黑名单喂给 iOS 系统拦截。 | 🔴 **完全缺失** | 我们的工程为 Flutter/Android 侧，缺失 iOS CallDirectory Extension 目标与 AppGroup 共享库。 |
| **39** | **`SpamSniper`**<br>`ObjectivePGP` | **订阅包 PGP/RSA 签名校验**：拉取远程黑名单数据包前，使用 PGP/RSA 公钥校验文件签名，防止数据被篡改。 | 🟡 **Package已实现(SHA256)<br>缺少PGP** | `packages/phone_subscription` 实现了 SHA-256 哈希校验，但缺少 PGP/RSA 非对称签名验证。 |
| **40** | **`yourcallrule`**<br>`app_delta_setup_config.json` | **增量数据管线 (Data Pipeline)**：拉取归一化 `merged_rules/{COUNTRY}/*.json`，校验 SHA-256 后增量解压写入 drift 数据库。 | 🟢 **均已实现并集成** | `packages/phone_subscription` 与 `lib/core/services/data_pipeline_sync_service.dart` 均已完整实现。 |
| **41** | **`yourcallrule`**<br>`app_plugin_setup_config.json` | **动态 JS 查号插件管线**：`flutter_js` 沙箱运行 Baidu, SpamBlocker, SkipCalls 等查号抓取脚本，支持在线热更新。 | 🟢 **均已实现并集成** | `packages/phone_lookup_plugin` 与 `lib/features/phone_plugin` 均已完整实现。 |

---

## 三、 深剖解密：FCC 与 FTC 数据库源码解析中的全量 Tag 体系

在 `CallShield` 的解析脚本（`import_all_sources.py`、`update_ftc.py`）以及端侧归导引擎（`CallCategoryResolver.kt`）中，**上游 FCC 与 FTC 的原始 API 字段远比表面看到的 10 个分类更加丰富**。

以下是物理源码解析出来的 **FCC 与 FTC 全量原始 Tag 字段与分类结构**：

### 🏛️ 1. FTC (Federal Trade Commission) 官方 DNC 数据库 API 全量 Tag (`api.ftc.gov/v0/dnc-complaints`)

FTC 原始数据由 **核心分类标志 (`attributes`)** 与 **消费者主题描述 (`subject`)** 两部分拼接而成：

#### A. 核心分类标志 Tag
- `recorded-message-or-robocall` (`Y`/`N`): 是否预录音/自动拨号（源码中只要为 `Y` 即强制标记为 `type = "robocall"`）。
- `is-robocall` (`y`/`yes`/`true`/`1`): 机器人外呼确认标志。
- `is-dnc-violation`: 违反 National Do Not Call Registry（全美禁拨注册表）。

#### B. 消费者举报主题分类 Tag (`subject` 字段)
物理代码在解析 FTC JSON 时，`subject` 字段包含了以下所有官方举报大类与细分 Tag：
1. `Debt Collector / Debt Settlement`: **债务催收与债务重组**。
2. `Credit Card / Financial Services`: **信用卡利率/金融服务套路**。
3. `Imporsonator / Government Impostor`: **冒充政府/官方人员**（如假冒 IRS 税务局、SSA 社保局、Jury Duty 陪审团等）。
4. `Medical & Prescriptions / Medicare`: **医疗保健与联邦医疗保险 (Medicare) 诈骗**。
5. `Auto Warranty / Vehicle Protection`: **汽车延保/质保到期续费**（北美最频繁的推销套路之一）。
6. `Computer & Tech Support`: **电脑技术支持诈骗**（冒充 Microsoft / Apple 声称系统受感染需远程控制）。
7. `Home Security & Improvement`: **房屋安防与家装工程推销**。
8. `Charity & Donation`: **假冒慈善捐赠/警察抚恤金募捐**。
9. `Lottery & Sweepstakes / Prize`: **假冒中奖与彩票套路**。
10. `Energy & Solar`: **太阳能与电力能源推销**。
11. `Work-from-Home / Jobs`: **在家兼职/招聘套路**。
12. `Wangiri / One-Ring Callback`: **响一声挂断诱骗回拨高额付费电话**。

---

### 🏛️ 2. FCC (Federal Communications Commission) Unwanted Calls 数据集全量 Tag (`opendata.fcc.gov`)

FCC Socrata 数据库通过 `issue`（主要问题）与 `type_of_call_or_message`（呼叫/消息类型）两个字段组合定义：

#### A. 主要问题分类 Tag (`issue`)
1. `Unwanted Calls`: 未经许可的打扰呼叫（默认分类）。
2. `Telemarketing`: 商业电话营销。
3. `Robocalls`: 机器人自动呼叫。
4. `Caller ID Spoofing`: **主叫号码伪造**（代码中检测包含 `"spoof"` 关键词时，触发 `explicit_spoof_claim` 伪造信号）。
5. `Junk Fax`: 垃圾传真。
6. `Sms Spam` / `Text Message Spam`: **垃圾短信/短信欺诈**。
7. `Harassment / Prank`: 恶作剧与恶意骚扰。
8. `CPA / Toll-Free Fraud`: 800/888 免付费电话反向吸费。

#### B. 呼叫与消息类型 Tag (`type_of_call_or_message`)
1. `Prerecorded Voice`: 预先录制的语音。
2. `Live Voice`: 真人推销员/催收员。
3. `Text Message`: 文本短信/彩信。
4. `Abandoned Call`: 呼叫中心无人接听的盲拨测试。

#### C. 呼叫角色分拆 Tag (`complaint_role`)
`import_all_sources.py` 会自动将每一条 FCC 投诉拆解为两个号码角色：
1. `caller_id_number` (`caller_id`): 来电显示弹出的主叫号码（可能被伪造）。
2. `advertiser_business_phone_number` (`callback_business`): 广告/语音中留下的真实商家/诈骗分子回拨号码。

---

### 🏛️ 3. 端侧两级收敛映射链

源码将上游数十种复杂的 FCC/FTC 原始 Tag 进行了**两级收敛**：

```
[FCC/FTC 原始 API 字段]
(数十种 Issue / Subject 细分标签)
          ↓ (import_all_sources.py 归一化)
[基础类型 (Spam Type)]
(robocall / telemarketer / sms_spam)
          ↓ (CallCategoryResolver.kt 语义增强)
[用户级 10 大 Label (CallCategory)]
(DebtCollector / Political / Robocall / Scam / Phishing / Telemarketer / Wangiri / Survey / Business / Unknown)
```

这样既保证了**上游能全量抓取美国政府发布的所有细分类型**，又保证了**端侧界面能够简化为 10 大标清 Label 供用户配置四态覆写策略**。

---

## 四、 后续工程落地分步实施计划

### 1. 🟡 优先补全：Package 已具备能力，主 App (`lib/`) 补全 UI 与装配
- **“期待电话” Quick Settings Tile 面板**：在 `lib/features/home` 增加快捷放行 Tile 状态联动与倒计时交互。
- **免 SMS 权限通知级消息拦截面板**：在 `lib/features/sms` 暴露针对 RCS / WhatsApp / Telegram 通知级隐蔽消除拦截的配置。
- **接通即挂断与麦克风静音**：在 Native 侧 `MyCallScreeningService.kt` 补充 `isMicrophoneMute = true` 保护并暴露 1s 挂断延时。
- **Label 策略覆盖矩阵 Sheet**：在 `lib/features/call_policy` 补齐针对催收/政治/诈骗/营销等 9 大 Label 的 4 态控制 Sheet。

### 2. 🔴 重点攻坚：补齐 Native/Dart 核心高级防护子包与服务
- **呼出防诈重定向 (`MyCallRedirectionService.kt`)**：利用 `ROLE_CALL_REDIRECTION` 角色在外拨前拦截高危/诈骗号码并弹窗确认。
- **端侧 20 维 GBT 机器学习打分 (`SpamMLScorer`)**：引入纯 Kotlin 轻量级梯度提升树模型，实现端侧 Spam Score 概率打分。
- **短彩信钓鱼短链展开与高危 TLD 校验**：实现短链展开 (`bit.ly`) 与高危域名/TLD 安全校验。
- **防 ReDoS 正则算力树 (`BacktrackingPaths`)**：在规则校验时增加回溯深度与算力树检查，死锁坏正则。
- **Proximity 贴耳熄屏锁 (`PROXIMITY_SCREEN_OFF_WAKE_LOCK`)**：在通话中控制距离传感器，防止贴耳误触。
- **通话中 DTMF 键盘与一键挂断拉黑**：在通话悬浮窗/界面增加按键音发送器与二合一挂断拉黑按钮。
- **AES-256-GCM 加密备份 (`.cbbk`)**：在 `packages/infra` 增加带有密码保护的加密备份与恢复。
- **GitHub Issue 免后端众包提交**：在 `packages/phone_marking` 增加 GitHub OAuth Device Flow 众包 Issue 提交管线。
