// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_phone_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(markPhoneControlCenter)
final markPhoneControlCenterProvider = MarkPhoneControlCenterProvider._();

final class MarkPhoneControlCenterProvider
    extends
        $FunctionalProvider<
          MarkPhoneControlCenter,
          MarkPhoneControlCenter,
          MarkPhoneControlCenter
        >
    with $Provider<MarkPhoneControlCenter> {
  MarkPhoneControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markPhoneControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markPhoneControlCenterHash();

  @$internal
  @override
  $ProviderElement<MarkPhoneControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarkPhoneControlCenter create(Ref ref) {
    return markPhoneControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkPhoneControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarkPhoneControlCenter>(value),
    );
  }
}

String _$markPhoneControlCenterHash() =>
    r'2f260c2b6b45ab4ae56b5f522bde622d1e227f05';
