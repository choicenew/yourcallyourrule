// 文件路径: lib/features/location/services/location_sync_service.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo; // 别名

/// 归属地同步服务
/// 它的唯一职责是监听 CallerIdService 的数据流，
/// 并将识别出的归属地信息持久化到 Location 数据库中。
class LocationSyncService {
  final CallerIdService _callerIdService;
  final LocationService _locationService;
  StreamSubscription<CallerIdData>? _subscription;

  LocationSyncService(this._callerIdService, this._locationService);

  /// 开始监听和同步
  void start() {
    // 先取消旧的监听，防止重复
    _subscription?.cancel();
    
    // 监听 callerIdStream
    _subscription = _callerIdService.callerIdStream.listen(_handleCallerIdData);
  }

  /// 处理接收到的 CallerIdData
  Future<void> _handleCallerIdData(CallerIdData data) async {
    // 检查是否有归属地信息，并且该信息不是 "Unknown" 或空的
    if (data.region != null && data.region!.isNotEmpty && data.region != 'Unknown') {
      
      // 检查数据库中是否已存在该号码的记录
      final existingEntry = await _locationService.getByPhoneNumber(data.phoneNumber.value);
      
      // 如果不存在，我们就保存它
      if (existingEntry == null) {
        final locationEntry = LocationEntry(
          id: const Uuid().v4(),
          phoneNumber: data.phoneNumber,

          // 从 CallerIdData 中获取所有相关信息
          region: data.region,
          countryName: data.countryName,
          carrier: data.carrier,
          numberType: data.numberType,
        );
        
        // 调用 LocationService 的方法来保存数据
        await _locationService.saveLocation(locationEntry);

        debugPrint('[LocationSyncService] Saved new location for ${data.phoneNumber.value}: ${data.region}');
      }
    }
  }

  /// 停止监听
  void dispose() {
    _subscription?.cancel();
  }
}