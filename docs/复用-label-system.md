#复用标签系统设计说明

## 核心思路

我们的目标是建立一个统一的标签管理系统，使各种规则（AllowedRule、BlacklistRule等）能够通过ID引用标签，而不是各自存储标签文本。这样可以避免数据冗余，并确保标签的一致性和可管理性。

## 1. 使用 LabelEntry 作为标签主体

在当前系统中，`LabelEntry` 已经存在，我们将它直接用作标签的主要容器，而不是再创建一个独立的 `Label` 类。

### 修改 LabelEntry 类

```dart
class LabelEntry extends RuleBase {
  // 电话号码值对象 - 对于纯标签管理可以考虑移除此字段
  final PhoneNumber? phoneNumber; // 改为可选
  
  // 标签文本内容
  final String label;
  
  // 头像（可选）
  final String? avatar;
  
  // 标签图标（可选）
  final String? icon;
  
  // 构造函数
  const LabelEntry({
    required super.id, // 使用UUID作为唯一标识符
    String? name,
    super.priority = defaultPriority,
    this.phoneNumber, // 改为可选
    required this.label,
    super.action = defaultAction,
    super.isEnabled = true,
    this.avatar,
    this.icon,
  }) : super(
        name: name ?? '',
      );
      
  // 其他方法...
}
```

## 2. 在规则类中使用 labelEntryId 引用标签

### AllowedRule 类的修改

```dart
class AllowedRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String labelEntryId; // 使用标签条目ID代替label字符串
  final bool isSubscribed;
  final int count;
  
  const AllowedRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.labelEntryId, // 引用标签条目ID
    super.action = RuleAction.allow,
    super.isEnabled = true,
    this.isSubscribed = false,
    this.count = 0,
  });
  
  // 修改toMap和fromMap方法...
}
```

同理修改 BlacklistRule 类。

## 3. 添加 LabelService 进行标签管理

创建一个服务负责统一管理标签的CRUD操作：

```dart
class LabelService {
  final LabelEntryRepository _repository;
  
  LabelService(this._repository);
  
  // 创建新标签
  Future<LabelEntry> createLabel(String labelText, {String? avatar, String? icon}) async {
    // 使用UUID生成唯一标识符
    final id = const Uuid().v4();
    
    final labelEntry = LabelEntry(
      id: id,
      label: labelText,
      avatar: avatar,
      icon: icon,
    );
    
    await _repository.save(labelEntry);
    return labelEntry;
  }
  
  // 获取所有标签
  Future<List<LabelEntry>> getAllLabels() async {
    return await _repository.getAll();
  }
  
  // 根据ID获取标签
  Future<LabelEntry?> getLabelById(String id) async {
    return await _repository.getById(id);
  }
  
  // 更新标签
  Future<void> updateLabel(LabelEntry label) async {
    await _repository.update(label);
  }
  
  // 删除标签
  Future<void> deleteLabel(String id) async {
    await _repository.delete(id);
  }
}
```

## 4. 创建视图模型关联规则和标签

### RuleViewModel 基类

```dart
// 基础规则视图模型
abstract class RuleViewModel {
  final RuleBase rule;
  final LabelEntry? labelEntry; // 关联的标签条目
  
  RuleViewModel({
    required this.rule,
    this.labelEntry,
  });
  
  // 通用属性获取方法
  String get id => rule.id;
  String get name => rule.name;
  bool get isEnabled => rule.isEnabled;
  
  // 标签相关属性
  String get labelText => labelEntry?.label ?? 'Unknown';
  String? get labelAvatar => labelEntry?.avatar;
  String? get labelIcon => labelEntry?.icon;
}
```

### AllowedRuleViewModel 示例

