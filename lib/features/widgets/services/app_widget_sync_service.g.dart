// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_widget_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
/// 遵照 AGENTS.md / veherego-widget-realtime-protocol 铁律：
/// 1. 100% 绑定现有真实 Provider 实体数据
/// 2. 绝对严禁任何硬编码假数据或硬编码汉字/模拟号码
/// 3. 无数据时合规呈现 "--" 空状态
/// 4. 监听 localeProvider 实时同步 app_locale 解决切语言不根治问题

@ProviderFor(AppWidgetSyncService)
final appWidgetSyncServiceProvider = AppWidgetSyncServiceProvider._();

/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
/// 遵照 AGENTS.md / veherego-widget-realtime-protocol 铁律：
/// 1. 100% 绑定现有真实 Provider 实体数据
/// 2. 绝对严禁任何硬编码假数据或硬编码汉字/模拟号码
/// 3. 无数据时合规呈现 "--" 空状态
/// 4. 监听 localeProvider 实时同步 app_locale 解决切语言不根治问题
final class AppWidgetSyncServiceProvider
    extends $NotifierProvider<AppWidgetSyncService, void> {
  /// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
  /// 遵照 AGENTS.md / veherego-widget-realtime-protocol 铁律：
  /// 1. 100% 绑定现有真实 Provider 实体数据
  /// 2. 绝对严禁任何硬编码假数据或硬编码汉字/模拟号码
  /// 3. 无数据时合规呈现 "--" 空状态
  /// 4. 监听 localeProvider 实时同步 app_locale 解决切语言不根治问题
  AppWidgetSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appWidgetSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appWidgetSyncServiceHash();

  @$internal
  @override
  AppWidgetSyncService create() => AppWidgetSyncService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$appWidgetSyncServiceHash() =>
    r'e2c9afbb84b3165b63990bde0feae43cfd00633e';

/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
/// 遵照 AGENTS.md / veherego-widget-realtime-protocol 铁律：
/// 1. 100% 绑定现有真实 Provider 实体数据
/// 2. 绝对严禁任何硬编码假数据或硬编码汉字/模拟号码
/// 3. 无数据时合规呈现 "--" 空状态
/// 4. 监听 localeProvider 实时同步 app_locale 解决切语言不根治问题

abstract class _$AppWidgetSyncService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
