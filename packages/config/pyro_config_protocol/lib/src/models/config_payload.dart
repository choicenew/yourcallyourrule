/// 标准配置全量快照与云同步负载数据体契约
class ConfigBackupPayload {
  final String type;
  final int version;
  final int timestamp;
  final Map<String, dynamic> data;

  const ConfigBackupPayload({
    this.type = 'config_backup',
    this.version = 1,
    required this.timestamp,
    required this.data,
  });

  /// 转为纯基础 Map 结构，与 clouddrive / 文件 I/O 实现 100% 零依赖传输
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'version': version,
      'timestamp': timestamp,
      'data': data,
    };
  }

  factory ConfigBackupPayload.fromMap(Map<String, dynamic> map) {
    return ConfigBackupPayload(
      type: map['type'] as String? ?? 'config_backup',
      version: (map['version'] as num?)?.toInt() ?? 1,
      timestamp: (map['timestamp'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch,
      data: map['data'] as Map<String, dynamic>? ?? <String, dynamic>{},
    );
  }
}
