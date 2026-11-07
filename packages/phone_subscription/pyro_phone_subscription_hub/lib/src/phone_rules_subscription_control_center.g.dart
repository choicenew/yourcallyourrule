// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_rules_subscription_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneRulesSubscriptionControlCenter)
final phoneRulesSubscriptionControlCenterProvider =
    PhoneRulesSubscriptionControlCenterProvider._();

final class PhoneRulesSubscriptionControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneRulesSubscriptionControlCenter,
          PhoneRulesSubscriptionControlCenter,
          PhoneRulesSubscriptionControlCenter
        >
    with $Provider<PhoneRulesSubscriptionControlCenter> {
  PhoneRulesSubscriptionControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneRulesSubscriptionControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$phoneRulesSubscriptionControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneRulesSubscriptionControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneRulesSubscriptionControlCenter create(Ref ref) {
    return phoneRulesSubscriptionControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneRulesSubscriptionControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneRulesSubscriptionControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneRulesSubscriptionControlCenterHash() =>
    r'1488003e62379d1687a1ce46df450c6fab4e0622';
