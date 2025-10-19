// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stir_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// STIR验证处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与STIR验证相关的原生方法调用，并将其结果作为状态（StirInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `stirCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。

@ProviderFor(StirCallHandler)
const stirCallHandlerProvider = StirCallHandlerProvider._();

/// STIR验证处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与STIR验证相关的原生方法调用，并将其结果作为状态（StirInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `stirCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
final class StirCallHandlerProvider
    extends $NotifierProvider<StirCallHandler, StirInfo?> {
  /// STIR验证处理器 Provider
  ///
  /// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
  /// 它负责处理与STIR验证相关的原生方法调用，并将其结果作为状态（StirInfo）暴露出来。
  ///
  /// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `stirCallHandlerProvider` 的 Provider。
  /// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
  const StirCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stirCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stirCallHandlerHash();

  @$internal
  @override
  StirCallHandler create() => StirCallHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StirInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StirInfo?>(value),
    );
  }
}

String _$stirCallHandlerHash() => r'9ab35d2a23d1e93ecfe59ff2370703411ea3484a';

/// STIR验证处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与STIR验证相关的原生方法调用，并将其结果作为状态（StirInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `stirCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。

abstract class _$StirCallHandler extends $Notifier<StirInfo?> {
  StirInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StirInfo?, StirInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StirInfo?, StirInfo?>,
              StirInfo?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
