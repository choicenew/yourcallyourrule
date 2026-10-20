// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SmsFilterService 的 @Riverpod Provider

@ProviderFor(smsFilterService)
final smsFilterServiceProvider = SmsFilterServiceProvider._();

/// SmsFilterService 的 @Riverpod Provider

final class SmsFilterServiceProvider
    extends
        $FunctionalProvider<
          SmsFilterService,
          SmsFilterService,
          SmsFilterService
        >
    with $Provider<SmsFilterService> {
  /// SmsFilterService 的 @Riverpod Provider
  SmsFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsFilterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsFilterServiceHash();

  @$internal
  @override
  $ProviderElement<SmsFilterService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SmsFilterService create(Ref ref) {
    return smsFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsFilterService>(value),
    );
  }
}

String _$smsFilterServiceHash() => r'e6c85f73dbe690f084f52abcd9d7378665cc8904';
