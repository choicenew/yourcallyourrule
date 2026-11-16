// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interceptor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimeInterceptorConfigNotifier)
final timeInterceptorConfigProvider = TimeInterceptorConfigNotifierProvider._();

final class TimeInterceptorConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          TimeInterceptorConfigNotifier,
          TimeInterceptorConfig
        > {
  TimeInterceptorConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeInterceptorConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeInterceptorConfigNotifierHash();

  @$internal
  @override
  TimeInterceptorConfigNotifier create() => TimeInterceptorConfigNotifier();
}

String _$timeInterceptorConfigNotifierHash() =>
    r'35913951c198d6bd9937c0ddfb3dbdb1e2dd1bf9';

abstract class _$TimeInterceptorConfigNotifier
    extends $AsyncNotifier<TimeInterceptorConfig> {
  FutureOr<TimeInterceptorConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<TimeInterceptorConfig>, TimeInterceptorConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TimeInterceptorConfig>,
                TimeInterceptorConfig
              >,
              AsyncValue<TimeInterceptorConfig>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
