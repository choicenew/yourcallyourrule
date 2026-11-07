import 'package:pyro_phone_count_filter_protocol/src/models/phone_count_filter_config.dart';

/// 本地频次持久化 Driver 抽象接口契约 (PhoneCountStorageDriver)
abstract class PhoneCountStorageDriver {
  Future<PhoneCountFilterConfig> getConfig();
  Future<void> saveConfig(PhoneCountFilterConfig config);
}
