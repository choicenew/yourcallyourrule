// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 联系人数据状态的 Notifier

@ProviderFor(ContactsNotifier)
final contactsProvider = ContactsNotifierProvider._();

/// 联系人数据状态的 Notifier
final class ContactsNotifierProvider
    extends $AsyncNotifierProvider<ContactsNotifier, List<PhoneContactEntry>> {
  /// 联系人数据状态的 Notifier
  ContactsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactsNotifierHash();

  @$internal
  @override
  ContactsNotifier create() => ContactsNotifier();
}

String _$contactsNotifierHash() => r'21ae4d29154747a64ba3a7ddc68897097d678847';

/// 联系人数据状态的 Notifier

abstract class _$ContactsNotifier
    extends $AsyncNotifier<List<PhoneContactEntry>> {
  FutureOr<List<PhoneContactEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PhoneContactEntry>>,
              List<PhoneContactEntry>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PhoneContactEntry>>,
                List<PhoneContactEntry>
              >,
              AsyncValue<List<PhoneContactEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
