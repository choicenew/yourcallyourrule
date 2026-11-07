# Pyro Risk Profiler

统一的用户风控等级评定、行为计分与风控决策 Pure Dart 核心库。支持多端（Flutter / Server / CLI / Hetu Script）快速复用。

## 核心特性

- **多维风控等级评定 (`UserSensitivityLevel`)**：分级体系（0~5 级：纯净、轻度、低敏、中度、高敏、极端）。
- **用户行为计分器 (`UserRiskCalculator`)**：支持基于时长、放大/细看意图、保存/下载转化、敏感词命中等多维度的动态增量行为计分。
- **历史画像评估 (`UserProfilingEvaluator`)**：基于浏览历史标签比例对用户进行冷启动或全量敏感度画像评估。
- **风控决策中枢 (`RiskMasterEvaluator`)**：结合数据源信誉与用户敏感度等级，裁决商业化安全配置（`RiskProfile`）与广告分流层级（`AdTrafficTier`）。
- **状态与存储抽象 (`RiskProfileManager` & `IRiskProfileStorage`)**：纯 Dart 解耦，支持无缝接入 Isar、Hive、SharedPreferences、SQLite，并提供响应式 `Stream<int> onLevelChanged`。

## 架构组成

| 组件 | 说明 |
| :--- | :--- |
| `UserSensitivityLevel` | 0~5 级用户敏感度枚举定义 |
| `UserRiskProfile` | 用户画像数据实体（包含得分、等级、元数据与更新时间） |
| `UserRiskInteraction` | 用户交互打分输入模型（与具体 App 的实体彻底解耦） |
| `UserRiskCalculator` | 纯数学增量打分与升级阈值判定器 |
| `UserProfilingEvaluator` | 历史标签占比分析与画像评估器 |
| `RiskMasterEvaluator` | 广告/商业化流量与风控安全等级判定中枢 |
| `IRiskProfileStorage` | 存储持久化接口，内置 `MemoryRiskProfileStorage` |
| `RiskProfileManager` | 统一的风控画像状态管理与调度器 |

## 快速使用

### 1. 初始化风控管理器
```dart
final manager = RiskProfileManager(
  sensitiveKeywords: {'nsfw', 'r18', 'bikini'},
  onLog: (msg) => debugPrint(msg),
);

await manager.initialize(userId: 'primary_user');

// 监听等级升级变更
manager.onLevelChanged.listen((newLevel) {
  debugPrint('User risk level changed to: $newLevel');
});
```

### 2. 传入用户交互流进行风控打分
```dart
await manager.processInteraction(
  UserRiskInteraction(
    tags: ['bikini_girl', 'summer'],
    viewDurationMillis: 8000,
    intent: RiskInteractionIntent.inspect,
    isDownloaded: true,
  ),
);

debugPrint('Current Level: ${manager.currentLevel}');
debugPrint('Current Score: ${manager.currentProfile?.sensitivityScore}');
```

### 3. 商业化风控决策裁决
```dart
const evaluator = RiskMasterEvaluator();

final risk = evaluator.determineRiskProfile(
  userLevel: manager.currentSensitivity,
  sourceLevel: SourceRiskLevel.safe,
);

final adTier = evaluator.determineAdTier(
  userLevel: manager.currentSensitivity,
);

debugPrint('Ad Decision: risk=$risk, tier=$adTier');
```

---
*Created for Pyro Engine Ecosystem.*
