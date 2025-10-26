import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';

part 'device_profile_service_provider.g.dart';

/// DeviceProfileService 的 Provider。
///
/// 使用 @riverpod 注解，使其可以在整个应用中被依赖注入。
/// 由于 DeviceProfileService 没有任何构造函数依赖，所以它的 Provider 非常简单。
@riverpod
DeviceProfileService deviceProfileService(Ref ref) {
  return DeviceProfileService();
}