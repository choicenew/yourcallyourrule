import 'package:plugindemo/core/base/base_entity.dart';

class PluginEntry extends BaseEntity {
  final String name;
  final String url;
  final String version;
  final String description;
  final bool isEnabled;
  final int pluginOrder;
  final bool isAutoUpdate;
  final Map<String, dynamic> config;

  const PluginEntry({
    required super.id,
    required this.name,
    required this.url,
    required this.version,
    required this.description,
    required this.isEnabled,
    required this.pluginOrder,
    this.isAutoUpdate = false,
    this.config = const {},
  });

  factory PluginEntry.fromMap(Map<String, dynamic> map) {
    return PluginEntry(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      version: map['version'],
      description: map['description'] ?? '',
      isEnabled: map['isEnabled'] == 1,
      pluginOrder: map['pluginOrder'],
      isAutoUpdate: map['isAutoUpdate'] == 1,
      config:
          map['config'] != null ? Map<String, dynamic>.from(map['config']) : {},
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'version': version,
      'description': description,
      'isEnabled': isEnabled ? 1 : 0,
      'pluginOrder': pluginOrder,
      'isAutoUpdate': isAutoUpdate ? 1 : 0,
      'config': config,
    };
  }

  PluginEntry copyWith({
    String? id,
    String? name,
    String? url,
    String? version,
    String? description,
    bool? isEnabled,
    int? pluginOrder,
    bool? isAutoUpdate,
    Map<String, dynamic>? config,
  }) {
    return PluginEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      version: version ?? this.version,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      pluginOrder: pluginOrder ?? this.pluginOrder,
      isAutoUpdate: isAutoUpdate ?? this.isAutoUpdate,
      config: config ?? this.config,
    );
  }
}
