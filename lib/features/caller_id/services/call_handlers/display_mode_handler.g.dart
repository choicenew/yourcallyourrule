// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_mode_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 显示模式处理器 Provider
///
/// 【最终方案】: 这是一个异步 Provider，因为它需要在初始化时执行异步操作（管理引擎）。
/// 它负责创建并提供一个 DisplayModeHandler 的单例。

@ProviderFor(displayModeHandler)
const displayModeHandlerProvider = DisplayModeHandlerProvider._();

/// 显示模式处理器 Provider
///
/// 【最终方案】: 这是一个异步 Provider，因为它需要在初始化时执行异步操作（管理引擎）。
/// 它负责创建并提供一个 DisplayModeHandler 的单例。

final class DisplayModeHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<DisplayModeHandler>,
          DisplayModeHandler,
          FutureOr<DisplayModeHandler>
        >
    with
        $FutureModifier<DisplayModeHandler>,
        $FutureProvider<DisplayModeHandler> {
  /// 显示模式处理器 Provider
  ///
  /// 【最终方案】: 这是一个异步 Provider，因为它需要在初始化时执行异步操作（管理引擎）。
  /// 它负责创建并提供一个 DisplayModeHandler 的单例。
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
  $FutureProviderElement<DisplayModeHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DisplayModeHandler> create(Ref ref) {
    return displayModeHandler(ref);
  }
}

String _$displayModeHandlerHash() =>
    r'50e2c3b8ea1bdaa4419c1222ff536ab10f1c4cc1';
