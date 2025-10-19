// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通话处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。

@ProviderFor(CallHandler)
const callHandlerProvider = CallHandlerProvider._();

/// 通话处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
final class CallHandlerProvider
    extends $NotifierProvider<CallHandler, CallData?> {
  /// 通话处理器 Provider
  ///
  /// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
  const CallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHandlerHash();

  @$internal
  @override
  CallHandler create() => CallHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallData? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallData?>(value),
    );
  }
}

String _$callHandlerHash() => r'8d1473600f92f1c536b091f4c27a2ffc125f7e62';

/// 通话处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。

abstract class _$CallHandler extends $Notifier<CallData?> {
  CallData? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallData?, CallData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallData?, CallData?>,
              CallData?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
