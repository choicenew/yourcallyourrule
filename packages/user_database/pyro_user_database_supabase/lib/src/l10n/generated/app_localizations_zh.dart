// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get supabaseSyncTitle => 'Supabase 云端数据库同步';

  @override
  String get projectUrlLabel => 'Supabase 项目地址 URL';

  @override
  String get projectUrlHint => 'https://xyz.supabase.co';

  @override
  String get anonKeyLabel => 'Anon 匿名 / API 密钥';

  @override
  String get anonKeyHint => 'eyJhbGciOiJIUzI1NiIsIn...';

  @override
  String get connectionStringLabel => 'Postgres 数据库连接串';

  @override
  String get saveConfigButton => '保存配置';

  @override
  String get testConnectionButton => '测试物理连通性';

  @override
  String get connectionSuccess => 'Supabase 数据库物理连通成功！';

  @override
  String get connectionFailed => '无法连接至 Supabase 数据库，请检查配置';
}
