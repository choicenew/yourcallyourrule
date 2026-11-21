// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_phone_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LabelPhonesNotifier)
final labelPhonesProvider = LabelPhonesNotifierProvider._();

final class LabelPhonesNotifierProvider
    extends $AsyncNotifierProvider<LabelPhonesNotifier, List<LabelPhoneEntry>> {
  LabelPhonesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelPhonesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelPhonesNotifierHash();

  @$internal
  @override
  LabelPhonesNotifier create() => LabelPhonesNotifier();
}

String _$labelPhonesNotifierHash() =>
    r'47290d2ec780612e3602bdead266e9e6b0175e27';

abstract class _$LabelPhonesNotifier
    extends $AsyncNotifier<List<LabelPhoneEntry>> {
  FutureOr<List<LabelPhoneEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<LabelPhoneEntry>>, List<LabelPhoneEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<LabelPhoneEntry>>,
                List<LabelPhoneEntry>
              >,
              AsyncValue<List<LabelPhoneEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(labelPhoneByNumber)
final labelPhoneByNumberProvider = LabelPhoneByNumberFamily._();

final class LabelPhoneByNumberProvider
    extends
        $FunctionalProvider<
          AsyncValue<LabelPhoneEntry?>,
          LabelPhoneEntry?,
          FutureOr<LabelPhoneEntry?>
        >
    with $FutureModifier<LabelPhoneEntry?>, $FutureProvider<LabelPhoneEntry?> {
  LabelPhoneByNumberProvider._({
    required LabelPhoneByNumberFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labelPhoneByNumberProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labelPhoneByNumberHash();

  @override
  String toString() {
    return r'labelPhoneByNumberProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LabelPhoneEntry?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LabelPhoneEntry?> create(Ref ref) {
    final argument = this.argument as String;
    return labelPhoneByNumber(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabelPhoneByNumberProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labelPhoneByNumberHash() =>
    r'63c3bfc6058272cc0ef3c23014bbee9e14f2c806';

final class LabelPhoneByNumberFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LabelPhoneEntry?>, String> {
  LabelPhoneByNumberFamily._()
    : super(
        retry: null,
        name: r'labelPhoneByNumberProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabelPhoneByNumberProvider call(String number) =>
      LabelPhoneByNumberProvider._(argument: number, from: this);

  @override
  String toString() => r'labelPhoneByNumberProvider';
}
