# Pyro House Ads (全矩阵自家广告与交叉推广中台)

专为多 App 矩阵生态设计的**自家广告（House Ads）、VIP 内购促销与跨应用交叉导流（Cross-Promotion）中台微包**。

## 🌟 核心设计亮点

1. **单一矩阵配置表 + 自包名分流（Self-Filtering）**：
   - 维护一份包含矩阵全系产品（壁纸、小说、漫画、音乐等）的“全家桶清单”，所有 App **100% 共享同一份文件**；
   - 运行时自动比对当前 App 包名：**本 App 自动转化为 VIP 内购促销广告，兄弟 App 自动转化为 Google Play 导流广告**，绝不自推自己。
2. **官方标准 ARB 国际化对接**：
   - 摒弃脆弱的私有 JSON 字典，通过 `HouseAdStringResolver` 无缝直连官方 `app_en.arb` / `app_zh.arb` 多语言体系。
3. **轻量程序化色彩自适应渲染**：
   - 纯 Flutter 渐变色填充 + 矢量图标排版，0 图片资产依赖，秒开无延迟，自动适配 Banner（锚定横幅）、MREC、原生卡片、插屏弹窗等 6 大形态。
4. **无缝对接 Magma 聚合网络**：
   - 内置 `PyroMagmaHouseAdapter`，在 AdMob/Unity 无填充（No Fill）时全自动平滑兜底。

## 🏛️ 架构组成

| 组件 | 职责说明 |
| :--- | :--- |
| `MatrixAppItem` | 矩阵 App 描述模型（包名、ARB Keys、VIP 路由、渐变色彩、轮播权重） |
| `HouseAdSlotType` | 广告位形态枚举（`anchoredBanner`, `mrec`, `nativeSmall`, `nativeMedium`, `nativeLarge`, `interstitial`） |
| `MatrixAdArbitrator` | 矩阵仲裁器：根据 `currentPackageName` 自动剔除自身并分流主客产品 |
| `HouseAdScheduler` | 调度与防疲劳算法：结合 `UserAdState` 进行权重随机与去重轮播 |
| `HouseAdAdaptiveCard` | 响应式自适应卡片组件，按约束自动排版 |
| `PyroHouseAdsAdapter` | 标准 `NetworkAdapter` 广告驱动实现，可独立注册至 `AdsHub.instance` |
| `HouseAdsManager` | 统一的中台总控入口 |

## 🚀 快速使用

### 1. 全矩阵共享清单配置 (`matrix_apps_config.dart`)
```dart
const kMatrixAppsConfig = [
  MatrixAppItem(
    packageName: 'com.pyro.wallpaper',
    titleKey: 'promoWallpaperTitle',
    descKey: 'promoWallpaperDesc',
    vipRoute: '/wallpaper_vip',
    gradientColors: [Color(0xFFE65100), Color(0xFFFF9800)],
    icon: Icons.wallpaper_rounded,
  ),
  MatrixAppItem(
    packageName: 'com.pyro.novel',
    titleKey: 'promoNovelTitle',
    descKey: 'promoNovelDesc',
    vipRoute: '/novel_vip',
    gradientColors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
    icon: Icons.menu_book_rounded,
  ),
];
```

### 2. 主 App 初始化与挂载注册
```dart
final houseAds = HouseAdsManager.instance;
houseAds.init(
  currentPackageName: 'com.pyro.wallpaper', // 当前 App 自身包名
  matrixApps: kMatrixAppsConfig,
  stringResolver: (context, key) => AppLocalizations.of(context).translate(key),
  onNavigateVip: (context, route) => Navigator.pushNamed(context, route!),
  onLaunchStore: (context, pkg) => launchUrl(Uri.parse('market://details?id=$pkg')),
);

// 挂载进 AdsHub 广告中枢（与其他广告驱动 AdMob/AppLovin/Unity 平级）
AdsHub.instance.register(PyroHouseAdsAdapter(houseAds));
```

### 3. 在页面中直接调用
```dart
// 任意位置插入自适应广告卡片
const HouseAdWidget(slot: HouseAdSlotType.anchoredBanner)
```

---
*Part of Pyro Engine Ecosystem.*
