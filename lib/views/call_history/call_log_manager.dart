// call_log_manager.dart
import 'dart:async';
import 'package:call_log/call_log.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;


import '../../generated/l10n.dart';

import '../../services/caller_id_service.dart';
import '../../utils/global_variable.dart';

import '../../utils/parse_phonenumber.dart';


import 'call_log_database.dart';

class CallLogManager {
  final _callLogController = BehaviorSubject<List<CallLogEntry>>();
  bool _isLoading = false;
  bool _hasInitializedCallLogs = false;
  StreamSubscription<dynamic>? _newCallLogsSubscription;
  final CallerIdService _callerIdService;
  final BuildContext context;
  final CallLogDatabase _database = CallLogDatabase.instance;
  Map<String, CallerIdData> _callerIdDataCache = {};

  CallLogManager(this.context, this._callerIdService) {

    _initialize();
  }

  Stream<List<CallLogEntry>> get callLogsStream => _callLogController.stream;
  Map<String, CallerIdData> get callerIdCache => _callerIdDataCache;

  Future<void> _initialize() async {

    final status = await Permission.phone.status;
    if (status.isGranted) {
      await loadAllCallerIdData(); // Load caller ID cache first
      await loadAllCallLogs();
      _setupCallLogListener();
    } else if (status.isDenied) {
      await _requestPhonePermission();
    }
  }

  Future<void> _setupCallLogListener() async {

    
    await _newCallLogsSubscription?.cancel();
    
    _newCallLogsSubscription = CallLog.listenNewCallLogs().listen(
      (newCallLog) async {

        await _handleNewCallLog(newCallLog);
      },
      onError: (error) {
 
        Future.delayed(const Duration(seconds: 5), _setupCallLogListener);
      },
      cancelOnError: false,
    );
  }

