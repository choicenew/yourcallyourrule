// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 遵照 Riverpod 3 标准规范的商业变现与特权状态控制器 (AsyncNotifier)
/// 异步控制模式彻底解决冷启动非 VIP 闪烁 Bug，保证状态响应一致性

@ProviderFor(CommercialNotifier)
const commercialProvider = CommercialNotifierProvider._();

/// 遵照 Riverpod 3 标准规范的商业变现与特权状态控制器 (AsyncNotifier)
/// 异步控制模式彻底解决冷启动非 VIP 闪烁 Bug，保证状态响应一致性
final class CommercialNotifierProvider
    extends $AsyncNotifierProvider<CommercialNotifier, CommercialState> {
  /// 遵照 Riverpod 3 标准规范的商业变现与特权状态控制器 (AsyncNotifier)
  /// 异步控制模式彻底解决冷启动非 VIP 闪烁 Bug，保证状态响应一致性
  const CommercialNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'commercialProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$commercialNotifierHash();

  @$internal
  @override
  CommercialNotifier create() => CommercialNotifier();
}

String _$commercialNotifierHash() =>
    r'5df6df53fc8c0d47dcf0830b264b8086571cbe2b';

/// 遵照 Riverpod 3 标准规范的商业变现与特权状态控制器 (AsyncNotifier)
/// 异步控制模式彻底解决冷启动非 VIP 闪烁 Bug，保证状态响应一致性

abstract class _$CommercialNotifier extends $AsyncNotifier<CommercialState> {
  FutureOr<CommercialState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<CommercialState>, CommercialState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<CommercialState>, CommercialState>,
        AsyncValue<CommercialState>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
