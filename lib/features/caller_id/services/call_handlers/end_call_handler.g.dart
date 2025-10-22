// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider，负责创建 EndCallHandler 的单例。
/// 【最终方案】: 它只注入通用的 `ref` 对象，让 Handler 可以在需要时访问任何 Provider。

@ProviderFor(endCallHandler)
const endCallHandlerProvider = EndCallHandlerProvider._();

/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider，负责创建 EndCallHandler 的单例。
/// 【最终方案】: 它只注入通用的 `ref` 对象，让 Handler 可以在需要时访问任何 Provider。

final class EndCallHandlerProvider
    extends $FunctionalProvider<EndCallHandler, EndCallHandler, EndCallHandler>
    with $Provider<EndCallHandler> {
  /// 结束通话处理器 Provider
  ///
  /// 这是一个简单的服务型 Provider，负责创建 EndCallHandler 的单例。
  /// 【最终方案】: 它只注入通用的 `ref` 对象，让 Handler 可以在需要时访问任何 Provider。
  const EndCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'endCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$endCallHandlerHash();

  @$internal
  @override
  $ProviderElement<EndCallHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EndCallHandler create(Ref ref) {
    return endCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EndCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EndCallHandler>(value),
    );
  }
}

String _$endCallHandlerHash() => r'40c43809c735e3edb9be870fce0c42184d84b3ec';
