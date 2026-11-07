// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intercept_event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(interceptEventStreamController)
final interceptEventStreamControllerProvider =
    InterceptEventStreamControllerProvider._();

final class InterceptEventStreamControllerProvider
    extends
        $FunctionalProvider<
          StreamController<InterceptEvent>,
          StreamController<InterceptEvent>,
          StreamController<InterceptEvent>
        >
    with $Provider<StreamController<InterceptEvent>> {
  InterceptEventStreamControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interceptEventStreamControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interceptEventStreamControllerHash();

  @$internal
  @override
  $ProviderElement<StreamController<InterceptEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamController<InterceptEvent> create(Ref ref) {
    return interceptEventStreamController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamController<InterceptEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamController<InterceptEvent>>(
        value,
      ),
    );
  }
}

String _$interceptEventStreamControllerHash() =>
    r'3e7612c30042ad98b49002152587c80f2c444a31';
