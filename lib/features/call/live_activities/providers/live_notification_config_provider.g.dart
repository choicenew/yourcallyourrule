// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_notification_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveNotificationConfigManager)
const liveNotificationConfigManagerProvider =
    LiveNotificationConfigManagerProvider._();

final class LiveNotificationConfigManagerProvider
    extends
        $FunctionalProvider<
          LiveNotificationConfigManager,
          LiveNotificationConfigManager,
          LiveNotificationConfigManager
        >
    with $Provider<LiveNotificationConfigManager> {
  const LiveNotificationConfigManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveNotificationConfigManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveNotificationConfigManagerHash();

  @$internal
  @override
  $ProviderElement<LiveNotificationConfigManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveNotificationConfigManager create(Ref ref) {
    return liveNotificationConfigManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveNotificationConfigManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveNotificationConfigManager>(
        value,
      ),
    );
  }
}

String _$liveNotificationConfigManagerHash() =>
    r'2a2c01c549fae3a16877a705e5fb077fe2f4c2f7';

@ProviderFor(LiveNotificationConfigNotifier)
const liveNotificationConfigProvider =
    LiveNotificationConfigNotifierProvider._();

final class LiveNotificationConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          LiveNotificationConfigNotifier,
          LiveNotificationConfig
        > {
  const LiveNotificationConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveNotificationConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveNotificationConfigNotifierHash();

  @$internal
  @override
  LiveNotificationConfigNotifier create() => LiveNotificationConfigNotifier();
}

String _$liveNotificationConfigNotifierHash() =>
    r'39234428b741728427d435981023c7395bd31699';

abstract class _$LiveNotificationConfigNotifier
    extends $AsyncNotifier<LiveNotificationConfig> {
  FutureOr<LiveNotificationConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<LiveNotificationConfig>, LiveNotificationConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LiveNotificationConfig>,
                LiveNotificationConfig
              >,
              AsyncValue<LiveNotificationConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
