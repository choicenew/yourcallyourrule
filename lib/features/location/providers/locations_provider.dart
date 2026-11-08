import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/location/repositories/location_repository.dart';
import 'package:yourcallyourrule/data/repositories/location_repository_impl.dart';

/// 位置数据状态的Notifier�?
class LocationsNotifier extends AsyncNotifier<List<LocationEntry>> {
  late final LocationRepository _locationRepository;

  @override
  Future<List<LocationEntry>> build() async {
    // 初始化仓�?
    _initRepository();
    // 加载所有位�?
    return _loadLocations();
  }

  void _initRepository() {
    // 获取仓库实例
    _locationRepository = ref.read(locationRepositoryProvider);
  }

  Future<List<LocationEntry>> _loadLocations() async {
    try {
      // 获取所有位�?
      return await _locationRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加位置
  Future<void> addLocation(LocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.save(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新位置
  Future<void> updateLocation(LocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.update(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除位置
  Future<void> deleteLocation(String locationId) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.deleteById(locationId);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// 位置数据提供�?
final locationsProvider = AsyncNotifierProvider<LocationsNotifier, List<LocationEntry>>(() {
  return LocationsNotifier();
});


