import 'dart:async';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;

import '../../services/caller_id_service.dart';
import '../../utils/global_variable.dart';
import '../../utils/parse_phonenumber.dart';
import 'call_log_database.dart';

class CallLogManager {
  final _callLogController = BehaviorSubject<List<CallLogEntry>>();
  bool _isLoading = false;
  final CallerIdService _callerIdService;
  final BuildContext context;
  final CallScreeningDatabase _database = CallScreeningDatabase.instance;
  Map<String, CallerIdData> _callerIdDataCache = {};

  CallLogManager(this.context, this._callerIdService) {
    _initialize();
  }

//  Stream<List<CallLogEntry>> get callLogsStream => _callLogController.stream;

  Stream<List<CallLogEntry>> get callLogsStream => _callLogController.stream.map((logs) => logs.where((entry) => entry.number != null).toList());
  Map<String, CallerIdData> get callerIdCache => _callerIdDataCache;

  Future<void> _initialize() async {
    await loadAllCallerIdData();
    await loadAllCallLogs();
  }

  Future<void> loadAllCallLogs() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    try {
      final logs = await _database.getRecentLogs();
      
      if (!_callLogController.isClosed) {
        _callLogController.add(logs);
      }
    } catch (e) {
      if (!_callLogController.isClosed) {
        _callLogController.addError(e);
      }
    } finally {
      _isLoading = false;
    }
  }



  Future<void> refresh() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    try {
      final logs = await _database.getRecentLogs();
      
      if (!_callLogController.isClosed) {
        _callLogController.add(logs);
      }
    } catch (e) {
      if (!_callLogController.isClosed) {
        _callLogController.addError(e);
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> filterByPhoneNumber(String phoneNumber) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final filteredLogs = await _database.getLogsByPhoneNumber(phoneNumber);
      _callLogController.add(filteredLogs);
    } finally {
      _isLoading = false;
    }
  }

  Future<CallerIdData> getCallerIdData(CallLogEntry entry) async {
    String? phoneNumber = entry.number ?? '';

    if (phoneNumber.isEmpty) {
      return _getUnknownCallerIdData();
    }

    if (_callerIdDataCache.containsKey(phoneNumber)) {
      return _callerIdDataCache[phoneNumber]!;
    }

    final callerIdDataFromDb = await _database.getCallerIdDataByPhoneNumber(phoneNumber);
    if (callerIdDataFromDb != null) {
      await _saveCallerIdDataToCache(phoneNumber, callerIdDataFromDb);
      return callerIdDataFromDb;
    }

    final callerIdData = await _fetchAndSaveCallerIdData(phoneNumber);
    return callerIdData;
  }

  Future<CallerIdData> _fetchAndSaveCallerIdData(String phoneNumber) async {
    try {
      final parsedData = await parsePhoneNumber(phoneNumber);
      final countryCode = parsedData['countryCode']!;
      final e164Number = parsedData['e164Number']!;

      final languageCode = currentLocale?.languageCode ?? 'en';
      final dlibLocale = dlibphone.Locale(
        language: languageCode,
        country: countryCode.toUpperCase(),
      );

      final callerIdData = await _callerIdService.getCallerId(phoneNumber, dlibLocale);
      await _saveCallerIdDataToCache(phoneNumber, callerIdData);
      await _database.insertCallerIdData(callerIdData);
      
      return callerIdData;
    } catch (error) {
      return _getUnknownCallerIdData(phoneNumber);
    }
  }

  Future<void> _saveCallerIdDataToCache(String phoneNumber, CallerIdData callerIdData) async {
    if (_callerIdDataCache.length >= 50) {
      _callerIdDataCache.remove(_callerIdDataCache.keys.first);
    }
    _callerIdDataCache[phoneNumber] = callerIdData;
  }

  CallerIdData _getUnknownCallerIdData([String? phoneNumber]) {
    return CallerIdData(
      phoneNumber: phoneNumber ?? 'Unknown',
      countryName: 'Unknown',
      region: 'Unknown',
      carrier: 'Unknown',
      numberType: PhoneNumberType.unknown,
      labels: [Label(label: 'Unknown')],
      name: 'OtherUnknown',
      avatar: 'Unknown',
      count: 0,
    );
  }

  Future<void> saveCallerIdData(String phoneNumber, CallerIdData callerIdData) async {
    await _database.insertCallerIdData(callerIdData);
    if (_callerIdDataCache.length >= 50) {
      _callerIdDataCache.remove(_callerIdDataCache.keys.first);
    }
    _callerIdDataCache[phoneNumber] = callerIdData;
  }

  Future<void> loadAllCallerIdData() async {
    try {
      final callerIdDataList = await _database.getAllCallerIdData();
      _callerIdDataCache = {
        for (var data in callerIdDataList)
          data.phoneNumber: data
      };
    } catch (e) {
      // Handle error silently
    }
  }

  void dispose() {
    _callLogController.close();
  }
}