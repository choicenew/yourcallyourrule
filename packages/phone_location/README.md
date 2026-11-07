# 📍 Phone Location Subsystem (`packages/phone_location`)

电话号码归属地解析与地名管理包，遵循空壳宿主 App 架构与纯数据驱动领域值对象模式 (Data-Driven Domain Value Objects)。

---

## 🏗️ 架构物理划分拓扑

- **`lib/src/protocol/`**: 强实体号码归属地模型 (`PhoneLocationEntry`，基于 `@freezed` 代码生成，包含 `fromJson` / `toJson` / `fromMap` / `toMap`)。
- **`lib/src/hub/`**: 号码归属地服务中枢 (`PhoneLocationService`，基于 `@Riverpod(keepAlive: true)` 代码生成)。

---

## 🚀 核心逻辑与零依赖

1. **强实体号码归属地模型 (`PhoneLocationEntry`)**：
   - 包含 `id`, `phoneNumber`, `region`, `countryName`, `carrier`, `numberType` 强实体字段，消除与设备 GPS 地理位置的语义混淆。
2. **纯归属地服务 (`PhoneLocationService`)**：
   - 离线解析号段归属地与运营商，**零上层依赖**。
