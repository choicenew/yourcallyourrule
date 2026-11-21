// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationsNotifier)
final locationsProvider = LocationsNotifierProvider._();

final class LocationsNotifierProvider
    extends
        $AsyncNotifierProvider<LocationsNotifier, List<PhoneLocationEntry>> {
  LocationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationsNotifierHash();

  @$internal
  @override
  LocationsNotifier create() => LocationsNotifier();
}

String _$locationsNotifierHash() => r'772b59d011586ca4cd454aa7b818db09fdf5a3cb';

abstract class _$LocationsNotifier
    extends $AsyncNotifier<List<PhoneLocationEntry>> {
  FutureOr<List<PhoneLocationEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PhoneLocationEntry>>,
              List<PhoneLocationEntry>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PhoneLocationEntry>>,
                List<PhoneLocationEntry>
              >,
              AsyncValue<List<PhoneLocationEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
