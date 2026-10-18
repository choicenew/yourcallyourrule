# 🚀 Flutter AdMob 广告架构、算法与高收益重构全景指南

> **文档目的**：本 README 完整收录并总结了关于 Flutter AdMob 广告集成中的 **“提升有效展示率 (Show Rate)”**、**“最大化 eCPM 收益”**、**“滑动窗口动态预测预加载算法”**、**“Google AdMob 官方合规规范”** 以及 **“防卡顿/防 ANR 架构”** 的所有深度讨论与工程落地经验。
> 
> **用途**：可直接复制本文档内容提供给其他 AI（如 ChatGPT、Claude、DeepSeek 等）或团队开发者，作为 Flutter 商业化广告模块重构与优化的权威指南。

---

## 一、 商业变现核心设计思想

1. **真实展示数 (Impressions) 才是收益的唯一来源**：
   * 收益计算公式：`收益 = (展示数 / 1000) × eCPM`。
   * 广告 **“被请求”** 或 **“被匹配”** 不产生任何收益，只有 **“真实呈现给用户 (Impression)”** 才会产生收益。
   * **核心法则**：绝不上盲目数量塞满屏幕，但凡放一个广告位，就必须做到 **“0 毫秒秒出”**、**“布局不弹跳”**、**“划回来不销毁”**、**“视觉高档不突兀”**，将有效展示率（Show Rate）拉到 95%+。

---

## 二、 🧠 滑动窗口动态自适应预测预加载算法 (Dynamic Sliding Window Adaptive Predictor)

为解决“连续快速滑动卡片或频繁换页时广告供给不上”的行业痛点，我们在 `lib/ads/ad_preload_service.dart` 中落地了 **动态自适应预测算法**：

```text
               ┌────────────────────────────────────────────────────────┐
               │    _calculateAdaptiveCapacity() 动态消费速度预测器      │
               └───────────────────────────┬────────────────────────────┘
                                           │
             ┌─────────────────────────────┴─────────────────────────────┐
             ▼                                                           ▼
┌───────────────────────────┐                               ┌───────────────────────────┐
│     【基准闲置态】         │                               │     【高频滑动爆发态】    │
│ 10秒内消费 < 2 次         │                               │ 10秒内消费 >= 2 次        │
├───────────────────────────┤                               ├───────────────────────────┤
│ 预加载池容量上限 = 1      │                               │ 预加载池容量上限扩容至 = 2  │
│ 100% 严格遵守官方最严规范  │                               │ 开启双槽位备用，连续 0ms  │
└───────────────────────────┘                               └───────────────────────────┘
             ▲                                                           │
             └─────────────────── 用户停止滑动超过 10 秒 ────────────────┘
                                  (自动平滑收缩归一)
```

### 算法三大运行逻辑：
1. **基准闲置态 (容量 = 1)**：App 处于正常低频浏览时，预加载池容量上限保持为 **1**，100% 严格遵守 Google 官方规范（*Keep 1 to 2 ads in pool*），绝不产生任何资源浪费。
2. **高频消耗感知 (自适应扩容 = 2)**：自动记录 10 秒窗口内的广告消耗频次。当检测到用户正在快速滑动卡片/频繁换页（10 秒内消耗 >= 2 次）时：
   * 算法判定进入“高频消费状态”，**预加载池容量上限自动提升至 2**；
   * 后台并行维护 2 个已加载好的独立广告实例，确保快速刷卡片时广告 **连续 0 毫秒秒出**！
3. **闲置自动归一 (平滑收缩 = 1)**：当用户停止快速滑动超过 10 秒，预测器检测到消耗速度慢下来后，容量上限**自动平滑收缩恢复至 1**。

---

## 三、 🛡️ Google AdMob 官方标准规范与合规红线

### 1. 预加载池容量规范（Google Official Rule）
谷歌官方开发者指南（*Caching Ads Best Practices*）明确规定：
> *"Always load the next ad in advance. To avoid excessive unused requests, do not attempt to pre-load a large number of ads. **Keep 1 to 2 ads in your pool at any time.**"*
> 
> **中文直译**：“始终提前加载下一个广告。为避免产生大量无用的广告请求（这会损害您的匹配率与收益），切勿尝试预加载大量广告。**在任何时候，将您的预加载池保持在 1 到 2 个广告即可。**”

