// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_call_log_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 系统通话记录服务提供者

@ProviderFor(systemCallLogService)
final systemCallLogServiceProvider = SystemCallLogServiceProvider._();

/// 系统通话记录服务提供者

final class SystemCallLogServiceProvider
    extends
        $FunctionalProvider<
          SystemCallLogService,
          SystemCallLogService,
          SystemCallLogService
        >
    with $Provider<SystemCallLogService> {
  /// 系统通话记录服务提供者
  SystemCallLogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemCallLogServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemCallLogServiceHash();

  @$internal
  @override
  $ProviderElement<SystemCallLogService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SystemCallLogService create(Ref ref) {
    return systemCallLogService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemCallLogService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemCallLogService>(value),
    );
  }
}

String _$systemCallLogServiceHash() =>
    r'0ddc3076b22945cf4f3f5a1bcd0b0a062877e21e';
