// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 使用 @riverpod 注解，将旧的 StateNotifier 迁移为现代的 Notifier。
/// 这个 Notifier 负责管理和持久化应用的所有购买相关状态。
///
/// keepAlive: true 确保状态在整个应用生命周期内保持活动，
/// 不会因为用户导航离开相关页面而被重置。

@ProviderFor(PurchaseState)
const purchaseStateProvider = PurchaseStateProvider._();

/// 使用 @riverpod 注解，将旧的 StateNotifier 迁移为现代的 Notifier。
/// 这个 Notifier 负责管理和持久化应用的所有购买相关状态。
///
/// keepAlive: true 确保状态在整个应用生命周期内保持活动，
/// 不会因为用户导航离开相关页面而被重置。
final class PurchaseStateProvider
    extends $NotifierProvider<PurchaseState, PurchaseStateModel> {
  /// 使用 @riverpod 注解，将旧的 StateNotifier 迁移为现代的 Notifier。
  /// 这个 Notifier 负责管理和持久化应用的所有购买相关状态。
  ///
  /// keepAlive: true 确保状态在整个应用生命周期内保持活动，
  /// 不会因为用户导航离开相关页面而被重置。
  const PurchaseStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseStateHash();

  @$internal
  @override
  PurchaseState create() => PurchaseState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseStateModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseStateModel>(value),
    );
  }
}

String _$purchaseStateHash() => r'21c13422ddbb9f987ffbb98ec433879f1cb4c2a2';

/// 使用 @riverpod 注解，将旧的 StateNotifier 迁移为现代的 Notifier。
/// 这个 Notifier 负责管理和持久化应用的所有购买相关状态。
///
/// keepAlive: true 确保状态在整个应用生命周期内保持活动，
/// 不会因为用户导航离开相关页面而被重置。

abstract class _$PurchaseState extends $Notifier<PurchaseStateModel> {
  PurchaseStateModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PurchaseStateModel, PurchaseStateModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PurchaseStateModel, PurchaseStateModel>,
              PurchaseStateModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
