// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_phone_rule_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localdynamicSource)
final localdynamicSourceProvider = LocaldynamicSourceProvider._();

final class LocaldynamicSourceProvider
    extends
        $FunctionalProvider<
          LocaldynamicSource,
          LocaldynamicSource,
          LocaldynamicSource
        >
    with $Provider<LocaldynamicSource> {
  LocaldynamicSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localdynamicSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localdynamicSourceHash();

  @$internal
  @override
  $ProviderElement<LocaldynamicSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocaldynamicSource create(Ref ref) {
    return localdynamicSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaldynamicSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaldynamicSource>(value),
    );
  }
}

String _$localdynamicSourceHash() =>
    r'1f979bcacadbc7147069c0f52c99eda2ab0ac769';
