# 纯数据驱动领域实体与运行期动态例化规范 (Data-Driven Domain Value Objects Specification)

文件位置：`packages/DATA_DRIVEN_ENTITY_SPEC.md`

---

## 核心哲学：弃用硬编码 Enum，采用数据驱动值对象 (Domain Value Objects)

为了保证整个 VehereGo / Mix 系统的子 package 组具备**零发版云端热更新**能力，并彻底符合**全球多语言国际化 (i18n)** 铁律，所有子包（`pickup`, `identity`, `ticket`, `course`, `live`, `location` 等）的类型、品类与状态定义必须无条件遵守本规范。

---

## 一、 为什么彻底弃用 `enum` 枚举？

1. **编译期死锁问题**：
   `enum` 是 Dart 编译期固定的符号表（如 `enum PickupKind { parcel, food }`）。当云端规则库（`rules_manifest.json`）动态下发了一个编译期从未见过的全新分类 ID（如 `'medicine'` 或 `'xx'`）时，写死的 `enum` 无法在运行期动态新增项，直接打破了云端热更新架构。
2. **语言字面量污染**：
   严禁在 `enum` 或实体属性中写入 `labelCn: '快递包裹'`、`'周一'` 等硬编码中文字符串。

---

## 二、 纯数据驱动领域值对象代码范式

所有的分类、状态与品类，统一采用**重写了 `operator ==` 和 `hashCode` 的不可变领域值对象（Immutable Value Object）**：

```dart
import 'package:meta/meta.dart';

/// 纯数据驱动取件凭证种类值对象 (PickupKind)
@immutable
class PickupKind {
  final String id; // 领域唯一代码 (如 'parcel', 'food', 'xx')

  const PickupKind(this.id);

  // 1. 代码内部预留的标准常用静态常量 (供编译期静态类型安全比较)
  static const PickupKind parcel = PickupKind('parcel');
  static const PickupKind food = PickupKind('food');
  static const PickupKind queue = PickupKind('queue');
  static const PickupKind memo = PickupKind('memo');

  // 2. 从 JSON 运行期动态例化 (Runtime Instantiation)
  factory PickupKind.fromJson(Map<String, dynamic> json) {
    final rawId = json['kind_id']?.toString() ?? 'parcel';
    return PickupKind(rawId);
  }

  // 3. 便捷快捷判断 getter
  bool get isParcel => id == 'parcel';
  bool get isFood => id == 'food';

  // 4. 重写 operator == 和 hashCode：只要 ID 相同，内存中两个独立生成的对象 100% 绝对判等！
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickupKind && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
```

---

## 三、 运行期动态例化（Runtime Entity Instantiation）原理

1. **图纸（Class） vs 实例（Object）**：
   * 编译好的 App 中保存的是 `PickupKind` 的类图纸；
   * 当云端发来未见过的全新 JSON `{"kind_id": "xx"}` 时，App 执行 `PickupKind('xx')`，瞬间在手机内存中造出了代表 `'xx'` 的强类型实体对象！
2. **零硬编码与国际化解耦**：
   * 实体内部 **100% 不保存任何人类语言展示文本**。
   * UI 展现层拿到 `kind` 后，如果 `kind.id` 为标准 Key，通过 `AppLocalizations.of(context)` 呈现本地化文案；若为云端新 ID，向 `BrandManifest` / 词典查询云端动态标题。