  Future<void> loadAllCallLogs() async {

    // 在 _initialize() 中读取 _hasInitializedCallLogs 的值
_hasInitializedCallLogs = await _getHasInitializedCallLogs();

    if (_isLoading) {

      return;
    }

    _isLoading = true;
    try {

      
      final lastSyncTimestamp = await _getLastSyncTimestamp();
      
      final Iterable<CallLogEntry> result;
      if (!_hasInitializedCallLogs || lastSyncTimestamp == 0) {
        result = await CallLog.get();

      } else {
        result = await CallLog.query(
          dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
        );
 
      }
      
      if (result.isNotEmpty) {
        await _database.insertCallLogs(result.toList());
        await _preloadCallerIdData(result.toList());
      }

      final logs = await _database.getRecentLogs(limit: 1000);
      
      if (!_callLogController.isClosed) {
 
        _callLogController.add(logs);
      }
      
      await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
      _hasInitializedCallLogs = true;
 
      // 在 _loadAllCallLogs() 中保存 _hasInitializedCallLogs 的值
await _saveHasInitializedCallLogs(true);
    } catch (e) {

      if (!_callLogController.isClosed) {
        _callLogController.addError(e);
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _handleNewCallLog(CallLogEntry newCallLog) async {

    
    if (newCallLog.number == null) {

      return;
    }

    try {
      // Update CallerID data
      if (!_callerIdDataCache.containsKey(newCallLog.number)) {
        final callerIdData = await getCallerIdData(newCallLog);
        _callerIdDataCache[newCallLog.number!] = callerIdData;
        await _database.insertCallerIdData(callerIdData);
      }
      
      // Save to database
      await _database.insertCallLog(newCallLog);
      
      // Get updated records
      final updatedLogs = await _database.getRecentLogs();
      
      if (!_callLogController.isClosed) {

        _callLogController.add(updatedLogs);
      }
      
    } catch (e) {
     // print("Error handling new call log: $e");
    }
  }

  Future<void> refresh() async {
 
    
    if (_isLoading) {
     
      return;
    }

    _isLoading = true;
    try {
      final lastSyncTimestamp = await _getLastSyncTimestamp();
      final Iterable<CallLogEntry> result = await CallLog.query(
        dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
      );
      
      if (result.isNotEmpty) {
        await _database.insertCallLogs(result.toList());
        await _preloadCallerIdData(result.toList());
      }
      
      final updatedLogs = await _database.getRecentLogs();
      
      if (!_callLogController.isClosed) {
      
        _callLogController.add(updatedLogs);
      }
      
      await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
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

  // CallerID related methods
  Future<void> _preloadCallerIdData(List<CallLogEntry> logs) async {
    for (var entry in logs) {
      if (entry.number != null && !_callerIdDataCache.containsKey(entry.number)) {
        final callerIdData = await _fetchAndSaveCallerIdData(entry.number!);
        _callerIdDataCache[entry.number!] = callerIdData;
        //await _database.insertCallerIdData(callerIdData);
      }
    }
  }

Future<CallerIdData> getCallerIdData(CallLogEntry entry) async {
  String? phoneNumber = entry.number ?? '';

  if (phoneNumber.isEmpty) {
    return _getUnknownCallerIdData();
  }

  // 1. Check cache
  if (_callerIdDataCache.containsKey(phoneNumber)) {
    return _callerIdDataCache[phoneNumber]!;
  } 
 
    // 2. Check database
    final callerIdDataFromDb = await _database.getCallerIdDataDatabaseByPhoneNumber(phoneNumber);
        // print("manager库if之前: ${callerIdDataFromDb!.countryName}"); 
    if (callerIdDataFromDb != null) {
      // Save to cache
      await _saveCallerIdDataToCache(phoneNumber, callerIdDataFromDb);
       
      return callerIdDataFromDb;
    }
   
      // 3. Fetch from _callerIdService and save to cache and database
   final callerIdData = await _fetchAndSaveCallerIdData(phoneNumber);
  //    print("fetch 数据: $callerIdData.countryName"); 
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
    _callerIdDataCache.remove(_callerIdDataCache.keys.first); // Remove the oldest cache item
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

// 在 CallLogManager 中添加
Future<void> saveCallerIdData(String phoneNumber, CallerIdData callerIdData) async {
    await _database.insertCallerIdData(callerIdData); // 保存到数据库
// 在 CallLogManager 中添加
  if (_callerIdDataCache.length >= 50) {
    _callerIdDataCache.remove(_callerIdDataCache.keys.first); // 移除最旧的缓存项
  }
  _callerIdDataCache[phoneNumber] = callerIdData; 

}


  // Load cached CallerID data from database
  Future<void> loadAllCallerIdData() async {
    try {
      final callerIdDataList = await _database.getAllCallerIdData();
      _callerIdDataCache = {
        for (var data in callerIdDataList)
          data.phoneNumber: data
      };
    } catch (e) {
      //print("Error loading cached caller ID data: $e");
    }
  }

// 读取 _hasInitializedCallLogs
Future<bool> _getHasInitializedCallLogs() async {
  final asyncPrefs = SharedPreferencesAsync();
  return await asyncPrefs.getBool('has_initialized_call_logs') ?? false;
}

// 保存 _hasInitializedCallLogs
Future<void> _saveHasInitializedCallLogs(bool value) async {
  final asyncPrefs = SharedPreferencesAsync();
  await asyncPrefs.setBool('has_initialized_call_logs', value);
}


  Future<int> _getLastSyncTimestamp() async {
    final asyncPrefs = SharedPreferencesAsync();
    return await asyncPrefs.getInt('last_sync_timestamp') ?? 0;
  }

  Future<void> _saveLastSyncTimestamp(int timestamp) async {
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setInt('last_sync_timestamp', timestamp);
  }

  Future<void> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).permissionGranted)),
      );
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).thisAppNeedsAccessToYourCallLogInformation),
          action: SnackBarAction(
            label: S.of(context).grantPermission,
            onPressed: () async {
              status = await Permission.contacts.request();
              if (status.isGranted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).permissionGranted)),
                );
              } else {
                await openAppSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).deniedPermissionCanManuallyEnablePermissionInSetting),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).deniedPermissionCanManuallyEnablePermissionInSetting),
        ),
      );
    }
  }

  void dispose() {
   
    _newCallLogsSubscription?.cancel();
    _callLogController.close();
 //   _database.close();
  }
}



