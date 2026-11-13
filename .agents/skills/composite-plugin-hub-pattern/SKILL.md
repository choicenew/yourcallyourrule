---
name: composite-plugin-hub-pattern
description: 核心定义“标准的 Composite 组合模式 + 插件化控制中枢 + 主 App 单向胶水装配体系”多包拆分与解耦范式。规避子模块反向依赖 Hub、规避 UI 硬编码 Cross-Import，约束所有的 registerFilter/registerPlugin 装配动作 100% 集中发生在主 App 协调层 (AppCoordinator)。
---

# Composite 组合模式 + 插件化控制中枢 + 主 App 装配范式 (Composite Plugin Hub Standard Specification)

本规范定义了项目中所有的扩展型控制中枢（如 `call_filter`、`sms`、`notification` 等）的标准五层解耦与装配铁律。

---

## 🏗️ 架构四大核心组件与职责分工

```
  ┌─────────────────────────────────────────────────────────┐
  │                    *_protocol (契约层)                   │
  │        (仅定义抽象 Interface 契约与纯数据 Value Objects)   │
  └────────────────────────────┬────────────────────────────┘
                               │ 仅依赖契约
                               ▼
  ┌─────────────────────────────────────────────────────────┐
  │                    *_hub (控制中枢层)                   │
  │     (纯 Composite 组合评估容器, 持有 List<Interface>,   │
  │      提供 registerPlugin/registerFilter 接口,           │
  │      绝对零依赖、零硬编码任何具体 Driver/Filter 实现类) │
  └────────────────────────────▲────────────────────────────┘
                               │ 单向注入 (registerFilter)
                               │
  ┌────────────────────────────┴────────────────────────────┐
  │          Host App Orchestration Layer (主 App 装配层)   │
  │    (唯一胶水层：AppCoordinator / AppHubExchangeConnector│
  │     集中 import Hub 与各个 Driver，在启动时完成注册)    │
  └────────────────────────────▲────────────────────────────┘
                               │ 单向提供实例
                               │
  ┌────────────────────────────┴────────────────────────────┐
  │            *_driver / 子 Feature (独立驱动层)           │
  │       (独立实现 Interface 契约, 绝对反向 0 依赖 Hub)     │
  └─────────────────────────────────────────────────────────┘
```

---

## 📌 核心架构三大铁律

### 1. Hub 纯洁性铁律 (Hub Decoupling)
* **规则**：`*_hub` 仅作为一个 Composite 容器与顺序/并行评估引擎。
* **禁令**：**绝对禁止在 `*_hub` 内部硬编码 `import` 任何具体 Driver 或 Feature**；
* **设计**：`*_hub` 仅对外暴露 `register(Interface)` 接口，不感知谁实现了该接口。

### 2. Driver 零反向依赖铁律 (Driver Autonomy)
* **规则**：各个独立的 Driver 或子功能包（如 `local_filter`、`remote_filter`、`sim_slot`、`time_interceptor`）仅关注实现 `Interface`。
* **禁令**：**绝对禁止 Driver 反向 `import` `*_hub` 或主动调用 Hub 的注册逻辑**。

### 3. 主 App 集中装载铁律 (Host App Single-Way Injection)
* **规则**：所有的装配注册动作 **100% 集中发生在主 App 协调层（`lib/core/coordinator/`）**。
* **机制**：主 App 作为全局唯一的 Mediator（胶水层），在初始化时负责实例化 Driver，并调用 `Hub.instance.register(driver)` 进行单向装配。

### 4. UI 纯动态渲染铁律 (Dynamic UI Rendering)
* **规则**：`*_ui` 页面与组件仅消费 `Hub.instance.registeredItems` 列表。
* **机制**：配置页面通过动态遍历已注册的集合渲染列表卡片与开关，**绝对禁止在 UI 中硬编码 `import` 具体的 Driver 页面或 Widget**。

---

## 💡 应用案例与代码模式

### 主 App 装配示例 (`lib/core/coordinator/app_hub_exchange_connector.dart`)
```dart
void registerAllFilters(Ref ref) {
  // 主 App 作为唯一 Orchestrator，集中将独立 Filter 注册入 Hub
  EnhancedCompositeFilterService.instance.registerFilter(ref.read(localCountFilterProvider));
  EnhancedCompositeFilterService.instance.registerFilter(ref.read(remoteNumberFilterProvider));
  EnhancedCompositeFilterService.instance.registerFilter(ref.read(simSlotRuleFilterProvider));
}
```

### UI 动态遍历示例 (`enhanced_filter_settings_page.dart`)
```dart
// 纯动态渲染已注册的 Filter，零硬编码 import
ListView.builder(
  itemCount: EnhancedCompositeFilterService.instance.filters.length,
  itemBuilder: (context, index) {
    final filter = EnhancedCompositeFilterService.instance.filters[index];
    return FilterTile(
      title: filter.filterType.id,
      onToggle: (enabled) => ...,
    );
  },
);
```
