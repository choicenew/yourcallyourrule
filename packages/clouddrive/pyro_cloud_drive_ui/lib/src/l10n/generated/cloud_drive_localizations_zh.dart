// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cloud_drive_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class CloudDriveLocalizationsZh extends CloudDriveLocalizations {
  CloudDriveLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get cloudSettingsTitle => '云端网盘设置';

  @override
  String get encryptionTitle => '端到端防泄漏加密';

  @override
  String get encryptionSubtitle => '使用主密码加密备份与同步数据';

  @override
  String get encryptionEnabled => '已开启端到端加密';

  @override
  String get encryptionDisabled => '加密未开启';

  @override
  String get configuredDrives => '已配置网盘';

  @override
  String get noDrivesRegistered => '暂未连接任何网盘服务';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get saveAndEnable => '保存并开启加密';

  @override
  String get setPasswordTitle => '设置主加密密码';

  @override
  String get setPasswordDescription => '此密码将用于对所有云端同步备份文件进行高强度加解密';

  @override
  String get masterPasswordLabel => '主加密密码';

  @override
  String get passwordEmptyError => '密码不能为空';

  @override
  String get syncNow => '立即同步';

  @override
  String get settings => '设置';

  @override
  String get connected => '已连接';

  @override
  String get disconnected => '未连接';

  @override
  String lastSynced(String time) {
    return '上次同步: $time';
  }
}
