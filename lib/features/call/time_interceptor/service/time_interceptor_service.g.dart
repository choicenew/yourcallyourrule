// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interceptor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 使用生成器创建 Service 的 Provider

@ProviderFor(timeInterceptorService)
const timeInterceptorServiceProvider = TimeInterceptorServiceProvider._();

/// 使用生成器创建 Service 的 Provider

final class TimeInterceptorServiceProvider
    extends
        $FunctionalProvider<
          TimeInterceptorService,
          TimeInterceptorService,
          TimeInterceptorService
        >
    with $Provider<TimeInterceptorService> {
  /// 使用生成器创建 Service 的 Provider
  const TimeInterceptorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeInterceptorServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeInterceptorServiceHash();

  @$internal
  @override
  $ProviderElement<TimeInterceptorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TimeInterceptorService create(Ref ref) {
    return timeInterceptorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeInterceptorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeInterceptorService>(value),
    );
  }
}

String _$timeInterceptorServiceHash() =>
    r'b536cbeb2a78ef7d80777896ed886db3383c5509';
