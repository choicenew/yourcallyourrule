// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_monitor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全局的、唯一的 CallerIdData 数据流控制器 Provider
/// 使用 `@Riverpod(keepAlive: true)` 确保它是一个真正的全局单例，
/// 不会被意外销毁，可以被后台服务安全地、持续地监听。

@ProviderFor(callerIdDataSubject)
const callerIdDataSubjectProvider = CallerIdDataSubjectProvider._();

/// 全局的、唯一的 CallerIdData 数据流控制器 Provider
/// 使用 `@Riverpod(keepAlive: true)` 确保它是一个真正的全局单例，
/// 不会被意外销毁，可以被后台服务安全地、持续地监听。

final class CallerIdDataSubjectProvider
    extends
        $FunctionalProvider<
          BehaviorSubject<CallerIdData>,
          BehaviorSubject<CallerIdData>,
          BehaviorSubject<CallerIdData>
        >
    with $Provider<BehaviorSubject<CallerIdData>> {
  /// 全局的、唯一的 CallerIdData 数据流控制器 Provider
  /// 使用 `@Riverpod(keepAlive: true)` 确保它是一个真正的全局单例，
  /// 不会被意外销毁，可以被后台服务安全地、持续地监听。
  const CallerIdDataSubjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdDataSubjectProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdDataSubjectHash();

  @$internal
  @override
  $ProviderElement<BehaviorSubject<CallerIdData>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BehaviorSubject<CallerIdData> create(Ref ref) {
    return callerIdDataSubject(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BehaviorSubject<CallerIdData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BehaviorSubject<CallerIdData>>(
        value,
      ),
    );
  }
}

String _$callerIdDataSubjectHash() =>
    r'ad6c67c4ab6def2d25900eca7a1d03b9482a5d41';

/// 全局的、唯一的原始事件流控制器 Provider
/// 使用 `keepAlive: true` 确保它的生命周期独立于任何 Notifier，不会被热重载影响。

@ProviderFor(rawCallEventStreamController)
const rawCallEventStreamControllerProvider =
    RawCallEventStreamControllerProvider._();

/// 全局的、唯一的原始事件流控制器 Provider
/// 使用 `keepAlive: true` 确保它的生命周期独立于任何 Notifier，不会被热重载影响。

final class RawCallEventStreamControllerProvider
    extends
        $FunctionalProvider<
          StreamController<MethodCall>,
          StreamController<MethodCall>,
          StreamController<MethodCall>
        >
    with $Provider<StreamController<MethodCall>> {
  /// 全局的、唯一的原始事件流控制器 Provider
  /// 使用 `keepAlive: true` 确保它的生命周期独立于任何 Notifier，不会被热重载影响。
  const RawCallEventStreamControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rawCallEventStreamControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rawCallEventStreamControllerHash();

  @$internal
  @override
  $ProviderElement<StreamController<MethodCall>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamController<MethodCall> create(Ref ref) {
    return rawCallEventStreamController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamController<MethodCall> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamController<MethodCall>>(value),
    );
  }
}

String _$rawCallEventStreamControllerHash() =>
    r'bd8a54006c557bc101e5d19cee6836604e2d6533';

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
    r'7b9defe5f908a048b87e3ea5cf4a87ae75c695b4';

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
