// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全局 App 中枢协调器 (App Coordinator / Event Mediator)
/// 负责跨 Feature 通信与解耦事件派发，彻底消除 lib/features/X 跨包引用 lib/features/Y

@ProviderFor(appCoordinator)
final appCoordinatorProvider = AppCoordinatorProvider._();

/// 全局 App 中枢协调器 (App Coordinator / Event Mediator)
/// 负责跨 Feature 通信与解耦事件派发，彻底消除 lib/features/X 跨包引用 lib/features/Y

final class AppCoordinatorProvider
    extends $FunctionalProvider<AppCoordinator, AppCoordinator, AppCoordinator>
    with $Provider<AppCoordinator> {
  /// 全局 App 中枢协调器 (App Coordinator / Event Mediator)
  /// 负责跨 Feature 通信与解耦事件派发，彻底消除 lib/features/X 跨包引用 lib/features/Y
  AppCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appCoordinatorHash();

  @$internal
  @override
  $ProviderElement<AppCoordinator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppCoordinator create(Ref ref) {
    return appCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppCoordinator>(value),
    );
  }
}

String _$appCoordinatorHash() => r'21c1e6544b888b7e218e42e0fd0a85893712603e';
