# 📍 Pyro Phone Location Protocol (`pyro_phone_location_protocol`)

电话号码归属地纯协议与实体包，0 业务逻辑，0 假存，遵循纯数据驱动领域值对象模式 (Data-Driven Domain Value Objects)。

---

## 🏗️ 架构物理划分拓扑

- **`lib/src/models/`**: `PhoneLocationEntry` (`@freezed` 代码生成，包含 `fromJson` / `toJson` / `fromMap` / `toMap`)。
- **`lib/src/drivers/`**: `PhoneLocationStorageDriver` (抽象持久化 Driver 接口契约)。
