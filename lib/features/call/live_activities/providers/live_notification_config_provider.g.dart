// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_notification_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveNotificationConfigManager)
final liveNotificationConfigManagerProvider =
    LiveNotificationConfigManagerProvider._();

final class LiveNotificationConfigManagerProvider
    extends
        $FunctionalProvider<
          LiveNotificationConfigManager,
          LiveNotificationConfigManager,
          LiveNotificationConfigManager
        >
    with $Provider<LiveNotificationConfigManager> {
  LiveNotificationConfigManagerProvider._()
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
final liveNotificationConfigProvider =
    LiveNotificationConfigNotifierProvider._();

final class LiveNotificationConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          LiveNotificationConfigNotifier,
          LiveNotificationConfig
        > {
  LiveNotificationConfigNotifierProvider._()
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
    r'cccdf5871e07ad77dec4bc4afd4a17fddce2db9f';

abstract class _$LiveNotificationConfigNotifier
    extends $AsyncNotifier<LiveNotificationConfig> {
  FutureOr<LiveNotificationConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
