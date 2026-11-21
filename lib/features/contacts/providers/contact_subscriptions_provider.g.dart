// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_subscriptions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 联系人订阅数据状态的 Notifier

@ProviderFor(ContactSubscriptionsNotifier)
final contactSubscriptionsProvider = ContactSubscriptionsNotifierProvider._();

/// 联系人订阅数据状态的 Notifier
final class ContactSubscriptionsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ContactSubscriptionsNotifier,
          List<PhoneSubscriptionPayload>
        > {
  /// 联系人订阅数据状态的 Notifier
  ContactSubscriptionsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactSubscriptionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactSubscriptionsNotifierHash();

  @$internal
  @override
  ContactSubscriptionsNotifier create() => ContactSubscriptionsNotifier();
}

String _$contactSubscriptionsNotifierHash() =>
    r'c9a900889ebdad30e693c9c12cd0cc16d9191b40';

/// 联系人订阅数据状态的 Notifier

abstract class _$ContactSubscriptionsNotifier
    extends $AsyncNotifier<List<PhoneSubscriptionPayload>> {
  FutureOr<List<PhoneSubscriptionPayload>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PhoneSubscriptionPayload>>,
              List<PhoneSubscriptionPayload>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PhoneSubscriptionPayload>>,
                List<PhoneSubscriptionPayload>
              >,
              AsyncValue<List<PhoneSubscriptionPayload>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
