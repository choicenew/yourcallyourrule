import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

part 'phone_location_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneLocationControlCenter phoneLocationControlCenter(Ref ref) {
  return PhoneLocationControlCenter.instance;
}

/// 电话号码归属地中枢控制中心 (PhoneLocationControlCenter)
class PhoneLocationControlCenter {
  static final PhoneLocationControlCenter instance = PhoneLocationControlCenter._();

  PhoneLocationControlCenter._();

  PhoneLocationStorageDriver? _storageDriver;
  PhoneLocationResolverDriver? _resolverDriver;

  void registerStorageDriver(PhoneLocationStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneLocationHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  void registerResolverDriver(PhoneLocationResolverDriver driver) {
    _resolverDriver = driver;
    debugPrint('[PhoneLocationHub] 已挂载注册归属地解析驱动: ${driver.runtimeType}');
  }

  PhoneLocationStorageDriver? get storageDriver => _storageDriver;
  PhoneLocationResolverDriver? get resolverDriver => _resolverDriver;

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    return await _storageDriver?.getByPhoneNumber(phoneNumber);
  }

  Future<void> saveLocation(PhoneLocationEntry entry) async {
    await _storageDriver?.saveLocation(entry);
    debugPrint('[PhoneLocationHub] 中枢保存号码归属地: ${entry.phoneNumber} -> ${entry.region}');
  }

  /// 查询或解析号码归属地 (优先本地驱动缓存，缺失时触发解析驱动并自动落盘)
  Future<PhoneLocationEntry?> getCallerLocation(
    String phoneNumber, {
    String? localeLanguage,
    String? localeCountry,
  }) async {
    final cached = await _storageDriver?.getByPhoneNumber(phoneNumber);
    if (cached != null) {
      return cached;
    }

    if (_resolverDriver != null) {
      final resolved = await _resolverDriver!.resolveLocation(
        phoneNumber,
        localeLanguage: localeLanguage,
        localeCountry: localeCountry,
      );
      if (resolved != null) {
        await _storageDriver?.saveLocation(resolved);
        return resolved;
      }
    }
    return null;
  }
}
