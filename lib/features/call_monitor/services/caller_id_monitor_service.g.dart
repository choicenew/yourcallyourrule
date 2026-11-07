// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_monitor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(callerIdDataSubject)
final callerIdDataSubjectProvider = CallerIdDataSubjectProvider._();

final class CallerIdDataSubjectProvider
    extends
        $FunctionalProvider<
          BehaviorSubject<CallerIdData>,
          BehaviorSubject<CallerIdData>,
          BehaviorSubject<CallerIdData>
        >
    with $Provider<BehaviorSubject<CallerIdData>> {
  CallerIdDataSubjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdDataSubjectProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdDataSubjectHash();

  @$internal
  @override
  $ProviderElement<BehaviorSubject<CallerIdData>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BehaviorSubject<CallerIdData> create(Ref ref) {
    return callerIdDataSubject(ref);
  }

  Override overrideWithValue(BehaviorSubject<CallerIdData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BehaviorSubject<CallerIdData>>(
        value,
      ),
    );
  }
}

String _$callerIdDataSubjectHash() =>
    r'ad6c67c4ab6def2d25900eca7a1d03b9482a5d41';

@ProviderFor(rawCallEventStreamController)
final rawCallEventStreamControllerProvider =
    RawCallEventStreamControllerProvider._();

final class RawCallEventStreamControllerProvider
    extends
        $FunctionalProvider<
          StreamController<MethodCall>,
          StreamController<MethodCall>,
          StreamController<MethodCall>
        >
    with $Provider<StreamController<MethodCall>> {
  RawCallEventStreamControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rawCallEventStreamControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rawCallEventStreamControllerHash();

  @$internal
  @override
  $ProviderElement<StreamController<MethodCall>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamController<MethodCall> create(Ref ref) {
    return rawCallEventStreamController(ref);
  }

  Override overrideWithValue(StreamController<MethodCall> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamController<MethodCall>>(value),
    );
  }
}

String _$rawCallEventStreamControllerHash() =>
    r'bd8a54006c557bc101e5d19cee6836604e2d6533';

@ProviderFor(CallerIdMonitorService)
final callerIdMonitorServiceProvider = CallerIdMonitorServiceProvider._();

final class CallerIdMonitorServiceProvider
    extends $AsyncNotifierProvider<CallerIdMonitorService, void> {
  CallerIdMonitorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdMonitorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdMonitorServiceHash();

  @$internal
  @override
  CallerIdMonitorService create() => CallerIdMonitorService();
}

String _$callerIdMonitorServiceHash() =>
    r'7b9defe5f908a048b87e3ea5cf4a87ae75c695b4';

abstract class _$CallerIdMonitorService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
