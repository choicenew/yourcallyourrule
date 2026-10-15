// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallFilterService 的 @riverpod Provider
/// 它会自动处理依赖注入

@ProviderFor(callFilterService)
final callFilterServiceProvider = CallFilterServiceProvider._();

/// CallFilterService 的 @riverpod Provider
/// 它会自动处理依赖注入

final class CallFilterServiceProvider
    extends
        $FunctionalProvider<
          CallFilterService,
          CallFilterService,
          CallFilterService
        >
    with $Provider<CallFilterService> {
  /// CallFilterService 的 @riverpod Provider
  /// 它会自动处理依赖注入
  CallFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callFilterServiceHash();

  @$internal
  @override
  $ProviderElement<CallFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallFilterService create(Ref ref) {
    return callFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallFilterService>(value),
    );
  }
}

String _$callFilterServiceHash() => r'14ee0569827d3936436ae6cdfa5372640cd36009';
