// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_mark_statistics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelMarkStatisticsService 的 @Riverpod Provider

@ProviderFor(labelMarkStatisticsService)
final labelMarkStatisticsServiceProvider =
    LabelMarkStatisticsServiceProvider._();

/// LabelMarkStatisticsService 的 @Riverpod Provider

final class LabelMarkStatisticsServiceProvider
    extends
        $FunctionalProvider<
          LabelMarkStatisticsService,
          LabelMarkStatisticsService,
          LabelMarkStatisticsService
        >
    with $Provider<LabelMarkStatisticsService> {
  /// LabelMarkStatisticsService 的 @Riverpod Provider
  LabelMarkStatisticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelMarkStatisticsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelMarkStatisticsServiceHash();

  @$internal
  @override
  $ProviderElement<LabelMarkStatisticsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelMarkStatisticsService create(Ref ref) {
    return labelMarkStatisticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelMarkStatisticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelMarkStatisticsService>(value),
    );
  }
}

String _$labelMarkStatisticsServiceHash() =>
    r'7f5b68df13e358fdd70dfb4335f7c4d053f3ed10';
