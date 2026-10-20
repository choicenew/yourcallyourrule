// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_status_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DownloadStatusService 的 @Riverpod Provider

@ProviderFor(downloadStatusService)
final downloadStatusServiceProvider = DownloadStatusServiceProvider._();

/// DownloadStatusService 的 @Riverpod Provider

final class DownloadStatusServiceProvider
    extends
        $FunctionalProvider<
          DownloadStatusService,
          DownloadStatusService,
          DownloadStatusService
        >
    with $Provider<DownloadStatusService> {
  /// DownloadStatusService 的 @Riverpod Provider
  DownloadStatusServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadStatusServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadStatusServiceHash();

  @$internal
  @override
  $ProviderElement<DownloadStatusService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadStatusService create(Ref ref) {
    return downloadStatusService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadStatusService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadStatusService>(value),
    );
  }
}

String _$downloadStatusServiceHash() =>
    r'de924337265986ef73ef424390b6ac71c504ae70';
