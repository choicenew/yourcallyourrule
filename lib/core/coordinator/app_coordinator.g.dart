// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 鍏ㄥ眬 App 涓灑鍗忚皟鍣?(App Coordinator / Event Mediator)
/// 璐熻矗璺?Feature 閫氫俊涓庤В鑰︿簨浠舵淳鍙戯紝褰诲簳娑堥櫎 lib/features/X 璺ㄥ寘寮曠敤 lib/features/Y

@ProviderFor(appCoordinator)
final appCoordinatorProvider = AppCoordinatorProvider._();

/// 鍏ㄥ眬 App 涓灑鍗忚皟鍣?(App Coordinator / Event Mediator)
/// 璐熻矗璺?Feature 閫氫俊涓庤В鑰︿簨浠舵淳鍙戯紝褰诲簳娑堥櫎 lib/features/X 璺ㄥ寘寮曠敤 lib/features/Y

final class AppCoordinatorProvider
    extends $FunctionalProvider<AppCoordinator, AppCoordinator, AppCoordinator>
    with $Provider<AppCoordinator> {
  /// 鍏ㄥ眬 App 涓灑鍗忚皟鍣?(App Coordinator / Event Mediator)
  /// 璐熻矗璺?Feature 閫氫俊涓庤В鑰︿簨浠舵淳鍙戯紝褰诲簳娑堥櫎 lib/features/X 璺ㄥ寘寮曠敤 lib/features/Y
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
