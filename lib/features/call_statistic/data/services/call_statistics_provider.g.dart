// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 【响应式】的通话统计 Notifier
///
/// 【MODIFIED】: 这是一个普通的 Notifier，它通过监听 Stream 来响应式地更新状态。

@ProviderFor(CallStatisticsNotifier)
const callStatisticsProvider = CallStatisticsNotifierProvider._();

/// 【响应式】的通话统计 Notifier
///
/// 【MODIFIED】: 这是一个普通的 Notifier，它通过监听 Stream 来响应式地更新状态。
final class CallStatisticsNotifierProvider
    extends $NotifierProvider<CallStatisticsNotifier, CallStatisticsState> {
  /// 【响应式】的通话统计 Notifier
  ///
  /// 【MODIFIED】: 这是一个普通的 Notifier，它通过监听 Stream 来响应式地更新状态。
  const CallStatisticsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callStatisticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callStatisticsNotifierHash();

  @$internal
  @override
  CallStatisticsNotifier create() => CallStatisticsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallStatisticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallStatisticsState>(value),
    );
  }
}

String _$callStatisticsNotifierHash() =>
    r'3e9150aa04436acee588ff866277227e0d933f76';

/// 【响应式】的通话统计 Notifier
///
/// 【MODIFIED】: 这是一个普通的 Notifier，它通过监听 Stream 来响应式地更新状态。

abstract class _$CallStatisticsNotifier extends $Notifier<CallStatisticsState> {
  CallStatisticsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallStatisticsState, CallStatisticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallStatisticsState, CallStatisticsState>,
              CallStatisticsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
