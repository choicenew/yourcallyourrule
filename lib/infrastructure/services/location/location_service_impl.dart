import 'package:dlibphonenumber/dlibphonenumber.dart';

import '../../../domain/repositories/location_repository.dart';
import '../../../domain/services/location_service.dart';
import '../base_service_impl.dart';

/// 电话号码归属地服务实现
/// 负责解析电话号码并获取归属地信息
class LocationServiceImpl extends BaseServiceImpl implements LocationService {
  final LocationRepository _locationRepository;
  final PhoneNumberUtil _phoneNumberUtil;
  final PhoneNumberOfflineGeocoder _geocoder;
  final PhoneNumberToCarrierMapper _carrierMapper;

  LocationServiceImpl(this._locationRepository) : 
    _phoneNumberUtil = PhoneNumberUtil.instance,
    _geocoder = PhoneNumberOfflineGeocoder.instance,
    _carrierMapper = PhoneNumberToCarrierMapper.instance;

  @override
  Future<Map<String, dynamic>?> getCallerLocationData(String phoneNumber, String languageCode) async {
    try {
      // 解析号码
      final parsedNumber = _phoneNumberUtil.parse(phoneNumber, null);
      
      // 检查号码是否有效
      if (!_phoneNumberUtil.isValidNumber(parsedNumber)) {
        logOperation('无效的电话号码', details: phoneNumber);
        return null;
      }

      // 获取号码类型
      final numberType = _phoneNumberUtil.getNumberType(parsedNumber);
      
      // 获取国家代码
      final regionCode = _phoneNumberUtil.getRegionCodeForNumber(parsedNumber);
      
      // 获取归属地描述
      final locale = Locale(languageCode);
      final region = _geocoder.getDescriptionForValidNumber(parsedNumber, locale, null);
      
      // 获取运营商信息
      final carrier = _carrierMapper.getNameForNumber(parsedNumber, locale);

      // 构建结果
      final result = {
        'phoneNumber': phoneNumber,
        'region': region,
        'countryCode': regionCode,
        'carrier': carrier,
        'numberType': numberType.index,
      };

      // 更新数据库
      await _updateLocationDatabase(result);
      
      logOperation('获取号码归属地成功', details: '号码: $phoneNumber, 地区: $region');
      return result;
    } catch (e) {
      logOperation('获取号码归属地失败', details: e.toString());
      return null;
    }
  }

  /// 更新数据库中的归属地信息
  Future<void> _updateLocationDatabase(Map<String, dynamic> locationData) async {
    await _locationRepository.saveLocationData(locationData);
  }

  /// 从数据库查询归属地信息
  @override
  Future<Map<String, dynamic>?> getLocationFromDatabase(String phoneNumber) async {
    return await _locationRepository.getLocationDataByPhoneNumber(phoneNumber);
  }

  /// 清理数据库中的过期数据
  @override
  Future<void> cleanupDatabase() async {
    logOperation('清理归属地数据库');
    await _locationRepository.cleanupExpiredData();
  }
}