// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_labels_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(predefinedLabelService)
final predefinedLabelServiceProvider = PredefinedLabelServiceProvider._();

final class PredefinedLabelServiceProvider
    extends
        $FunctionalProvider<
          PredefinedLabelService,
          PredefinedLabelService,
          PredefinedLabelService
        >
    with $Provider<PredefinedLabelService> {
  PredefinedLabelServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'predefinedLabelServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$predefinedLabelServiceHash();

  @$internal
  @override
  $ProviderElement<PredefinedLabelService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PredefinedLabelService create(Ref ref) {
    return predefinedLabelService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PredefinedLabelService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PredefinedLabelService>(value),
    );
  }
}

String _$predefinedLabelServiceHash() =>
    r'6ec98355c3d3903d0ab6012e542524a21a1e457c';

@ProviderFor(PredefinedLabelsNotifier)
final predefinedLabelsProvider = PredefinedLabelsNotifierProvider._();

final class PredefinedLabelsNotifierProvider
    extends
        $AsyncNotifierProvider<
          PredefinedLabelsNotifier,
          List<PredefinedLabel>
        > {
  PredefinedLabelsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'predefinedLabelsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$predefinedLabelsNotifierHash();

  @$internal
  @override
  PredefinedLabelsNotifier create() => PredefinedLabelsNotifier();
}

String _$predefinedLabelsNotifierHash() =>
    r'751f843fe0ee40ddfffba66da11e93c8b1c70985';

abstract class _$PredefinedLabelsNotifier
    extends $AsyncNotifier<List<PredefinedLabel>> {
  FutureOr<List<PredefinedLabel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PredefinedLabel>>, List<PredefinedLabel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PredefinedLabel>>,
                List<PredefinedLabel>
              >,
              AsyncValue<List<PredefinedLabel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(predefinedLabelById)
final predefinedLabelByIdProvider = PredefinedLabelByIdFamily._();

final class PredefinedLabelByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<PredefinedLabel?>,
          PredefinedLabel?,
          FutureOr<PredefinedLabel?>
        >
    with $FutureModifier<PredefinedLabel?>, $FutureProvider<PredefinedLabel?> {
  PredefinedLabelByIdProvider._({
    required PredefinedLabelByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'predefinedLabelByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$predefinedLabelByIdHash();

  @override
  String toString() {
    return r'predefinedLabelByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PredefinedLabel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PredefinedLabel?> create(Ref ref) {
    final argument = this.argument as String;
    return predefinedLabelById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PredefinedLabelByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$predefinedLabelByIdHash() =>
    r'ca4a5c1882308c31070d13bd4bdb775420cfd117';

final class PredefinedLabelByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PredefinedLabel?>, String> {
  PredefinedLabelByIdFamily._()
    : super(
        retry: null,
        name: r'predefinedLabelByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PredefinedLabelByIdProvider call(String id) =>
      PredefinedLabelByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'predefinedLabelByIdProvider';
}