/*

class CallLogManager {
  final _callLogController = BehaviorSubject<List<CallLogEntry>>();
  List<CallLogEntry> _currentLogs = [];
  Map<String, CallerIdData> _callerIdDataCache = {};
  bool _isLoading = false;
  bool _hasInitializedCallLogs = false;
  StreamSubscription<dynamic>? _newCallLogsSubscription;
  final CallerIdService _callerIdService;
  final BuildContext context;

  CallLogManager(this.context, this._callerIdService) {
    _initialize();
  }

  Stream<List<CallLogEntry>> get callLogsStream => _callLogController.stream;
  Map<String, CallerIdData> get callerIdCache => _callerIdDataCache;

  Future<void> _initialize() async {
    final status = await Permission.phone.status;
    if (status.isGranted) {
      await _loadAllCallLogs();
      _setupCallLogListener();
    } else if (status.isDenied) {
      await _requestPhonePermission();
    }
    await loadCachedCallerIdData();
  }


  Future<void> _loadAllCallLogsxx1() async {
  if (_isLoading || _hasInitializedCallLogs) return;

    _isLoading = true;
    try {
      final lastSyncTimestamp = await _getLastSyncTimestamp();
      final Iterable<CallLogEntry> result = await CallLog.query(
        dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
      );
      
      // Sort logs by timestamp in descending order
      _currentLogs = result.toList()
        ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      
      await _saveIncrementalCallLogsToFile(_currentLogs);
      await _preloadCallerIdData();
      
      // Notify UI with new list instance
      if (!_callLogController.isClosed) {
        _callLogController.add(List<CallLogEntry>.from(_currentLogs));
      }
      
      await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
      _hasInitializedCallLogs = true;
    } catch (e) {
      if (!_callLogController.isClosed) {
        _callLogController.addError(e);
      }
    } finally {
      _isLoading = false;
    }
  }


  Future<void> _loadAllCallLogsxx3() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    try {
      final lastSyncTimestamp = await _getLastSyncTimestamp();
      final Iterable<CallLogEntry> result = await CallLog.get();
      
      // Sort logs by timestamp in descending order
      _currentLogs = result.toList()
        ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      
      await _saveIncrementalCallLogsToFile(_currentLogs);
      await _preloadCallerIdData();
      
      // Notify UI with new list instance
      if (!_callLogController.isClosed) {
        _callLogController.add(List<CallLogEntry>.from(_currentLogs));
      }
      
      await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
      _hasInitializedCallLogs = true;
    } catch (e) {
      if (!_callLogController.isClosed) {
        _callLogController.addError(e);
      }
    } finally {
      _isLoading = false;
    }
  }

  // 加载所有通话记录 (页面初始化)
  Future<void> _loadAllCallLogsxxx2() async {
    if (_isLoading || _hasInitializedCallLogs) return; // 避免重复加载

   // setState(() {
      _isLoading = true;
  //  });

    try {
      // 第一次加载时从系统获取所有通话记录
      if (!_hasInitializedCallLogs) {
        final Iterable<CallLogEntry> result = await CallLog.get();
       _currentLogs = result.toList();

        // 将所有通话记录写入文件 (覆盖模式)
        await _saveIncrementalCallLogsToFile(_currentLogs);

        _hasInitializedCallLogs = true; // 标记已经初始化加载过
      } else {
        // 之后从文件加载增量通话记录
        _currentLogs = await _loadIncrementalCallLogsFromFile();
      }
    } catch (e) {
    } finally {
     // setState(() {
        _isLoading = false;
   //   });
    }
  }

Future<void> _loadAllCallLogs() async {
  if (_isLoading) {
    return;
  }

  _isLoading = true;
  try {
    
    // 获取最后同步时间戳
    final lastSyncTimestamp = await _getLastSyncTimestamp();
    
    // 如果是首次加载或者上次同步时间太久远，获取所有记录
    final Iterable<CallLogEntry> result;
    if (!_hasInitializedCallLogs || lastSyncTimestamp == 0) {
      result = await CallLog.get();
    } else {
      // 增量更新
      result = await CallLog.query(
        dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
      );
    }
    
    // 处理新数据
 
      final newLogs = result.toList()
        ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
        
      // 如果是首次加载，直接使用新数据
      if (!_hasInitializedCallLogs) {
        _currentLogs = newLogs;
      } else {
        // 否则合并新旧数据并去重
        final Map<String, CallLogEntry> uniqueLogs = {};
        
        // 添加现有记录到Map
        for (var log in _currentLogs) {
          String key = '${log.timestamp}_${log.number}';
          uniqueLogs[key] = log;
        }
        
        // 添加新记录到Map，自动去重
        for (var log in newLogs) {
          String key = '${log.timestamp}_${log.number}';
          uniqueLogs[key] = log;
        }
        
        // 转换回列表并排序
        _currentLogs = uniqueLogs.values.toList()
          ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      }
      
      await _saveIncrementalCallLogsToFile(_currentLogs);
      await _preloadCallerIdData();
      
      // 确保更新UI
      if (!_callLogController.isClosed) {
        _callLogController.add(List<CallLogEntry>.from(_currentLogs));
      }
  
    
    // 更新同步时间戳和初始化标志
    await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
    _hasInitializedCallLogs = true;
    
  } catch (e) {
    if (!_callLogController.isClosed) {
      _callLogController.addError(e);
    }
  } finally {
    _isLoading = false;
  }
}
  Future<void> _setupCallLogListener() async {
    
    // Cancel existing subscription
    await _newCallLogsSubscription?.cancel();
    
    _newCallLogsSubscription = CallLog.listenNewCallLogs().listen(
      (newCallLog) async {
        await _handleNewCallLog(newCallLog);
      },
      onError: (error) {
        // Retry setup after error
        Future.delayed(const Duration(seconds: 5), _setupCallLogListener);
      },
      cancelOnError: false,  // Don't cancel subscription on error
    );
  }




  Future<void> _handleNewCallLog(CallLogEntry newCallLog) async {
    
    if (newCallLog.number == null) {
      return;
    }

    try {
      // Update CallerID cache
      if (!_callerIdDataCache.containsKey(newCallLog.number)) {
        _callerIdDataCache[newCallLog.number!] = await getCallerIdData(newCallLog);
      }

      // Check for duplicate
      bool isDuplicate = _currentLogs.any((log) => 
        log.timestamp == newCallLog.timestamp && 
        log.number == newCallLog.number
      );

      if (!isDuplicate) {
        
        // Insert at beginning and maintain sort order
        _currentLogs.insert(0, newCallLog);
        _currentLogs.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
        
        await _saveIncrementalCallLogsToFile([newCallLog]);
        
        // Broadcast update with new list instance
        if (!_callLogController.isClosed) {
          _callLogController.add(List<CallLogEntry>.from(_currentLogs));
        }
      } else {
      }
    } catch (e) {
    }
  }

Future<void> refresh() async {
  
  if (_isLoading) {
    return;
  }

  _isLoading = true;
  try {
    final lastSyncTimestamp = await _getLastSyncTimestamp();
    final Iterable<CallLogEntry> result = await CallLog.query(
      dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
    );
    
    // Sort new logs
    final newLogs = result.toList()
      ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    
    // 使用Map合并新旧数据，保留历史数据
    final Map<String, CallLogEntry> uniqueLogs = {};
    
    // 保留现有数据
    for (var log in _currentLogs) {
      String key = '${log.timestamp}_${log.number}';
      uniqueLogs[key] = log;
    }
    
    // 添加新数据
    for (var log in newLogs) {
      String key = '${log.timestamp}_${log.number}';
      uniqueLogs[key] = log;
    }
    
    // 更新列表并排序
    _currentLogs = uniqueLogs.values.toList()
      ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    
    await _saveIncrementalCallLogsToFile(_currentLogs);
    await _preloadCallerIdData();
    
    if (!_callLogController.isClosed) {
      _callLogController.add(List<CallLogEntry>.from(_currentLogs));
    }
    
    await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
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
      final filteredLogs = _currentLogs
          .where((entry) => entry.number == phoneNumber)
          .toList();
      _callLogController.add(filteredLogs);
    } finally {
      _isLoading = false;
    }
  }

  // CallerID 相关方法
  Future<void> _preloadCallerIdData() async {
    await loadCachedCallerIdData();
    
    for (var entry in _currentLogs) {
      if (!_callerIdDataCache.containsKey(entry.number)) {
        _callerIdDataCache[entry.number ?? ''] = 
            await getCallerIdData(entry);
      }
    }
    
    await saveCachedCallerIdData();
  }

  Future<CallerIdData> getCallerIdData(
      CallLogEntry entry) async {
    String? phoneNumber = entry.number ?? '';

    // 解析号码 (使用提取出的函数)
    Map<String, String> parsedData = await parsePhoneNumber(entry.number!);
    String countryCode = parsedData['countryCode']!;
    String e164Number = parsedData['e164Number']!;

    // 使用 Provider 获取当前的 Locale
    final languageCode = currentLocale?.languageCode ?? 'en';

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      // country: countryCode ?? '', // 使用解析出的国家代码
      country: (countryCode).toUpperCase(), // 使用 toUpperCase() 方法
    );



    // 检查 phoneNumber 是否为空
    if (phoneNumber.isEmpty) {
      return CallerIdData(
        phoneNumber: 'Unknown', // 或其他你认为合适的默认值
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

    // 检查缓存
    if (_callerIdDataCache.containsKey(phoneNumber)) {
      return _callerIdDataCache[phoneNumber]!;
    }

    // 如果缓存中不存在数据，则查询数据库
    try {
      CallerIdData callerIdData =
          await _callerIdService.getCallerId(e164Number, dlibLocale);
      // 将查询结果存储到缓存中
      _callerIdDataCache[phoneNumber] = callerIdData;
      saveCachedCallerIdData(); // 保存更新后的数据

      return callerIdData;
    } catch (error) {
      return CallerIdData(
        phoneNumber: phoneNumber,
        countryName: 'locationOther',
        labels: [Label(label: 'Other')],
        name: 'OtherUnknown',
      );
    }
  }


// 从文件加载增量通话记录
Future<void> _saveIncrementalCallLogsToFile(List<CallLogEntry> newCallLogs) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/incremental_call_logs.json';
  final file = File(filePath);
  
  // 读取已有通话记录
  final existingCallLogs = await _loadIncrementalCallLogsFromFile();
  
  // 合并新旧通话记录
  existingCallLogs.addAll(newCallLogs);
  
  // 将合并后的数据写入文件，保持数值类型
  final jsonString = json.encode(existingCallLogs.map((callLog) {
    return {
      'name': callLog.name,
      'number': callLog.number,
      'formattedNumber': callLog.formattedNumber,
      'callType': callLog.callType.toString(),
      // 保持数值类型，不转换为字符串
      'duration': callLog.duration,
      'timestamp': callLog.timestamp,
      'cachedNumberType': callLog.cachedNumberType,
      'cachedNumberLabel': callLog.cachedNumberLabel,
      'cachedMatchedNumber': callLog.cachedMatchedNumber,
      'simDisplayName': callLog.simDisplayName,
      'phoneAccountId': callLog.phoneAccountId,
      'simSlotIndex': callLog.simSlotIndex,
    };
  }).toList());
  
  await file.writeAsString(jsonString);
}

Future<List<CallLogEntry>> _loadIncrementalCallLogsFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/incremental_call_logs.json';
  final file = File(filePath);
  
  if (await file.exists() && await file.length() > 0) {
    final jsonString = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) {
      Map<String, dynamic> convertedMap = Map<String, dynamic>.from(e);
      
      // 将字符串转换为整数
      if (convertedMap['duration'] is String) {
        convertedMap['duration'] = int.tryParse(convertedMap['duration']) ?? 0;
      }
      if (convertedMap['timestamp'] is String) {
        convertedMap['timestamp'] = int.tryParse(convertedMap['timestamp']) ?? 0;
      }
      if (convertedMap['cachedNumberType'] is String) {
        convertedMap['cachedNumberType'] = int.tryParse(convertedMap['cachedNumberType']);
      }
      // 处理 callType，转换为整数
      if (convertedMap['callType'] is String) {
        switch(convertedMap['callType'].toString().toLowerCase()) {
          case 'incoming': convertedMap['callType'] = 0; break;
          case 'outgoing': convertedMap['callType'] = 1; break;
          case 'missed': convertedMap['callType'] = 2; break;
          case 'voicemail': convertedMap['callType'] = 3; break;
          case 'rejected': convertedMap['callType'] = 4; break;
          case 'blocked': convertedMap['callType'] = 5; break;
          case 'answeredexternally': convertedMap['callType'] = 6; break;
          case 'wifiincoming': convertedMap['callType'] = 8; break;
          case 'wifioutgoing': convertedMap['callType'] = 9; break;
          default: convertedMap['callType'] = 7; // unknown
        }
      }
      
      return CallLogEntry.fromMap(convertedMap);
    }).toList();
  }
  return [];
}


// 保存缓存数据到本地文件
  Future<void> saveCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    final jsonData = jsonEncode(_callerIdDataCache);
    await file.writeAsString(jsonData);
  }

// 从本地文件加载缓存数据
  Future<void> loadCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      _callerIdDataCache = (jsonDecode(jsonData) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, CallerIdData.fromJson(value)));
    }
  }

  // 清理资源
  void dispose() {
    // 调试日志
    _newCallLogsSubscription?.cancel();
    _callLogController.close();
  }

  // 获取上次同步时间戳
  Future<int> _getLastSyncTimestamp() async {
    final asyncPrefs = SharedPreferencesAsync();
    return prefs.getInt('last_sync_timestamp') ?? 0;
  }

  // 保存上次同步时间戳
  Future<void> _saveLastSyncTimestamp(int timestamp) async {
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setInt('last_sync_timestamp', timestamp);
  }


//请求权限
  Future<void> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      // 显示 Snackbar 提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).permissionGranted),
        ),
      );
    } else if (status.isDenied) {
      // 权限被拒绝，显示 Snackbar 并再次请求权限
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(S.of(context).thisAppNeedsAccessToYourCallLogInformation),
          action: SnackBarAction(
            label: S.of(context).grantPermission,
            onPressed: () async {
              PermissionStatus status = await Permission.contacts.request();
              if (status.isGranted) {
                // 显示 Snackbar 提示用户
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).permissionGranted),
                  ),
                );
              } else {
                // 再次拒绝，引导用户手动开启
                await openAppSettings();
                // 再次拒绝，显示 Snackbar 提示用户可以在设置中手动开启
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S
                        .of(context)
                        .deniedPermissionCanManuallyEnablePermissionInSetting),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // 权限被永久拒绝，显示 Snackbar 提示用户可以在设置中手动开启
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S
              .of(context)
              .deniedPermissionCanManuallyEnablePermissionInSetting),
        ),
      );
    }
  }






}

*/







