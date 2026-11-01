import 'package:flutter/widgets.dart';

/// Type-safe Internationalization localizations dictionary for Pyro SMS UI
class SmsLocalizations {
  final Locale locale;

  SmsLocalizations(this.locale);

  static SmsLocalizations of(BuildContext context) {
    return Localizations.of<SmsLocalizations>(context, SmsLocalizations) ??
        SmsLocalizations(const Locale('en'));
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'smsProtectionSettingsTitle': 'SMS & Message Protection Settings',
      'permissionFreeScreeningTitle': 'Permission-Free Notification Screening',
      'permissionFreeScreeningSubtitle': 'Screen SMS/RCS notifications via NotificationListenerService',
      'protectedMessagingAppsTitle': 'Protected Messaging Apps',
      'protectedMessagingAppsSubtitle': 'Notifications from selected apps will be analyzed for phishing links and spam.',
      'googleSafeBrowsingTitle': 'Google Safe Browsing Link Protection',
      'googleSafeBrowsingSubtitle': 'Real-time API threat check for malicious and phishing URLs',
      'phishTankOpenPhishTitle': 'OpenPhish & PhishTank Live Feeds',
      'phishTankOpenPhishSubtitle': 'Sync 100,000+ threat domains for O(1) offline and online link checks',
      'virusTotalTitle': 'VirusTotal Multi-Engine Scanner',
      'virusTotalSubtitle': 'Multi-engine deep link threat analysis',
      'otpGuardTitle': '2FA OTP Code Privacy & Auto-Clear Guard',
      'otpGuardSubtitle': 'Mask sensitive 2FA verification codes, auto-expire in 5 min & clear clipboard',
      'bloomFilterTitle': '100k+ Keyword Bloom Filter & AC Automaton',
      'bloomFilterSubtitle': 'Ultra-fast O(n) multi-pattern keyword searching without UI stutter',
      'botAutomationTitle': 'Trigger-Action Automation Workflow',
      'botAutomationSubtitle': 'Auto-trigger Webhook HTTP alerts & message forwarding rules',
      'telephonyFallbackTitle': 'Native Telephony SMS Receiver Fallback',
      'telephonyFallbackSubtitle': 'Direct Android BroadcastReceiver & ContentProvider shim for sideloaded installs',
      'mlSpamScorerTitle': 'On-Device ML Spam Scorer',
      'mlSpamScorerSubtitle': '20-Feature GBT & Complement Naive Bayes scoring model',
      'smsBurstProtectionTitle': 'SMS Burst Protection',
      'smsBurstProtectionSubtitle': 'Auto-block unknown senders sending multiple SMS in 60 seconds',
      'viewEvidenceLogsTitle': 'View Evidence Logs',
      'saveProtectedAppsButton': 'Save Protected Apps',
      'evidenceLogsTitle': 'SMS Spam & Evidence Logs',
      'noEvidenceLogsMessage': 'No evidence logs recorded yet.',
    },
    'zh': {
      'smsProtectionSettingsTitle': '短信与消息防护设置',
      'permissionFreeScreeningTitle': '免权限通知级防护',
      'permissionFreeScreeningSubtitle': '通过 NotificationListenerService 智能识别防护短信/RCS通知',
      'protectedMessagingAppsTitle': '受保护的消息应用',
      'protectedMessagingAppsSubtitle': '来自选中应用的通知将被检测钓鱼链接与垃圾信息',
      'googleSafeBrowsingTitle': 'Google Safe Browsing 网址防护',
      'googleSafeBrowsingSubtitle': '实时 API 校验恶意软件与钓鱼网址',
      'phishTankOpenPhishTitle': 'OpenPhish 与 PhishTank 实时情报',
      'phishTankOpenPhishSubtitle': '同步 10 万+ 威胁域名，离在线 O(1) 极速匹配',
      'virusTotalTitle': 'VirusTotal 多引擎安全扫描',
      'virusTotalSubtitle': '多安全引擎深度网址校验',
      'otpGuardTitle': '2FA 验证码脱敏与剪贴板定时清空',
      'otpGuardSubtitle': '掩码脱敏 2FA 验证码，5 分钟内存销毁与剪贴板自动清空防窃取',
      'bloomFilterTitle': '十万级黑名单 Bloom Filter + AC 自动机',
      'bloomFilterSubtitle': '布隆过滤器与 AC 自动机单次扫描 O(n) 超高速无卡顿检索',
      'botAutomationTitle': 'Trigger-Action 自动化响应工作流',
      'botAutomationSubtitle': '自动触发 Webhook HTTP 告警与短信自动转发',
      'telephonyFallbackTitle': '原生 Telephony 广播与数据库垫片',
      'telephonyFallbackSubtitle': '面向侧载/高权限场景直接对接 Android SMS_RECEIVED 广播',
      'mlSpamScorerTitle': '端侧 ML 垃圾打分模型',
      'mlSpamScorerSubtitle': '20 维 GBT 特征向量与朴素贝叶斯打分',
      'smsBurstProtectionTitle': '短信频次爆破防御',
      'smsBurstProtectionSubtitle': '自动阻断 60 秒内发送多条短信的未知号码爆破',
      'viewEvidenceLogsTitle': '查看拦截证据日志',
      'saveProtectedAppsButton': '保存受保护应用',
      'evidenceLogsTitle': '短信垃圾拦截与证据日志',
      'noEvidenceLogsMessage': '暂无拦截证据日志',
    },
  };

  String get smsProtectionSettingsTitle => _getValue('smsProtectionSettingsTitle');
  String get permissionFreeScreeningTitle => _getValue('permissionFreeScreeningTitle');
  String get permissionFreeScreeningSubtitle => _getValue('permissionFreeScreeningSubtitle');
  String get protectedMessagingAppsTitle => _getValue('protectedMessagingAppsTitle');
  String get protectedMessagingAppsSubtitle => _getValue('protectedMessagingAppsSubtitle');
  String get googleSafeBrowsingTitle => _getValue('googleSafeBrowsingTitle');
  String get googleSafeBrowsingSubtitle => _getValue('googleSafeBrowsingSubtitle');
  String get phishTankOpenPhishTitle => _getValue('phishTankOpenPhishTitle');
  String get phishTankOpenPhishSubtitle => _getValue('phishTankOpenPhishSubtitle');
  String get virusTotalTitle => _getValue('virusTotalTitle');
  String get virusTotalSubtitle => _getValue('virusTotalSubtitle');
  String get otpGuardTitle => _getValue('otpGuardTitle');
  String get otpGuardSubtitle => _getValue('otpGuardSubtitle');
  String get bloomFilterTitle => _getValue('bloomFilterTitle');
  String get bloomFilterSubtitle => _getValue('bloomFilterSubtitle');
  String get botAutomationTitle => _getValue('botAutomationTitle');
  String get botAutomationSubtitle => _getValue('botAutomationSubtitle');
  String get telephonyFallbackTitle => _getValue('telephonyFallbackTitle');
  String get telephonyFallbackSubtitle => _getValue('telephonyFallbackSubtitle');
  String get mlSpamScorerTitle => _getValue('mlSpamScorerTitle');
  String get mlSpamScorerSubtitle => _getValue('mlSpamScorerSubtitle');
  String get smsBurstProtectionTitle => _getValue('smsBurstProtectionTitle');
  String get smsBurstProtectionSubtitle => _getValue('smsBurstProtectionSubtitle');
  String get viewEvidenceLogsTitle => _getValue('viewEvidenceLogsTitle');
  String get saveProtectedAppsButton => _getValue('saveProtectedAppsButton');
  String get evidenceLogsTitle => _getValue('evidenceLogsTitle');
  String get noEvidenceLogsMessage => _getValue('noEvidenceLogsMessage');

  String _getValue(String key) {
    final lang = locale.languageCode;
    return _localizedValues[lang]?[key] ?? _localizedValues['en']![key]!;
  }

  static const LocalizationsDelegate<SmsLocalizations> delegate = _SmsLocalizationsDelegate();
}

class _SmsLocalizationsDelegate extends LocalizationsDelegate<SmsLocalizations> {
  const _SmsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<SmsLocalizations> load(Locale locale) async => SmsLocalizations(locale);

  @override
  bool shouldReload(_SmsLocalizationsDelegate old) => false;
}
