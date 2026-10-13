---
trigger: always_on
---

# Riverpod 3.0 迁移核心速查表

## 1. 自动重试 (Automatic retry)
Riverpod 3.0 默认自动重试失败的 provider。
- **全局禁用**：
  ```dart
  ProviderScope(retry: (retryCount, error) => null, child: MyApp())
  ```
- **单 provider 禁用**：
  ```dart
  NotifierProvider<TodoList, List<Todo>>(TodoList.new, retry: (retryCount, error) => null)
  ```

## 2. 局部暂停 (Out of view providers are paused)
非视口 provider 默认暂停。在 consumer 层使用 `TickerMode(enabled: true, child: Consumer(...))` 可禁止暂停。

## 3. Legacy 组件新引入路径
`StateProvider`, `StateNotifierProvider`, `ChangeNotifierProvider` 移入 `legacy.dart`：
```dart
import 'package:hooks_riverpod/legacy.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/legacy.dart';
```

## 4. 统一使用 == 过滤更新
所有 provider 一律使用 `==` 过滤更新。若需自定义，覆写 `Notifier.updateShouldNotify`：
```dart
@override
bool updateShouldNotify(AsyncValue<Todo> previous, AsyncValue<Todo> next) => true;
```

## 5. ProviderObserver 变更
`ProviderObserver` 接口参数简化：
```diff
- void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container)
+ void didAddProvider(ProviderObserverContext context, Object? value)
```

## 6. Ref 简化与 Subclass 移除
去除了所有 Ref 的子类（如 `ProviderRef` 等，直接使用 `Ref`）。
属性/方法由 Ref 转移至 Notifier：
- `ProviderRef.state` -> `Notifier.state`
- `Ref.listenSelf` -> `Notifier.listenSelf`
- `FutureProviderRef.future` -> `AsyncNotifier.future`

## 7. AutoDispose 接口合并
不再需要 `AutoDispose` 前缀。直接进行全局替换：将 `AutoDisposeNotifier`/`AutoDisposeProvider` 等直接重命名为 `Notifier`/`Provider`。

## 8. Family 变体移除
去除了 `FamilyNotifier` 系列，合并入标准类。迁移示例：
```diff
- class CounterNotifier extends FamilyNotifier<int, String> {
+ class CounterNotifier extends Notifier<int> {
+   CounterNotifier(this.arg);
+   final String arg;
-   int build(String arg) {
+   int build() {
```

## 9. 异常抛出包装为 ProviderException
所有 provider 失败包装为 `ProviderException`。
```dart
try {
  await ref.read(myProvider.future);
} on ProviderException catch (e) {
  if (e.exception is NotFoundException) { ... }
}
```

## 10. 系统环境与 Flutter SDK 路径 (Environment Path)
- **Flutter SDK 本地安装路径**：`D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter`
- **Flutter CLI 绝对路径**：`D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter\bin\flutter.bat`
- **Dart CLI 绝对路径**：`D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter\bin\dart.bat`