import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/phone_location/repositories/location_repository.dart';
import 'package:yourcallyourrule/features/phone_location/data/repositories/location_repository_impl.dart';

part 'location_service.g.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationService(locationRepository);
}

class LocationService {
  final LocationRepository _repository;
  final PhoneNumberUtil _phoneNumberUtil;
  final PhoneNumberOfflineGeocoder _geocoder;
  final PhoneNumberToCarrierMapper _carrierMapper;
  final Uuid _uuid = const Uuid();

  LocationService(this._repository)
      : _phoneNumberUtil = PhoneNumberUtil.instance,
        _geocoder = PhoneNumberOfflineGeocoder.instance,
        _carrierMapper = PhoneNumberToCarrierMapper.instance;

  Future<PhoneLocationEntry?> getCallerLocation(String phoneNumber, Locale locale) async {
    try {
      final parsedNumber = _phoneNumberUtil.parse(phoneNumber, null);

      if (!_phoneNumberUtil.isValidNumber(parsedNumber)) {
        return null;
      }

      final region = await _geocoder.getDescriptionForNumber(parsedNumber, locale, null);
      final carrier = await _carrierMapper.getNameForNumber(parsedNumber, locale);
      final numberTypeInt = _phoneNumberUtil.getNumberType(parsedNumber).index;

      final entry = PhoneLocationEntry(
        id: _uuid.v4(),
        phoneNumber: phoneNumber,
        region: region,
        countryName: _phoneNumberUtil.getRegionCodeForNumber(parsedNumber),
        carrier: carrier,
        numberType: numberTypeInt.toString(),
      );

      await _repository.save(entry);
      return entry;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLocation(PhoneLocationEntry entry) async {
    await _repository.save(entry);
  }

  Future<void> updateLocationData(PhoneLocationEntry entry) async {
    await _repository.update(entry);
  }

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    return await _repository.getByPhoneNumber(phoneNumber);
  }

  Future<List<PhoneLocationEntry>> getAll() async {
    return await _repository.getAll();
  }

  Future<String?> getCountryCode(String phoneNumber) async {
    try {
      final parsed = _phoneNumberUtil.parse(phoneNumber, null);
      return _phoneNumberUtil.getRegionCodeForNumber(parsed);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteByPhoneNumber(String phoneNumber) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      await _repository.delete(entry);
    }
  }
}
