// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get cloudSettingsTitle => '云盘与同步设置';

  @override
  String get encryptionTitle => '端到端加密 (E2EE)';

  @override
  String get encryptionSubtitle => '在上传前使用 AES-256 加密所有备份与文件';

  @override
  String get encryptionEnabled => '已启用 (AES-256)';

  @override
  String get encryptionDisabled => '未启用';

  @override
  String get configuredDrives => '已配置的云盘服务';

  @override
  String get noDrivesRegistered => '暂未注册任何云盘服务';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get saveAndEnable => '保存并启用';

  @override
  String get setPasswordTitle => '设置端到端加密主密码';

  @override
  String get setPasswordDescription => '你的数据库备份和文件在上传到云端前将使用 AES-256 进行本地加密。';

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
  String get disconnected => '已断开';

  @override
  String lastSynced(String time) {
    return '上次同步: $time';
  }
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get cloudSettingsTitle => '云盘与同步设置';

  @override
  String get encryptionTitle => '端到端加密 (E2EE)';

  @override
  String get encryptionSubtitle => '在上传前使用 AES-256 加密所有备份与文件';

  @override
  String get encryptionEnabled => '已启用 (AES-256)';

  @override
  String get encryptionDisabled => '未启用';

  @override
  String get configuredDrives => '已配置的云盘服务';

  @override
  String get noDrivesRegistered => '暂未注册任何云盘服务';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get saveAndEnable => '保存并启用';

  @override
  String get setPasswordTitle => '设置端到端加密主密码';

  @override
  String get setPasswordDescription => '你的数据库备份和文件在上传到云端前将使用 AES-256 进行本地加密。';

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
  String get disconnected => '已断开';

  @override
  String lastSynced(String time) {
    return '上次同步: $time';
  }
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get cloudSettingsTitle => '雲端硬碟與同步設定';

  @override
  String get encryptionTitle => '端到端加密 (E2EE)';

  @override
  String get encryptionSubtitle => '在上傳前使用 AES-256 加密所有備份與檔案';

  @override
  String get encryptionEnabled => '已啟用 (AES-256)';

  @override
  String get encryptionDisabled => '未啟用';

  @override
  String get configuredDrives => '已設置的雲端硬碟';

  @override
  String get noDrivesRegistered => '未連接雲端硬碟';

  @override
  String get cancel => '取消';

  @override
  String get save => '存儲';

  @override
  String get saveAndEnable => '存儲並啟用';

  @override
  String get setPasswordTitle => '設置 E2EE 主密碼';

  @override
  String get setPasswordDescription => '您的備份在上傳前將使用 AES-256 加密。';

  @override
  String get masterPasswordLabel => '主密碼';

  @override
  String get passwordEmptyError => '密碼不得為空';

  @override
  String get syncNow => '立即同步';

  @override
  String get settings => '設置';

  @override
  String get connected => '已連接';

  @override
  String get disconnected => '已斷開連接';

  @override
  String lastSynced(String time) {
    return '上次同步：$time';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get cloudSettingsTitle => '雲端硬碟與同步設定';

  @override
  String get encryptionTitle => '端到端加密 (E2EE)';

  @override
  String get encryptionSubtitle => '在上傳前使用 AES-256 加密所有備份與檔案';

  @override
  String get encryptionEnabled => '已啟用 (AES-256)';

  @override
  String get encryptionDisabled => '未啟用';

  @override
  String get configuredDrives => '已設定的雲端硬碟';

  @override
  String get noDrivesRegistered => '未連線雲端硬碟';

  @override
  String get cancel => '取消';

  @override
  String get save => '儲存';

  @override
  String get saveAndEnable => '儲存並啟用';

  @override
  String get setPasswordTitle => '設定 E2EE 主密碼';

  @override
  String get setPasswordDescription => '您的備份在上傳前將使用 AES-256 加密。';

  @override
  String get masterPasswordLabel => '主密碼';

  @override
  String get passwordEmptyError => '密碼不得為空';

  @override
  String get syncNow => '立即同步';

  @override
  String get settings => '設定';

  @override
  String get connected => '已連線';

  @override
  String get disconnected => '已中斷連線';

  @override
  String lastSynced(String time) {
    return '上次同步：$time';
  }
}
