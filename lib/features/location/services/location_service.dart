import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/repositories/location_repository.dart';

import 'package:yourcallyourrule/core/services/list_service.dart';

import 'package:yourcallyourrule/core/services/universal_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;

class LocationService extends ListService<LocationEntry, String> {
  final LocationRepository _repository;
  final UniversalImportExportService<LocationEntry> _importExportService; // 修改服务类型

  //来自于dlibphonenumber的类
  final PhoneNumberUtil _phoneNumberUtil;
  final PhoneNumberOfflineGeocoder _geocoder;
  final PhoneNumberToCarrierMapper _carrierMapper;

  LocationService(this._repository)
      : _importExportService = UniversalImportExportService<LocationEntry>(_repository), // 正确初始化泛型服务
        _phoneNumberUtil = PhoneNumberUtil.instance,
        _geocoder = PhoneNumberOfflineGeocoder.instance,
        _carrierMapper = PhoneNumberToCarrierMapper.instance,
        super(_repository);

  // 核心业务方法
  Future<LocationEntry?> getCallerLocation(String phoneNumber, Locale locale) async {  // 修改参数为Locale类型
    final parsedNumber = _phoneNumberUtil.parse(phoneNumber, null);
    
    if (!_phoneNumberUtil.isValidNumber(parsedNumber)) {
      return null;
    }

    // 直接使用传入的locale参数（与原始代码逻辑一致）
    final region = _geocoder.getDescriptionForValidNumber(parsedNumber, locale, null);
    final carrier = _carrierMapper.getNameForNumber(parsedNumber, locale);
    final numberType = _phoneNumberUtil.getNumberType(parsedNumber);

    final entry = LocationEntry(
      id: const Uuid().v4(),
      phoneNumber: vo.PhoneNumber.fromString(phoneNumber),  // 使用前缀后的构造方式
      region: region,
      countryName: _phoneNumberUtil.getRegionCodeForNumber(parsedNumber),
      carrier: carrier,
      numberType: numberType,
    );

    await _repository.save(entry);
    return entry;
  }
  
  /// 【【【 最终、唯一的、正确的修复 】】】
  /// 新增一个 saveLocation 方法，以供 LocationSyncService 调用。
  /// 这个方法将保存操作委托给底层的 Repository。
  Future<void> saveLocation(LocationEntry entry) async {
    // 调用您在 Repository 中已经定义好的 save 方法
    await _repository.save(entry);
  }


  // 数据库操作方法
  Future<void> updateLocationData(LocationEntry entry) async {
    await _repository.update(entry);
  }

  Future<LocationEntry?> getByPhoneNumber(String phoneNumber) async {
     // 【【【 最终、唯一的、正确的修复 】】】
    // 您的 Repository 已经提供了一个更高效、更安全的方法，我们应该直接使用它。
    // 它直接在数据库层面查询，而不是获取全部数据到内存再筛选。
    return await _repository.getByPhoneNumber(phoneNumber);
  }
 
 

  // 继承自ListService的方法
  @override
  Future<List<LocationEntry>> getAll() async {
    final rules = await _repository.getAll();
    return rules.whereType<LocationEntry>().toList();
  }

  // 导入导出功能
  // 更新导入导出方法
  Future<List<LocationEntry>> importFromFile(String path) async {
    return await _importExportService.importFromFile(path);
  }

  Future<bool> exportToFile(String path) async {
    final data = await getAll();
    return await _importExportService.exportToFile(path, data);
  }

  // 添加国家代码获取方法
  Future<String?> getCountryCode(String phoneNumber) async {
    final parsed = _phoneNumberUtil.parse(phoneNumber, null);
    return _phoneNumberUtil.getRegionCodeForNumber(parsed);
  }

  // 添加删除功能
  Future<void> deleteByPhoneNumber(String phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      await _repository.delete(entry);
    }
  }
}