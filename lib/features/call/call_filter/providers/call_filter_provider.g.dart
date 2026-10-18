// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CallFilterConfigNotifier)
final callFilterConfigProvider = CallFilterConfigNotifierProvider._();

final class CallFilterConfigNotifierProvider
    extends $AsyncNotifierProvider<CallFilterConfigNotifier, CallFilterConfig> {
  CallFilterConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callFilterConfigNotifierHash();

  @$internal
  @override
  CallFilterConfigNotifier create() => CallFilterConfigNotifier();
}

String _$callFilterConfigNotifierHash() =>
    r'7b643ad2bf70312684c8691889ddda5eb551f9f7';

abstract class _$CallFilterConfigNotifier
    extends $AsyncNotifier<CallFilterConfig> {
  FutureOr<CallFilterConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CallFilterConfig>, CallFilterConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallFilterConfig>, CallFilterConfig>,
              AsyncValue<CallFilterConfig>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）

@ProviderFor(SimSlotCallFilterConfigNotifier)
final simSlotCallFilterConfigProvider =
    SimSlotCallFilterConfigNotifierFamily._();

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）
final class SimSlotCallFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          SimSlotCallFilterConfigNotifier,
          CallFilterConfig
        > {
  /// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）
  SimSlotCallFilterConfigNotifierProvider._({
    required SimSlotCallFilterConfigNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'simSlotCallFilterConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$simSlotCallFilterConfigNotifierHash();

  @override
  String toString() {
    return r'simSlotCallFilterConfigProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SimSlotCallFilterConfigNotifier create() => SimSlotCallFilterConfigNotifier();

  @override
  bool operator ==(Object other) {
    return other is SimSlotCallFilterConfigNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$simSlotCallFilterConfigNotifierHash() =>
    r'21c024a642cccd0db6f176d6a463951a816349a1';

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）

final class SimSlotCallFilterConfigNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SimSlotCallFilterConfigNotifier,
          AsyncValue<CallFilterConfig>,
          CallFilterConfig,
          FutureOr<CallFilterConfig>,
          int
        > {
  SimSlotCallFilterConfigNotifierFamily._()
    : super(
        retry: null,
        name: r'simSlotCallFilterConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）

  SimSlotCallFilterConfigNotifierProvider call(int simSlotIndex) =>
      SimSlotCallFilterConfigNotifierProvider._(
        argument: simSlotIndex,
        from: this,
      );

  @override
  String toString() => r'simSlotCallFilterConfigProvider';
}

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）

abstract class _$SimSlotCallFilterConfigNotifier
    extends $AsyncNotifier<CallFilterConfig> {
  late final _$args = ref.$arg as int;
  int get simSlotIndex => _$args;

  FutureOr<CallFilterConfig> build(int simSlotIndex);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CallFilterConfig>, CallFilterConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallFilterConfig>, CallFilterConfig>,
              AsyncValue<CallFilterConfig>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定，keepAlive: true 保证切页面不释放状态)

@ProviderFor(SeparateSimsNotifier)
final separateSimsProvider = SeparateSimsNotifierProvider._();

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定，keepAlive: true 保证切页面不释放状态)
final class SeparateSimsNotifierProvider
    extends $AsyncNotifierProvider<SeparateSimsNotifier, bool> {
  /// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定，keepAlive: true 保证切页面不释放状态)
  SeparateSimsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'separateSimsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$separateSimsNotifierHash();

  @$internal
  @override
  SeparateSimsNotifier create() => SeparateSimsNotifier();
}

String _$separateSimsNotifierHash() =>
    r'f0407049712f92c828f269d28adc40ecc01e10b4';

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定，keepAlive: true 保证切页面不释放状态)

abstract class _$SeparateSimsNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
