# 通用组件重构方案

## 概述

在分析项目代码后，我们发现多个页面存在大量重复代码，特别是在订阅管理和规则管理方面。为了减少代码重复，提高可维护性，我们创建了一系列通用组件，可以在不同的功能模块中复用。

## 已有的通用组件

项目中已经存在一些通用组件：

- `subscription_management_widget.dart` - 订阅管理组件
- `rule_management_widget.dart` - 规则管理组件
- `import_export_service_component.dart` - 导入导出服务组件

## 新增通用组件

为了进一步减少代码重复，我们新增了以下通用组件：

1. `generic_subscription_page.dart` - 通用订阅页面组件
2. `generic_rule_page.dart` - 通用规则管理页面组件

## 重构方案

### 订阅管理页面重构

以下页面可以使用通用订阅组件进行重构：

- `phone_subscription_page.dart`
- `sms_subscription_page.dart`
- `contact_subscription_page.dart`

重构示例：

```dart
// 重构前：每个页面都有自己的实现，大量重复代码
class PhoneSubscriptionPage extends StatefulWidget {
  // 大量重复代码...
}

// 重构后：使用通用组件
class PhoneSubscriptionPageRefactored extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericSubscriptionPage<Subscription, String, PhoneSubscriptionService>(
      title: '电话规则订阅',
      emptyText: '暂无订阅',
      buildInfoCard: _buildInfoCard,
      buildSubscriptionCard: _buildSubscriptionCard,
      showAddDialog: _showAddSubscriptionDialog,
      updateSubscription: (subscription, service) => 
          service.manualUpdateRulesFromSubscription(subscription),
    );
  }
  
  // 只需要实现特定的UI和业务逻辑...
}
```

### 规则管理页面重构

以下页面可以使用通用规则管理组件进行重构：

- `allowed_blocked_page.dart`
- `blacklist_whitelist_page.dart`
- `regex_rule_page.dart`
- `sms_management_page.dart`

重构示例：

```dart
// 重构前：每个页面都有自己的实现，大量重复代码
class RegexRulePage extends StatefulWidget {
  // 大量重复代码...
}

// 重构后：使用通用组件
class RegexRulePageRefactored extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericRulePage<RegexRule, RegexService>(
      title: '正则规则管理',
      emptyText: '正则规则',
      emptyIcon: Icons.code,
      addButtonText: '添加正则规则',
      buildRuleCard: _buildRuleCard,
      showAddDialog: _showAddRuleDialog,
      getAllRules: (service) => service.getAllRegexRules(),
      toggleRule: (service, ruleId, isEnabled) => 
          service.toggleRegexRule(ruleId, isEnabled),
      deleteRule: (service, ruleId) => service.removeRegexRule(ruleId),
    );
  }
  
  // 只需要实现特定的UI和业务逻辑...
}
```

## 重构优势

1. **减少代码重复** - 通过使用通用组件，大幅减少了重复代码，提高了代码的可维护性。
2. **统一用户界面** - 确保所有页面具有一致的用户界面和交互体验。
3. **简化开发** - 新增功能时，只需要关注特定的业务逻辑，而不需要重复实现通用功能。
4. **易于测试** - 通用组件可以单独测试，提高了代码的可测试性。
5. **提高可扩展性** - 新增功能时，可以直接使用现有的通用组件，减少开发时间。

## 使用指南

### 使用通用订阅页面组件

```dart
GenericSubscriptionPage<T, ID, S>(
  title: '页面标题',
  emptyText: '空状态文本',
  emptyIcon: Icons.icon,  // 可选
  buildInfoCard: () => Widget,  // 构建信息卡片
  buildSubscriptionCard: (subscription, state) => Widget,  // 构建订阅卡片
  showAddDialog: (context, service, refreshCallback) => void,  // 显示添加对话框
  updateSubscription: (subscription, service) => Future<void>,  // 更新订阅
)
```

### 使用通用规则管理页面组件

```dart
GenericRulePage<T, S>(
  title: '页面标题',
  themeColor: Colors.color,  // 可选
  emptyText: '空状态文本',
  emptyIcon: Icons.icon,
  addButtonText: '添加按钮文本',
  useLabelFilter: true/false,  // 是否使用标签筛选
  buildRuleCard: (rule) => Widget,  // 构建规则卡片
  showAddDialog: (context, service, refreshCallback) => void,  // 显示添加对话框
  getAllRules: (service) => Future<List<T>>,  // 获取所有规则
  toggleRule: (service, ruleId, isEnabled) => Future<void>,  // 切换规则状态
  deleteRule: (service, ruleId) => Future<void>,  // 删除规则
  importExportComponent: ImportExportServiceComponent,  // 可选
  showLabelFilterDialog: (context, onLabelSelected) => void,  // 可选
)
```

## 结论

通过使用通用组件重构现有页面，我们可以大幅减少代码重复，提高代码的可维护性和可扩展性。建议逐步将现有页面迁移到使用通用组件的方式，以实现代码的统一和简化。