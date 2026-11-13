// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(smsFilterService)
final smsFilterServiceProvider = SmsFilterServiceProvider._();

final class SmsFilterServiceProvider
    extends
        $FunctionalProvider<
          SmsFilterService,
          SmsFilterService,
          SmsFilterService
        >
    with $Provider<SmsFilterService> {
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

String _$smsFilterServiceHash() => r'f41c1202f12b55d05eb309e30cf03dedd25cb94f';
