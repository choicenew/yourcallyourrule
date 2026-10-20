// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LocaleService 的 @Riverpod Provider

@ProviderFor(localeService)
final localeServiceProvider = LocaleServiceProvider._();

/// LocaleService 的 @Riverpod Provider

final class LocaleServiceProvider
    extends $FunctionalProvider<LocaleService, LocaleService, LocaleService>
    with $Provider<LocaleService> {
  /// LocaleService 的 @Riverpod Provider
  LocaleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeServiceHash();

  @$internal
  @override
  $ProviderElement<LocaleService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocaleService create(Ref ref) {
    return localeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleService>(value),
    );
  }
}

String _$localeServiceHash() => r'0bcd29141942b4a93ade88caa796446fa7d7e808';
