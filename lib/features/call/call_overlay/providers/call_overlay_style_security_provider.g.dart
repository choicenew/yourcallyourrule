// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_overlay_style_security_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the configuration repository implementation.

@ProviderFor(configRepository)
final configRepositoryProvider = ConfigRepositoryProvider._();

/// Provider for the configuration repository implementation.

final class ConfigRepositoryProvider
    extends
        $FunctionalProvider<
          ConfigRepository,
          ConfigRepository,
          ConfigRepository
        >
    with $Provider<ConfigRepository> {
  /// Provider for the configuration repository implementation.
  ConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConfigRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ConfigRepository create(Ref ref) {
    return configRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConfigRepository>(value),
    );
  }
}

String _$configRepositoryHash() => r'602db6ffdf10f94eb4f605596851265b751b5c8a';

/// Provider for the CallOverlayConfigService.

@ProviderFor(callOverlayConfigService)
final callOverlayConfigServiceProvider = CallOverlayConfigServiceProvider._();

/// Provider for the CallOverlayConfigService.

final class CallOverlayConfigServiceProvider
    extends
        $FunctionalProvider<
          CallOverlayConfigService,
          CallOverlayConfigService,
          CallOverlayConfigService
        >
    with $Provider<CallOverlayConfigService> {
  /// Provider for the CallOverlayConfigService.
  CallOverlayConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callOverlayConfigServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callOverlayConfigServiceHash();

  @$internal
  @override
  $ProviderElement<CallOverlayConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallOverlayConfigService create(Ref ref) {
    return callOverlayConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallOverlayConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallOverlayConfigService>(value),
    );
  }
}

String _$callOverlayConfigServiceHash() =>
    r'e67bf3a731c7ae7a70dd61292be32932c2dfdc44';

/// Provider for the ConfigurationManager.
/// 这使得我们的业务逻辑层可以在整个应用中被轻松访问。

@ProviderFor(configurationManager)
final configurationManagerProvider = ConfigurationManagerProvider._();

/// Provider for the ConfigurationManager.
/// 这使得我们的业务逻辑层可以在整个应用中被轻松访问。

final class ConfigurationManagerProvider
    extends
        $FunctionalProvider<
          ConfigurationManager,
          ConfigurationManager,
          ConfigurationManager
        >
    with $Provider<ConfigurationManager> {
  /// Provider for the ConfigurationManager.
  /// 这使得我们的业务逻辑层可以在整个应用中被轻松访问。
  ConfigurationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configurationManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configurationManagerHash();

  @$internal
  @override
  $ProviderElement<ConfigurationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConfigurationManager create(Ref ref) {
    return configurationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConfigurationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConfigurationManager>(value),
    );
  }
}

String _$configurationManagerHash() =>
    r'74fc71c28de241be3504804b505c7a926c693615';

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallOverlayConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。

@ProviderFor(CallOverlayStyleSecurityNotifier)
final callOverlayStyleSecurityProvider =
    CallOverlayStyleSecurityNotifierProvider._();

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallOverlayConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。
final class CallOverlayStyleSecurityNotifierProvider
    extends
        $AsyncNotifierProvider<
          CallOverlayStyleSecurityNotifier,
          CallOverlayConfig
        > {
  /// The UI State Notifier.
  /// 它的唯一职责是持有当前的UI状态(CallOverlayConfig)，并响应UI的实时调整。
  /// 它不包含任何保存、加载等业务逻辑。
  CallOverlayStyleSecurityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callOverlayStyleSecurityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callOverlayStyleSecurityNotifierHash();

  @$internal
  @override
  CallOverlayStyleSecurityNotifier create() =>
      CallOverlayStyleSecurityNotifier();
}

String _$callOverlayStyleSecurityNotifierHash() =>
    r'9df99f7be03d78d06f6cdf6cbb44bcce6f94cedf';

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallOverlayConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。

abstract class _$CallOverlayStyleSecurityNotifier
    extends $AsyncNotifier<CallOverlayConfig> {
  FutureOr<CallOverlayConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CallOverlayConfig>, CallOverlayConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallOverlayConfig>, CallOverlayConfig>,
              AsyncValue<CallOverlayConfig>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
