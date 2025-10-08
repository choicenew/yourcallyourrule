// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callerid_style_security_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the configuration repository implementation.

@ProviderFor(configRepository)
const configRepositoryProvider = ConfigRepositoryProvider._();

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
  const ConfigRepositoryProvider._()
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

/// Provider for the CallerIdConfigService.

@ProviderFor(callerIdConfigService)
const callerIdConfigServiceProvider = CallerIdConfigServiceProvider._();

/// Provider for the CallerIdConfigService.

final class CallerIdConfigServiceProvider
    extends
        $FunctionalProvider<
          CallerIdConfigService,
          CallerIdConfigService,
          CallerIdConfigService
        >
    with $Provider<CallerIdConfigService> {
  /// Provider for the CallerIdConfigService.
  const CallerIdConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdConfigServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdConfigServiceHash();

  @$internal
  @override
  $ProviderElement<CallerIdConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallerIdConfigService create(Ref ref) {
    return callerIdConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallerIdConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallerIdConfigService>(value),
    );
  }
}

String _$callerIdConfigServiceHash() =>
    r'bc3bcf5540fecb54810c1ecdb52e942e6cb2d897';

/// Provider for the ConfigurationManager.
/// 这使得我们的业务逻辑层可以在整个应用中被轻松访问。

@ProviderFor(configurationManager)
const configurationManagerProvider = ConfigurationManagerProvider._();

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
  const ConfigurationManagerProvider._()
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
/// 它的唯一职责是持有当前的UI状态(CallerIdConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。

@ProviderFor(CallerIdStyleSecurityNotifier)
const callerIdStyleSecurityProvider = CallerIdStyleSecurityNotifierProvider._();

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallerIdConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。
final class CallerIdStyleSecurityNotifierProvider
    extends
        $AsyncNotifierProvider<CallerIdStyleSecurityNotifier, CallerIdConfig> {
  /// The UI State Notifier.
  /// 它的唯一职责是持有当前的UI状态(CallerIdConfig)，并响应UI的实时调整。
  /// 它不包含任何保存、加载等业务逻辑。
  const CallerIdStyleSecurityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdStyleSecurityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdStyleSecurityNotifierHash();

  @$internal
  @override
  CallerIdStyleSecurityNotifier create() => CallerIdStyleSecurityNotifier();
}

String _$callerIdStyleSecurityNotifierHash() =>
    r'1fc9edfa0b5c9a823fa4b982c99c71867a3db99b';

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallerIdConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。

abstract class _$CallerIdStyleSecurityNotifier
    extends $AsyncNotifier<CallerIdConfig> {
  FutureOr<CallerIdConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<CallerIdConfig>, CallerIdConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallerIdConfig>, CallerIdConfig>,
              AsyncValue<CallerIdConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
