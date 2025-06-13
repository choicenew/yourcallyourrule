# Your Call Your Rule - Riverpod 迁移指南

## 概述

本项目正在从Provider状态管理迁移到Riverpod状态管理。这是一个渐进式的迁移过程，允许两种状态管理方式共存，直到完全迁移完成。

## 迁移进度

目前已完成的迁移内容：

1. 基础Provider结构 - 所有基础仓库Provider已迁移到Riverpod
2. 服务Provider - 所有服务Provider已迁移到Riverpod
3. 设置页面 - 已创建Riverpod版本的设置页面

## 如何运行Riverpod版本

要运行Riverpod版本的应用，请使用以下命令：

```bash
flutter run -t lib/main_riverpod.dart
```

这将启动使用Riverpod状态管理的应用版本。

## 如何访问Riverpod版本的设置页面

在应用中，可以通过以下URL访问Riverpod版本的设置页面：

```
/settings-riverpod
```

## 迁移策略

1. **渐进式迁移**：我们采用渐进式迁移策略，不允许Provider和Riverpod共存。
2. **并行实现**：对于关键页面，我们创建了并行的Riverpod实现，以便进行测试和比较。
3. **保持兼容性**：确保在迁移过程中应用的功能不受影响。

## 迁移指南

### 将Provider页面迁移到Riverpod


2. 将StatelessWidget/StatefulWidget转换为ConsumerWidget/ConsumerStatefulWidget
3. 更新build方法签名，添加WidgetRef参数
4. 将`Provider.of<T>(context)`替换为`ref.watch(xxxProvider)`

### 示例

**Provider版本：**

```dart
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<TimeInterceptorService>(context);
    // ...
  }
}
```

**Riverpod版本：**

```dart
class SettingsPageRiverpod extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(timeInterceptorServiceProvider);
    // ...
  }
}
```

## 注意事项

- 在迁移过程中，保持两个版本的功能一致性
- 测试所有迁移的功能，确保行为一致
- 完成迁移后，移除旧的Provider实现

## 贡献指南

如果您要为此迁移做出贡献，请遵循以下步骤：

1. 为要迁移的页面或功能创建一个新的分支
2. 实现Riverpod版本的功能
3. 确保新实现与旧实现行为一致
4. 提交PR进行审核

## 联系方式

如有任何问题或建议，请联系项目维护者。