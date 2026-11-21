// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_subscriptions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SmsSubscriptionsNotifier)
final smsSubscriptionsProvider = SmsSubscriptionsNotifierProvider._();

final class SmsSubscriptionsNotifierProvider
    extends
        $AsyncNotifierProvider<
          SmsSubscriptionsNotifier,
          List<SmsSubscription>
        > {
  SmsSubscriptionsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsSubscriptionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsSubscriptionsNotifierHash();

  @$internal
  @override
  SmsSubscriptionsNotifier create() => SmsSubscriptionsNotifier();
}

String _$smsSubscriptionsNotifierHash() =>
    r'9d551f5c3caebf54ff4453d91a4c53fa02e912e6';

abstract class _$SmsSubscriptionsNotifier
    extends $AsyncNotifier<List<SmsSubscription>> {
  FutureOr<List<SmsSubscription>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SmsSubscription>>, List<SmsSubscription>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SmsSubscription>>,
                List<SmsSubscription>
              >,
              AsyncValue<List<SmsSubscription>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
