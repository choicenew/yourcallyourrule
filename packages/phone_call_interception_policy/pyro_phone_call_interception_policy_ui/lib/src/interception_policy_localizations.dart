import 'package:flutter/widgets.dart';

/// Type-safe Internationalization localizations dictionary for Pyro Interception Policy UI
class InterceptionPolicyLocalizations {
  final Locale locale;

  InterceptionPolicyLocalizations(this.locale);

  static InterceptionPolicyLocalizations of(BuildContext context) {
    return Localizations.of<InterceptionPolicyLocalizations>(context, InterceptionPolicyLocalizations) ??
        InterceptionPolicyLocalizations(const Locale('en'));
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'actionAllow': 'Allow',
      'actionAnswerThenHangup': 'Answer & Hangup',
      'actionSilence': 'Silence',
      'actionEndCall': 'End Call',
      'labelPolicyTitle': 'Label Interception Rules',
      'labelPolicySubtitle': 'Execute custom interception actions based on caller identity tags',
      'noConfiguredLabels': 'No custom label actions configured. Global default action will apply.',
      'deleteRuleTooltip': 'Delete this rule',
      'addLabelRuleTitle': 'Add Label Action Rule',
      'selectExistingLabel': 'Select existing tag:',
      'pleaseSelectLabel': 'Please select a tag',
      'customLabelName': 'Custom Tag Name',
      'customLabelHint': 'e.g. Spam, Telemarketing, Delivery, Support',
      'selectActionPrompt': 'Select action when tag matches:',
      'cancel': 'Cancel',
      'save': 'Save',
      'add': 'Add',
      'emergencyExemptionTitle': 'Emergency Exemption Guard',
      'emergencyExemptionSubtitle': 'Temporarily allow all incoming calls unconditionally after calling emergency services',
      'emergencyExemptionActiveWithTime': 'Emergency exemption active ({minutes} min remaining)',
      'emergencyExemptionActive': 'Emergency exemption active. Incoming calls will connect unconditionally.',
      'durationTitle': 'Exemption Duration Window',
      'durationSubtitle': 'Time window to keep allowing incoming calls after emergency dial',
      'duration15Min': '15 minutes',
      'duration30Min': '30 minutes (Recommended)',
      'duration1Hour': '1 hour',
      'duration2Hours': '2 hours',
      'customEmergencyNumbers': 'Custom Emergency Numbers ({count})',
      'customEmergencySubtitle': 'Add local EMS, community security, family emergency numbers',
      'addEmergencyNumberButton': 'Add Number',
      'addEmergencyNumberTitle': 'Add Emergency Number',
      'addEmergencyNumberDesc': 'Enter local emergency contact numbers (community rescue, station, dispatch, etc.):',
      'emergencyPhoneLabel': 'Emergency Phone Number',
      'emergencyPhoneHint': 'e.g. 911, 112, 999, 120',
      'noCustomEmergencyNumbers': 'No custom emergency numbers added yet. Tap top right to add.',
      'viewGlobalPresetNumbers': 'View Global Built-in Emergency Directory ({count})',
    },
    'zh': {
      'actionAllow': '放行 (Allow)',
      'actionAnswerThenHangup': '接通后挂断 (Answer & Hangup)',
      'actionSilence': '静音不接听 (Silence)',
      'actionEndCall': '直接挂断 (End Call)',
      'labelPolicyTitle': '标签个性化拦截规则',
      'labelPolicySubtitle': '针对识别到的不同身份标签，执行定制化的接听或拦截处置',
      'noConfiguredLabels': '暂未配置个性化标签处置，将按全局默认策略执行',
      'deleteRuleTooltip': '删除此规则',
      'addLabelRuleTitle': '添加标签处置规则',
      'selectExistingLabel': '选择已有标签：',
      'pleaseSelectLabel': '请选择标签',
      'customLabelName': '自定义标签名称',
      'customLabelHint': '例如: 骚扰、催收、外卖、客服等',
      'selectActionPrompt': '选择命中该标签时的处置动作：',
      'cancel': '取消',
      'save': '保存',
      'add': '添加',
      'emergencyExemptionTitle': '紧急呼叫放行防护',
      'emergencyExemptionSubtitle': '拨打紧急求助电话后，限时无条件放行所有来电',
      'emergencyExemptionActiveWithTime': '紧急豁免保护生效中 (剩余 {minutes} 分钟)',
      'emergencyExemptionActive': '紧急豁免保护生效中，来电将无条件直接接听',
      'durationTitle': '放行豁免持续时长',
      'durationSubtitle': '拨通后保持放行的时间窗口',
      'duration15Min': '15 分钟',
      'duration30Min': '30 分钟 (推荐)',
      'duration1Hour': '1 小时',
      'duration2Hours': '2 小时',
      'customEmergencyNumbers': '自定义紧急号码 ({count})',
      'customEmergencySubtitle': '可添加当地急救、社区、家庭等重要号码',
      'addEmergencyNumberButton': '添加号码',
      'addEmergencyNumberTitle': '添加紧急号码',
      'addEmergencyNumberDesc': '输入您所在地区的当地紧急电话（如社区求助站、保卫处、专线急救电话等）：',
      'emergencyPhoneLabel': '紧急电话号码',
      'emergencyPhoneHint': '例如: 120, 119, 010-12345',
      'noCustomEmergencyNumbers': '暂未添加自定义紧急电话，点击右上角快速添加',
      'viewGlobalPresetNumbers': '查看全球内置紧急号码库 ({count} 个)',
    },
  };

  String get actionAllow => _getValue('actionAllow');
  String get actionAnswerThenHangup => _getValue('actionAnswerThenHangup');
  String get actionSilence => _getValue('actionSilence');
  String get actionEndCall => _getValue('actionEndCall');
  String get labelPolicyTitle => _getValue('labelPolicyTitle');
  String get labelPolicySubtitle => _getValue('labelPolicySubtitle');
  String get noConfiguredLabels => _getValue('noConfiguredLabels');
  String get deleteRuleTooltip => _getValue('deleteRuleTooltip');
  String get addLabelRuleTitle => _getValue('addLabelRuleTitle');
  String get selectExistingLabel => _getValue('selectExistingLabel');
  String get pleaseSelectLabel => _getValue('pleaseSelectLabel');
  String get customLabelName => _getValue('customLabelName');
  String get customLabelHint => _getValue('customLabelHint');
  String get selectActionPrompt => _getValue('selectActionPrompt');
  String get cancel => _getValue('cancel');
  String get save => _getValue('save');
  String get add => _getValue('add');
  String get emergencyExemptionTitle => _getValue('emergencyExemptionTitle');
  String get emergencyExemptionSubtitle => _getValue('emergencyExemptionSubtitle');
  String emergencyExemptionActiveWithTime(int minutes) =>
      _getValue('emergencyExemptionActiveWithTime').replaceAll('{minutes}', minutes.toString());
  String get emergencyExemptionActive => _getValue('emergencyExemptionActive');
  String get durationTitle => _getValue('durationTitle');
  String get durationSubtitle => _getValue('durationSubtitle');
  String get duration15Min => _getValue('duration15Min');
  String get duration30Min => _getValue('duration30Min');
  String get duration1Hour => _getValue('duration1Hour');
  String get duration2Hours => _getValue('duration2Hours');
  String customEmergencyNumbers(int count) =>
      _getValue('customEmergencyNumbers').replaceAll('{count}', count.toString());
  String get customEmergencySubtitle => _getValue('customEmergencySubtitle');
  String get addEmergencyNumberButton => _getValue('addEmergencyNumberButton');
  String get addEmergencyNumberTitle => _getValue('addEmergencyNumberTitle');
  String get addEmergencyNumberDesc => _getValue('addEmergencyNumberDesc');
  String get emergencyPhoneLabel => _getValue('emergencyPhoneLabel');
  String get emergencyPhoneHint => _getValue('emergencyPhoneHint');
  String get noCustomEmergencyNumbers => _getValue('noCustomEmergencyNumbers');
  String viewGlobalPresetNumbers(int count) =>
      _getValue('viewGlobalPresetNumbers').replaceAll('{count}', count.toString());

  String _getValue(String key) {
    final lang = locale.languageCode;
    return _localizedValues[lang]?[key] ?? _localizedValues['en']![key] ?? key;
  }

  static const LocalizationsDelegate<InterceptionPolicyLocalizations> delegate =
      _InterceptionPolicyLocalizationsDelegate();
}

class _InterceptionPolicyLocalizationsDelegate
    extends LocalizationsDelegate<InterceptionPolicyLocalizations> {
  const _InterceptionPolicyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<InterceptionPolicyLocalizations> load(Locale locale) async =>
      InterceptionPolicyLocalizations(locale);

  @override
  bool shouldReload(_InterceptionPolicyLocalizationsDelegate old) => false;
}

