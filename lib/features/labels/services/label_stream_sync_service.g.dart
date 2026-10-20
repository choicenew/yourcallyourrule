// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_stream_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelStreamSyncService 的 @Riverpod Provider

@ProviderFor(labelStreamSyncService)
final labelStreamSyncServiceProvider = LabelStreamSyncServiceProvider._();

/// LabelStreamSyncService 的 @Riverpod Provider

final class LabelStreamSyncServiceProvider
    extends
        $FunctionalProvider<
          LabelStreamSyncService,
          LabelStreamSyncService,
          LabelStreamSyncService
        >
    with $Provider<LabelStreamSyncService> {
  /// LabelStreamSyncService 的 @Riverpod Provider
  LabelStreamSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelStreamSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelStreamSyncServiceHash();

  @$internal
  @override
  $ProviderElement<LabelStreamSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelStreamSyncService create(Ref ref) {
    return labelStreamSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelStreamSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelStreamSyncService>(value),
    );
  }
}

String _$labelStreamSyncServiceHash() =>
    r'3d80c8a6dccd52461bb2a97cec17681b6f3688fc';

/// 标签同步服务初始化提供者

@ProviderFor(labelSyncServiceInitializer)
final labelSyncServiceInitializerProvider =
    LabelSyncServiceInitializerProvider._();

/// 标签同步服务初始化提供者

final class LabelSyncServiceInitializerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// 标签同步服务初始化提供者
  LabelSyncServiceInitializerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelSyncServiceInitializerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelSyncServiceInitializerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return labelSyncServiceInitializer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$labelSyncServiceInitializerHash() =>
    r'78ccccffe87337c5e37b39b684827af0d15ca47e';
