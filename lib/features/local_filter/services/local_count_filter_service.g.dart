// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_count_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localCountFilterService)
const localCountFilterServiceProvider = LocalCountFilterServiceProvider._();

final class LocalCountFilterServiceProvider
    extends
        $FunctionalProvider<
          LocalCountFilterService,
          LocalCountFilterService,
          LocalCountFilterService
        >
    with $Provider<LocalCountFilterService> {
  const LocalCountFilterServiceProvider._()
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
    r'b369cc9936f695ffc88b5a22ff07cd2ce1411118';
