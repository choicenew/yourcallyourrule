// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RegexService 的 @Riverpod Provider

@ProviderFor(regexService)
final regexServiceProvider = RegexServiceProvider._();

/// RegexService 的 @Riverpod Provider

final class RegexServiceProvider
    extends $FunctionalProvider<RegexService, RegexService, RegexService>
    with $Provider<RegexService> {
  /// RegexService 的 @Riverpod Provider
  RegexServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regexServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regexServiceHash();

  @$internal
  @override
  $ProviderElement<RegexService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RegexService create(Ref ref) {
    return regexService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegexService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegexService>(value),
    );
  }
}

String _$regexServiceHash() => r'808e9b627f8472acbcdfc8435c301655c7f3dcf3';
