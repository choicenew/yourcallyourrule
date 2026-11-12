// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_widget_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务

@ProviderFor(AppWidgetSyncService)
final appWidgetSyncServiceProvider = AppWidgetSyncServiceProvider._();

/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
final class AppWidgetSyncServiceProvider
    extends $NotifierProvider<AppWidgetSyncService, void> {
  /// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
  AppWidgetSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appWidgetSyncServiceProvider',
        isAutoDispose: false,
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
    r'4b9179fdb1828bdacf62ac2a6dc8f9e752a204e0';

/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务

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
