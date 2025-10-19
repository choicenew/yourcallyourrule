// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SIM卡信息处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与SIM卡信息相关的原生方法调用，并将其结果作为状态（SimInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `simCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。

@ProviderFor(SimCallHandler)
const simCallHandlerProvider = SimCallHandlerProvider._();

/// SIM卡信息处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与SIM卡信息相关的原生方法调用，并将其结果作为状态（SimInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `simCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
final class SimCallHandlerProvider
    extends $NotifierProvider<SimCallHandler, SimInfo?> {
  /// SIM卡信息处理器 Provider
  ///
  /// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
  /// 它负责处理与SIM卡信息相关的原生方法调用，并将其结果作为状态（SimInfo）暴露出来。
  ///
  /// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `simCallHandlerProvider` 的 Provider。
  /// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
  const SimCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simCallHandlerHash();

  @$internal
  @override
  SimCallHandler create() => SimCallHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimInfo?>(value),
    );
  }
}

String _$simCallHandlerHash() => r'2f68475c3f5148bf1a8bceabddf14042dd969ee3';

/// SIM卡信息处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与SIM卡信息相关的原生方法调用，并将其结果作为状态（SimInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `simCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。

abstract class _$SimCallHandler extends $Notifier<SimInfo?> {
  SimInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SimInfo?, SimInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SimInfo?, SimInfo?>,
              SimInfo?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
