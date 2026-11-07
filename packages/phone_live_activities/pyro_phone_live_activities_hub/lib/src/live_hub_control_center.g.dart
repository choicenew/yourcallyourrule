// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_hub_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveHubControlCenter)
final liveHubControlCenterProvider = LiveHubControlCenterProvider._();

final class LiveHubControlCenterProvider
    extends
        $FunctionalProvider<
          LiveHubControlCenter,
          LiveHubControlCenter,
          LiveHubControlCenter
        >
    with $Provider<LiveHubControlCenter> {
  LiveHubControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveHubControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveHubControlCenterHash();

  @$internal
  @override
  $ProviderElement<LiveHubControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveHubControlCenter create(Ref ref) {
    return liveHubControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveHubControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveHubControlCenter>(value),
    );
  }
}

String _$liveHubControlCenterHash() =>
    r'92e89138407dfa86c2e69646eb1cce59e5b7bbc9';
