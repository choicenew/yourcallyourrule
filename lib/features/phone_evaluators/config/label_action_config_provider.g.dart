// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_action_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 纯动态标签动作映射表配置 Notifier (零硬编码，支持任意动态标签文本)

@ProviderFor(LabelActionConfig)
final labelActionConfigProvider = LabelActionConfigProvider._();

/// 纯动态标签动作映射表配置 Notifier (零硬编码，支持任意动态标签文本)
final class LabelActionConfigProvider
    extends $NotifierProvider<LabelActionConfig, Map<String, InterceptAction>> {
  /// 纯动态标签动作映射表配置 Notifier (零硬编码，支持任意动态标签文本)
  LabelActionConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelActionConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelActionConfigHash();

  @$internal
  @override
  LabelActionConfig create() => LabelActionConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, InterceptAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, InterceptAction>>(value),
    );
  }
}

String _$labelActionConfigHash() => r'ca14b6f83773657e2e512de627b0ebe96ca7906d';

/// 纯动态标签动作映射表配置 Notifier (零硬编码，支持任意动态标签文本)

abstract class _$LabelActionConfig
    extends $Notifier<Map<String, InterceptAction>> {
  Map<String, InterceptAction> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<Map<String, InterceptAction>, Map<String, InterceptAction>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, InterceptAction>,
                Map<String, InterceptAction>
              >,
              Map<String, InterceptAction>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
