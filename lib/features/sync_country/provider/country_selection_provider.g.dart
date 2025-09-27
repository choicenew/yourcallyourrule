// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing the list of selected country iso codes.
///
/// This notifier handles loading, adding, and removing selected countries.

@ProviderFor(SelectedCountries)
const selectedCountriesProvider = SelectedCountriesProvider._();

/// Notifier for managing the list of selected country iso codes.
///
/// This notifier handles loading, adding, and removing selected countries.
final class SelectedCountriesProvider
    extends $AsyncNotifierProvider<SelectedCountries, List<String>> {
  /// Notifier for managing the list of selected country iso codes.
  ///
  /// This notifier handles loading, adding, and removing selected countries.
  const SelectedCountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCountriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCountriesHash();

  @$internal
  @override
  SelectedCountries create() => SelectedCountries();
}

String _$selectedCountriesHash() => r'f5a01d816ec2f2eb82fc9126f60d1acf5398485b';

/// Notifier for managing the list of selected country iso codes.
///
/// This notifier handles loading, adding, and removing selected countries.

abstract class _$SelectedCountries extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
