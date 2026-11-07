# Pyro Atmosphere (全模态气象与环境感知中台)

专为 Pyro 生态设计的**全知全能气象与环境感知 Pure Dart 核心微包**。基于 Open-Meteo 全球气象与空气质量 API 构建，支持全模态 App（壁纸推荐、小说氛围理疗、阅读背景色感知）快速复用。

## 🌟 核心特性

- **多维气象指标采集**：温度、体感温度、相对湿度、气压、风速/阵风、能见度、紫外线 UV、云量、WMO 天气代码、白天/黑夜与日落日出时间。
- **AQI 空气质量与环境污染检测**：美国标准 AQI、PM2.5 颗粒物、花粉指数、二氧化氮污染水平，自动评估严重污染环境。
- **智能内存与地理位置缓存**：内置可配置 TTL 缓存（默认 30 分钟），避免频繁网络请求与电池损耗。
- **零 Flutter 依赖，Pure Dart**：可在 Flutter 客户端、服务端、CLI 或 Hetu 脚本引擎中无缝运行。

## 🏛️ 架构一览

| 类名 | 职责说明 |
| :--- | :--- |
| `AtmosphereState` | 环境快照模型（包含天气、AQI、时间戳，提供 `isPrecipitation` 与 `isHeavyPollution` 属性） |
| `AtmosphereService` | 并发拉取气象与 AQI，管理缓存与离线回退 |

## 🚀 快速使用

```dart
final atmosphereService = AtmosphereService(
  cacheTtl: const Duration(minutes: 30),
  onLog: (msg) => debugPrint(msg),
);

// 获取指定经纬度的实时环境感知
final state = await atmosphereService.getAtmosphere(
  lat: 31.2304,
  lng: 121.4737,
);

debugPrint('当前温度: ${state.temperature}°C, 空气质量 AQI: ${state.aqiUS}');
if (state.isPrecipitation) {
  debugPrint('🌧️ 正在下雨/下雪，触发阴雨舒适推荐策略');
}
```

---
*Part of Pyro Engine Ecosystem.*
