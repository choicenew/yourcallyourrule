// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_sync_bridge_connector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App 统一单点装配桥接连接器 (AppSyncBridgeConnector)

@ProviderFor(appSyncBridgeConnector)
final appSyncBridgeConnectorProvider = AppSyncBridgeConnectorProvider._();

/// App 统一单点装配桥接连接器 (AppSyncBridgeConnector)

final class AppSyncBridgeConnectorProvider
    extends
        $FunctionalProvider<
          AppSyncBridgeConnector,
          AppSyncBridgeConnector,
          AppSyncBridgeConnector
        >
    with $Provider<AppSyncBridgeConnector> {
  /// App 统一单点装配桥接连接器 (AppSyncBridgeConnector)
  AppSyncBridgeConnectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSyncBridgeConnectorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSyncBridgeConnectorHash();

  @$internal
  @override
  $ProviderElement<AppSyncBridgeConnector> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppSyncBridgeConnector create(Ref ref) {
    return appSyncBridgeConnector(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSyncBridgeConnector value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSyncBridgeConnector>(value),
    );
  }
}

String _$appSyncBridgeConnectorHash() =>
    r'a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0';
