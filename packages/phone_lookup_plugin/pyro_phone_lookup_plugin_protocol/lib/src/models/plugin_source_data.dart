import 'package:freezed_annotation/freezed_annotation.dart';

part 'plugin_source_data.freezed.dart';
part 'plugin_source_data.g.dart';

/// 网页 JS 插件查号抓取强实体 (PluginSourceData)
@freezed
abstract class PluginSourceData with _$PluginSourceData {
  const PluginSourceData._();

  const factory PluginSourceData({
    String? predefinedLabel,
    String? sourceLabel,
    String? avatar,
    int? count,
    String? province,
    String? city,
    String? carrier,
    String? name,
    String? phoneNumber,
    @Default('none') String actionName,
  }) = _PluginSourceData;

  factory PluginSourceData.fromJson(Map<String, dynamic> json) => _$PluginSourceDataFromJson(json);

  factory PluginSourceData.fromMap(Map<String, dynamic> map) => PluginSourceData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  String get id => phoneNumber ?? name ?? '';
}
