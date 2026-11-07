// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneLocationService)
final phoneLocationServiceProvider = PhoneLocationServiceProvider._();

final class PhoneLocationServiceProvider
    extends
        $FunctionalProvider<
          PhoneLocationService,
          PhoneLocationService,
          PhoneLocationService
        >
    with $Provider<PhoneLocationService> {
  PhoneLocationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneLocationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneLocationServiceHash();

  @$internal
  @override
  $ProviderElement<PhoneLocationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneLocationService create(Ref ref) {
    return phoneLocationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneLocationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneLocationService>(value),
    );
  }
}

String _$phoneLocationServiceHash() =>
    r'8c3b7be1523157a88d5488e3b3ba768bc33efcb1';
