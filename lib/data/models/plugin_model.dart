import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/data/models/base_model.dart';


class PluginModel extends BaseModel<PluginEntry> {
  final String name;
  final String url;
  final String version;
  final String description;
  final bool isEnabled;
  final int pluginOrder;
  final bool isAutoUpdate;

  const PluginModel({
    required super.id,
    required this.name,
    required this.url,
    required this.version,
    required this.description,
    required this.isEnabled,
    required this.pluginOrder,
    required this.isAutoUpdate,
  });

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
    };
  }
}