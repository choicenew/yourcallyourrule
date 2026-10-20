// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SmsService 的 @Riverpod Provider

@ProviderFor(smsService)
final smsServiceProvider = SmsServiceProvider._();

/// SmsService 的 @Riverpod Provider

final class SmsServiceProvider
    extends $FunctionalProvider<SmsService, SmsService, SmsService>
    with $Provider<SmsService> {
  /// SmsService 的 @Riverpod Provider
  SmsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsServiceHash();

  @$internal
  @override
  $ProviderElement<SmsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SmsService create(Ref ref) {
    return smsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsService>(value),
    );
  }
}

String _$smsServiceHash() => r'8cadd83aa828637aeb121a0fae585dfd21585f69';
