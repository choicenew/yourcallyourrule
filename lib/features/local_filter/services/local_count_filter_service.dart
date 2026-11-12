import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/local_filter/config/local_count_filter_config.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';

part 'local_count_filter_service.g.dart';

@riverpod
LocalCountFilterService localCountFilterService(Ref ref) {
  final service = LocalCountFilterService(
    callerIdentityService: ref.watch(callerIdentityServiceProvider),
    getConfig: () async => await ref.read(localCountFilterConfigProvider.future),
  );
  service.initialize();
  ref.onDispose(() => service.dispose());
  return service;
}

class LocalCountFilterService implements CallFilterInterface {
  final CallerIdentityService _callerIdentityService;
  final Future<LocalCountFilterConfig> Function() _getConfig;

  PluginSourceData? _latestPluginData;
  bool _isDisposed = false;

  StreamSubscription<PluginSourceData>? _pluginDataSubscription;

  LocalCountFilterService({
    required CallerIdentityService callerIdentityService,
    required Future<LocalCountFilterConfig> Function() getConfig,
  })  : _callerIdentityService = callerIdentityService,
        _getConfig = getConfig;

  @override
  CallFilterType get filterType => CallFilterType.localCount;

  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr, {dynamic simInfo}) async {
    try {
      if (_isDisposed) {
        return true;
      }
      final config = await _getConfig();
      if (!config.enableLocalCountFilter) {
        return true;
      }

      final phoneNumber = PhoneNumber.fromString(phoneNumberStr);

      if (_latestPluginData != null && _latestPluginData!.phoneNumber == phoneNumber.value && _latestPluginData!.count != null) {
        final count = _latestPluginData!.count!;
        final isExceeded = count >= config.countThreshold;
        if (isExceeded && config.rejectExceededNumbers) {
          return false;
        }
        if (!isExceeded && config.allowNonExceededNumbers) {
          return true;
        }
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  @override
  Future<void> initialize() async {
    _pluginDataSubscription ??= _callerIdentityService.pluginDataStream.listen((pluginSourceData) {
      _latestPluginData = pluginSourceData;
    });
  }

  void dispose() {
    _isDisposed = true;
    _pluginDataSubscription?.cancel();
  }
}
