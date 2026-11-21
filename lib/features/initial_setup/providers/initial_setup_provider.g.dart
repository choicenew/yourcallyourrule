// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_setup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 基础服务提供者

@ProviderFor(initialSetupService)
final initialSetupServiceProvider = InitialSetupServiceProvider._();

/// 基础服务提供者

final class InitialSetupServiceProvider
    extends
        $FunctionalProvider<
          InitialSetupService,
          InitialSetupService,
          InitialSetupService
        >
    with $Provider<InitialSetupService> {
  /// 基础服务提供者
  InitialSetupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialSetupServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialSetupServiceHash();

  @$internal
  @override
  $ProviderElement<InitialSetupService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InitialSetupService create(Ref ref) {
    return initialSetupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InitialSetupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InitialSetupService>(value),
    );
  }
}

String _$initialSetupServiceHash() =>
    r'df7b408adbfb2a37405dbacb588b9a9a12b2480c';

/// CDN 切换状态 Notifier

@ProviderFor(SetupUseCdnNotifier)
final setupUseCdnProvider = SetupUseCdnNotifierProvider._();

/// CDN 切换状态 Notifier
final class SetupUseCdnNotifierProvider
    extends $NotifierProvider<SetupUseCdnNotifier, bool> {
  /// CDN 切换状态 Notifier
  SetupUseCdnNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupUseCdnProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupUseCdnNotifierHash();

  @$internal
  @override
  SetupUseCdnNotifier create() => SetupUseCdnNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$setupUseCdnNotifierHash() =>
    r'8dd2e28127efea90f758c58dd84e9b542e7847c0';

/// CDN 切换状态 Notifier

abstract class _$SetupUseCdnNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 自定义 URL 状态 Notifier

@ProviderFor(SetupCustomUrlNotifier)
final setupCustomUrlProvider = SetupCustomUrlNotifierProvider._();

/// 自定义 URL 状态 Notifier
final class SetupCustomUrlNotifierProvider
    extends $NotifierProvider<SetupCustomUrlNotifier, String?> {
  /// 自定义 URL 状态 Notifier
  SetupCustomUrlNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupCustomUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupCustomUrlNotifierHash();

  @$internal
  @override
  SetupCustomUrlNotifier create() => SetupCustomUrlNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$setupCustomUrlNotifierHash() =>
    r'34198eafbdb357688d1c383456ed2397861bd6f8';

/// 自定义 URL 状态 Notifier

abstract class _$SetupCustomUrlNotifier extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)

@ProviderFor(SetupIsPluginConfigNotifier)
final setupIsPluginConfigProvider = SetupIsPluginConfigNotifierProvider._();

/// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)
final class SetupIsPluginConfigNotifierProvider
    extends $NotifierProvider<SetupIsPluginConfigNotifier, bool> {
  /// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)
  SetupIsPluginConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupIsPluginConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupIsPluginConfigNotifierHash();

  @$internal
  @override
  SetupIsPluginConfigNotifier create() => SetupIsPluginConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$setupIsPluginConfigNotifierHash() =>
    r'4ac7483c5c8e0a16049910d93b345dc32fa94bf2';

/// 切换全量规则配置 (app_delta_setup_config.json) 与 插件配置 (app_plugin_setup_config.json)

abstract class _$SetupIsPluginConfigNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 核心配置 AsyncNotifier/FutureProvider

@ProviderFor(setupConfig)
final setupConfigProvider = SetupConfigProvider._();

/// 核心配置 AsyncNotifier/FutureProvider

final class SetupConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<SetupConfig>,
          SetupConfig,
          FutureOr<SetupConfig>
        >
    with $FutureModifier<SetupConfig>, $FutureProvider<SetupConfig> {
  /// 核心配置 AsyncNotifier/FutureProvider
  SetupConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupConfigHash();

  @$internal
  @override
  $FutureProviderElement<SetupConfig> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SetupConfig> create(Ref ref) {
    return setupConfig(ref);
  }
}

String _$setupConfigHash() => r'1bae5e95fb50e9fc6cb2e02515a0d8a2bcf80d3f';

/// 自动检测用户国家/地区代码

@ProviderFor(detectedCountryCode)
final detectedCountryCodeProvider = DetectedCountryCodeProvider._();

/// 自动检测用户国家/地区代码

final class DetectedCountryCodeProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// 自动检测用户国家/地区代码
  DetectedCountryCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'detectedCountryCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$detectedCountryCodeHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return detectedCountryCode(ref);
  }
}

String _$detectedCountryCodeHash() =>
    r'ea54911a283ceb9e8614752a4014c4f788b88701';