```dart
class AllowedRuleViewModel extends RuleViewModel {
  AllowedRuleViewModel({
    required AllowedRule rule,
    LabelEntry? labelEntry,
  }) : super(
    rule: rule,
    labelEntry: labelEntry,
  );
  
  // 类型转换，获取具体的规则对象
  AllowedRule get allowedRule => rule as AllowedRule;
  
  // 特定于AllowedRule的属性
  String get phoneNumber => allowedRule.phoneNumber.value;
  bool get isSubscribed => allowedRule.isSubscribed;
  int get count => allowedRule.count;
}
```

## 5. 加载和显示带标签的规则

在加载规则列表时，需要同时加载关联的标签信息：

```dart
Future<List<AllowedRuleViewModel>> loadAllowedRules() async {
  final rules = await _allowedRuleService.getAllRules();
  
  // 提取所有labelEntryId
  final labelIds = rules.map((rule) => rule.labelEntryId).toSet().toList();
  
  // 批量加载标签
  final labels = await _labelService.getLabelsByIds(labelIds);
  final labelMap = {for (var label in labels) label.id: label};
  
  // 创建视图模型，关联规则和标签
  return rules.map((rule) {
    return AllowedRuleViewModel(
      rule: rule,
      labelEntry: labelMap[rule.labelEntryId],
    );
  }).toList();
}
```

## 为什么使用这种设计？

1. **利用现有结构**：直接使用已有的 `LabelEntry` 类作为标签容器，避免创建额外的类。

2. **职责清晰**：
   - `LabelEntry`: 存储标签数据（ID、文本、图标等）
   - `AllowedRule`/`BlacklistRule`: 存储规则数据，通过ID引用标签
   - `LabelService`: 管理标签的CRUD操作
   - `ViewModel`: 在UI层关联规则和标签

3. **数据一致性**：通过ID引用确保标签数据的一致性，一处修改全局生效。

4. **用户体验良好**：用户不会直接接触ID，而是通过ViewModel看到友好的标签文本和图标。

## 实现步骤

1. 修改 `LabelEntry` 类，确保其包含足够的标签信息。
2. 修改 `AllowedRule` 和 `BlacklistRule` 类，使用 `labelEntryId` 替代 `label` 字符串。
3. 实现 `LabelService` 提供标签管理功能。
4. 创建视图模型类（`RuleViewModel`、`AllowedRuleViewModel` 等）。
5. 在UI层加载和显示数据时，关联规则和对应的标签。

## 数据库表设计

```sql
-- 标签表(使用LabelEntry)
CREATE TABLE label_entries (
  id TEXT PRIMARY KEY,
  name TEXT,
  label TEXT NOT NULL,
  priority INTEGER,
  action TEXT,
  is_enabled INTEGER DEFAULT 1,
  avatar TEXT,
  icon TEXT,
  phone_number TEXT -- 可选
);

-- 允许规则表
CREATE TABLE allowed_rules (
  id TEXT PRIMARY KEY,
  name TEXT,
  priority INTEGER,
  phone_number TEXT NOT NULL,
  label_entry_id TEXT NOT NULL, -- 引用标签条目ID
  action TEXT,
  is_enabled INTEGER DEFAULT 1,
  is_subscribed INTEGER DEFAULT 0,
  count INTEGER DEFAULT 0,
  FOREIGN KEY (label_entry_id) REFERENCES label_entries (id)
);

-- 黑名单规则表(类似)
CREATE TABLE blacklist_rules (
  id TEXT PRIMARY KEY,
  name TEXT,
  priority INTEGER,
  phone_number TEXT NOT NULL,
  label_entry_id TEXT NOT NULL, -- 引用标签条目ID
  action TEXT,
  is_enabled INTEGER DEFAULT 1,
  is_subscribed INTEGER DEFAULT 0,
  count INTEGER DEFAULT 0,
  FOREIGN KEY (label_entry_id) REFERENCES label_entries (id)
);
```

## 总结

这种设计保持了简单性，同时解决了标签管理的核心问题。通过利用现有的 `LabelEntry` 类作为标签容器，我们避免了创建额外的类，同时实现了标签的统一管理。