### 2. 4 小时强行过期校验 (Ad Expiration)
* 谷歌官方规定：预加载的广告对象，加载成功后生命周期最多保留 4 小时。
* `PreloadedAdWrapper` 内部增加了 `isExpired` 超时判断（预留 3 小时安全阈值），超时自动自毁并重新拉取，防止无效曝光。

### 3. 绝对零遮挡红线 (Zero Overlap Policy)
* Google AdMob 政策禁止任何代码覆盖、遮挡或重叠在 `AdWidget`（广告画布）上面。
* **实现方案**：卡片容器 (`_buildSponsoredCard`) 仅在 `AdWidget` **外部外包**一层独立的圆角边框外壳（完全不使用 `Stack` 层叠），100% 尊重并保留谷歌原生广告自身渲染的“广告 / Ad”标，零重叠、零违规风险。

### 4. Onboarding 引导阶段绝对禁显广告
* 在 `SplashScreen` 中增加了硬性约束：只要用户处在首次安装/未完成 `Onboarding` 初始设置阶段（`_isFirstLaunch == true`），**严禁触发任何开屏或插屏广告**，确保用户顺畅完成初始化。

### 5. 激励视频广告 (Rewarded Video Ads) 规则
* 激励视频广告可以提前预加载视频素材（实现点击即秒播，免去用户等待 5 秒缓冲圈圈）；
* **铁律**：提前预加载的激励视频**绝对不能自动播放**，必须由用户主动点击“看视频领奖励”按钮后才能触发 `.show()`。

---

## 四、 🛠️ 四大核心 UI & 性能问题与重构经验

### 1. 痛点一：0 高度塌陷（Layout Shift）与剧烈弹跳
* **原因**：广告未加载完成时返回 `const SizedBox.shrink()`（0 高度），加载成功后突然变高（如 250px）推开页面，但用户早就滑走了。
* **解决方案**：在卡片外包容器中提供固定规格的**骨架屏占位屏 (Skeleton Placeholder)**。加载期间空间先行锁定，广告返回瞬间平滑无缝接入，**展示率直接拉满**！

### 2. 痛点二：列表滑动销毁循环 (Dispose on Scroll)
* **原因**：Flutter 的 `ListView` 默认会将划出屏幕外（Off-screen）的 Widget `dispose()` 销毁，划回来时重新发起网络请求等 3~5 秒，造成“刷着刷着广告就没了”的恶劣体验。
* **解决方案**：
  * 在 `AdListUtils.buildListWithAds` 中增加了**广告位置 Key 缓存 Map (`adWidgetCache`)**；
  * 配合广告 Widget 混入 `AutomaticKeepAliveClientMixin`（`wantKeepAlive = true`），滑动划出屏幕绝不销毁，划回来 **0 毫秒瞬间恢复呈现**！

### 3. 痛点三：同页面多广告位 `AdUnit` 挂载冲突
* **原因**：同一个 AdUnit ID 不能同时被挂载到 Widget 树的多个节点上，否则原生 SDK 报错 `Ad already attached to widget tree`。
* **解决方案**：在组件 `initState` 中克隆配置，生成实例级唯一 Provider 作用域 Key (`_scopedAdInfo`)，同页面多个广告位完全独立加载。

### 4. 痛点四：死循环重试风暴与主线程 ANR 卡死
* **原因**：在失败回调 `onAdFailedToLoad` 中误将状态重置为未开始，触发无限递归重新加载，导致主线程 ANR。
* **解决方案**：标记 `isFailed = true` 阻止无脑重试；引入 **4 秒延迟单次自动重试** 应对网络抖动；捕获到环境硬拦截（如无 JS 引擎或 Code 0）时触发全局熔断器（Circuit Breaker）。

---

## 五、 🎨 多巴胺精美卡片外壳设计 (Card Design Language)

