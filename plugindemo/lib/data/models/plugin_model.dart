import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/data/models/base_model.dart';

class PluginModel extends BaseModel<PluginEntry> {
  final String name;
  final String url;
  final String version;
  final String description;
  final bool isEnabled;
  final int pluginOrder;
  final bool isAutoUpdate;
  final Map<String, dynamic> config;

  const PluginModel({
    required super.id,
    required this.name,
    required this.url,
    required this.version,
    required this.description,
    required this.isEnabled,
    required this.pluginOrder,
    required this.isAutoUpdate,
    this.config = const {},
  });

  factory PluginModel.fromMap(Map<String, dynamic> map) {
    return PluginModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      version: map['version'],
      description: map['description'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      pluginOrder: map['pluginOrder'] ?? 0,
      isAutoUpdate: (map['isAutoUpdate'] ?? 0) == 1,
      config:
          map['config'] != null ? Map<String, dynamic>.from(map['config']) : {},
    );
  }

  factory PluginModel.fromEntity(PluginEntry entity) {
    return PluginModel(
      id: entity.id,
      name: entity.name,
      url: entity.url,
      version: entity.version,
      description: entity.description,
      isEnabled: entity.isEnabled,
      pluginOrder: entity.pluginOrder,
      isAutoUpdate: entity.isAutoUpdate,
      config: entity.config,
    );
  }

  @override
  PluginEntry toEntity() {
    return PluginEntry(
      id: id,
      name: name,
      url: url,
      version: version,
      description: description,
      isEnabled: isEnabled,
      pluginOrder: pluginOrder,
      isAutoUpdate: isAutoUpdate,
      config: config,
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
}
