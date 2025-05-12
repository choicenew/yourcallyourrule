# simplified标签管理系统设计说明

## 系统概览

这个标签管理系统采用了基于ID引用的设计模式，通过将标签定义和标签使用分离，实现统一管理和更新标签的目标。系统主要包含以下几个核心组件：

1. **PredefinedLabel 类** - 负责定义标签的基本结构，包含UUID和标签文本等信息
2. **PredefinedLabelService** - 负责创建和管理标签
3. **LabelViewModel** - 提供通用的视图模型用于UI显示

## 核心组件详解

### 1. PredefinedLabel 类

```dart
class PredefinedLabel {
  final String id;      // UUID作为唯一标识符
  final String text;    // 标签文本内容
  final String? avatar; // 可选的头像
  final String? icon;   // 可选的图标

  const PredefinedLabel({
    required this.id,
    required this.text,
    this.avatar,
    this.icon,
  });

  // 序列化方法
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'avatar': avatar,
      'icon': icon,
    };
  }

  // 反序列化方法
  factory PredefinedLabel.fromMap(Map<String, dynamic> map) {
    return PredefinedLabel(
      id: map['id'],
      text: map['text'],
      avatar: map['avatar'],
      icon: map['icon'],
    );
  }
}
```

### 2. PredefinedLabelService

```dart
class PredefinedLabelService {
  final Database _db;
  final Uuid _uuid = Uuid();

  PredefinedLabelService(this._db);

  // 创建新标签
  Future<PredefinedLabel> createLabel(String text, {String? avatar, String? icon}) async {
    final label = PredefinedLabel(
      id: _uuid.v4(),
      text: text,
      avatar: avatar,
      icon: icon,
    );
    
    await _db.insert('predefined_labels', label.toMap());
    return label;
  }

  // 获取所有标签
  Future<List<PredefinedLabel>> getAllLabels() async {
    final maps = await _db.query('predefined_labels');
    return maps.map((map) => PredefinedLabel.fromMap(map)).toList();
  }

  // 根据ID获取标签
  Future<PredefinedLabel?> getLabelById(String id) async {
    final maps = await _db.query(
      'predefined_labels',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isEmpty) return null;
    return PredefinedLabel.fromMap(maps.first);
  }

  // 更新标签
  Future<void> updateLabel(PredefinedLabel label) async {
    await _db.update(
      'predefined_labels',
      label.toMap(),
      where: 'id = ?',
      whereArgs: [label.id],
    );
  }

  // 删除标签
  Future<void> deleteLabel(String id) async {
    await _db.delete(
      'predefined_labels',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
```

### 3. 修改规则类 (AllowedRule, BlacklistRule, LabelEntry)

所有规则类都需要将原来的`label`字符串字段改为`labelId`引用字段。以`AllowedRule`为例：

```dart
class AllowedRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String labelId;  // 使用labelId引用PredefinedLabel
  // 其他字段...

  const AllowedRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.labelId,  // 必须提供labelId
    // 其他参数...
  });

  // 其他方法相应修改...
}
```

### 4. LabelViewModel 通用视图模型

```dart
class LabelViewModel<T> {
  final T rule;  // 可以是AllowedRule, BlacklistRule或LabelEntry
  final PredefinedLabel? label;
  final String Function(T) getLabelId;  // 获取规则中labelId的函数

  LabelViewModel({
    required this.rule,
    this.label,
    required this.getLabelId,
  });

  // 便捷方法 - 获取标签文本
  String get labelText => label?.text ?? 'Unknown Label';

  // 便捷方法 - 获取标签ID
  String get labelId => getLabelId(rule);

  // 便捷方法 - 获取标签头像
  String? get labelAvatar => label?.avatar;

  // 便捷方法 - 获取标签图标
  String? get labelIcon => label?.icon;
}
```

## 数据库表设计

```sql
-- 预定义标签表
CREATE TABLE predefined_labels (
  id TEXT PRIMARY KEY,      -- UUID
  text TEXT NOT NULL,       -- 标签文本
  avatar TEXT,              -- 可选头像
  icon TEXT                 -- 可选图标
);

-- 规则表示例 (以allowed_rules为例)
CREATE TABLE allowed_rules (
  id TEXT PRIMARY KEY,
  name TEXT,
  priority INTEGER NOT NULL,
  phone_number TEXT NOT NULL,
  label_id TEXT NOT NULL,   -- 引用predefined_labels表的id
  action TEXT NOT NULL,
  is_enabled INTEGER DEFAULT 1,
  is_subscribed INTEGER DEFAULT 0,
  count INTEGER DEFAULT 0,
  avatar TEXT,
  FOREIGN KEY (label_id) REFERENCES predefined_labels (id)
);
```

## 使用流程说明

### 1. 创建和管理标签

```dart
// 初始化服务
final labelService = PredefinedLabelService(database);

// 创建新标签
final spamLabel = await labelService.createLabel('垃圾电话', 
    icon: 'spam_icon');
final friendLabel = await labelService.createLabel('朋友', 
    avatar: 'friend_avatar.png');

// 获取所有标签
final allLabels = await labelService.getAllLabels();

// 更新标签
final updatedLabel = PredefinedLabel(
  id: spamLabel.id,
  text: '骚扰电话',  // 修改文本
  icon: spamLabel.icon,
);
await labelService.updateLabel(updatedLabel);
```

### 2. 创建使用标签ID的规则

```dart
// 创建带有标签ID引用的规则
final rule = AllowedRule(
  id: uuid.v4(),
  name: '朋友Alex',
  priority: RulePriority(1),
  phoneNumber: PhoneNumber.fromString('+123456789'),
  labelId: friendLabel.id,  // 使用标签ID
  // 其他参数...
);

await ruleRepository.saveRule(rule);
```

### 3. 在UI中使用视图模型显示规则和标签

```dart
// 加载规则
final rules = await ruleRepository.getAllRules();

// 提取所有使用的标签ID
final labelIds = rules.map((r) => r.labelId).toSet().toList();

// 批量加载所有相关的标签
final labelsMap = <String, PredefinedLabel>{};
for (final id in labelIds) {
  final label = await labelService.getLabelById(id);
  if (label != null) {
    labelsMap[id] = label;
  }
}

// 创建视图模型
final viewModels = rules.map((rule) {
  return LabelViewModel<AllowedRule>(
    rule: rule,
    label: labelsMap[rule.labelId],
    getLabelId: (r) => r.labelId,
  );
}).toList();

// 在UI中使用视图模型
for (final vm in viewModels) {
  print('电话: ${vm.rule.phoneNumber.value}');
  print('标签: ${vm.labelText}');
  if (vm.labelAvatar != null) {
    print('头像: ${vm.labelAvatar}');
  }
}
```

## 优势总结

1. **集中管理标签** - 所有标签定义在`PredefinedLabel`中统一管理
2. **减少数据冗余** - 标签文本只存储一次，通过ID引用
3. **保持一致性** - 更新标签只需在一处修改，所有引用处自动更新
4. **通用视图模型** - `LabelViewModel`可用于所有规则类型，降低代码重复
5. **扩展性好** - 可以轻松添加新的标签属性而不影响现有规则结构

## 实施建议

1. 首先创建`PredefinedLabel`类和对应的数据库表
2. 实现`PredefinedLabelService`
3. 修改所有规则类，将`label`字段改为`labelId`
4. 创建通用的`LabelViewModel`
5. 更新UI代码，使用视图模型显示数据

通过这种设计，您可以为应用添加完整的标签管理功能，包括创建、编辑、删除标签，以及将标签分配给不同类型的规则。所有更改都会自动应用到使用这些标签的规则上。
