// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(smsService)
final smsServiceProvider = SmsServiceProvider._();

final class SmsServiceProvider
    extends $FunctionalProvider<SmsService, SmsService, SmsService>
    with $Provider<SmsService> {
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

String _$smsServiceHash() => r'900f5deb2b4f00f2cef7fd48565b73e8ccbe967b';
