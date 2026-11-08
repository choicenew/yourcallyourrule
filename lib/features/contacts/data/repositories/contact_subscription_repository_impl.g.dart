// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_subscription_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 联系人订阅仓库提供者

@ProviderFor(contactSubscriptionRepository)
final contactSubscriptionRepositoryProvider =
    ContactSubscriptionRepositoryProvider._();

/// 联系人订阅仓库提供者

final class ContactSubscriptionRepositoryProvider
    extends
        $FunctionalProvider<
          ContactSubscriptionRepository,
          ContactSubscriptionRepository,
          ContactSubscriptionRepository
        >
    with $Provider<ContactSubscriptionRepository> {
  /// 联系人订阅仓库提供者
  ContactSubscriptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactSubscriptionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactSubscriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContactSubscriptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContactSubscriptionRepository create(Ref ref) {
    return contactSubscriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactSubscriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactSubscriptionRepository>(
        value,
      ),
    );
  }
}

String _$contactSubscriptionRepositoryHash() =>
    r'ed8344535f183d6da5a56b475b356dfd45fb8fb1';
