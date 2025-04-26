import 'package:yourcallyourrule/core/base/base_entity.dart';

class PluginEntry extends BaseEntity {
  final String name;
  final String url;
  final String version;
  final bool isEnabled;
  final int pluginOrder;
  final bool isAutoUpdate;

  const PluginEntry({
    required super.id,
    required this.name,
    required this.url,
    required this.version,
    required this.isEnabled,
    required this.pluginOrder,
    this.isAutoUpdate = false,
  });

  factory PluginEntry.fromMap(Map<String, dynamic> map) {
    return PluginEntry(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      version: map['version'],
      isEnabled: map['isEnabled'] == 1,
      pluginOrder: map['pluginOrder'],
      isAutoUpdate: map['isAutoUpdate'] == 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'version': version,
      'isEnabled': isEnabled ? 1 : 0,
      'pluginOrder': pluginOrder,
      'isAutoUpdate': isAutoUpdate ? 1 : 0,
    };
  }

  PluginEntry copyWith({
    String? id,
    String? name,
    String? url,
    String? version,
    bool? isEnabled,
    int? pluginOrder,
    bool? isAutoUpdate,
  }) {
    return PluginEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      version: version ?? this.version,
      isEnabled: isEnabled ?? this.isEnabled,
      pluginOrder: pluginOrder ?? this.pluginOrder,
      isAutoUpdate: isAutoUpdate ?? this.isAutoUpdate,
    );
  }
}