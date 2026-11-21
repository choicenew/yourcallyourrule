// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_logs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通话记录数据状态的 Notifier

@ProviderFor(CallLogsNotifier)
final callLogsProvider = CallLogsNotifierProvider._();

/// 通话记录数据状态的 Notifier
final class CallLogsNotifierProvider
    extends $AsyncNotifierProvider<CallLogsNotifier, List<CallLogEntry>> {
  /// 通话记录数据状态的 Notifier
  CallLogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogsNotifierHash();

  @$internal
  @override
  CallLogsNotifier create() => CallLogsNotifier();
}

String _$callLogsNotifierHash() => r'5885c72c0f92374ba375ce9b13ef70c49e5d1051';

/// 通话记录数据状态的 Notifier

abstract class _$CallLogsNotifier extends $AsyncNotifier<List<CallLogEntry>> {
  FutureOr<List<CallLogEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CallLogEntry>>, List<CallLogEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CallLogEntry>>, List<CallLogEntry>>,
              AsyncValue<List<CallLogEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
