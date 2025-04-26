import 'package:geolocator/geolocator.dart';

import '../../../../lib/infrastructure/base_service_impl.dart';

/// 位置服务实现
/// 负责获取和处理位置信息
class LocationServiceImpl extends BaseServiceImpl {
  /// 获取当前位置
  Future<Position?> getCurrentLocation() async {
    try {
      // 检查位置服务是否启用
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logOperation('位置服务未启用');
        return null;
      }
      
      // 检查位置权限
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logOperation('位置权限被拒绝');
          return null;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        logOperation('位置权限被永久拒绝');
        return null;
      }
      
      // 获取位置
      final position = await Geolocator.getCurrentPosition();
      logOperation('获取当前位置', details: '${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      logOperation('获取位置失败', details: e.toString());
      return null;
    }
  }
  
  /// 计算两点之间的距离（米）
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
  
  /// 获取位置流
  Stream<Position> getPositionStream() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}