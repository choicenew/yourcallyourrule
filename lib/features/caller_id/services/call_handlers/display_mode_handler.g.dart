// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_mode_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 显示模式处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责：
/// 1. 监听全局的显示模式配置（`callerIdConfigProvider`）。
/// 2. 根据配置变化，实时管理 `FloatingWindowAndroid` 引擎的生命周期。
/// 3. 提供 `showCallerIdInfo` 方法，根据当前模式分发显示任务给具体的处理器。
///
/// 使用 `keepAlive: true` 确保此服务在应用后台时保持活动状态。

@ProviderFor(DisplayModeHandler)
const displayModeHandlerProvider = DisplayModeHandlerProvider._();

/// 显示模式处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责：
/// 1. 监听全局的显示模式配置（`callerIdConfigProvider`）。
/// 2. 根据配置变化，实时管理 `FloatingWindowAndroid` 引擎的生命周期。
/// 3. 提供 `showCallerIdInfo` 方法，根据当前模式分发显示任务给具体的处理器。
///
/// 使用 `keepAlive: true` 确保此服务在应用后台时保持活动状态。
final class DisplayModeHandlerProvider
    extends $NotifierProvider<DisplayModeHandler, DisplayMode> {
  /// 显示模式处理器 Provider
  ///
  /// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
  /// 它负责：
  /// 1. 监听全局的显示模式配置（`callerIdConfigProvider`）。
  /// 2. 根据配置变化，实时管理 `FloatingWindowAndroid` 引擎的生命周期。
  /// 3. 提供 `showCallerIdInfo` 方法，根据当前模式分发显示任务给具体的处理器。
  ///
  /// 使用 `keepAlive: true` 确保此服务在应用后台时保持活动状态。
  const DisplayModeHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayModeHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayModeHandlerHash();

  @$internal
  @override
  DisplayModeHandler create() => DisplayModeHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisplayMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisplayMode>(value),
    );
  }
}

String _$displayModeHandlerHash() =>
    r'74efbc678803d95d35e85b85b6fc3d013d44a030';

/// 显示模式处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责：
/// 1. 监听全局的显示模式配置（`callerIdConfigProvider`）。
/// 2. 根据配置变化，实时管理 `FloatingWindowAndroid` 引擎的生命周期。
/// 3. 提供 `showCallerIdInfo` 方法，根据当前模式分发显示任务给具体的处理器。
///
/// 使用 `keepAlive: true` 确保此服务在应用后台时保持活动状态。

abstract class _$DisplayModeHandler extends $Notifier<DisplayMode> {
  DisplayMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DisplayMode, DisplayMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DisplayMode, DisplayMode>,
              DisplayMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
