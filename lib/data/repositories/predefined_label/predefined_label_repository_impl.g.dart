// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_label_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 预定义标签仓库提供者

@ProviderFor(predefinedLabelRepository)
final predefinedLabelRepositoryProvider = PredefinedLabelRepositoryProvider._();

/// 预定义标签仓库提供者

final class PredefinedLabelRepositoryProvider
    extends
        $FunctionalProvider<
          PredefinedLabelRepository,
          PredefinedLabelRepository,
          PredefinedLabelRepository
        >
    with $Provider<PredefinedLabelRepository> {
  /// 预定义标签仓库提供者
  PredefinedLabelRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'predefinedLabelRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$predefinedLabelRepositoryHash();

  @$internal
  @override
  $ProviderElement<PredefinedLabelRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PredefinedLabelRepository create(Ref ref) {
    return predefinedLabelRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PredefinedLabelRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PredefinedLabelRepository>(value),
    );
  }
}

String _$predefinedLabelRepositoryHash() =>
    r'b70150f7fafec7d95696fd9f48a5f937d531f5a8';
