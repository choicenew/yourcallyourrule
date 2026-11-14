# 🛡️ Call Filter 插件化控制中枢与 Connector 自注册架构规范

文件位置：`packages/CALL_FILTER_AUTO_REGISTRATION_SPEC.md`

---

## 一、 架构核心哲学与五层解耦模型

遵照 `composite-plugin-hub-pattern` 规范，通话过滤器 subsystems 采用极简彻底解耦的五层架构：

```
  ┌─────────────────────────────────────────────────────────┐
  │         pyro_phone_call_filter_protocol (契约层)        │
  │            (定义 CallFilterInterface 与 CallFilterType)   │
  └────────────────────────────┬────────────────────────────┘
                               │ 仅依赖契约
                               ▼
  ┌─────────────────────────────────────────────────────────┐
  │           pyro_phone_call_filter_hub (控制中枢)          │
  │          (持有 EnhancedCompositeFilterService,           │
  │           提供 registerFilter 接口, 绝对零依赖各 Driver) │
  └────────────────────────────▲────────────────────────────┘
                               │ 单向自注册 (registerFilter)
  ┌────────────────────────────┴────────────────────────────┐
  │        各独立 Filter 微包 Connectors (外观装配线)         │
  │ - PyroPhoneCountFilterConnector.registerAll()           │
  │ - PyroPhoneRemoteFilterConnector.registerAll()          │
  │ - PyroTimeInterceptorConnector.registerAll()            │
  │ - SimSlotRuleConnector.registerAll()                    │
  └────────────────────────────▲────────────────────────────┘
                               │ 一键调起挂载
  ┌────────────────────────────┴────────────────────────────┐
  │           Host App Orchestration (主 App 胶水层)        │
  │   (在 AppHubExchangeConnector 中一键调用各 Connector)    │
  └─────────────────────────────────────────────────────────┘
```

---

## 二、 过滤器自注册机制与代码范式

### 1. 契约定义 (`pyro_phone_call_filter_protocol`)
```dart
abstract class CallFilterInterface {
  CallFilterType get filterType;
  Future<bool> shouldAcceptCall(String phoneNumber);
  Future<void> initialize();
}
```

### 2. 子包 Connector 自注册 (`pyro_phone_count_filter_connector` 等)
各个独立 Filter 子包通过其 Connector 自提供 Driver 并向 Hub 完成自注册：
```dart
class PyroPhoneCountFilterConnector {
  static void registerAll({PhoneCountStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneCountStorageDriver();
    PhoneCountFilterControlCenter.instance.registerStorageDriver(driver);

    // 【核心：自提供 Driver + 向 call_filter 中枢自注册】
    EnhancedCompositeFilterService.instance.registerFilter(CountThresholdFilterDriver());
  }
}
```

### 3. 主 App 集中装配 (`AppHubExchangeConnector`)
主 App 作为唯一的 Mediator 胶水层，在初始化管道时一键调起各个 Connector 的自注册：
```dart
void initializeConnectorBridge() {
  // 8. 注册全量 Filter 驱动向 call_filter 自注册中枢挂载
  PyroPhoneCountFilterConnector.registerAll();
  PyroPhoneRemoteFilterConnector.registerAll();
  PyroTimeInterceptorConnector.registerAll();
  SimSlotRuleConnector.registerAll();
}
```

---

## 三、 UI 纯动态渲染与 100% 强类型比对规范

UI 页面 (`EnhancedCompositeFilterSettingsWidget`) 纯动态遍历 `EnhancedCompositeFilterService.instance.filters` 列表，使用 `CallFilterType` 强类型值对象比对，直接嵌入各个子包原生的设置组件：

```dart
Widget _buildSpecificFilterContent(CallFilterType type) {
  // 遵照 DATA_DRIVEN_ENTITY_SPEC.md 规范：无裸字符串，全强类型值对象比对
  if (type == CallFilterType.basicRule) {
    return const CallFilterSettingsWidget();
  } else if (type == CallFilterType.localCount || type.id == 'localCountThreshold' || type.id == 'timeWindow') {
    return const LocalFilterSettingsWidget();
  } else if (type == CallFilterType.remoteNumber || type.id == 'remoteRisk') {
    return const RemoteFilterSettingsWidget();
  } else if (type == CallFilterType.simSlot) {
    return const SimSlotRuleFilterWidget(simSlotIndex: 0);
  }
  return const LocalFilterSettingsWidget();
}
```

**铁律**：严禁在 UI 判断中使用 `'basicRule'` 等硬编码 Magic Strings，必须 100% 嵌入对应的原生属性调节 Widget！
