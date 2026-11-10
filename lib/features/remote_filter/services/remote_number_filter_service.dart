import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/remote_filter/config/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

part 'remote_number_filter_service.g.dart';

@riverpod
RemoteNumberFilterService remoteNumberFilterService(Ref ref) {
  return RemoteNumberFilterService(
    remoteNumberService: ref.watch(remoteNumberServiceProvider),
    getConfig: () async => await ref.read(remoteNumberFilterConfigProvider.future),
  );
}

/// 远程号码过滤服务
class RemoteNumberFilterService implements CallFilterInterface {
  final RemoteNumberService _remoteNumberService;
  final Future<RemoteNumberFilterConfig> Function() _getConfig;

  RemoteNumberFilterService({
    required RemoteNumberService remoteNumberService,
    required Future<RemoteNumberFilterConfig> Function() getConfig,
  })  : _remoteNumberService = remoteNumberService,
        _getConfig = getConfig;

  @override
  CallFilterType get filterType => CallFilterType.remoteNumber;

  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr, {SimInfo? simInfo}) async {
    try {
      final config = await _getConfig();
      if (!config.enableRemoteNumberFilter) {
        return true;
      }

      final phoneNumber = PhoneNumber(phoneNumberStr);
      final remoteInfo = await _remoteNumberService.queryRemoteNumberInfo(phoneNumberStr);

      if (remoteInfo != null) {
        final updatedEntry = await _remoteNumberService.incrementCount(phoneNumber);
        if (config.prioritizeRemoteAction && updatedEntry != null) {
          return await _remoteNumberService.shouldAcceptBasedOnCount(phoneNumber);
        }

        final isExceeded = await _remoteNumberService.isCountExceeded(phoneNumber);
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
    return;
  }
}