为消除原生矩形广告框置于 App 中的生硬突兀感，广告组件引入了统一的卡片外壳：
* **系统主题全适应**：自动根据 `Brightness.dark / light` 适配 `theme.colorScheme.surfaceContainerHighest` 衬底；
* **圆角与边框**：16.0px 大圆角 + 柔和边框 + 层次感阴影；
* **完美对齐**：内外 Margin 与 Padding 与应用周围的功能卡片完全统一，质感高档不割裂。

---

## 六、 📂 目录架构与组件分工

```text
lib/ads/
├── ad_preload_service.dart     # 核心：全局广告预加载池 + 动态滑动窗口预测算法
├── ad_manager.dart             # 全局 AdUnit ID 配置文件
├── ad_state.dart               # 全局广告启用/禁用开关 (StateNotifier)
├── ad_control_service.dart     # 广告逻辑控制服务 (关联 VIP 购买状态)
├── ad_cache_provider.dart      # 基于 Riverpod 的独立广告缓存 Provider
├── ad_list_utils.dart          # 列表广告工具类 (带 adWidgetCache 位置锁)
├── google_ad.dart              # 全品类 Google 广告封装组件 (带卡片外壳与 0ms 预加载消费)
├── adwidgets/
│   ├── inline_adaptive_ad.dart # 行内自适应 Banner 组件 (防塌陷与卡片外壳)
│   ├── anchored_adaptive_ad.dart# 底部固定锚定 Banner 组件
│   ├── app_open_ad.dart        # 开屏广告管理器 (带 4s 硬超时放行机制)
│   └── native_ads.dart         # 原生高级广告构建函数
└── README.md                   # 本文档
```

---

## 七、 🚨 AdMob 生产环境排查与 No-Fill 归因指南

若正式发版 App 出现广告加载失败，按以下 4 步排查 AdMob 后台配置：
1. **应用审核状态 (App Readiness Review)**：进入 AdMob 后台 ➔ [应用] ➔ 确认是否已关联商店链接且状态为 **“准备就绪 (Ready)”**。若为“准备中”，系统 100% 返回 No-Fill。
2. **app-ads.txt 校验**：确认开发者官网根目录配置了正确的 `app-ads.txt` 规则。
3. **底价设置 (Floor Price)**：不要将底价设为过高或“高底价优化”，初级阶段建议设为“针对所有价格优化 (Optimized for all eCPMs)”以追求 100% 填充。
4. **政策中心告警**：检查账号是否有政策中心告警或 PIN 码未验证限制。

---

## 八、 🤖 给其他 AI 助手 / 开发者的标准 Prompt 模板

你可以直接复制以下框内文本提供给其他 AI：

```text
在 Flutter 项目中重构与优化 Google AdMob 广告模块时，请严格遵守以下工程规范：

1. [预测预加载池] 维护全局预加载池，默认维持 1 个广告容量（严格遵守 Google 官方规范 Keep 1 to 2 ads in pool）。内置消费速度预测器，当检测到用户在 10 秒内频繁消费（滑动卡片/换页）时，自适应扩容至 2 个并发预加载，闲置 10 秒后自动收缩回 1。
2. [消除高度塌陷] 广告在加载过程中（isLoaded == false 且 !isFailed）绝不返回 SizedBox.shrink()。必须使用预留固定高度的骨架屏卡片外壳，保证布局稳定不弹跳。
3. [列表滑动保活与位置缓存] 列表中使用 AdListUtils 的广告位置缓存 Map，且广告 Widget 混入 AutomaticKeepAliveClientMixin(wantKeepAlive = true)，确保滑动划出屏幕绝不 dispose 销毁已加载广告，划回来 0ms 秒出。
4. [零遮挡合规] 绝对严禁在谷歌 AdWidget 上方叠加任何 UI 层（Stack 盖层），外包卡片容器必须独立在 AdWidget 外部，尊重并保留原生广告自身渲染的“Ad”标。
5. [引导页隔离] 首次启动或未完成 Onboarding 引导设置阶段，绝对禁止触发开屏或任何广告。
```
