// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_alert_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FraudAlertConfigNotifier)
const fraudAlertConfigProvider = FraudAlertConfigNotifierProvider._();

final class FraudAlertConfigNotifierProvider
    extends $AsyncNotifierProvider<FraudAlertConfigNotifier, FraudAlertConfig> {
  const FraudAlertConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fraudAlertConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fraudAlertConfigNotifierHash();

  @$internal
  @override
  FraudAlertConfigNotifier create() => FraudAlertConfigNotifier();
}

String _$fraudAlertConfigNotifierHash() =>
    r'c8d04d21c7dddced1ed45606e1eb608a34d94ab6';

abstract class _$FraudAlertConfigNotifier
    extends $AsyncNotifier<FraudAlertConfig> {
  FutureOr<FraudAlertConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<FraudAlertConfig>, FraudAlertConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FraudAlertConfig>, FraudAlertConfig>,
              AsyncValue<FraudAlertConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
