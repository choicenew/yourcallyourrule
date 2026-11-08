// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_mark_statistics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 标记统计仓库提供者

@ProviderFor(labelMarkStatisticsRepository)
final labelMarkStatisticsRepositoryProvider =
    LabelMarkStatisticsRepositoryProvider._();

/// 标记统计仓库提供者

final class LabelMarkStatisticsRepositoryProvider
    extends
        $FunctionalProvider<
          LabelMarkStatisticsRepository,
          LabelMarkStatisticsRepository,
          LabelMarkStatisticsRepository
        >
    with $Provider<LabelMarkStatisticsRepository> {
  /// 标记统计仓库提供者
  LabelMarkStatisticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelMarkStatisticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelMarkStatisticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<LabelMarkStatisticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelMarkStatisticsRepository create(Ref ref) {
    return labelMarkStatisticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelMarkStatisticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelMarkStatisticsRepository>(
        value,
      ),
    );
  }
}

String _$labelMarkStatisticsRepositoryHash() =>
    r'0e250359fd82d605ca9f8335a60079704550c2bb';
