// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_subscription_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SMS订阅仓库提供者

@ProviderFor(smsSubscriptionRepository)
final smsSubscriptionRepositoryProvider = SmsSubscriptionRepositoryProvider._();

/// SMS订阅仓库提供者

final class SmsSubscriptionRepositoryProvider
    extends
        $FunctionalProvider<
          SmsSubscriptionRepository,
          SmsSubscriptionRepository,
          SmsSubscriptionRepository
        >
    with $Provider<SmsSubscriptionRepository> {
  /// SMS订阅仓库提供者
  SmsSubscriptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsSubscriptionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsSubscriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SmsSubscriptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SmsSubscriptionRepository create(Ref ref) {
    return smsSubscriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsSubscriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsSubscriptionRepository>(value),
    );
  }
}

String _$smsSubscriptionRepositoryHash() =>
    r'5cffd841fabb60dd429b7519fe7dbc74eb6105df';
