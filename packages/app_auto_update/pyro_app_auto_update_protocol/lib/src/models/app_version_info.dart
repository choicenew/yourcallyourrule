import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_info.freezed.dart';
part 'app_version_info.g.dart';

/// 纯数据驱动版本更新信息强实体 (AppVersionInfo)
@freezed
abstract class AppVersionInfo with _$AppVersionInfo {
  const AppVersionInfo._();

  const factory AppVersionInfo({
    required String latestVersion,
    required int versionCode,
    required String downloadUrl,
    String? releaseNotes,
    @Default(false) bool isForceUpdate,
  }) = _AppVersionInfo;

  factory AppVersionInfo.fromJson(Map<String, dynamic> json) => _$AppVersionInfoFromJson(json);

  factory AppVersionInfo.fromMap(Map<String, dynamic> map) => AppVersionInfo.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
