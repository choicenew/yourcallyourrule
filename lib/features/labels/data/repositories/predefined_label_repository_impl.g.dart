// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_label_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(predefinedLabelRepository)
final predefinedLabelRepositoryProvider = PredefinedLabelRepositoryProvider._();

final class PredefinedLabelRepositoryProvider
    extends
        $FunctionalProvider<
          PredefinedLabelRepository,
          PredefinedLabelRepository,
          PredefinedLabelRepository
        >
    with $Provider<PredefinedLabelRepository> {
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
    r'746f00025c64d4fff5ce1f9f37bffa6b9ffcf2eb';
