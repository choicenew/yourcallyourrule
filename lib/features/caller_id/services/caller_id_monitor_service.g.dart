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
/// 它负责：
/// 1. 在初始化时（build方法），从 Riverpod 获取所有需要的 Handler 和 Service 实例。
/// 2. 将这些 Handler 注册到原生通道管理器（AndroidCallChannelManager）。
/// 3. 监听核心数据流的变化。
///
/// 使用 `keepAlive: true` 确保此服务在应用启动后持续在后台运行。

@ProviderFor(CallerIdMonitorService)
const callerIdMonitorServiceProvider = CallerIdMonitorServiceProvider._();

/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它负责：
/// 1. 在初始化时（build方法），从 Riverpod 获取所有需要的 Handler 和 Service 实例。
/// 2. 将这些 Handler 注册到原生通道管理器（AndroidCallChannelManager）。
/// 3. 监听核心数据流的变化。
///
/// 使用 `keepAlive: true` 确保此服务在应用启动后持续在后台运行。
final class CallerIdMonitorServiceProvider
    extends $AsyncNotifierProvider<CallerIdMonitorService, void> {
  /// 来电显示监控服务 Provider
  ///
  /// 使用 Riverpod 3.0 的 AsyncNotifier API。
  /// 这是整个来电处理流程的“大脑”和“总指挥”。
  /// 它负责：
  /// 1. 在初始化时（build方法），从 Riverpod 获取所有需要的 Handler 和 Service 实例。
  /// 2. 将这些 Handler 注册到原生通道管理器（AndroidCallChannelManager）。
  /// 3. 监听核心数据流的变化。
  ///
  /// 使用 `keepAlive: true` 确保此服务在应用启动后持续在后台运行。
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
    r'c5fe06025e157cdc4955da2134d20649a928efef';

/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它负责：
/// 1. 在初始化时（build方法），从 Riverpod 获取所有需要的 Handler 和 Service 实例。
/// 2. 将这些 Handler 注册到原生通道管理器（AndroidCallChannelManager）。
/// 3. 监听核心数据流的变化。
///
/// 使用 `keepAlive: true` 确保此服务在应用启动后持续在后台运行。

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