/*
class CallLogManager {
  final _callLogController = StreamController<List<CallLogEntry>>.broadcast();
  List<CallLogEntry> _currentLogs = [];
  Map<String, CallerIdData> _callerIdDataCache = {};
  bool _isLoading = false;
  bool _hasInitializedCallLogs = false;
  StreamSubscription<dynamic>? _newCallLogsSubscription;
 final CallerIdService _callerIdService;
final BuildContext context;

  CallLogManager(this.context, this._callerIdService) {
    _initialize();
  }

  Stream<List<CallLogEntry>> get callLogsStream => _callLogController.stream;
  bool get isLoading => _isLoading;
  Map<String, CallerIdData> get callerIdCache => _callerIdDataCache;

  Future<void> _initialize() async {

    final status = await Permission.phone.status;
    if (status.isGranted) {
      await _loadAllCallLogs();
      _setupCallLogListener();
    } else if (status.isDenied) {
      await _requestPhonePermission();
    }
    await loadCachedCallerIdData();
  }




  Future<void> _setupCallLogListener() async {
    _newCallLogsSubscription = CallLog.listenNewCallLogs().listen((newCallLog) async {
      await _handleNewCallLog(newCallLog);
    });
  }

  Future<void> _handleNewCallLog(CallLogEntry newCallLog) async {
    // 从缓存中获取或加载 CallerIdData
    if (!_callerIdDataCache.containsKey(newCallLog.number)) {
      _callerIdDataCache[newCallLog.number ?? ''] = 
          await getCallerIdData(newCallLog);
    }

    // 保存到文件
    await _saveIncrementalCallLogsToFile([newCallLog]);

    // 更新内存中的数据并通知监听者
    _currentLogs.insert(0, newCallLog);
    _callLogController.add(_currentLogs);
  }

  Future<void> _loadAllCallLogs() async {
    if (_isLoading || _hasInitializedCallLogs) return;

    _isLoading = true;
    try {
      if (!_hasInitializedCallLogs) {
        final Iterable<CallLogEntry> result = await CallLog.get();
        _currentLogs = result.toList();
        await _saveIncrementalCallLogsToFile(_currentLogs);
        _hasInitializedCallLogs = true;
      } else {
        _currentLogs = await _loadIncrementalCallLogsFromFile();
      }
      
      await _preloadCallerIdData();
      _callLogController.add(_currentLogs);
    } catch (e) {
      print('Error loading call logs: $e');
      _callLogController.addError(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refresh() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final lastSyncTimestamp = await _getLastSyncTimestamp();
      final Iterable<CallLogEntry> result = await CallLog.query(
        dateTimeFrom: DateTime.fromMillisecondsSinceEpoch(lastSyncTimestamp),
      );
      final newCallLogs = result.toList();

      await _saveIncrementalCallLogsToFile(newCallLogs);
      _currentLogs.addAll(newCallLogs);
      await _saveLastSyncTimestamp(DateTime.now().millisecondsSinceEpoch);
      
      _callLogController.add(_currentLogs);
    } catch (e) {
      print('Error refreshing call logs: $e');
      _callLogController.addError(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> filterByPhoneNumber(String phoneNumber) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final filteredLogs = _currentLogs
          .where((entry) => entry.number == phoneNumber)
          .toList();
      _callLogController.add(filteredLogs);
    } finally {
      _isLoading = false;
    }
  }

  // CallerID 相关方法
  Future<void> _preloadCallerIdData() async {
    await loadCachedCallerIdData();
    
    for (var entry in _currentLogs) {
      if (!_callerIdDataCache.containsKey(entry.number)) {
        _callerIdDataCache[entry.number ?? ''] = 
            await getCallerIdData(entry);
      }
    }
    
    await saveCachedCallerIdData();
  }

  Future<CallerIdData> getCallerIdData(
      CallLogEntry entry) async {
    String? phoneNumber = entry.number ?? '';

    // 解析号码 (使用提取出的函数)
    Map<String, String> parsedData = await parsePhoneNumber(entry.number!);
    String countryCode = parsedData['countryCode']!;
    String e164Number = parsedData['e164Number']!;

    // 使用 Provider 获取当前的 Locale
    final languageCode = currentLocale?.languageCode ?? 'en';

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      // country: countryCode ?? '', // 使用解析出的国家代码
      country: (countryCode).toUpperCase(), // 使用 toUpperCase() 方法
    );



    // 检查 phoneNumber 是否为空
    if (phoneNumber.isEmpty) {
      return CallerIdData(
        phoneNumber: 'Unknown', // 或其他你认为合适的默认值
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

    // 检查缓存
    if (_callerIdDataCache.containsKey(phoneNumber)) {
      return _callerIdDataCache[phoneNumber]!;
    }

    // 如果缓存中不存在数据，则查询数据库
    try {
      CallerIdData callerIdData =
          await _callerIdService.getCallerId(e164Number, dlibLocale);
      // 将查询结果存储到缓存中
      _callerIdDataCache[phoneNumber] = callerIdData;
      saveCachedCallerIdData(); // 保存更新后的数据

      return callerIdData;
    } catch (error) {
      return CallerIdData(
        phoneNumber: phoneNumber,
        countryName: 'locationOther',
        labels: [Label(label: 'Other')],
        name: 'OtherUnknown',
      );
    }
  }


// 从文件加载增量通话记录
Future<void> _saveIncrementalCallLogsToFile(List<CallLogEntry> newCallLogs) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/incremental_call_logs.json';
  final file = File(filePath);
  
  // 读取已有通话记录
  final existingCallLogs = await _loadIncrementalCallLogsFromFile();
  
  // 合并新旧通话记录
  existingCallLogs.addAll(newCallLogs);
  
  // 将合并后的数据写入文件，保持数值类型
  final jsonString = json.encode(existingCallLogs.map((callLog) {
    return {
      'name': callLog.name,
      'number': callLog.number,
      'formattedNumber': callLog.formattedNumber,
      'callType': callLog.callType.toString(),
      // 保持数值类型，不转换为字符串
      'duration': callLog.duration,
      'timestamp': callLog.timestamp,
      'cachedNumberType': callLog.cachedNumberType,
      'cachedNumberLabel': callLog.cachedNumberLabel,
      'cachedMatchedNumber': callLog.cachedMatchedNumber,
      'simDisplayName': callLog.simDisplayName,
      'phoneAccountId': callLog.phoneAccountId,
      'simSlotIndex': callLog.simSlotIndex,
    };
  }).toList());
  
  await file.writeAsString(jsonString);
}

Future<List<CallLogEntry>> _loadIncrementalCallLogsFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/incremental_call_logs.json';
  final file = File(filePath);
  
  if (await file.exists() && await file.length() > 0) {
    final jsonString = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) {
      Map<String, dynamic> convertedMap = Map<String, dynamic>.from(e);
      
      // 将字符串转换为整数
      if (convertedMap['duration'] is String) {
        convertedMap['duration'] = int.tryParse(convertedMap['duration']) ?? 0;
      }
      if (convertedMap['timestamp'] is String) {
        convertedMap['timestamp'] = int.tryParse(convertedMap['timestamp']) ?? 0;
      }
      if (convertedMap['cachedNumberType'] is String) {
        convertedMap['cachedNumberType'] = int.tryParse(convertedMap['cachedNumberType']);
      }
      // 处理 callType，转换为整数
      if (convertedMap['callType'] is String) {
        switch(convertedMap['callType'].toString().toLowerCase()) {
          case 'incoming': convertedMap['callType'] = 0; break;
          case 'outgoing': convertedMap['callType'] = 1; break;
          case 'missed': convertedMap['callType'] = 2; break;
          case 'voicemail': convertedMap['callType'] = 3; break;
          case 'rejected': convertedMap['callType'] = 4; break;
          case 'blocked': convertedMap['callType'] = 5; break;
          case 'answeredexternally': convertedMap['callType'] = 6; break;
          case 'wifiincoming': convertedMap['callType'] = 8; break;
          case 'wifioutgoing': convertedMap['callType'] = 9; break;
          default: convertedMap['callType'] = 7; // unknown
        }
      }
      
      return CallLogEntry.fromMap(convertedMap);
    }).toList();
  }
  return [];
}


// 保存缓存数据到本地文件
  Future<void> saveCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    final jsonData = jsonEncode(_callerIdDataCache);
    await file.writeAsString(jsonData);
  }

// 从本地文件加载缓存数据
  Future<void> loadCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      _callerIdDataCache = (jsonDecode(jsonData) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, CallerIdData.fromJson(value)));
    }
  }

  // 清理资源
  void dispose() {
    _newCallLogsSubscription?.cancel();
    _callLogController.close();
  }

  // 获取上次同步时间戳
  Future<int> _getLastSyncTimestamp() async {
    final asyncPrefs = SharedPreferencesAsync();
    return prefs.getInt('last_sync_timestamp') ?? 0;
  }

  // 保存上次同步时间戳
  Future<void> _saveLastSyncTimestamp(int timestamp) async {
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setInt('last_sync_timestamp', timestamp);
  }


//请求权限
  Future<void> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      // 显示 Snackbar 提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).permissionGranted),
        ),
      );
    } else if (status.isDenied) {
      // 权限被拒绝，显示 Snackbar 并再次请求权限
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(S.of(context).thisAppNeedsAccessToYourCallLogInformation),
          action: SnackBarAction(
            label: S.of(context).grantPermission,
            onPressed: () async {
              PermissionStatus status = await Permission.contacts.request();
              if (status.isGranted) {
                // 显示 Snackbar 提示用户
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).permissionGranted),
                  ),
                );
              } else {
                // 再次拒绝，引导用户手动开启
                await openAppSettings();
                // 再次拒绝，显示 Snackbar 提示用户可以在设置中手动开启
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S
                        .of(context)
                        .deniedPermissionCanManuallyEnablePermissionInSetting),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // 权限被永久拒绝，显示 Snackbar 提示用户可以在设置中手动开启
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S
              .of(context)
              .deniedPermissionCanManuallyEnablePermissionInSetting),
        ),
      );
    }
  }






}

*/