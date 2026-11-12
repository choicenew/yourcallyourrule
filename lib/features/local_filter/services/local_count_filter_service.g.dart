// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_count_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localCountFilterService)
final localCountFilterServiceProvider = LocalCountFilterServiceProvider._();

final class LocalCountFilterServiceProvider
    extends
        $FunctionalProvider<
          LocalCountFilterService,
          LocalCountFilterService,
          LocalCountFilterService
        >
    with $Provider<LocalCountFilterService> {
  LocalCountFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCountFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localCountFilterServiceHash();

  @$internal
  @override
  $ProviderElement<LocalCountFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalCountFilterService create(Ref ref) {
    return localCountFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalCountFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalCountFilterService>(value),
    );
  }
}

String _$localCountFilterServiceHash() =>
    r'11da8452ec232e5d78cfb98242bf502db5ddd9f3';
