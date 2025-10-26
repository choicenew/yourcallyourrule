// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_notification_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ProposalNotificationManager 的 Provider。
///
/// 【MODIFIED】: 修正了 Provider 的函数签名，使其与 @riverpod 规范一致。

@ProviderFor(proposalNotificationManager)
const proposalNotificationManagerProvider =
    ProposalNotificationManagerProvider._();

/// ProposalNotificationManager 的 Provider。
///
/// 【MODIFIED】: 修正了 Provider 的函数签名，使其与 @riverpod 规范一致。

final class ProposalNotificationManagerProvider
    extends
        $FunctionalProvider<
          ProposalNotificationManager,
          ProposalNotificationManager,
          ProposalNotificationManager
        >
    with $Provider<ProposalNotificationManager> {
  /// ProposalNotificationManager 的 Provider。
  ///
  /// 【MODIFIED】: 修正了 Provider 的函数签名，使其与 @riverpod 规范一致。
  const ProposalNotificationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalNotificationManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalNotificationManagerHash();

  @$internal
  @override
  $ProviderElement<ProposalNotificationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalNotificationManager create(Ref ref) {
    return proposalNotificationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalNotificationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalNotificationManager>(value),
    );
  }
}

String _$proposalNotificationManagerHash() =>
    r'ba342f4b3b4e537c7e06223f7b3facfb27815f34';
