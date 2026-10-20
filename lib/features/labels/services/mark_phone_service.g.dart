// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_phone_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelPhoneService 的 @Riverpod Provider

@ProviderFor(markPhoneService)
final markPhoneServiceProvider = MarkPhoneServiceProvider._();

/// LabelPhoneService 的 @Riverpod Provider

final class MarkPhoneServiceProvider
    extends
        $FunctionalProvider<
          LabelPhoneService,
          LabelPhoneService,
          LabelPhoneService
        >
    with $Provider<LabelPhoneService> {
  /// LabelPhoneService 的 @Riverpod Provider
  MarkPhoneServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markPhoneServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markPhoneServiceHash();

  @$internal
  @override
  $ProviderElement<LabelPhoneService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelPhoneService create(Ref ref) {
    return markPhoneService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelPhoneService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelPhoneService>(value),
    );
  }
}

String _$markPhoneServiceHash() => r'a38df4c2494967034a5e336bcc2323ac24b8ca67';
