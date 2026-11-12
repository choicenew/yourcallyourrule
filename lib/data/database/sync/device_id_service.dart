import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'device_id_service.g.dart';

/// DeviceIdService Provider (主 App 极简设备服务兼容层)
@Riverpod(keepAlive: true)
DeviceIdService deviceIdService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return DeviceIdService(configRepository);
}

/// 设备节点角色
enum DeviceRole {
  master,
  slave,
  unknown,
}

/// 设备节点数据与抽象标识
class DeviceNode {
  final String deviceId;
  final String deviceName;
  final DeviceRole role;
  final DateTime lastHeartbeatTime;

  const DeviceNode({
    required this.deviceId,
    required this.deviceName,
    this.role = DeviceRole.master,
    required this.lastHeartbeatTime,
  });
}

/// 兼容转接服务：提供设备标识与节点查询，核心设备角色与状态托管至 Device Master Slave Hub
class DeviceIdService {
  final ConfigRepository _configRepository;

  static const String _configKey = 'config_device_id';
  static const String _idKey = 'config_id';

  const DeviceIdService(this._configRepository);

  /// 获取设备的唯一标识
  Future<String> getDeviceId() async {
    final config = await _configRepository.getConfig(_configKey);
    final deviceId = config?[_idKey] as String?;

    if (deviceId != null && deviceId.isNotEmpty) {
      return deviceId;
    }

    const newId = 'local_primary_device';
    await _configRepository.saveConfig(_configKey, {_idKey: newId});
    return newId;
  }

  /// 构建并返回当前设备的 DeviceNode 节点实体
  Future<DeviceNode> getDeviceNode({String? name}) async {
    final id = await getDeviceId();
    return DeviceNode(
      deviceId: id,
      deviceName: name ?? 'Pyro Phone Node',
      role: DeviceRole.master,
      lastHeartbeatTime: DateTime.now(),
    );
  }
}