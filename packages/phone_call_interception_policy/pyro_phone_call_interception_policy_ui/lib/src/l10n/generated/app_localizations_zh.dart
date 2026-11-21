// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get actionAllow => '放行 (Allow)';

  @override
  String get actionAnswerThenHangup => '接通后挂断 (Answer & Hangup)';

  @override
  String get actionSilence => '静音不接听 (Silence)';

  @override
  String get actionEndCall => '直接挂断 (End Call)';

  @override
  String get labelPolicyTitle => '标签个性化拦截规则';

  @override
  String get labelPolicySubtitle => '针对识别到的不同身份标签，执行定制化的接听或拦截处置';

  @override
  String get noConfiguredLabels => '暂未配置个性化标签处置，将按全局默认策略执行';

  @override
  String get deleteRuleTooltip => '删除此规则';

  @override
  String get addLabelRuleTitle => '添加标签处置规则';

  @override
  String get selectExistingLabel => '选择已有标签：';

  @override
  String get pleaseSelectLabel => '请选择标签';

  @override
  String get customLabelName => '自定义标签名称';

  @override
  String get customLabelHint => '例如: 骚扰、催收、外卖、客服等';

  @override
  String get selectActionPrompt => '选择命中该标签时的处置动作：';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get add => '添加';

  @override
  String get emergencyExemptionTitle => '紧急呼叫放行防护';

  @override
  String get emergencyExemptionSubtitle => '拨打紧急求助电话后，限时无条件放行所有来电';

  @override
  String emergencyExemptionActiveWithTime(int minutes) {
    return '紧急豁免保护生效中 (剩余 $minutes 分钟)';
  }

  @override
  String get emergencyExemptionActive => '紧急豁免保护生效中，来电将无条件直接接听';

  @override
  String get durationTitle => '放行豁免持续时长';

  @override
  String get durationSubtitle => '拨通后保持放行的时间窗口';

  @override
  String get duration15Min => '15 分钟';

  @override
  String get duration30Min => '30 分钟 (推荐)';

  @override
  String get duration1Hour => '1 小时';

  @override
  String get duration2Hours => '2 小时';

  @override
  String customEmergencyNumbers(int count) {
    return '自定义紧急号码 ($count)';
  }

  @override
  String get customEmergencySubtitle => '可添加当地急救、社区、家庭等重要号码';

  @override
  String get addEmergencyNumberButton => '添加号码';

  @override
  String get addEmergencyNumberTitle => '添加紧急号码';

  @override
  String get addEmergencyNumberDesc => '输入您所在地区的当地紧急电话（如社区求助站、保卫处、专线急救电话等）：';

  @override
  String get emergencyPhoneLabel => '紧急电话号码';

  @override
  String get emergencyPhoneHint => '例如: 120, 119, 010-12345';

  @override
  String get noCustomEmergencyNumbers => '暂未添加自定义紧急电话，点击右上角快速添加';

  @override
  String viewGlobalPresetNumbers(int count) {
    return '查看全球内置紧急号码库 ($count 个)';
  }
}
