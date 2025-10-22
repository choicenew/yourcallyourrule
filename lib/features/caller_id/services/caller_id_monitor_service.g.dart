// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_monitor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它的 `build` 方法只在服务第一次启动时执行一次，负责设置好与原生代码的通信桥梁。

@ProviderFor(CallerIdMonitorService)
const callerIdMonitorServiceProvider = CallerIdMonitorServiceProvider._();

/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它的 `build` 方法只在服务第一次启动时执行一次，负责设置好与原生代码的通信桥梁。
final class CallerIdMonitorServiceProvider
    extends $AsyncNotifierProvider<CallerIdMonitorService, void> {
  /// 来电显示监控服务 Provider
  ///
  /// 使用 Riverpod 3.0 的 AsyncNotifier API。
  /// 这是整个来电处理流程的“大脑”和“总指挥”。
  /// 它的 `build` 方法只在服务第一次启动时执行一次，负责设置好与原生代码的通信桥梁。
  const CallerIdMonitorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdMonitorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdMonitorServiceHash();

  @$internal
  @override
  CallerIdMonitorService create() => CallerIdMonitorService();
}

String _$callerIdMonitorServiceHash() =>
    r'aae96c7623870df5cd46a5b0aca6e5ccde032cf0';

/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它的 `build` 方法只在服务第一次启动时执行一次，负责设置好与原生代码的通信桥梁。

abstract class _$CallerIdMonitorService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
