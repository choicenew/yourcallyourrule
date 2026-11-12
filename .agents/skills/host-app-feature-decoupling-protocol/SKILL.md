---
name: host-app-feature-decoupling-protocol
description: 现代 Dart/Flutter 多包架构下主 App (lib/features/) 功能模块解耦、通用泛型/自动化存储引擎 (Generic Entity Store) 数据库一键无感切换与已抽离 Packages 对接指南。定义通用零横向依赖铁律、Protocol 契约接入、Generic Store 泛型存储引擎与 Drift/Isar 自动化切换设计、Riverpod 3 胶水 Provider 桥接、App Coordinator / Mediator 事件总线中转。
---

# Modular App Feature Decoupling & Automated Database Engine Protocol Specification
#(通用多包架构 Feature 解耦与泛型自动化数据库切换规范)

本规范为 **通用型 Flutter / Dart 多包（Multi-Package）应用架构标准**，用于指导主 App（`lib/features/`）中业务 Feature 的完全解耦、通用泛型/自动化存储引擎 (Generic Entity Store) 的架构构建，消除几十个 DataSource 样板代码，实现数据库的真正一键无感全量切换。

---

## 🏛️ 通用泛型存储引擎与全量一键无感切换 (Generic Entity Store & Auto-Switching Protocol)

### 1. 痛点：为什么不能为每个 Feature 手写 DataSource？
如果有 20~30 个业务 Feature（如 `phone_rules`, `regex_rules`, `sim_slot_rules`, `contacts`, `labels`, `subscriptions` 等），如果为每个 Feature 手写一个 `DriftPhoneRuleDataSource`、`DriftContactDataSource`...：
* **样板代码爆炸**：需要手写几万行重复的 `_toCompanion()` 与 CRUD 逻辑；
* **切换数据库噩梦**：未来如果从 Drift 切换到 Isar、Realm 或 Hive，需要手写另外 20~30 个 `IsarXxxDataSource` 类，这在工程上是不可接受且极易出错的。

### 2. 解决方案：通用泛型/自动化存储引擎 (`EntityStore<T>`)

引入 **`EntityStore<T extends Entity>` 泛型自动化存储引擎**。主 App 与各 Feature 彻底摆脱对特定数据库（Drift / Isar）的感知，全量实体统一通过泛型引擎存取。

```
                       ┌─────────────────────────────────────────────────────────┐
                       │                   UI / Business Service                 │
                       │           ref.watch(entityStoreProvider<PhoneRule>())    │
                       └────────────────────────────┬────────────────────────────┘
                                                    │ 纯 Entity 泛型调用
                                                    ▼
                       ┌─────────────────────────────────────────────────────────┐
                       │              abstract class EntityStore<T>              │
                       │     (定义泛型 CRUD / WatchStream / Query 契约，零 ORM 概念)   │
                       └────────────────────────────┬────────────────────────────┘
                                                    │ 单一 Factory 一键全量切换
                          ┌─────────────────────────┴─────────────────────────┐
                          ▼                                                   ▼
       ┌──────────────────────────────────────┐            ┌──────────────────────────────────────┐
       │     DriftEntityStore<T> (全量通用实现)│            │      IsarEntityStore<T> (全量通用实现)│
       │  (单一工厂类，自动处理全量实体的 CRUD) │            │  (单一工厂类，自动处理全量实体的 CRUD) │
       └──────────────────────────────────────┘            └──────────────────────────────────────┘
```

### 3. 一键无感全量切换机制代码规范

1. **泛型存储接口定义 (`EntityStore<T>`)**：
   ```dart
   /// 泛型存储契约：支持任意 Protocol Entity，零 ORM 依赖
   abstract class EntityStore<T extends ProtocolEntity> {
     Future<List<T>> getAll();
     Future<T?> getById(String id);
     Future<void> save(T entity);
     Future<void> saveAll(List<T> entities);
     Future<void> delete(String id);
     Stream<List<T>> watchAll();
   }
   ```

2. **单一通用驱动引擎实现 (`DriftEntityStore<T>`)**：
   * 全全局只需要**一个通用 Drift 实现引擎**（基于 Table / DAO / Map 自动序列化），彻底消灭 20+ 离散的 DataSource 手写类！

3. **Riverpod 3 泛型注入 (One-Click Global Factory Switch)**：
   ```dart
   /// 泛型 Provider：根据 Entity 类型自动返回对应的 Store
   final entityStoreProvider = Provider.family<EntityStore<T>, Type>((ref, type) {
     final factory = ref.watch(entityStoreFactoryProvider);
     return factory.createStore<T>();
   });

   /// 全局切换开关：从 Drift 切换到 Isar，只需在此修改一个 Factory 类！
   @riverpod
   EntityStoreFactory entityStoreFactory(Ref ref) {
     // 当前全量使用 Drift 泛型引擎：
     return DriftEntityStoreFactory(ref.watch(localDatabaseProvider));

     // 未来一键切换全量 Isar：
     // return IsarEntityStoreFactory(ref.watch(isarDatabaseProvider));
   }
   ```

---

## 🧩 胶水层的极简使用方式

在 `lib/features/phone_rules/` 或其他任何 Feature 中：
* **零手写 DataSource 类**！
* **直接使用泛型 Store**：
  ```dart
  @riverpod
  class PhoneRulesBridgeNotifier extends _$PhoneRulesBridgeNotifier {
    late final EntityStore<PhoneRuleEntity> _store;

    @override
    FutureOr<List<PhoneRuleEntity>> build() {
      _store = ref.watch(entityStoreProvider<PhoneRuleEntity>());
      return _store.getAll();
    }

    Future<void> addRule(PhoneRuleEntity rule) async {
      await _store.save(rule);
      ref.invalidateSelf();
    }
  }
  ```

---

## 🚫 强红线铁律 (Universal Non-negotiable Rules)

1. **严禁手写离散重复的 DataSource 类**：
   * 严禁在 `lib/features/` 中为每一个 Feature 重复编写 `DriftXxxDataSource`；
   * 必须统一走 `EntityStore<T>` 泛型自动化引擎或 Package 内置的 Hub/Database。

2. **零横向直连 (Zero Cross-Feature Direct Import)**：
   * 绝对禁止在 `lib/features/feature_a/` 中引用 `import 'package:<app_package_name>/features/feature_b/...'`；
   * 跨 Feature 通信统一通过 `AppCoordinator` / `Bridge` 中转。

---

## 📋 重构校验自查门禁 (Audit Checklist)

- [ ] **泛型 EntityStore 治理校验**：确认已消灭离散手写的 DataSource 样板类，改用通用 `EntityStore<T>` 泛型引擎；
- [ ] **一键切换验证**：确认在 `entityStoreFactoryProvider` 中修改工厂类后，全量 20+ Feature 能够无缝一键完成数据库切换；
- [ ] **Riverpod 3 代码生成**：注解与 `.g.dart` 生成无误；
- [ ] **横向解耦校验**：确认无任何跨 Feature 直连 import。
