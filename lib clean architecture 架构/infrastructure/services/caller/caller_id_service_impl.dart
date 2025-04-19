import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';

import '../../../domain/entities/caller/caller_id_data.dart';
import '../../../domain/services/caller_id_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../domain/repositories/label_repository.dart';
import '../../../domain/repositories/location_repository.dart';
import '../../../../lib/domain/repositories/caller_id_cache_repository.dart';
import '../../models/call_model.dart';
import '../base_service_impl.dart';

/// 来电识别服务实现
class CallerIdServiceImpl extends BaseServiceImpl implements CallerIdService {
  final ContactRepository _contactRepository;
  final RuleRepository _ruleRepository;
  final LabelRepository _labelRepository;
  final LocationRepository _locationRepository;
  final CallerIdCacheRepository _cacheRepository;
  
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  
  CallerIdServiceImpl(
    this._contactRepository,
    this._ruleRepository,
    this._labelRepository,
    this._locationRepository,
    this._cacheRepository,
  );
  
  @override
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  
  @override
  Future<CallerIdData> getCallerId(PhoneNumber phoneNumber, String locale) async {
    // 1. 获取格式化号码
    final formattedNumbers = await getFormattedNumbers(phoneNumber, locale);
    final e164Number = formattedNumbers['e164'] ?? '';
    final nationalNumber = formattedNumbers['national'] ?? '';
    
    // 2. 查询联系人
    final contact = await _contactRepository.getContactByPhoneNumber(phoneNumber.value);
    
    // 尝试使用格式化号码再次查询
    final contactByE164 = contact ?? await _contactRepository.getContactByPhoneNumber(e164Number);
    final contactByNational = contactByE164 ?? await _contactRepository.getContactByPhoneNumber(nationalNumber);
    
    // 3. 检查规则匹配
    final matchedRule = await _ruleRepository.findMatchingRule(phoneNumber.value);
    
    // 尝试使用格式化号码再次查询
    final ruleByE164 = matchedRule ?? await _ruleRepository.findMatchingRule(e164Number);
    final ruleByNational = ruleByE164 ?? await _ruleRepository.findMatchingRule(nationalNumber);
    
    // 4. 获取标签
    final label = await _labelRepository.getLabelByPhoneNumber(phoneNumber.value);
    
    // 尝试使用格式化号码再次查询
    final labelByE164 = label ?? await _labelRepository.getLabelByPhoneNumber(e164Number);
    final labelByNational = labelByE164 ?? await _labelRepository.getLabelByPhoneNumber(nationalNumber);
    
    // 5. 获取位置信息
    final locationData = await _locationRepository.getLocationDataByPhoneNumber(phoneNumber.value);
    
    // 6. 构建来电显示数据
    final callerIdData = CallerIdData(
      phoneNumber: phoneNumber,
      name: contactByNational?.name,
      location: locationData?['location'] as String?,
      carrier: locationData?['carrier'] as String?,
      countryName: locationData?['countryName'] as String?,
      label: labelByNational?.name,
      avatar: contactByNational?.avatar,
      isBlocked: ruleByNational?.action == 'block',
      isSpam: ruleByNational?.type == 'spam',
      matchedRuleId: ruleByNational?.id,
      matchedRuleType: ruleByNational?.type,
    );
    
    // 7. 更新数据流
    updateCallerIdData(callerIdData);
    
    return callerIdData;
  }
  
  @override
  void updateCallerIdData(CallerIdData data) {
    _callerIdSubject.add(data);
  }
  
  @override
  Future<bool> shouldBlockNumber(PhoneNumber phoneNumber) async {
    // 检查号码是否在黑名单中
    final matchedRule = await _ruleRepository.findMatchingRule(phoneNumber.value);
    
    // 如果找到匹配的规则，检查规则类型
    if (matchedRule != null) {
      // 如果规则动作是阻止，返回true
      if (matchedRule.action == 'block') {
        return true;
      }
      
      // 如果规则类型是垃圾信息，返回true
      if (matchedRule.type == 'spam') {
        return true;
      }
    }
    
    // 默认不阻止
    return false;
  }
  
  @override
  Future<void> saveCallerIdDataToCache(PhoneNumber phoneNumber, CallerIdData data) async {
    await _cacheRepository.saveCallerIdData(phoneNumber.value, data);
  }
  
  @override
  Future<CallerIdData?> getCallerIdDataFromCache(PhoneNumber phoneNumber) async {
    return await _cacheRepository.getCallerIdData(phoneNumber.value);
  }
  
  @override
  Future<Map<String, String>> getFormattedNumbers(PhoneNumber phoneNumber, String locale) async {
    try {
      // 使用 dlibphonenumber 解析号码
      final phoneNumberUtil = PhoneNumberUtil.instance;
      
      // 检查号码是否包含国际前缀
      final internationalPrefixRegex = RegExp(r'^\+');
      
      String e164Number = "";
      String nationalNumber = "";
      
      if (internationalPrefixRegex.hasMatch(phoneNumber.value)) {
        // 包含国际区号，使用 null 作为国家代码
        final parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber.value, null);
        
        e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      } else {
        // 不包含国际区号，使用 locale 中的国家代码
        final countryCode = locale.split('_').length > 1 ? locale.split('_')[1] : 'US';
        final parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber.value, countryCode);
        
        e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      }
      
      return {
        'e164': e164Number,
        'national': nationalNumber,
      };
    } catch (e) {
      // 解析失败，返回原始号码
      return {
        'e164': phoneNumber.value,
        'national': phoneNumber.value,
      };
    }
  }
  
  @override
  Future<String?> getLocationForNumber(PhoneNumber phoneNumber, String locale) async {
    final locationData = await _locationRepository.getLocationDataByPhoneNumber(phoneNumber.value);
    return locationData?['location'] as String?;
  }
  
  @override
  Future<String?> getCarrierForNumber(PhoneNumber phoneNumber, String locale) async {
    final locationData = await _locationRepository.getLocationDataByPhoneNumber(phoneNumber.value);
    return locationData?['carrier'] as String?;
  }
}