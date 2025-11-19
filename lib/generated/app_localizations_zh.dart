// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutContactSubscription => '关于联系人订阅';

  @override
  String get aboutLabels => '关于标签';

  @override
  String get aboutPhoneSubscriptionRules => '关于电话订阅规则';

  @override
  String get aboutPhoneSubscriptions => '关于电话订阅';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      '通过 URL 订阅电话规则列表，自动更新规则。支持 JSON、CSV 格式的规则文件。';

  @override
  String get aboutSmsFilter => '关于短信过滤';

  @override
  String get aboutSmsSubscriptionRules => '关于短信订阅规则';

  @override
  String get aboutSubtitle => '应用版本和法律信息';

  @override
  String get aboutTitle => '关于';

  @override
  String get action => '操作';

  @override
  String get actionAll => '全部';

  @override
  String get actionAllow => '允许';

  @override
  String get actionBlock => '阻止';

  @override
  String get actionFilterAll => '全部过滤';

  @override
  String get actionFilterTitle => '按操作类型过滤';

  @override
  String get actionFilterTooltip => '操作过滤器';

  @override
  String get actionNone => '无操作';

  @override
  String get actionSilence => '静音';

  @override
  String actionTag(Object actionType) {
    return '操作: $actionType';
  }

  @override
  String get actionType => '操作类型';

  @override
  String get actionUnknown => '未知';

  @override
  String get add => '添加';

  @override
  String get addAllowedBlockedRule => '添加允许/阻止规则';

  @override
  String get addAllowSubscription => '添加允许订阅';

  @override
  String get addBlockSubscription => '添加阻止订阅';

  @override
  String get addContactButton => '添加联系人';

  @override
  String addContactFailed(Object error) {
    return '添加联系人失败: $error';
  }

  @override
  String get addedToAllowedRules => '已添加到允许规则';

  @override
  String get addedToBlacklist => '已添加到黑名单';

  @override
  String get addedToBlockedRules => '已添加到阻止规则';

  @override
  String get addedToFavoriteContacts => '已添加到收藏联系人';

  @override
  String get addedToFavorites => '已添加到收藏联系人';

  @override
  String get addedToWhitelist => '已添加到白名单';

  @override
  String get addFavorite => '添加收藏';

  @override
  String get addFilter => '添加过滤器';

  @override
  String get addLabel => '添加标签';

  @override
  String get addLabelButton => '添加标签';

  @override
  String addLabelFailed(Object error) {
    return '添加标签失败: $error';
  }

  @override
  String get addLabelToCall => '为通话记录添加标签';

  @override
  String get addName => '添加名称';

  @override
  String get addNoneSubscription => '添加无订阅';

  @override
  String get addOrEditContactInfo => '用于添加或编辑联系人信息';

  @override
  String get addPhoneMark => '添加电话标记';

  @override
  String get addPhoneNumberRule => '添加电话号码规则';

  @override
  String get addPlugin => '添加插件';

  @override
  String get addPluginFailed => '添加插件失败';

  @override
  String addPluginFailedWithError(Object error) {
    return '添加插件失败: $error';
  }

  @override
  String get addPluginFromLocalFile => '从本地文件添加插件';

  @override
  String get addPluginFromUrl => '从 URL 添加插件';

  @override
  String get addRegexRule => '添加正则表达式规则';

  @override
  String get addRule => '添加规则';

  @override
  String get addRuleButton => '添加规则';

  @override
  String addRuleFailed(Object error) {
    return '添加规则失败：$error';
  }

  @override
  String get addRuleTooltip => '添加规则';

  @override
  String get addSilenceSubscription => '添加静音订阅';

  @override
  String get addSimRuleButton => '添加 SIM 卡规则';

  @override
  String get addSmsFilterRule => '添加短信过滤规则';

  @override
  String get addSmsRule => '添加短信规则';

  @override
  String get addSmsSubscription => '添加短信订阅';

  @override
  String get addSubscription => '添加订阅';

  @override
  String get addSubscriptionButton => '添加订阅';

  @override
  String addSubscriptionFailed(Object error) {
    return '添加订阅失败：$error';
  }

  @override
  String get addSubscriptionTooltip => '添加订阅';

  @override
  String get addToAllowedRules => '添加到允许规则';

  @override
  String get addToBlacklist => '添加到黑名单';

  @override
  String get addToBlockedRules => '添加到阻止规则';

  @override
  String get addToFavoriteContacts => '添加到收藏联系人';

  @override
  String get addToFavorites => '添加到收藏夹';

  @override
  String get addToRules => '添加到规则';

  @override
  String get addToWhitelist => '添加到白名单';

  @override
  String get adPlaceholder => '广告占位符';

  @override
  String get agent => '代理';

  @override
  String get all => '全部';

  @override
  String get allCallsTab => '全部';

  @override
  String get allDataClearedSuccessfully => '所有数据已成功清除';

  @override
  String get allow => '允许';

  @override
  String get allowAllAllowRules => '允许所有允许规则';

  @override
  String get allowAllAllowRulesDesc => '允许来自允许规则的呼叫';

  @override
  String get allowAllBlacklistedNumbers => '允许所有黑名单号码';

  @override
  String get allowAllBlacklistedNumbersDesc => '允许来自黑名单的呼叫';

  @override
  String get allowAllBlockRules => '允许所有阻止规则';

  @override
  String get allowAllBlockRulesDesc => '允许来自阻止规则的呼叫';

  @override
  String get allowAllowedNumbers => '允许允许的号码';

  @override
  String get allowAllowedNumbersDesc => '允许来自白名单的呼叫';

  @override
  String get allowBlock => '允许/阻止';

  @override
  String get allowBlockedNumbers => '允许阻止的号码';

  @override
  String get allowBlockedNumbersDesc => '允许来自黑名单的呼叫';

  @override
  String get allowedBlockedRule => '允许/阻止规则';

  @override
  String get allowedBlockedRuleEditDialogTitle => '编辑允许/阻止规则';

  @override
  String get allowedBlockedRuleManagement => '允许/阻止规则管理';

  @override
  String get allowNonExceededNumbers => '允许未超出限制的号码';

  @override
  String get allowNonExceededNumbersDescription => '自动允许未超过计数阈值的号码';

  @override
  String get allowRegexAllowRules => '允许正则表达式允许规则';

  @override
  String get allowRegexAllowRulesDesc => '为允许规则启用正则表达式模式匹配';

  @override
  String get allowRegexAllowRulesDescription => '启用基于正则表达式的允许规则';

  @override
  String get allowRegexBlockRules => '允许正则表达式阻止规则';

  @override
  String get allowRegexBlockRulesDesc => '为阻止规则启用正则表达式模式匹配';

  @override
  String get allowRegexBlockRulesDescription => '启用基于正则表达式的阻止规则';

  @override
  String get allowRule => '允许规则';

  @override
  String get allowRules => '允许规则';

  @override
  String get allowWhitelistedNumbers => '允许白名单号码';

  @override
  String get allowWhitelistedNumbersDescription => '允许白名单中的所有号码';

  @override
  String get allPermissionsGranted => '已授予所有权限';

  @override
  String get allSettingsCompleted => '所有设置已完成。';

  @override
  String allUpdateSuccess(Object count) {
    return '所有更新已完成（$count 条规则）';
  }

  @override
  String get answerThenHangup => '接听然后挂断';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule。保留所有权利。';

  @override
  String get applicationSoftware => '应用软件';

  @override
  String get apply => '应用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => '授权失败：请检查客户端 ID 和密钥';

  @override
  String get authorizationFailedMessage => '授权失败';

  @override
  String get authorizationSuccessMessage => '授权成功';

  @override
  String get authorizeLoginButton => '授权登录';

  @override
  String get automotiveIndustry => '汽车工业';

  @override
  String get autoSyncLabel => '自动同步';

  @override
  String get autoUpdate => '自动更新';

  @override
  String get autoUpdateDescription => '设置订阅的自动更新间隔或手动更新';

  @override
  String get autoUpdateSettings => '自动更新设置';

  @override
  String get autoUpdateSettingsSubtitle => '管理规则和插件的自动更新';

  @override
  String get autoUpdateSettingsTitle => '自动更新设置';

  @override
  String get autoUpdateSubtitle => '管理规则和插件的自动更新';

  @override
  String get autoUpdateTitle => '自动更新';

  @override
  String get avatarBorderColor => '头像边框颜色';

  @override
  String get avatarBorderSize => '头像边框大小';

  @override
  String get avatarIconSizesSetting => '头像和图标大小';

  @override
  String get avatarPosition => '头像位置';

  @override
  String get avatarSize => '头像大小';

  @override
  String axisPosition(Object axis) {
    return '$axis 位置';
  }

  @override
  String get backgroundGradientSetting => '背景渐变';

  @override
  String get backup => '备份';

  @override
  String get backupAndRestore => '备份和还原';

  @override
  String get backupAndRestoreSubtitle => '备份或还原应用程序数据';

  @override
  String get backupAndRestoreTitle => '备份和还原';

  @override
  String get backupFailed => '备份失败';

  @override
  String get backupFailedMessage => '备份失败';

  @override
  String backupFailedWithError(Object error) {
    return '备份失败：$error';
  }

  @override
  String get backupRestoreSubtitle => '备份或还原应用程序数据';

  @override
  String get backupRestoreTitle => '备份和还原';

  @override
  String get backupSectionTitle => '备份';

  @override
  String get backupSettings => '备份设置';

  @override
  String get backupSettingsDialogTitle => '备份设置';

  @override
  String get backupSettingsTitle => '备份设置';

  @override
  String get backupSuccessMessage => '成功备份到云';

  @override
  String backupSuccessToLocal(Object path) {
    return '备份成功到：$path';
  }

  @override
  String get backupToCloud => '备份到云';

  @override
  String get backupToCloudDescription => '将设置和规则备份到云存储';

  @override
  String backupToCloudFailed(Object error) {
    return '备份到云失败：$error';
  }

  @override
  String get backupToCloudLabel => '备份到云';

  @override
  String get backupToCloudSuccess => '成功备份到云';

  @override
  String get backupToCloudTitle => '备份到云';

  @override
  String get backupToLocalLabel => '备份到本地';

  @override
  String get bank => '银行';

  @override
  String get basicInfo => '基本信息';

  @override
  String get basicRuleFilter => '基本规则过滤';

  @override
  String get basicRuleFiltering => '基本规则过滤';

  @override
  String get basicRuleFilteringExplanation => '• 基本规则过滤：基于黑名单、白名单和正则表达式的过滤规则';

  @override
  String get basicRuleFilterSettings => '基本规则过滤设置';

  @override
  String get basicRuleFilterSubtitle => '使用黑名单/白名单和正则表达式过滤呼叫';

  @override
  String get batchDeleteContacts => '批量删除联系人';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '确定要删除 $count 个选定的联系人吗？';
  }

  @override
  String get batchDeleteFailed => '批量删除失败';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '确定要删除 $count 个标签吗？';
  }

  @override
  String get blacklist => '黑名单';

  @override
  String get blacklistingAndWhitelisting => '黑名单和白名单';

  @override
  String get blacklistLabel => '黑名单';

  @override
  String get blackWhiteList => '黑/白名单';

  @override
  String get block => '阻止';

  @override
  String get blockCalls => '阻止呼叫';

  @override
  String get blocked => '已阻止';

  @override
  String get blockedCallAction => '已阻止的呼叫操作';

  @override
  String get blockedCalls => '已阻止的呼叫';

  @override
  String get blockedCallsTitle => '已阻止的呼叫';

  @override
  String get blockedCommunications => '已阻止的通讯';

  @override
  String get blockedPhoneLabel => '已阻止的呼叫';

  @override
  String get blockedSpamCalls => '已阻止的垃圾呼叫';

  @override
  String get blockingTrend => '阻止趋势';

  @override
  String get blockInternationalCalls => '匹配不以 + 或 00 开头的号码';

  @override
  String get blockInternationalCallsTitle => '阻止国际呼叫';

  @override
  String get blockLandlineNumbersTitle => '阻止座机号码';

  @override
  String get blockMobileNumbers => '匹配不以 13-19 开头的号码';

  @override
  String get blockMobileNumbersTitle => '阻止手机号码';

  @override
  String get blockPremiumRateNumbers => '匹配不以 118 或 120-190 开头的号码';

  @override
  String get blockPremiumRateNumbersTitle => '阻止高价号码';

  @override
  String get blockRule => '阻止规则';

  @override
  String get blockRules => '阻止规则';

  @override
  String get blockSpecificAreaCodes => '匹配以 0 + 2-3 位数字开头的号码';

  @override
  String get blockSpecificAreaCodesTitle => '阻止特定区号：';

  @override
  String get blockTypeAnalysisTitle => '阻止类型分析';

  @override
  String get both => '两者';

  @override
  String get bulkDelete => '批量删除联系人';

  @override
  String get bulkDeleteContacts => '批量删除联系人';

  @override
  String get bulkDeleteLabels => '批量删除标签';

  @override
  String get call => '呼叫';

  @override
  String get callback => '回拨';

  @override
  String callbackTo(String number) {
    return '回拨至 $number';
  }

  @override
  String get callBlocking => '呼叫阻止';

  @override
  String get callerIdApp => '来电显示应用';

  @override
  String get callerIdCustomizationTitle => '自定义来电显示';

  @override
  String get callerIdDialogTitle => '来电显示信息';

  @override
  String get callerIdDisplayMode => '来电显示模式';

  @override
  String callerIdMarkedByCount(Object count) {
    return '被标记 $count 次';
  }

  @override
  String get callerIdPreview => '来电显示预览';

  @override
  String get callFilter => '来电过滤';

  @override
  String get callFilterDescription =>
      '启用后，来电将根据以下规则列表进行检查。默认情况下，呼叫过滤规则不会在设备之间同步。';

  @override
  String get callFilterRules => '来电过滤规则';

  @override
  String get callFilterRulesDescription => '设置来电过滤的基本规则';

  @override
  String get callFilterSettings => '来电过滤设置';

  @override
  String get callFrequencyInterceptionSubtitle => '设置呼叫频率限制和阻止规则';

  @override
  String get callFrequencyInterceptionTitle => '呼叫频率拦截';

  @override
  String get callHistory => '通话记录';

  @override
  String get callHistoryInfoDesc => '此处显示您的通话记录，包括来电、去电和未接来电。';

  @override
  String get callHistoryInfoTitle => '通话记录';

  @override
  String callHistoryInitFailed(Object error) {
    return '初始化通话记录失败: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '刷新通话记录失败: $error';
  }

  @override
  String get callHistoryTab => '通话记录';

  @override
  String get callHistoryTimelineEarlier => '更早';

  @override
  String get callHistoryTimelineToday => '今天';

  @override
  String get callHistoryTimelineYesterday => '昨天';

  @override
  String get callScreeningPermission => '来电筛选权限';

  @override
  String get callScreeningPermissionDescription => '用于筛选和阻止垃圾电话。';

  @override
  String get callScreeningPermissionNotGranted => '未授予来电筛选权限，可能会影响应用程序功能。';

  @override
  String get callSettingsSubtitle => '来电显示、过滤和阻止设置';

  @override
  String get callSettingsTitle => '通话设置';

  @override
  String get callStatistics => '通话统计';

  @override
  String get callTypeAnswered => '已接听';

  @override
  String get callTypeBlocked => '已阻止';

  @override
  String get callTypeIconColor => '通话类型图标颜色';

  @override
  String get callTypeMissed => '未接来电';

  @override
  String get callTypeOutgoing => '已拨出';

  @override
  String get callTypePosition => '通话类型位置';

  @override
  String get callTypeUnknown => '未知';

  @override
  String get cancelButton => '取消';

  @override
  String get carRental => '汽车租赁';

  @override
  String get carrier => '运营商';

  @override
  String get carrierColor => '运营商颜色';

  @override
  String get carrierFontSize => '运营商字体大小';

  @override
  String get carrierPosition => '运营商位置';

  @override
  String get changeLabel => '更改标签';

  @override
  String changePluginStatusFailed(Object error) {
    return '更改插件状态失败: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '更改订阅状态失败: $error';
  }

  @override
  String get changeTag => '更改标签';

  @override
  String get charity => '慈善机构';

  @override
  String chartMonthFormat(int month) {
    return '月份 $month';
  }

  @override
  String get chartOneDayAgo => '1 天前';

  @override
  String get chartOneMonthAgo => '1 个月前';

  @override
  String get chartOneWeekAgo => '1 周前';

  @override
  String get chartTenDaysAgo => '10 天前';

  @override
  String get chartThreeDaysAgo => '3 天前';

  @override
  String get chartToday => '今天';

  @override
  String get checkFileFormat => '请检查文件格式或权限';

  @override
  String checkPermissionFailed(Object error) {
    return '检查权限失败：$error';
  }

  @override
  String get chooseDefaultInterceptAction => '选择默认拦截操作';

  @override
  String get clearAllData => '清除所有数据';

  @override
  String get clearAllDataConfirmation => '确定要清除所有应用程序数据吗？此操作无法撤销。';

  @override
  String get clearAllDataDescription => '清除所有应用程序数据';

  @override
  String get clearAllDataLabel => '清除所有数据';

  @override
  String get clearFilter => '清除过滤器';

  @override
  String get clearLabelFilter => '清除标签过滤器';

  @override
  String get clearLabelFilterButton => '清除标签过滤器';

  @override
  String get closeButton => '关闭';

  @override
  String get cloudSync => '云同步';

  @override
  String get cloudSyncAndBackupTitle => '云同步和备份';

  @override
  String get cloudSyncSettingsSubtitle => '配置 WebDAV、OneDrive 和 Google Drive';

  @override
  String get cloudSyncSettingsTitle => '云同步设置';

  @override
  String get cloudSyncTitle => '云同步';

  @override
  String get collapseLabelSelector => '折叠标签选择器';

  @override
  String get collection => '催收';

  @override
  String get colorPickerTitle => '选择颜色';

  @override
  String get configManagement => '配置管理';

  @override
  String get configUpdated => '配置已更新';

  @override
  String get configurationAdvice => '通过适当的配置，您可以为工作和个人 SIM 卡设置不同的过滤策略。';

  @override
  String get configureBackupOptions => '配置备份选项';

  @override
  String get configureBackupOptionsSubtitle => '配置备份选项';

  @override
  String get configureCloudSyncService => '配置云同步服务';

  @override
  String get configureCloudSyncServiceHint => '请配置云同步服务以启用多设备同步。';

  @override
  String get configureCloudSyncServiceMessage => '请配置云同步服务以启用多设备同步。';

  @override
  String get configureSimCardFilterRules => '配置 SIM 卡过滤规则';

  @override
  String get configureSyncServiceHint => '请先在云同步设置中配置同步服务';

  @override
  String get confirm => '确认';

  @override
  String get confirmBatchDeleteContacts => '确定要删除所选';

  @override
  String get confirmButton => '确认';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get confirmDeleteContact => '确定要删除';

  @override
  String get confirmDeleteContactName => '确认删除？';

  @override
  String get confirmDeleteFilter => '确定要删除此过滤器吗？';

  @override
  String confirmDeleteLabel(Object name) {
    return '确定要删除标签 \"$name\" 吗';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '确定要删除插件 \"$name\" 吗？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '确定要删除 $count 个插件吗？';
  }

  @override
  String get confirmDeleteRuleMessage => '确定要删除此规则吗？此操作无法撤销。';

  @override
  String get confirmDeleteSelectedContacts => '确定要删除选定的联系人吗？';

  @override
  String get confirmDeleteSmsFilterRule => '确定要删除此短信过滤规则吗？';

  @override
  String get confirmDeleteSmsRule => '确定要删除此短信规则吗？';

  @override
  String get confirmDeleteSubscription => '确定要删除此订阅吗？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get confirmPassword => '确认密码';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get connectedStatus => '已连接';

  @override
  String get connectionFailedCheckCredentialsMessage => '连接失败：请检查服务器地址、用户名和密码';

  @override
  String get connectionFailedMessage => '连接失败';

  @override
  String get connectionStatusLabel => '连接状态';

  @override
  String get connectionSuccessMessage => '连接成功';

  @override
  String get contactAddSuccess => '联系人添加成功';

  @override
  String get contactDeleted => '联系人已删除';

  @override
  String get contactEditDialog => '联系人编辑对话框';

  @override
  String get contactNameHint => '输入联系人姓名（可选）';

  @override
  String get contactNameLabel => '姓名';

  @override
  String get contactNameOptional => '联系人姓名（可选）';

  @override
  String get contactNotFound => '未找到联系人';

  @override
  String get contacts => '联系人';

  @override
  String contactsDeleted(Object count) {
    return '已删除 $count 个联系人';
  }

  @override
  String get contactSettingsSubtitle => '联系人管理和标签设置';

  @override
  String get contactSettingsTitle => '联系人设置';

  @override
  String contactsLoadingFailed(Object error) {
    return '加载联系人失败: $error';
  }

  @override
  String get contactsManagement => '联系人管理';

  @override
  String get contactsManagementPageTitle => '联系人管理页面';

  @override
  String get contactsPageTitle => '联系人管理';

  @override
  String get contactsPermission => '联系人权限';

  @override
  String get contactsPermissionDescription => '用于识别联系人来电。';

  @override
  String get contactsTab => '联系人';

  @override
  String get contactSubscriptionDescription =>
      '通过 URL 订阅联系人列表，自动更新联系人信息和标签。支持 JSON 格式数据。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '加载联系人订阅失败: $error';
  }

  @override
  String get contactSubscriptionPageTitle => '联系人订阅';

  @override
  String get contactUpdateSuccess => '联系人更新成功';

  @override
  String get contactUs => '联系我们';

  @override
  String get content => '内容';

  @override
  String get contentRegex => '内容正则表达式';

  @override
  String get countColor => '计数颜色';

  @override
  String get countFontSize => '计数字体大小';

  @override
  String get countPosition => '计数位置';

  @override
  String get country => '国家/地区';

  @override
  String get countryNameColor => '国家/地区名称颜色';

  @override
  String get countryNameFontSize => '国家/地区名称字体大小';

  @override
  String get countryRegionNamePosition => '国家/地区名称位置';

  @override
  String get countrySelectionDialog => '国家/地区选择对话框';

  @override
  String get countrySelectionDialogDescription => '用于选择国家/地区以查询来电显示信息';

  @override
  String get countThresholdDescription => '设置触发过滤操作所需的最小计数阈值';

  @override
  String get countThresholdLabel => '计数阈值';

  @override
  String get countThresholdSettings => '计数阈值设置';

  @override
  String countThresholdValue(Object count) {
    return '计数阈值: $count';
  }

  @override
  String get createdRules => '已创建规则';

  @override
  String get csvFormat => 'CSV 格式';

  @override
  String get currentDeviceChip => '当前';

  @override
  String get currentDeviceLabel => '当前设备标签';

  @override
  String get currentDeviceTitle => '当前设备';

  @override
  String get currentLabels => '当前标签:';

  @override
  String get currentLanguage => '当前语言';

  @override
  String get currentPasswordLabel => '当前密码';

  @override
  String get customerService => '客户服务';

  @override
  String get customRange => '自定义范围';

  @override
  String get dailyStatistics => '每日统计';

  @override
  String get dailyStatisticsDesc => '接收有关被阻止的呼叫和消息的每日统计信息';

  @override
  String get dashboardTab => '仪表盘';

  @override
  String get dataAnalysis => '数据分析';

  @override
  String get dataAnalysisDashboardPage => '数据分析仪表盘页面';

  @override
  String get dataExport => '数据导出';

  @override
  String dataLoadFailure(Object error) {
    return '数据加载失败：$error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '加载数据失败：$error';
  }

  @override
  String get dataMigration => '数据迁移';

  @override
  String get dataMigrationDescription =>
      '此功能允许您在设备之间传输所有数据。目前，您可以使用备份和还原功能手动迁移数据。';

  @override
  String get dataMigrationDialogContent =>
      '此功能允许您在设备之间传输所有数据。目前，您可以使用备份和还原功能手动迁移数据。';

  @override
  String get dataMigrationDialogTitle => '数据迁移';

  @override
  String get dataMigrationSectionTitle => '数据迁移';

  @override
  String get dataSourceReminder => '数据源提醒';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
      one: '1 天',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 天 VIP';
  }

  @override
  String get debtCollection => '催收';

  @override
  String get defaultPeriod => '周';

  @override
  String get delete => '删除';

  @override
  String get deleteButton => '删除';

  @override
  String get deleteContact => '删除联系人';

  @override
  String deleteContactConfirm(Object name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get deleteContactConfirmation => '确定要删除联系人吗';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '确定要删除 $deviceName 吗？';
  }

  @override
  String get deleteDeviceDialogTitle => '删除设备';

  @override
  String deleteFailed(Object error) {
    return '删除失败：$error';
  }

  @override
  String get deleteFilter => '删除过滤器';

  @override
  String get deleteLabel => '删除标签';

  @override
  String deleteLabelFailed(Object error) {
    return '删除标签失败：$error';
  }

  @override
  String get deletePlugin => '删除插件';

  @override
  String deletePluginFailed(Object error) {
    return '删除插件失败：$error';
  }

  @override
  String get deletePlugins => '删除插件';

  @override
  String deletePluginsFailed(Object error) {
    return '删除插件失败：$error';
  }

  @override
  String get deleteRule => '删除规则';

  @override
  String deleteRuleFailed(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String get deleteSelected => '删除所选';

  @override
  String get deleteSmsRule => '删除短信规则';

  @override
  String get deleteSubscription => '删除订阅';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '确定要删除订阅 \"$name\" 吗？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '删除订阅失败：$error';
  }

  @override
  String get deleteSuccess => '删除成功';

  @override
  String get delivery => '交付';

  @override
  String get deviceDeletedSuccessfully => '设备已成功删除';

  @override
  String get deviceDeletedSuccessfullyMessage => '设备已成功删除';

  @override
  String get deviceIdLabel => '设备 ID';

  @override
  String get deviceIDLabel => '设备 ID';

  @override
  String get deviceManagementSubtitle => '管理多设备同步';

  @override
  String get deviceManagementTitle => '设备管理';

  @override
  String get deviceModelLabel => '设备型号';

  @override
  String get deviceName => '设备名称';

  @override
  String get deviceNameCannotBeEmpty => '设备名称不能为空';

  @override
  String get deviceNameHint => '请输入设备名称';

  @override
  String get deviceNameLabel => '设备名称';

  @override
  String get deviceRenamedSuccessfully => '设备重命名成功';

  @override
  String get deviceRenamedSuccessfullyMessage => '设备重命名成功';

  @override
  String get devicesSyncedSuccessfully => '设备同步成功';

  @override
  String get devicesSyncedSuccessfullyMessage => '设备同步成功';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '设备同步成功';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '设备注销成功';

  @override
  String get dialogTitle => '正则表达式说明';

  @override
  String get differentFromLocalCounter =>
      '此功能与本地计数器过滤器不同，因为它侧重于短时间内的重复呼叫模式，而不是长期标记计数。';

  @override
  String get disabled => '已禁用';

  @override
  String get disabledStatus => '已禁用';

  @override
  String get disableGlobalPlugins => '禁用全局插件';

  @override
  String get disableSubscriptionSuccessfully => '禁用订阅成功';

  @override
  String get disconnectButton => '断开连接';

  @override
  String get disconnectedMessage => '已断开连接';

  @override
  String get disconnectedStatus => '已断开连接';

  @override
  String get disconnectFailedMessage => '断开连接失败';

  @override
  String get done => '完成';

  @override
  String get dualSimAdvice => '此功能对于双 SIM 卡手机尤其有用，可以为工作和个人 SIM 卡设置不同的过滤策略。';

  @override
  String get earlier => '更早';

  @override
  String get ecommerce => '电子商务';

  @override
  String get edit => '编辑';

  @override
  String get editContact => '编辑联系人';

  @override
  String get editFilter => '编辑过滤器';

  @override
  String get editLabel => '编辑标签';

  @override
  String get editPhoneRule => '编辑电话规则';

  @override
  String get editPhoneRules => '用于编辑电话规则';

  @override
  String get editPhoneRuleTitle => '编辑电话规则';

  @override
  String get editRule => '编辑规则';

  @override
  String get editSmsRule => '编辑短信规则';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '元素位置';

  @override
  String get email => '电子邮件';

  @override
  String get emailOptional => '电子邮件（可选）';

  @override
  String get enableCallFilter => '启用呼叫过滤';

  @override
  String get enableCallFilterDescription =>
      '启用后，传入呼叫将根据以下规则列表进行检查。默认情况下，呼叫过滤规则不会在设备之间同步。';

  @override
  String get enabled => '已启用';

  @override
  String get enabledStatus => '已启用';

  @override
  String get enableEncryption => '启用加密';

  @override
  String get enableEncryptionDescription => '加密备份文件';

  @override
  String get enableEncryptionLabel => '启用加密';

  @override
  String get enableEncryptionSubtitle => '备份文件将被加密';

  @override
  String get enableEncryptionTitle => '启用加密';

  @override
  String get enableGlobalPlugins => '启用全局插件';

  @override
  String get enableLocalCountFilter => '启用本地计数过滤器';

  @override
  String get enableLocalCountFilterDescription => '根据呼叫标记计数自动过滤垃圾呼叫';

  @override
  String get enableLocalNotification => '使用本地通知';

  @override
  String get enableLocalNotificationDescription => '启用后，过滤后的消息的通知将显示在设备上';

  @override
  String get enableLocationSummary => '位置';

  @override
  String get enableMuteRules => '启用静音规则';

  @override
  String get enableMuteRulesDesc => '应用静音拦截规则配置';

  @override
  String get enableNoneActionRules => '启用无操作规则';

  @override
  String get enableNoneActionRulesDesc => '允许没有拦截操作的规则配置';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get enableRemoteNumberFilter => '启用远程号码过滤';

  @override
  String get enableRemoteNumberFilterDescription => '使用远程数据库过滤号码';

  @override
  String get enableRule => '启用规则';

  @override
  String get enableSmsFilter => '启用短信过滤';

  @override
  String get enableSmsFilterDescription => '启用后，消息将根据规则自动过滤';

  @override
  String get enableStatisticsNotifications => '启用统计通知';

  @override
  String get enableSubscriptionSuccessfully => '成功启用订阅';

  @override
  String get enableTimeInterception => '启用时间拦截';

  @override
  String get enableTimeInterceptionDescription => '在短时间内拦截重复呼叫';

  @override
  String get enableTimeInterceptor => '启用时间拦截器';

  @override
  String get endCallImmediately => '立即结束通话';

  @override
  String get endColor => '结束颜色';

  @override
  String get endDate => '结束日期';

  @override
  String get enhancedFilterInstructionsTitle => '增强型过滤系统';

  @override
  String get enhancedFilterSettings => '增强型过滤设置';

  @override
  String get enhancedFilterSettingsTitle => '增强型过滤设置';

  @override
  String get enhancedFilterSystemDescription => '增强型过滤系统支持全局规则和每个 SIM 卡的过滤配置。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '请输入电话号码和正则表达式模式';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => '请输入电话号码和正则表达式模式。';

  @override
  String get enterContactName => '请输入联系人姓名';

  @override
  String get enterCurrentPasswordHint => '请输入当前密码';

  @override
  String get enterDeviceName => '输入设备名称';

  @override
  String get enterDeviceNameHint => '请输入设备名称';

  @override
  String get enterEmail => '请输入电子邮件';

  @override
  String get enterEmailOptional => '请输入电子邮件（可选）';

  @override
  String get enterEncryptionPasswordHint => '输入加密密码';

  @override
  String get enterEncryptionPasswordTitle => '输入加密密码';

  @override
  String get enterFilterName => '请输入过滤器名称';

  @override
  String get enterFilterPattern => '请输入过滤模式';

  @override
  String get enterIconCode => '输入图标代码';

  @override
  String get enterName => '输入联系人姓名';

  @override
  String get enterNewDeviceNameHint => '输入此设备的新名称';

  @override
  String get enterNewPasswordHint => '请输入新密码';

  @override
  String get enterPasswordAgain => '再次输入密码';

  @override
  String get enterPasswordHint => '请输入密码';

  @override
  String get enterPhoneNumber => '输入电话号码';

  @override
  String get enterPhoneNumberHint => '输入电话号码进行测试';

  @override
  String get enterPhoneNumberMultiple => '请输入电话号码，多个号码用逗号分隔';

  @override
  String get enterPhoneNumberToStartSearch => '输入电话号码以开始搜索';

  @override
  String get enterPhoneNumberToVerify => '输入电话号码以验证';

  @override
  String get enterPluginName => '输入插件名称';

  @override
  String get enterPluginUrl => '输入插件 URL 地址';

  @override
  String get enterRegexHint => '输入正则表达式模式';

  @override
  String get enterRuleNameAndPattern => '请输入规则名称和模式';

  @override
  String get enterRuleNameAndPatternMessage => '请输入规则名称和正则表达式模式。';

  @override
  String get enterRuleNameHint => '输入规则名称';

  @override
  String get enterSearchContent => '请输入搜索内容';

  @override
  String get enterSubscriptionName => '输入订阅名称';

  @override
  String get enterSubscriptionUrl => '输入订阅 URL';

  @override
  String get enterSyncFolderNameHint => '请输入同步文件夹名称（默认：NotificationManager）';

  @override
  String get entertainment => '娱乐';

  @override
  String get enterValidNameAndUrl => '请输入有效的名称和 URL';

  @override
  String get enterValidUrl => '请输入有效的 URL';

  @override
  String get enterVersion => '输入版本';

  @override
  String get enterWebDAVPasswordHint => '请输入 WebDAV 密码';

  @override
  String get enterWebDAVServerAddressHint => '请输入 WebDAV 服务器地址';

  @override
  String get enterWebDAVUsernameHint => '请输入 WebDAV 用户名';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '删除设备时出错：$error';
  }

  @override
  String get errorLoadingPlugin => '加载插件时出错';

  @override
  String errorOccurredMessage(Object error) {
    return '发生错误：$error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '重命名设备时出错：$error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '同步设备时出错：$error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '同步设备时出错：$error';
  }

  @override
  String get errorText => '错误';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '注销设备时出错：$error';
  }

  @override
  String get exampleBlock400Prefix => '例如，阻止 400 前缀号码';

  @override
  String get exampleBlockMarketingSms => '例如，阻止营销短信';

  @override
  String get exampleContentRegex => '例如，.*offer.*';

  @override
  String get exampleContentRegexHint => '内容正则表达式示例';

  @override
  String get exampleCouponPromotionDiscount => '例如，.*(优惠券|促销|折扣).*';

  @override
  String get exampleFamilyFriends => '例如，家人、朋友等';

  @override
  String get examplePhoneNumber => '例如，10086、12345 等';

  @override
  String get exampleRegex400Prefix => '400 前缀的正则表达式示例';

  @override
  String get exampleRegexFormat => '示例：^10086\$ 格式';

  @override
  String get exampleSenderRegexHint => '示例';

  @override
  String get exchange => '兑换';

  @override
  String get exchangeNow => '立即兑换';

  @override
  String get exchangeVip => '兑换 VIP';

  @override
  String get expandLabelSelector => '展开标签选择器';

  @override
  String expiryTime(Object time) {
    return '到期时间：$time';
  }

  @override
  String get export => '导出';

  @override
  String get exportAllApplicationSettings => '导出所有应用程序设置';

  @override
  String get exportAllApplicationSettingsSubtitle => '导出所有应用程序设置';

  @override
  String get exportAllRuleConfigurations => '导出所有规则配置';

  @override
  String get exportAllRuleConfigurationsSubtitle => '导出所有规则配置';

  @override
  String get exportComplete => '导出完成';

  @override
  String get exportConfig => '导出配置';

  @override
  String get exportContacts => '导出联系人';

  @override
  String get exportData => '导出数据';

  @override
  String get exportError => '导出错误';

  @override
  String get exportFailed => '导出失败';

  @override
  String get exportFailure => '导出配置失败';

  @override
  String get exportFeatureComingSoon => '导出功能即将推出';

  @override
  String get exporting => '正在导出...';

  @override
  String get exportLabels => '导出标签';

  @override
  String exportLabelsFailed(Object error) {
    return '导出标签失败: $error';
  }

  @override
  String get exportPluginList => '导出插件列表';

  @override
  String exportPluginListFailed(Object error) {
    return '导出插件列表失败: $error';
  }

  @override
  String get exportRules => '导出规则';

  @override
  String get exportRulesDialogTitle => '导出规则';

  @override
  String get exportRulesTitle => '导出规则';

  @override
  String get exportSmsRules => '导出短信规则';

  @override
  String get exportStatisticsData => '导出统计数据';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get exportSuccesslly => '配置导出成功';

  @override
  String get failedToAddContact => '添加联系人失败';

  @override
  String failedToAddRule(Object error) {
    return '添加规则失败: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return '添加短信规则失败: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return '添加短信订阅失败: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '备份设置失败: $error';
  }

  @override
  String get failedToDecryptBackupFile => '解密备份文件失败';

  @override
  String get failedToDeleteDevice => '删除设备失败';

  @override
  String failedToDeleteSmsRule(Object error) {
    return '删除短信规则失败: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return '导出规则失败: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return '导出短信规则失败: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '获取来电显示信息失败: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return '导入规则失败: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return '导入短信规则失败: $error';
  }

  @override
  String get failedToLoadContacts => '加载联系人失败';

  @override
  String get failedToLoadPlugin => '加载插件失败';

  @override
  String get failedToRenameDevice => '重命名设备失败';

  @override
  String get failedToRestoreSettings => '恢复设置失败';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '恢复设置失败: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '设置密码失败: $error';
  }

  @override
  String get failedToSyncDevices => '同步设备失败';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '切换规则状态失败: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '切换订阅状态失败';

  @override
  String get failedToUpdateContact => '更新联系人失败';

  @override
  String failedToUpdateSmsRule(Object error) {
    return '更新短信规则失败: $error';
  }

  @override
  String get failure => '失败';

  @override
  String get favoriteContacts => '收藏的联系人';

  @override
  String get featureAddRules => '• 添加特定电话号码的规则';

  @override
  String get featureCenter => '功能中心';

  @override
  String get featureEnableDisable => '• 启用/禁用每个SIM卡的不同过滤器';

  @override
  String get featureListTitle => '功能：';

  @override
  String get featureManageRules => '• 管理每个SIM卡的规则列表';

  @override
  String get features => '功能';

  @override
  String get fetchingCallerIdInfo => '正在获取来电显示信息...';

  @override
  String fileSavedTo(Object path) {
    return '文件保存到：$path';
  }

  @override
  String get filter => '过滤器';

  @override
  String get filterByLabel => '按标签过滤';

  @override
  String get filterClear => '清除过滤器';

  @override
  String get filterControlPanelTitle => '过滤器控制面板';

  @override
  String get filterControlSubtitle => '管理所有过滤器的开启/关闭状态';

  @override
  String get filterControlTitle => '筛选器控制';

  @override
  String get filterDeleteFailed => '筛选器删除失败';

  @override
  String get filterDeleteSuccess => '筛选器删除成功';

  @override
  String get filterDetails => '筛选器详情';

  @override
  String get filtered => '已筛选';

  @override
  String get filteredSms => '已筛选短信';

  @override
  String get filteredSmsLabel => '已筛选短信';

  @override
  String get filterExplanation => '筛选器说明';

  @override
  String get filterManagement => '筛选器管理';

  @override
  String get filterName => '筛选器名称';

  @override
  String get filterPattern => '筛选器模式';

  @override
  String get filterPriorityNote => '注意：筛选器之间存在优先级关系，详情请参考帮助文档';

  @override
  String get filterSaveFailed => '筛选器保存失败';

  @override
  String get filterSaveSuccess => '筛选器保存成功';

  @override
  String get filterSettings => '筛选器设置';

  @override
  String get filterSettingsTitle => '筛选器设置';

  @override
  String get filterSMS => '筛选短信';

  @override
  String get filterToggleInstructions => '为此 SIM 卡槽启用或禁用筛选器：';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status 筛选器：$filterName';
  }

  @override
  String get filterType => '筛选器类型';

  @override
  String get financial => '金融';

  @override
  String get flexibleCombinationFeature => '• 灵活组合：为每个 SIM 卡槽启用/禁用筛选器';

  @override
  String get fontSizesSetting => '字体大小';

  @override
  String foundRules(Object count) {
    return '找到 $count 条规则';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '找到 $count 条规则。是否要导入它们？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '找到 $count 条规则。是否要导入它们？';
  }

  @override
  String get fraudAlert => '欺诈警报 - 挂断电话';

  @override
  String get fraudScamLikely => '疑似欺诈诈骗';

  @override
  String get free => '免费';

  @override
  String get functionSettingsTitle => '功能设置';

  @override
  String generalUpdateFailure(Object error) {
    return '更新失败：$error';
  }

  @override
  String get getFree => '获取免费';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '配置所有 SIM 卡的全局筛选器：';

  @override
  String get globalFilterFeature => '• 全局筛选器：所有来电的基本规则';

  @override
  String get globalFilterSettings => '全局筛选器设置';

  @override
  String get globalFilterToggleInstructions => '配置应用于所有 SIM 卡槽的全局筛选器设置：';

  @override
  String get globalSearchSubtitle => '搜索联系人、标签、黑名单、白名单等';

  @override
  String get globalSearchTitle => '全局搜索';

  @override
  String get globalSettings => '全局设置';

  @override
  String get googleAdDisplayPosition => 'Google 广告展示位置';

  @override
  String get googleAdMobIntegrationText => '可以在此处集成 Google AdMob 广告';

  @override
  String get googleDriveAuthDescription =>
      '使用系统配置的 Google Drive 客户端 ID 和密钥进行授权';

  @override
  String get googleDriveAuthorizationHint =>
      '使用系统配置的 Google Drive 客户端 ID 和密钥进行授权';

  @override
  String get googleDriveConfigTitle => 'Google Drive 配置';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive 配置';

  @override
  String get government => '政府';

  @override
  String get granted => '已授予';

  @override
  String get grantNecessaryPermissions => '授予必要的权限';

  @override
  String get grantPermissions => '授予权限';

  @override
  String get headhunter => '猎头';

  @override
  String get height => '身高';

  @override
  String get homePageTitle => '主页';

  @override
  String get homeTab => '主页';

  @override
  String get howItWorksPoint1 => '• 系统将自动允许在设定的时间窗口内来自同一号码的呼叫';

  @override
  String get howItWorksPoint2 => '• 较短的时间窗口会导致更严格的拦截；较长的时间窗口会导致更宽松的拦截';

  @override
  String get howItWorksPoint3 => '• 系统检查通话记录以确定是否是重复呼叫';

  @override
  String get howItWorksTitle => '工作原理：';

  @override
  String get iconCodeOptional => '图标代码（可选）';

  @override
  String get iconSize => '图标大小';

  @override
  String get import => '导入';

  @override
  String get important => '重要';

  @override
  String get importButton => '导入';

  @override
  String get importConfig => '导入配置';

  @override
  String get importContacts => '导入联系人';

  @override
  String get importExportContacts => '导入/导出联系人';

  @override
  String get importExportContactsTooltip => '导入/导出联系人';

  @override
  String get importExportRules => '导入/导出规则';

  @override
  String importFailed(Object error) {
    return '导入失败：$error';
  }

  @override
  String get importFailure => '导入配置失败';

  @override
  String get importFeatureComingSoon => '导入功能即将推出';

  @override
  String get importLabels => '导入标签';

  @override
  String importLabelsFailed(Object error) {
    return '导入标签失败：$error';
  }

  @override
  String get importPluginList => '导入插件列表';

  @override
  String importPluginListFailed(Object error) {
    return '导入插件列表失败：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '成功导入 $count 个插件';
  }

  @override
  String get importRuleConfigurationsFromFile => '从文件导入规则配置';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '从文件导入规则配置';

  @override
  String get importRules => '导入规则';

  @override
  String get importRulesButton => '导入规则';

  @override
  String get importRulesDialogTitle => '导入规则';

  @override
  String importRulesError(Object error) {
    return '导入规则失败：$error';
  }

  @override
  String get importRulesInstructions => '从 CSV 文件导入规则';

  @override
  String get importRulesSuccess => '规则导入成功';

  @override
  String get importRulesTitle => '导入规则';

  @override
  String get importSuccess => '导入成功';

  @override
  String get incomingCallInterceptAction => '来电拦截动作';

  @override
  String get incomingCallNotification => '来电通知';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get initializing => '正在初始化';

  @override
  String get installed => '已安装';

  @override
  String get insufficientMarks => '分数不足';

  @override
  String get insurance => '保险';

  @override
  String get interceptAction => '拦截动作';

  @override
  String get interceptionActionSettingsSubtitle => '设置如何处理被阻止的呼叫';

  @override
  String get interceptionActionSettingsTitle => '拦截动作设置';

  @override
  String get interceptionTimeInterval => '拦截时间间隔';

  @override
  String get internet => '互联网';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 更新间隔设置为 $days 天';
  }

  @override
  String get invalidContentRegex => '无效的内容正则表达式';

  @override
  String get invalidLabel => '无效标签';

  @override
  String get invalidRegexPattern => '无效的正则表达式模式';

  @override
  String get invalidSenderRegex => '无效的发件人正则表达式';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '加入 Telegram 频道和群组以获取更多信息';

  @override
  String get jsLogsTitle => 'JS 日志';

  @override
  String get jsonFormat => 'JSON 格式';

  @override
  String get keepAllVersions => '保留所有版本';

  @override
  String get keepAllVersionsDescription => '保留每个备份的所有历史版本';

  @override
  String get keepAllVersionsLabel => '保留所有版本';

  @override
  String get keepAllVersionsSubtitle => '保留每个备份的历史版本';

  @override
  String get keepAllVersionsTitle => '保留所有版本';

  @override
  String get label => '标签';

  @override
  String labelAddedSuccessfully(Object name) {
    return '成功添加标签 \"$name\"';
  }

  @override
  String get labelCategories => '标签类别';

  @override
  String get labelDeleted => '标签已删除';

  @override
  String get labelDescription => '标签可帮助您更好地管理联系人，将自定义标签添加到电话号码，以便于识别来电和消息。';

  @override
  String get labelFilter => '标签筛选';

  @override
  String get labelFilterTooltip => '标签筛选';

  @override
  String get labelIconColor => '标签图标颜色';

  @override
  String get labelManagement => '标签管理';

  @override
  String get labelNotFound => '未找到标签';

  @override
  String get labelRemoved => '标签已移除';

  @override
  String labelRemoveFailed(Object error) {
    return '移除标签失败：$error';
  }

  @override
  String get labels => '标签';

  @override
  String get labelsColor => '标签颜色';

  @override
  String labelsDeleted(Object count) {
    return '已删除 $count 个标签';
  }

  @override
  String get labelsExportedSuccessfully => '标签导出成功';

  @override
  String get labelsFontSize => '标签字体大小';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '成功导入 $count 个标签';
  }

  @override
  String get labelsPosition => '标签位置';

  @override
  String labelTag(Object labelId) {
    return '标签: $labelId';
  }

  @override
  String get labelUpdated => '标签已更新';

  @override
  String labelUpdateFailed(Object error) {
    return '更新标签失败：$error';
  }

  @override
  String get labelUpdateSuccess => '标签 \"\$labelText\" 更新成功';

  @override
  String get languageSettings => '语言设置';

  @override
  String get languageSettingsSubtitle => '更改应用程序显示语言';

  @override
  String get languageSettingsTitle => '语言设置';

  @override
  String get last30Days => '最近 30 天';

  @override
  String get last7Days => '最近 7 天';

  @override
  String get lastSyncLabel => '上次同步';

  @override
  String lastUpdated(Object date) {
    return '上次更新时间：$date';
  }

  @override
  String get lifetimeMembership => '终身会员';

  @override
  String get lifetimeMembershipDescription => '一次性购买，永久解锁所有高级功能和未来更新';

  @override
  String loadContactsFailed(Object error) {
    return '加载联系人失败：$error';
  }

  @override
  String get loadDataFailed => '加载数据失败';

  @override
  String get loadFailed => '加载失败';

  @override
  String get loading => '加载中...';

  @override
  String get loadingData => '正在加载数据...';

  @override
  String get loadingTags => '正在加载标签...';

  @override
  String loadLabelFailed(Object error) {
    return '加载标签失败：$error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '加载标签失败：$error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '加载标记的电话号码失败：$error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '加载标记的电话失败：$error';
  }

  @override
  String get loadMore => '加载更多';

  @override
  String get loadPluginButton => '加载插件';

  @override
  String loadPluginsFailed(Object error) {
    return '加载插件失败：$error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '加载设置失败：$error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return '加载短信规则失败：$error';
  }

  @override
  String get loadStatusFailedMessage => '加载状态失败';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String get loan => '贷款';

  @override
  String get localBackupTitle => '本地备份';

  @override
  String get localCounterFilter => '本地计数器过滤器';

  @override
  String get localCounterFilterSubtitle => '根据通话频率自动过滤垃圾电话';

  @override
  String get localCountFilter => '本地计数过滤器';

  @override
  String get localCountFilterDescription => '根据本地号码计数拦截频繁的呼叫';

  @override
  String get localCountFilterExplanationContent =>
      '本地计数过滤器分析通话历史记录，以自动识别和阻止频繁的垃圾电话。';

  @override
  String get localCountFilterExplanationTitle => '本地计数过滤器说明';

  @override
  String get localCountFilterHowItWorksPoint1 => '• 确定是否根据号码的计数值进行阻止';

  @override
  String get localCountFilterHowItWorksPoint2 => '• 当号码的计数超过设置的阈值时，您可以选择自动阻止它';

  @override
  String get localCountFilterHowItWorksPoint3 => '• 您可以选择允许未超过阈值的号码';

  @override
  String get localCountFilterHowItWorksPoint4 => '• 您可以选择是否记录所有查询日志';

  @override
  String get localCountFiltering => '本地计数过滤';

  @override
  String get localCountFilteringExplanation => '• 本地计数过滤：基于本地标记计数的过滤规则';

  @override
  String get localCountFilterSettings => '本地计数过滤器设置';

  @override
  String get localCountFilterUseCases => '此过滤器特别适合于识别自动拨打的垃圾电话和营销电话。';

  @override
  String get localFilterSettings => '本地过滤器设置';

  @override
  String get localNotificationDisabled => '本地通知已禁用';

  @override
  String get localNotificationEnabled => '本地通知已启用';

  @override
  String get localServices => '本地服务';

  @override
  String get locationColor => '位置颜色';

  @override
  String get locationFontSize => '位置字体大小';

  @override
  String get locationIconColor => '位置图标颜色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => '记录所有本地查询';

  @override
  String get logAllLocalQueriesDescription => '记录所有本地号码查询的日志';

  @override
  String get logAllRemoteQueries => '记录所有远程查询';

  @override
  String get logAllRemoteQueriesDescription => '记录所有远程号码查询操作';

  @override
  String get manage => '管理联系人';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => '管理收藏联系人';

  @override
  String get manageFilterRules => '管理过滤规则';

  @override
  String get manageFilterRulesDescription => '添加、编辑或删除短信过滤规则';

  @override
  String get manageFrequentContacts => '管理常用联系人';

  @override
  String get markCounts => '标记计数';

  @override
  String get markCount => '标记计数';

  @override
  String markedByCount(Object count) {
    return '标记为 $count';
  }

  @override
  String get markedPhonesList => '标记的电话号码';

  @override
  String get markExchange => '标记交换';

  @override
  String get markPhone => '标记电话号码';

  @override
  String markPhoneFailed(Object error) {
    return '标记电话号码失败: $error';
  }

  @override
  String get markPhoneManagementSubtitle => '标记电话号码';

  @override
  String get markPhoneManagementTitle => '标记电话管理';

  @override
  String get markPhoneSuccess => '电话号码标记成功';

  @override
  String get matchFailed => '匹配失败!';

  @override
  String get matchFailedMessage => '匹配失败。';

  @override
  String get matchNumbersWithSpecialCharacters => '匹配特定的号码格式';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '匹配带特殊字符的号码:';

  @override
  String get matchSpecificDigitPatterns => '匹配 XXX-XXXX-XXXX 格式';

  @override
  String get matchSpecificDigitPatternsTitle => '匹配特定的数字模式:';

  @override
  String get matchSuccessful => '匹配成功!';

  @override
  String get matchSuccessfulMessage => '匹配成功!';

  @override
  String get medical => '医疗';

  @override
  String get membershipPrivileges => '会员特权';

  @override
  String get migrationTool => '迁移工具';

  @override
  String get migrationToolTitle => '迁移工具';

  @override
  String get minutes => '分钟';

  @override
  String get month => '月';

  @override
  String get monthly => '每月';

  @override
  String get monthlyCallCount => '每月通话';

  @override
  String get monthlyChartTitle => '每月拦截的通话';

  @override
  String get monthlyMembership => '每月会员';

  @override
  String get monthlyMembershipDescription => '解锁所有高级功能，每月自动续订';

  @override
  String get monthlyTotal => '每月总计';

  @override
  String get monthlyTotalLabel => '每月总计';

  @override
  String get moreOptions => '更多选项';

  @override
  String get mute => '静音';

  @override
  String get name => '名称';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '名称和电话号码不能为空';

  @override
  String get nameAndPhoneNumberRequired => '名称和电话号码不能为空';

  @override
  String get nameColor => '姓名颜色';

  @override
  String get nameFontSize => '姓名字体大小';

  @override
  String nameLabel(Object name) {
    return '姓名: $name';
  }

  @override
  String get namePosition => '姓名位置';

  @override
  String get nameUnknown => '姓名：未知';

  @override
  String nameWithValue(String name) {
    return '姓名: $name';
  }

  @override
  String get newPasswordLabel => '新密码';

  @override
  String get nextStep => '下一步';

  @override
  String get noAction => '无操作';

  @override
  String get noActionRules => '无操作规则';

  @override
  String get noActiveCloudSyncServiceMessage => '没有活动的云同步服务';

  @override
  String get noCallLogs => '没有通话记录';

  @override
  String get noCallRecords => '没有通话记录';

  @override
  String get noContacts => '还没有联系人';

  @override
  String get noContactsYet => '还没有联系人';

  @override
  String get noData => '没有数据';

  @override
  String get noDevicesRegisteredMessage => '没有注册的设备';

  @override
  String get noDevicesRegisteredYet => '还没有注册的设备。';

  @override
  String get noFilters => '还没有过滤器';

  @override
  String get noLabels => '还没有标签';

  @override
  String get noMarkedPhones => '没有标记的电话号码';

  @override
  String get noMatchingContacts => '没有匹配的联系人';

  @override
  String get noMatchingContactsFound => '没有找到匹配的联系人';

  @override
  String get noMatchingNumbersFound => '没有找到匹配的号码';

  @override
  String get noMatchingRecords => '没有匹配的通话记录';

  @override
  String noMatchingRules(Object ruleType) {
    return '没有匹配的 $ruleType';
  }

  @override
  String get none => '无';

  @override
  String get noneServiceType => '无';

  @override
  String get noPlugins => '暂无插件';

  @override
  String get noRecords => '没有通话记录';

  @override
  String get noResultReturned => '没有返回结果';

  @override
  String get noResultReturnedLog => '插件没有返回结果';

  @override
  String noRules(Object ruleType) {
    return '暂无 $ruleType';
  }

  @override
  String get noRulesPrompt => '未找到规则，请添加规则';

  @override
  String get noRulesToExport => '没有要导出的规则';

  @override
  String get noSmsFilterRulesYet => '还没有短信过滤规则';

  @override
  String get noSmsRulesYet => '还没有短信规则';

  @override
  String get noSubscriptions => '没有订阅';

  @override
  String get noSubscriptionsYet => '还没有订阅';

  @override
  String get notGranted => '未授权';

  @override
  String get notificationMode => '通知模式';

  @override
  String get notificationModeDescription => '在通知栏中显示来电信息';

  @override
  String get notificationPermission => '通知权限';

  @override
  String get notificationPermissionDescription => '用于显示来电和消息通知。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知设置';

  @override
  String get notificationSettingsSaved => '通知设置保存成功';

  @override
  String get notSet => '未设置';

  @override
  String get notVerifiedText => '未验证';

  @override
  String get noValidSmsRulesFoundInFile => '文件中未找到有效的短信规则';

  @override
  String get number => '号码';

  @override
  String get numberColor => '号码颜色';

  @override
  String get numberFontSize => '号码字体大小';

  @override
  String get numberPosition => '号码位置';

  @override
  String get numberSearch => '号码搜索';

  @override
  String get numberTypeColor => '号码类型颜色';

  @override
  String get numberTypeFontSize => '号码类型字体大小';

  @override
  String get numberTypePosition => '号码类型位置';

  @override
  String get ok => '确定';

  @override
  String get okButton => '确定';

  @override
  String get onboardingCompleteDescription => '您的通话安全管家已准备就绪，开始享受安全的通话体验！';

  @override
  String get onboardingLanguageDescription => '选择您喜欢的语言，以获得最佳体验。';

  @override
  String get onboardingPermissionsDescription => '为了提供完整的服务，我们需要以下权限：';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '一键拦截垃圾来电和短信，自定义拦截规则，给您一个安静的环境。';

  @override
  String get onboardingSmartCallerIdDescription => '自动识别未知来电，标记可疑号码，保护您的通话安全。';

  @override
  String get onboardingWelcomeDescription => '您的通话管理专家，提供全面的来电识别和拦截服务。';

  @override
  String get oneDriveAuthDescription => '使用系统配置的 OneDrive 客户端 ID 和密钥进行授权';

  @override
  String get oneDriveAuthorizationHint => '使用系统配置的 OneDrive 客户端 ID 和密钥进行授权';

  @override
  String get oneDriveConfigTitle => 'OneDrive 配置';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 配置';

  @override
  String get onlineCallerIdSubscription => '在线来电显示订阅';

  @override
  String get openAppSettings => '打开应用设置';

  @override
  String openAppSettingsFailed(Object error) {
    return '打开应用设置失败：$error';
  }

  @override
  String operationFailed(Object error) {
    return '操作失败：$error';
  }

  @override
  String get operationFailure => '操作失败';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get other => '其他';

  @override
  String get ourOtherApps => '我们的其他应用';

  @override
  String get overlayMode => '悬浮窗';

  @override
  String get overlayModeDescription => '在悬浮窗中显示来电信息';

  @override
  String get overlayPermission => '悬浮窗权限';

  @override
  String get overlayPermissionDescription => '用于显示来电悬浮窗。';

  @override
  String get overview => '概览';

  @override
  String get password => '密码';

  @override
  String get passwordCannotBeEmpty => '密码不能为空';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordsDoNotMatch => '密码不匹配';

  @override
  String get passwordSetSuccessfully => '密码设置成功';

  @override
  String get pattern => '模式';

  @override
  String get pendingSync => '待同步';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '周';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '权限请求被拒绝';

  @override
  String get permissionGranted => '权限已授予';

  @override
  String get permissionManagement => '权限管理';

  @override
  String get phoneCallsTab => '电话';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get phoneNumberCannotBeEmpty => '电话号码不能为空';

  @override
  String get phoneNumberHint => '输入电话号码';

  @override
  String get phoneNumberHintText => '输入要添加规则的电话号码';

  @override
  String get phoneNumberLabel => '电话号码';

  @override
  String get phoneNumberRegexRequired => '请输入电话号码和正则表达式';

  @override
  String get phoneNumberRequired => '电话号码是必需的';

  @override
  String get phoneNumberTypeFixedLine => '固定电话';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定电话或移动电话';

  @override
  String get phoneNumberTypeMobile => '移动电话';

  @override
  String get phoneNumberTypePager => '寻呼机';

  @override
  String get phoneNumberTypePersonalNumber => '个人号码';

  @override
  String get phoneNumberTypePremiumRate => '高价电话';

  @override
  String get phoneNumberTypeSharedCost => '分摊费用电话';

  @override
  String get phoneNumberTypeTollFree => '免费电话';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '未知';

  @override
  String get phoneNumberTypeVoicemail => '语音邮件';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '电话权限';

  @override
  String get phonePermissionDescription => '用于识别和阻止来电。';

  @override
  String get phoneRule => '电话规则';

  @override
  String get phoneRuleEditDialog => '电话规则编辑对话框';

  @override
  String get phoneRuleManagement => '电话规则管理';

  @override
  String get phoneRuleSubscription => '电话规则订阅';

  @override
  String get phoneSubscription => '电话订阅';

  @override
  String get phoneSubscriptionRulesDescription =>
      '通过 URL 订阅电话规则列表，以自动更新白名单和黑名单规则。支持 JSON 格式的规则文件。';

  @override
  String get phoneSubscriptionTitle => '电话规则订阅';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => '请选择一个标签并输入有效的电话号码';

  @override
  String pluginAddedSuccess(Object name) {
    return '插件 \"$name\" 添加成功';
  }

  @override
  String get pluginDeleted => '插件已删除';

  @override
  String get pluginLatestVersion => '插件已是最新版本';

  @override
  String get pluginListExportSuccess => '插件列表导出成功';

  @override
  String get pluginLoadedSuccessfully => '插件加载成功';

  @override
  String get pluginManagement => '插件管理';

  @override
  String get pluginManagementSubtitle => '管理和配置第三方插件';

  @override
  String get pluginManagementTitle => '插件管理';

  @override
  String get pluginName => '插件名称';

  @override
  String get pluginNotLoaded => '插件尚未加载。请先加载插件。';

  @override
  String pluginsDeleted(Object count) {
    return '成功删除 $count 个插件。';
  }

  @override
  String get pluginService => '插件服务';

  @override
  String get pluginTestPageTitle => '插件测试';

  @override
  String get pluginUpdateSuccess => '插件更新成功';

  @override
  String get pluginUrl => '插件 URL';

  @override
  String get pluginUrlCannotBeEmpty => '插件 URL 不能为空';

  @override
  String get pluginUrlHint => '输入插件 URL';

  @override
  String get pluginUrlLabel => '插件 URL';

  @override
  String get pluginVersion => '插件版本';

  @override
  String get political => '政治';

  @override
  String get powerfulSpamBlocking => '强大的垃圾邮件拦截';

  @override
  String get previousStep => '上一步';

  @override
  String get prioritizeRemoteAction => '优先使用远程操作设置';

  @override
  String get prioritizeRemoteActionDescription => '优先使用来自远程数据库的操作设置';

  @override
  String get processing => '处理中...';

  @override
  String get processingOperation => '处理中...';

  @override
  String get purchase => '购买';

  @override
  String get quarterlyMembership => '季度会员';

  @override
  String get quarterlyMembershipDescription => '解锁所有高级功能，每季度自动续订';

  @override
  String get queryButton => '查询';

  @override
  String get queryFailed => '查询失败';

  @override
  String get queryFailedLog => '查询失败';

  @override
  String get querying => '查询中...';

  @override
  String get queryingPhoneNumber => '查询电话号码';

  @override
  String get queryResultTitle => '查询结果';

  @override
  String get ready => '准备就绪！';

  @override
  String get receiveWeeklyStatistics => '接收每周统计信息';

  @override
  String get recruiter => '招聘人员';

  @override
  String get reEnterPasswordHint => '请重新输入密码';

  @override
  String get refresh => '刷新';

  @override
  String get refreshPermissionStatus => '刷新权限状态';

  @override
  String get refreshTooltip => '刷新';

  @override
  String regexError(Object error) {
    return '正则表达式错误：$error';
  }

  @override
  String regexErrorMessage(Object error) {
    return '正则表达式错误：$error';
  }

  @override
  String get regexPattern => '正则表达式';

  @override
  String get regexPatternExplanation => '正则表达式解释';

  @override
  String get regexPatternExplanationButton => '正则表达式解释';

  @override
  String get regexPatternLabel => '正则表达式';

  @override
  String get regexPatternsExamples => '使用标准正则表达式语法定义模式。例如：';

  @override
  String get regexPatternsForPhoneNumberMatching => '用于电话号码匹配的正则表达式';

  @override
  String get regexRule => '正则表达式规则';

  @override
  String regexRuleAddFailed(Object error) {
    return '添加正则表达式规则失败：$error';
  }

  @override
  String get regexRuleAddSuccess => '正则表达式规则添加成功';

  @override
  String get regexRuleManagement => '正则表达式规则管理';

  @override
  String get regexRuleNamePatternRequired => '规则名称和正则表达式不能为空';

  @override
  String get regexRules => '正则表达式规则';

  @override
  String get regexTesterTitle => '正则表达式测试器';

  @override
  String regexValidationFailed(Object error) {
    return '正则表达式验证失败：$error';
  }

  @override
  String get regexValidationSuccess => '正则表达式验证成功';

  @override
  String get region => '地区';

  @override
  String get registeredDevicesTitle => '注册设备';

  @override
  String get rejectAllCalls => '拒绝所有来电';

  @override
  String get rejectAllCallsDescription => '启用后，所有来电都将被以最高优先级拒绝';

  @override
  String get rejectAllNumbers => '拒绝所有号码';

  @override
  String get rejectAllNumbersDesc => '启用后，拒绝所有来电';

  @override
  String get rejectExceededNumbers => '拒绝超出数量的号码';

  @override
  String get rejectExceededNumbersDescription => '自动拒绝超过数量阈值的号码';

  @override
  String get remoteFilterSettings => '远程过滤设置';

  @override
  String get remoteFilterSettingsPageTitle => '远程号码过滤设置';

  @override
  String get remoteNumberFilter => '远程号码过滤';

  @override
  String get remoteNumberFilterDatabaseInfo => '此过滤器使用独立的远程数据库来获取最新的号码信息。';

  @override
  String get remoteNumberFilterDescription => '根据远程数据库信息拦截骚扰电话';

  @override
  String get remoteNumberFilterExplanationContent =>
      '远程号码过滤器通过查询基于号码计数的远程数据库来识别和阻止垃圾电话。';

  @override
  String get remoteNumberFilterExplanationTitle => '远程号码过滤说明';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• 数量阈值：根据号码出现频率确定';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• 过滤操作：配置如何处理超过阈值的号码';

  @override
  String get remoteNumberFilterFeaturePriority => '• 优先级设置：设置远程操作的优先级';

  @override
  String get remoteNumberFilterFeatures => '功能：';

  @override
  String get remoteNumberFiltering => '远程号码过滤';

  @override
  String get remoteNumberFilteringExplanation => '• 远程号码过滤：基于远程数据库信息的过滤规则';

  @override
  String get remoteNumberFilterSubtitle => '使用云数据库和社区报告识别垃圾电话';

  @override
  String get removeAdsDescription => '永久删除应用程序中的所有广告，以获得更流畅的体验';

  @override
  String get removeAdsTitle => '移除广告';

  @override
  String get removedFromFavoriteContacts => '从收藏联系人中移除';

  @override
  String get removedFromFavorites => '从收藏夹中移除';

  @override
  String get removeFavorite => '移除收藏';

  @override
  String get removeFromFavorites => '从收藏夹中移除';

  @override
  String get renameButton => '重命名';

  @override
  String get renameDeviceDialogTitle => '重命名设备';

  @override
  String get renameDeviceTitle => '重命名设备';

  @override
  String get replaceCurrentSettingsConfirmation => '这将替换您当前的所有设置。您确定要继续吗？';

  @override
  String get requestAllPermissions => '请求所有权限';

  @override
  String get requestPermission => '请求权限';

  @override
  String requestPermissionFailed(Object error) {
    return '请求权限失败：$error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 个标记';
  }

  @override
  String get reset => '重置';

  @override
  String get restore => '恢复';

  @override
  String get restoreApplicationSettingsFromBackup => '从备份恢复应用程序设置';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '从备份恢复应用程序设置';

  @override
  String get restoreButton => '恢复';

  @override
  String restoreFailedWithError(Object error) {
    return '从云恢复失败：$error';
  }

  @override
  String get restoreFromCloud => '从云恢复';

  @override
  String get restoreFromCloudDescription => '从云存储恢复设置和规则';

  @override
  String restoreFromCloudFailed(Object error) {
    return '从云恢复失败：$error';
  }

  @override
  String get restoreFromCloudLabel => '从云恢复';

  @override
  String get restoreFromCloudSuccess => '从云恢复成功';

  @override
  String get restoreFromCloudTitle => '从云恢复';

  @override
  String get restoreFromLocal => '从本地恢复';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restoreSectionTitle => '恢复';

  @override
  String get restoreSettings => '恢复设置';

  @override
  String get restoreSettingsConfirmation => '这将替换您当前的所有设置。您确定要继续吗？';

  @override
  String get restoreSettingsDialogTitle => '恢复设置';

  @override
  String get restoreSettingsTitle => '恢复设置';

  @override
  String get restoreSuccessFromLocal => '从本地恢复成功';

  @override
  String get restoreSuccessMessage => '从云恢复成功';

  @override
  String get retry => '重试';

  @override
  String get ridesharing => '共享出行';

  @override
  String get risk => '风险';

  @override
  String get robocall => '自动电话';

  @override
  String get ruleAction => '规则操作';

  @override
  String get ruleAddButton => '添加规则';

  @override
  String get ruleAddedSuccess => '规则添加成功';

  @override
  String ruleAddFailure(Object error) {
    return '添加规则失败：$error';
  }

  @override
  String get ruleAddSuccess => '规则添加成功';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '您确定要删除此$ruleType吗？';
  }

  @override
  String get ruleDeleteConfirmTitle => '删除规则';

  @override
  String get ruleDeletedSuccess => '规则删除成功';

  @override
  String get ruleDeletedSuccessfully => '规则删除成功';

  @override
  String ruleDeleteFailed(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String get ruleDeleteSuccess => '规则删除成功';

  @override
  String get ruleDisabledSuccessfully => '规则已成功禁用';

  @override
  String get ruleEnabledSuccessfully => '规则已成功启用';

  @override
  String ruleLoadFailed(Object error) {
    return '加载规则失败：$error';
  }

  @override
  String get ruleManagement => '规则管理';

  @override
  String get ruleManagementTitle => '规则管理';

  @override
  String get ruleName => '规则名称';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => '规则名称和内容正则表达式不能为空';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '规则名称和电话号码不能为空';

  @override
  String get ruleNameHint => '例如，家人、朋友等。';

  @override
  String get ruleNameLabel => '规则名称';

  @override
  String get ruleNamePatternRequired => '请输入规则名称和模式';

  @override
  String get ruleNameRequired => '规则名称和电话号码不能为空';

  @override
  String get ruleNotExist => '规则不存在或已被删除';

  @override
  String ruleNotFound(Object error) {
    return '未找到规则：$error';
  }

  @override
  String get ruleSavedSuccessfully => '规则保存成功！';

  @override
  String get ruleSavedSuccessMessage => '规则保存成功！';

  @override
  String ruleSaveFailed(Object error) {
    return '保存失败: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '保存失败: $error';
  }

  @override
  String get ruleSaveSuccess => '规则保存成功！';

  @override
  String get rulesExportedSuccessfully => '规则导出成功';

  @override
  String rulesExportedTo(Object path) {
    return '规则导出到: $path';
  }

  @override
  String get rulesImported => '规则导入成功';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count 条规则导入成功';
  }

  @override
  String rulesImportFailed(Object error) {
    return '导入规则失败: $error';
  }

  @override
  String get ruleStatistics => '规则统计';

  @override
  String ruleStatusChanged(Object status) {
    return '规则 $status 成功';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作失败: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '规则 $status 成功';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '更新规则失败: $error';
  }

  @override
  String get ruleUpdateSuccess => '规则更新成功';

  @override
  String get ruleVerification => '规则验证';

  @override
  String get save => '保存';

  @override
  String get saveButton => '保存';

  @override
  String get saveButtonLabel => '保存';

  @override
  String get saveButtonText => '保存';

  @override
  String saveFailed(Object error) {
    return '保存失败: $error';
  }

  @override
  String get saveFilter => '保存过滤器';

  @override
  String get saveSettings => '保存设置';

  @override
  String saveSettingsFailed(Object error) {
    return '保存设置失败: $error';
  }

  @override
  String get scamsLikely => '疑似诈骗';

  @override
  String get search => '搜索';

  @override
  String get searchContacts => '搜索联系人';

  @override
  String searchError(Object error) {
    return '搜索错误: $error';
  }

  @override
  String get searchFilters => '搜索过滤器';

  @override
  String get searchForContacts => '搜索联系人';

  @override
  String get searchHint => '搜索...';

  @override
  String get searchSettingsSubtitle => '搜索联系人、标签、黑名单、白名单等。';

  @override
  String get searchSettingsTitle => '搜索设置';

  @override
  String get securityMessage => '不要相信任何电话。始终独立验证客户服务号码。切勿分享密码、验证码、银行卡号或个人信息。';

  @override
  String get selectActionToPerform => '选择规则匹配时要执行的操作';

  @override
  String get selectActionWhenBlockingCalls => '选择阻止呼叫时的操作';

  @override
  String get selectActionWhenRuleMatches => '选择规则匹配时的操作';

  @override
  String get selectAll => '全选';

  @override
  String get selectCountry => '选择国家';

  @override
  String get selectDateRange => '选择日期范围';

  @override
  String get selectedDateRange => '所选日期范围';

  @override
  String selectedItems(Object count) {
    return '已选择 $count 项';
  }

  @override
  String get selectedLabel => '已选择：';

  @override
  String get selectExportFormat => '选择导出格式';

  @override
  String get selectLabel => '选择标签';

  @override
  String get selectLabelAndEnterPhoneNumber => '请选择一个标签并输入有效的电话号码';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selectMultiple => '选择多个';

  @override
  String get selectPeriod => '选择时间段';

  @override
  String get selectSimCard => '选择 SIM 卡';

  @override
  String get selectSimSlot => '选择 SIM 卡槽';

  @override
  String get selectSpecificActionForBlockedCalls => '选择阻止来电时要执行的特定操作';

  @override
  String get selectTag => '选择标签';

  @override
  String get selectTags => '选择标签';

  @override
  String get selectTrustedDataSource => '请选择受信任的数据源';

  @override
  String get selectYourLanguage => '选择您的语言';

  @override
  String get sender => '发送者';

  @override
  String get senderRegexOptional => '发送者正则表达式（可选）';

  @override
  String get serverAddressLabel => '服务器地址';

  @override
  String get serviceTypeContact => '联系人订阅';

  @override
  String get serviceTypeLabel => '服务类型';

  @override
  String get serviceTypePhone => '电话订阅';

  @override
  String get serviceTypePlugin => '插件更新';

  @override
  String get serviceTypeSms => '短信订阅';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '设置';

  @override
  String get setEncryptionPassword => '设置加密密码';

  @override
  String get setEncryptionPasswordDescription => '设置用于备份和恢复的加密密码';

  @override
  String get setEncryptionPasswordLabel => '设置加密密码';

  @override
  String get setEncryptionPasswordTitle => '设置加密密码';

  @override
  String get setPasswordButton => '设置';

  @override
  String get settings => '设置';

  @override
  String settingsBackedUpTo(Object path) {
    return '设置已备份到：$path';
  }

  @override
  String get settingsLoaded => '设置已加载';

  @override
  String settingsLoadFailed(Object error) {
    return '加载设置失败：$error';
  }

  @override
  String get settingsRestoredSuccessfully => '设置已成功恢复。请重启应用以使更改生效。';

  @override
  String get settingsSaved => '设置已保存';

  @override
  String settingsSaveFailed(Object error) {
    return '保存设置失败：$error';
  }

  @override
  String get settingsTab => '设置';

  @override
  String get settingsTitle => '设置';

  @override
  String get setup => '设置';

  @override
  String get showContactEditDialogStaticMethod => '用于显示联系人编辑对话框的静态方法';

  @override
  String get showExplanation => '显示说明';

  @override
  String get silence => '静音';

  @override
  String get silenceAndNoAnswer => '静音且不接听';

  @override
  String get silenceNoAnswer => '静音不接听';

  @override
  String get silentCallVoiceClone => '静音呼叫语音克隆';

  @override
  String get silentRules => '静音规则';

  @override
  String simCard(Object simNumber) {
    return 'SIM 卡 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 卡颜色';

  @override
  String get simCardConfigurationExplanation => '• SIM 卡配置：为每个 SIM 卡设置独立的过滤规则';

  @override
  String get simCardFilterRules => 'SIM 卡过滤规则';

  @override
  String get simCardFilterRulesDescription => '根据 SIM 卡槽设置不同的过滤规则';

  @override
  String get simCardFontSize => 'SIM 卡字体大小';

  @override
  String get simCardPosition => 'SIM 卡位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return '加载 SIM 卡信息失败：$error';
  }

  @override
  String get simRuleInstructions => 'SIM 卡槽规则允许您为每个 SIM 卡槽配置独立的过滤规则。';

  @override
  String get simRuleInstructionsTitle => 'SIM 卡槽规则';

  @override
  String get simRuleManagement => 'SIM卡槽规则管理';

  @override
  String simSlot1(String countryIso) {
    return 'SIM卡 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM卡 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return '加载SIM数据失败: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM卡槽过滤配置';

  @override
  String get simSlotFilterConfigurationDescription => '允许按SIM卡槽设置过滤规则';

  @override
  String get simSlotFilterDescription => '为每个SIM卡配置独立的过滤规则：';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM卡槽 $slotNumber 过滤设置';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return '加载SIM卡槽失败: $error';
  }

  @override
  String get simSlotManagement => 'SIM卡槽管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM卡槽操作失败: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM卡槽位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM卡槽规则：每个SIM卡独立的过滤策略';

  @override
  String get simSlotRuleListTitle => 'SIM卡槽规则列表';

  @override
  String get simSlotRuleManagement => 'SIM卡槽规则';

  @override
  String get simSlotRuleManagementTitle => '规则管理';

  @override
  String get simSlotSettings => 'SIM卡槽设置';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM卡槽 $slotNumber';
  }

  @override
  String get skip => '跳过';

  @override
  String get smartCallerId => '智能来电识别';

  @override
  String get sms => '短信';

  @override
  String get smsFilterDescription =>
      '短信过滤可帮助您自动过滤垃圾短信，并保持您的短信列表干净。您可以设置过滤规则和通知方法。';

  @override
  String get smsFilterDisabled => '短信过滤已禁用';

  @override
  String get smsFilterEnabled => '短信过滤已启用';

  @override
  String get smsFilterRuleAddedSuccessfully => '短信过滤规则添加成功';

  @override
  String get smsFilterRules => '短信过滤规则';

  @override
  String get smsFilterSettings => '短信过滤设置';

  @override
  String get smsHistory => '短信历史';

  @override
  String get smsManagement => '短信管理';

  @override
  String get smsPermission => '短信权限';

  @override
  String get smsPermissionDescription => '用于过滤垃圾短信。';

  @override
  String get smsRuleAddedSuccessfully => '短信规则添加成功';

  @override
  String get smsRuleDeletedSuccessfully => '短信规则删除成功';

  @override
  String smsRuleLoadFailed(Object error) {
    return '加载短信规则失败: $error';
  }

  @override
  String get smsRuleManagement => '短信规则管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return '短信规则已成功导出到 $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => '短信规则已成功导入';

  @override
  String get smsRuleSubscription => '短信规则订阅';

  @override
  String get smsRuleUpdatedSuccessfully => '短信规则更新成功';

  @override
  String get smsSettingsSubtitle => '短信过滤和关键词阻止';

  @override
  String get smsSettingsTitle => '短信设置';

  @override
  String get smsSubscription => '短信订阅';

  @override
  String get smsSubscriptionAddedSuccessfully => '短信订阅添加成功';

  @override
  String get smsSubscriptionRulesDescription =>
      '通过URL订阅短信规则列表，支持正则表达式匹配。您可以设置阻止或允许操作。';

  @override
  String get smsTab => '短信';

  @override
  String get somePermissionsDenied => '某些权限请求被拒绝';

  @override
  String get spamLikely => '可能是垃圾信息';

  @override
  String get startColor => '起始颜色';

  @override
  String get startDate => '开始日期';

  @override
  String get startUsing => '开始使用';

  @override
  String get statAnswered => '已接听';

  @override
  String get statBlocked => '已阻止';

  @override
  String get staticMethodShowCallerIdDialog => '用于显示来电显示信息对话框的静态方法';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      '用于显示国家/地区选择对话框的静态方法';

  @override
  String get staticMethodToDisplayDialog => '用于显示对话框的静态方法';

  @override
  String get statistics => '统计';

  @override
  String get statisticsExportFeatureComingSoon => '统计导出功能即将推出';

  @override
  String get statisticsGrid => '统计网格';

  @override
  String get statisticsPageTitle => '数据分析';

  @override
  String get stirColor => 'STIR 颜色';

  @override
  String get stirFontSize => 'STIR 字体大小';

  @override
  String get stirPosition => 'STIR 位置';

  @override
  String get storagePermission => '存储权限';

  @override
  String get storagePermissionDescription => '用于保存设置和规则。';

  @override
  String get subscribe => '订阅';

  @override
  String subscriptionAddSuccess(Object name) {
    return '成功添加订阅 \"$name\"';
  }

  @override
  String get subscriptionDeleteConfirmContent => '确定要删除此订阅吗？';

  @override
  String get subscriptionDeleteConfirmTitle => '删除订阅';

  @override
  String get subscriptionDeleted => '订阅已删除';

  @override
  String get subscriptionDeletedSuccessfully => '订阅已成功删除';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '删除订阅失败：$error';
  }

  @override
  String get subscriptionDeleteSuccess => '订阅已删除';

  @override
  String get subscriptionEmptyState => '没有可用的订阅';

  @override
  String get subscriptionEmptyText => '尚无订阅';

  @override
  String subscriptionLoadFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String get subscriptionManagementTitle => '订阅管理';

  @override
  String get subscriptionName => '订阅名称';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '订阅名称和 URL 不能为空';

  @override
  String get subscriptionNameHint => '输入订阅名称';

  @override
  String get subscriptionPageTitle => '订阅管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '更改订阅状态失败：$error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '切换订阅状态失败：$error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '更新订阅失败：$error';
  }

  @override
  String get subscriptionUpdateSuccess => '订阅已成功更新';

  @override
  String get subscriptionUrl => '订阅 URL';

  @override
  String get subscriptionUrlHint => '输入订阅 URL';

  @override
  String successfullyImportedRules(Object count) {
    return '成功导入 $count 条规则';
  }

  @override
  String get supportSync => '支持同步';

  @override
  String get survey => '调查';

  @override
  String get syncDevicesButton => '同步设备';

  @override
  String get syncFailed => '同步失败';

  @override
  String get syncFailedMessage => '同步失败';

  @override
  String get syncFolderNameHint => '请输入同步文件夹名称 (默认: NotificationManager)';

  @override
  String get syncFolderNameLabel => '同步文件夹名称';

  @override
  String get synchronized => '已同步';

  @override
  String get syncing => '正在同步...';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncStatusTitle => '同步状态';

  @override
  String get syncStatusUpdatedMessage => '同步状态已更新';

  @override
  String get syncSuccessful => '同步成功';

  @override
  String get syncSuccessMessage => '同步成功';

  @override
  String get syncWithCloudStorage => '与云存储同步';

  @override
  String get syncWithCloudStorageSubtitle => '与云存储同步';

  @override
  String get systemFeatures => '系统功能：';

  @override
  String get systemSettingsTitle => '系统设置';

  @override
  String get tabAll => '全部';

  @override
  String get tabAnswered => '已接听';

  @override
  String get tabBlocked => '已拦截';

  @override
  String get tabMissed => '未接来电';

  @override
  String get tabOutgoing => '已拨出';

  @override
  String tagLabel(String tag) {
    return '标签：$tag';
  }

  @override
  String get tagsUpdated => '标签已更新';

  @override
  String get takeaway => '外卖';

  @override
  String get telecommunication => '电信';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => '电话销售';

  @override
  String get testButton => '测试';

  @override
  String get testButtonLabel => '测试';

  @override
  String get testConnectionButton => '测试连接';

  @override
  String get textColorsSetting => '文本和标签颜色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '这款应用是一款强大的来电显示工具，可以识别并拦截不需要的来电。';

  @override
  String get thisWeek => '本周';

  @override
  String get timeInterceptor => '时间拦截器';

  @override
  String get timeInterceptorDescription => '根据呼叫频率自动拦截/允许潜在的呼叫';

  @override
  String get timeInterceptorExplanation => '• 时间拦截器：在短时间内拦截/允许重复呼叫';

  @override
  String get timeInterceptorExplanationContent =>
      '呼叫频率拦截功能分析呼叫频率，以自动识别和拦截/允许频繁的垃圾电话。';

  @override
  String get timeInterceptorExplanationTitle => '呼叫频率拦截说明';

  @override
  String get timeInterceptorSettingsTitle => '呼叫频率拦截设置';

  @override
  String get timeInterceptorSubtitle => '根据呼叫频率自动拦截潜在的垃圾电话';

  @override
  String get timeInterceptorTitle => '启用呼叫频率拦截';

  @override
  String get timeWindowDescription => '设置允许重复呼叫的时间窗口大小。来自同一号码在此窗口内的呼叫将被允许';

  @override
  String timeWindowLabel(int minutes) {
    return '拦截时间窗口（分钟）：$minutes';
  }

  @override
  String get timeWindowSetting => '设置允许重复呼叫的时间窗口大小。来自同一号码在此窗口内的呼叫将被允许';

  @override
  String get today => '今天';

  @override
  String get total => '总计';

  @override
  String get totalBlocked => '总拦截';

  @override
  String get totalFiltered => '总过滤';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '在设备或平台之间传输数据';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => '在设备或平台之间传输数据';

  @override
  String get travelTicketing => '旅游票务';

  @override
  String get trend => '趋势';

  @override
  String get trendChart => '趋势图';

  @override
  String get tutorial => '教程';

  @override
  String get type => '类型';

  @override
  String get unassignedSIMCard => '未分配的 SIM 卡';

  @override
  String get unknown => '未知';

  @override
  String get unknownLabel => '未知标签';

  @override
  String get unknownTag => '标签：未知';

  @override
  String get unregisterButton => '取消注册';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '确定要取消注册 $deviceName 吗？';
  }

  @override
  String get unregisterDeviceTitle => '取消注册设备';

  @override
  String get unsupportedFileFormat => '不支持的文件格式';

  @override
  String get update => '更新';

  @override
  String get updateAllNow => '立即全部更新';

  @override
  String get updateCallFilterConfig => '更新呼叫过滤配置';

  @override
  String updateContactFailed(Object error) {
    return '更新联系人失败：$error';
  }

  @override
  String get updateFavoriteStatus => '更新收藏状态';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '更新收藏状态失败：$error';
  }

  @override
  String get updateInterval => '更新间隔';

  @override
  String get updateLabelFailed => '更新标签失败';

  @override
  String get updateNow => '立即更新';

  @override
  String get updatePlugin => '更新插件';

  @override
  String updatePluginFailed(Object error) {
    return '更新插件失败：$error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '更新规则失败：$error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '更新订阅失败：$error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service 成功更新（$count 条规则）';
  }

  @override
  String get updateTags => '更新标签';

  @override
  String get useCasesPoint1 => '• 识别自动重拨的垃圾电话';

  @override
  String get useCasesPoint2 => '• 拦截在短时间内多次拨打的营销电话';

  @override
  String get useCasesPoint3 => '• 阻止电话轰炸和骚扰';

  @override
  String get useCasesTitle => '使用场景：';

  @override
  String get useGlobalSettings => '使用全局设置';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '用户名';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '使用标准正则表达式语法来定义模式。例如：';

  @override
  String get validateRegex => '验证正则表达式';

  @override
  String get verificationFailedText => '失败';

  @override
  String get verifiedText => '已验证';

  @override
  String get verify => '验证';

  @override
  String version(Object version) {
    return '版本：$version';
  }

  @override
  String get vipExchangeDescription => '用电话号码标记计数交换 VIP 会员资格';

  @override
  String get vipExchangeTitle => '标记交换 VIP';

  @override
  String get watchAd => '观看广告';

  @override
  String get watchAdForTemp => '观看广告以获得临时权限';

  @override
  String get watchAdForTempDescription => '观看一个短片广告，以暂时解锁一些高级功能';

  @override
  String get webDAVConfigTitle => 'WebDAV 配置';

  @override
  String get webdavConfigurationTitle => 'WebDAV 配置';

  @override
  String get webdavPasswordHint => '请输入 WebDAV 密码';

  @override
  String get webdavServerAddressHint => '请输入 WebDAV 服务器地址';

  @override
  String get webdavUsernameHint => '请输入 WebDAV 用户名';

  @override
  String get week => '周';

  @override
  String get weekly => '每周';

  @override
  String get weeklyBlockedCallsSummary => '每周拦截电话摘要';

  @override
  String get weeklyChartTitle => '每周拦截电话';

  @override
  String get weeklyReport => '每周报告';

  @override
  String get weeklyReportDesc => '接收每周的呼叫阻止活动总结报告';

  @override
  String get welcome => '欢迎';

  @override
  String get whitelist => '白名单';

  @override
  String get whitelistLabel => '白名单';

  @override
  String get width => '宽度';

  @override
  String get wildcardMatchingDescription =>
      '使用 \'.\' 匹配任何字符 (例如 \'123.456\' 匹配 123-456)';

  @override
  String get wildcardMatchingTitle => '通配符匹配:';

  @override
  String get wildcardSupportForFlexibleFiltering => '通配符支持灵活过滤';

  @override
  String get windowSizeSetting => '窗口大小';

  @override
  String get year => '年';

  @override
  String get yearly => '每年';

  @override
  String get yearlyChartTitle => '年度拦截通话';

  @override
  String get noSimCardsDetected => '未检测到 SIM 卡';

  @override
  String get filterManagementDescription => '设置呼叫过滤';

  @override
  String get callerIdCustomizationSubtitle => '自定义来电显示布局';

  @override
  String get fraudAlerSettingTitle => '欺诈警报设置';

  @override
  String get fraudAlerSettingSubtitle => '设置欺诈警报';

  @override
  String get enableFraudAlert => '启用欺诈警报';

  @override
  String get enableFraudAlertDescription => '疑似诈骗电话警报';

  @override
  String get enableVibration => '启用震动';

  @override
  String get enableVibrationDescription => '当呼叫疑似诈骗电话时震动';

  @override
  String get notificationSettingsTitle => '通知设置';

  @override
  String get useLocalNotification => '使用本地通知';

  @override
  String get useLocalNotificationDescription => '为来电启用本地通知';

  @override
  String get cancelLocalNotification => '关闭本地通知';

  @override
  String get useStirNotification => '使用来自 STIR 的通知';

  @override
  String get useStirNotificationDescription => '启用来自 STIR 的通知来电';

  @override
  String get cancelLocalNotificationDescription => '自动关闭本地通知';

  @override
  String get callerIdSettingsTitle => '来电显示设置';

  @override
  String get callerIdSettingsSubtitle => '设置来电通知和显示模式';

  @override
  String get purchaseTitle => '购买';

  @override
  String get purchaseSubtitle => '购买服务';

  @override
  String get callerIdNotificationTitle => '来电信息';

  @override
  String callerIdBody(String phoneNumber) {
    return '号码: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '已阻止的呼叫';

  @override
  String blockedCallBody(String phoneNumber) {
    return '已阻止来自 $phoneNumber 的呼叫';
  }

  @override
  String get stirVerified => '已验证';

  @override
  String get stirNotVerified => '未验证';

  @override
  String get stirFailed => '验证失败';

  @override
  String get stirUnknown => '未知的验证状态';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 验证';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '号码 $phoneNumber 的 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '滚动安全消息设置';

  @override
  String get messageColor => '消息颜色';

  @override
  String get messageFontSize => '消息字体大小';

  @override
  String get messagePosition => '消息位置';

  @override
  String get containerWidth => '容器宽度';

  @override
  String get scrollSpeed => '滚动速度';

  @override
  String get enableSecurityMessage => '启用安全消息';

  @override
  String get fraudAlertTitle => '欺诈警报';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '来自 $phoneNumber 的潜在欺诈电话';
  }

  @override
  String loadRulesFailed(Object error) {
    return '加载规则失败: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '加载通话记录失败: $error';
  }

  @override
  String get noBlockedTypeData => '无可用阻止类型数据';

  @override
  String importEntity(Object entityTypeName) {
    return '导入 $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName 导入成功，共导入 $count 条记录';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '导入 $entityTypeName 失败: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '导出 $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName 导出成功';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '导出 $entityTypeName 失败: $error';
  }

  @override
  String get cloudSyncService => '云同步服务';

  @override
  String get membershipCenter => '会员中心';

  @override
  String get redeemVipWithMarks => '使用积分兑换 VIP';

  @override
  String get currentMarkCount => '当前积分数量';

  @override
  String get markMoreNumbersForMore => '标记更多号码以获得更多积分';

  @override
  String get noAds => '无广告';

  @override
  String get cloudBackup => '云备份';

  @override
  String get callerIdEnhancement => '来电显示增强';

  @override
  String get voiceRecognition => '语音识别';

  @override
  String get feature => '功能';

  @override
  String get normalUser => '普通用户';

  @override
  String get vipUser => 'VIP 用户';

  @override
  String get temporaryVip => '临时 VIP';

  @override
  String get removeAds => '移除广告';

  @override
  String get unknownAction => '未知操作';

  @override
  String get settingsBackup => '设置备份';

  @override
  String get allServicesStatusTitle => '当前服务状态';

  @override
  String get allServicesStatusSubtitle => '每个云服务的当前状态';

  @override
  String get redirect => '重定向';

  @override
  String get notify => '通知';

  @override
  String get log => '日志';

  @override
  String get custom => '自定义';

  @override
  String get allowActionDescription => '即使号码在黑名单中，也将允许呼叫。';

  @override
  String get blockActionDescription => '呼叫将被阻止并显示在通话记录中。';

  @override
  String get silenceActionDescription => '呼叫将被静音但显示在通话记录中。';

  @override
  String get noneActionDescription => '不会对呼叫采取任何特殊操作。';

  @override
  String get redirectActionDescription => '将呼叫重定向到指定的号码。';

  @override
  String get labelActionDescription => '为呼叫添加标签，以便于识别。';

  @override
  String get notifyActionDescription => '收到呼叫时发送通知。';

  @override
  String get logActionDescription => '记录呼叫信息而不采取任何其他操作。';

  @override
  String get customActionDescription => '执行自定义操作。';

  @override
  String get synced => '已同步';

  @override
  String get needVipAccess => '您需要 VIP 权限才能使用此功能';

  @override
  String importExportDescription(Object entityTypeName) {
    return '导入或导出 $entityTypeName 数据';
  }

  @override
  String get importExportTitle => '导入/导出';

  @override
  String get noPhoneRules => '未找到电话规则';

  @override
  String get noRegexRules => '未找到正则表达式规则';

  @override
  String get noAllowedBlockedRules => '未找到允许/阻止规则';

  @override
  String get importExport => '导入/导出';

  @override
  String get filterByAction => '按操作筛选';

  @override
  String get upgradeToVip => '升级到 VIP';

  @override
  String get batteryOptimizationPermission => '电池优化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '允许应用程序在后台运行以提供来电显示等服务。';

  @override
  String get permissionTitle => '特殊权限';

  @override
  String get permissionSubtitle => '管理悬浮窗和电池优化权限';

  @override
  String get themeSettingsTitle => '主题设置';

  @override
  String get themeSettingsSubtitle => '选择你喜欢的主题';

  @override
  String get databaseSyncTitle => '数据库同步';

  @override
  String get countrySyncSettingsTitle => '基于国家的数据库同步设置';

  @override
  String get countrySyncSettingsSubtitle => '选择用于数据同步的国家';

  @override
  String get countryDataDisclaimer => '请注意：数据库可能不包含所有特定国家或地区的数据。';

  @override
  String get editSubscription => '编辑订阅';

  @override
  String get searchByNameOrPhoneNumber => '按姓名或电话号码搜索';

  @override
  String get allowedBlockedRulesInfo => '允许/阻止规则用于匹配特定电话号码的呼叫，具有最高优先级。';

  @override
  String get searchPhoneRulesHint => '搜索电话规则';

  @override
  String get phoneRulesInfo => '电话规则用于匹配特定电话号码的呼叫，优先级较低。有些来自 phoneRule 订阅';

  @override
  String get searchSubscriptionsHint => '搜索订阅';

  @override
  String get searchPluginsHint => '搜索插件';

  @override
  String get searchLabelsHint => '搜索标签';

  @override
  String get pluginDescription => '插件描述';

  @override
  String get enterPluginDescription => '输入插件描述';

  @override
  String get searchRegexRulesHint => '搜索正则表达式规则';

  @override
  String get regexRulesInfo => '正则表达式规则用于基于正则表达式模式过滤呼叫。';

  @override
  String get searchMarkedPhonesHint => '搜索标记的电话';

  @override
  String get searchContactSubscriptionsHint => '搜索联系人订阅';

  @override
  String get showAllContacts => '显示所有联系人';

  @override
  String get showFavorites => '显示收藏夹';

  @override
  String get manualEntry => '手动输入信息';

  @override
  String get scriptSaved => '脚本已保存';

  @override
  String editScriptFor(String pluginName) {
    return '编辑 $pluginName 的脚本';
  }

  @override
  String get saveScript => '保存脚本';

  @override
  String get testPlugin => '测试插件';

  @override
  String get description => '描述';

  @override
  String get accessTargetUrl => '访问目标 URL';

  @override
  String get result => '结果';

  @override
  String get editScript => '编辑脚本';

  @override
  String get numberFormat => '号码格式';

  @override
  String get nationalNumber => '国内号码';

  @override
  String get e164Number => 'E.164 号码';

  @override
  String get pluginRulesInfo => '为了安全起见，请仅使用来自可信来源的插件。 欢迎使用我们的模板创建您自己的自定义插件！';

  @override
  String get advancedMode => '高级模式';

  @override
  String get pleaseEnterAtLeastOneNumber => '请至少输入一个号码。';

  @override
  String get openInWebView => '在 WebView 中打开';

  @override
  String get pluginLabel => '插件标签';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '消息背景颜色';

  @override
  String get clearAllCallLogs => '清除所有通话记录';

  @override
  String get clearAllCallLogsConfirmation => '确认清除所有通话记录';

  @override
  String get allCallLogsCleared => '所有通话记录已清除';

  @override
  String get unblocked => '已取消阻止';

  @override
  String get blockNumber => '阻止号码';

  @override
  String get blockNumberSuccess => '阻止号码成功';

  @override
  String get blockNumberFailed => '阻止号码失败';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '确定要取消阻止 $phoneNumber 吗？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '正在呼叫 $phoneNumber...';
  }

  @override
  String get viewDetails => '查看详情';

  @override
  String get unblock => '取消阻止';

  @override
  String get unblockNumber => '取消阻止号码';

  @override
  String get unblockNumberSuccess => '号码已成功取消阻止';

  @override
  String get unblockNumberFailed => '取消阻止号码失败';

  @override
  String get serviceNotAvailable => '服务不可用';

  @override
  String get callingNumberFailed => '呼叫号码失败';

  @override
  String get listView => '列表视图';

  @override
  String get timelineView => '时间线视图';

  @override
  String get nameCannotBeEmpty => '名称不能为空';

  @override
  String get selectAction => '选择操作';

  @override
  String get selectTargetService => '选择目标服务';

  @override
  String get callDetails => '通话详情';

  @override
  String get callType => '通话类型';

  @override
  String get callTime => '通话时间';

  @override
  String get numberInvalidFormat => '号码格式无效';

  @override
  String get membershipFeature => '会员功能';

  @override
  String get medium => '媒介';

  @override
  String get verificationReport => '验证报告';

  @override
  String get finalRisk => '最终风险';

  @override
  String get simState => 'SIM 卡状态';

  @override
  String get ipCountry => 'IP 国家/地区';

  @override
  String get simCountry => 'SIM 卡国家/地区';

  @override
  String get isRoaming => '正在漫游';

  @override
  String get isNumberMatch => '号码匹配';

  @override
  String get support => '支持';

  @override
  String get rewardedAdService => '激励广告服务';

  @override
  String get hasVipPrivilegeExceptAds => '您已经拥有 VIP 权限（广告除外）';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '您已经拥有临时权限，到期日期：$expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '您需要观看 $count 个广告才能获得临时 VIP 权限';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '您已获得 $days 天的临时购买权限。到期日期：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '临时购买权限已过期';

  @override
  String get loadingAd => '正在加载广告...';

  @override
  String get earnedTempVip => '获得临时 VIP';

  @override
  String get vipExchangeService => 'VIP 兑换服务';

  @override
  String get marksInsufficient => '兑换积分不足';

  @override
  String get invalidExchangeRule => '无效的兑换规则';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '成功兑换 $description，到期日期：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '兑换失败：$error';
  }

  @override
  String get vip3DaysWithAds => '3 天 VIP（含广告，仅同步）';

  @override
  String get vip5DaysNoAds => '5 天全功能无广告 VIP';

  @override
  String get vip7DaysNoAds => '7 天全功能无广告 VIP';

  @override
  String get noNotifications => '没有通知';

  @override
  String get clearAllNotifications => '清除所有通知';

  @override
  String get clearAllNotificationsConfirmation => '确认清除所有通知';

  @override
  String get allNotificationsCleared => '所有通知已清除';

  @override
  String get clearButton => '清除';

  @override
  String get justNow => '刚刚';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟前',
      one: '1 分钟前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时前',
      one: '1 小时前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天前',
      one: '1 天前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨天';

  @override
  String get deletionProposal => '删除提议';

  @override
  String get deletionProposals => '删除提议';

  @override
  String get createProposal => '创建提议';

  @override
  String get createProposalTitle => '创建删除提议';

  @override
  String get reason => '原因';

  @override
  String get reasonOutdated => '号码已过期';

  @override
  String get reasonPrivacy => '隐私问题';

  @override
  String get reasonNotInService => '停止服务';

  @override
  String get reasonWronglyIdentified => '错误识别';

  @override
  String get reasonInaccurateInfo => '信息不准确';

  @override
  String get reasonWrongMarked => '标记错误';

  @override
  String get reasonOther => '其他';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get proposalStatus => '状态';

  @override
  String get statusPending => '待处理';

  @override
  String get statusActive => '进行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusExpired => '已过期';

  @override
  String get riskLevel => '风险等级';

  @override
  String get riskLevelVerified => '已验证';

  @override
  String get riskLevelLow => '低风险';

  @override
  String get riskLevelHigh => '高风险';

  @override
  String get riskLevelUnknown => '未知';

  @override
  String get votingProgress => '投票进度';

  @override
  String agreeVotes(int count) {
    return '同意: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反对: $count';
  }

  @override
  String totalVotes(int count) {
    return '总计: $count';
  }

  @override
  String get voteAgree => '同意';

  @override
  String get voteDisagree => '反对';

  @override
  String createdAt(String date) {
    return '创建时间: $date';
  }

  @override
  String get showReport => '显示报告';

  @override
  String get hideReport => '隐藏报告';

  @override
  String get proposalStatistics => '提议统计';

  @override
  String get totalProposals => '总提议数';

  @override
  String get activeProposals => '进行中提议';

  @override
  String get completedProposals => '已完成提议';

  @override
  String get myVotes => '我的投票';

  @override
  String get proposalCreated => '提议创建成功';

  @override
  String get proposalCreateFailed => '创建提议失败';

  @override
  String get voteSubmitted => '投票提交成功';

  @override
  String get voteSubmitFailed => '投票提交失败';

  @override
  String get noProposalsFound => '未找到提议';

  @override
  String get loadingProposals => '正在加载提议...';

  @override
  String get refreshProposals => '刷新提议';

  @override
  String get totalPendingProposals => '待处理提议总数';

  @override
  String get highRisk => '高风险';

  @override
  String get mediumRisk => '中风险';

  @override
  String get lowRisk => '低风险';

  @override
  String get communityImpact => '社区影响';

  @override
  String get criticalIssues => '关键问题';

  @override
  String get communityParticipation => '社区参与度';

  @override
  String get noActivity => '无活动';

  @override
  String get low => '低';

  @override
  String get moderate => '中等';

  @override
  String get high => '高';

  @override
  String get veryHigh => '很高';

  @override
  String get voted => '已投票';

  @override
  String get communityVotes => '社区投票';

  @override
  String get waitingForMoreVotes => '等待更多社区投票';

  @override
  String get proposalProcessed => '此提案已处理完成';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反对';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒绝';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待处理';

  @override
  String get critical => '严重';

  @override
  String get oppose => '反对';

  @override
  String get veryLow => '极低';

  @override
  String get deletionProposalNotificationDescription => '关于删除提议投票结果和更新的通知。';

  @override
  String get deletionProposalCreated => '删除提议已创建';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '您对 $phoneNumber 的删除提议已提交社区审核。';
  }

  @override
  String get proposalApproved => '提议已通过 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '对 $phoneNumber 的删除提议已被社区通过（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get proposalRejected => '提议已拒绝 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '对 $phoneNumber 的删除提议已被社区拒绝（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get communityVotingStarted => '社区投票已开始';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '对 $phoneNumber 的新删除提议现已开放社区投票。';
  }

  @override
  String get votingCompleted => '投票已完成';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '对 $phoneNumber 的社区投票已结束。结果：$result（$supportPercentage% 支持）。';
  }

  @override
  String get newVoteReceived => '收到新投票';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '有人投票$voteType删除 $phoneNumber。当前票数：$totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '加载投票数失败';

  @override
  String get voteCount => '投票数';

  @override
  String get deletionProposalInfo => '删除建议信息';

  @override
  String get deletionProposalDescription => '建议删除违反社区准则的号码。您的参与有助于保持平台安全。';

  @override
  String get voteToEarnVip => '对提案进行投票以赚取 VIP 特权！';

  @override
  String get voteFailed => '投票失败';

  @override
  String get searchProposals => '搜索建议';

  @override
  String get defaultNotifications => '默认通知';

  @override
  String get defaultNotificationsDescription => '应用程序的默认通知通道。';

  @override
  String get blockedCallNotifications => '拦截来电通知';

  @override
  String get blockedCallNotificationsDescription => '显示有关被阻止的呼叫的信息。';

  @override
  String get stirVerification => 'STIR/SHAKEN 验证';

  @override
  String get stirVerificationDescription => '显示号码的 STIR/SHAKEN 验证结果。';

  @override
  String get fraudAlerts => '欺诈警报';

  @override
  String get fraudAlertsDescription => '显示潜在欺诈呼叫的警告。';

  @override
  String get notificationFrequencyDescription =>
      '选择您接收有关新删除建议的通知频率。您可以立即、批量或按自定义间隔接收它们。';

  @override
  String get immediateNotifications => '立即';

  @override
  String get immediateNotificationsDescription => '一旦创建提案，立即收到通知。';

  @override
  String get batchNotifications => '批量';

  @override
  String get batchNotificationsDescription => '定期接收通知摘要。';

  @override
  String get customNotifications => '自定义';

  @override
  String get customNotificationsDescription => '定义您自己的接收通知的间隔。';

  @override
  String get customFrequency => '自定义频率';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 小时';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 小时 $minutes 分钟';
  }

  @override
  String get pendingProposals => '待定提案';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个待定提案',
      one: '1 个待定提案',
      zero: '没有待定提案',
    );
    return '您有 $_temp0。';
  }

  @override
  String get guidelinesLabel => '指南';

  @override
  String get reportingGuidelines =>
      '• 仅报告真正有问题的号码\n• 提供准确和详细的原因\n• 根据严重程度选择适当的风险等级\n• 虚假报告可能会导致帐户受限';

  @override
  String get riskLevelLabel => '风险等级';

  @override
  String get riskLevelDescription => '号码的风险等级';

  @override
  String get phoneNumberMinDigits => '电话号码必须至少为 7 位数字';

  @override
  String get provideDetailedExplanation => '提供详细的解释（最少 10 个字符）';

  @override
  String get reasonMinCharacters => '原因必须至少 10 个字符';

  @override
  String get countryCodeTwoLetters => '国家代码 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '国家代码 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '例如，US, CN, GB';

  @override
  String get countryCodeRequired => '需要国家代码';

  @override
  String get countryCodeLengthError => '国家代码必须为 2 个字母';

  @override
  String get phoneNumberLengthError => '电话号码必须至少为 7 位数字';

  @override
  String get reasonHint => '提供详细解释（至少 10 个字符）';

  @override
  String get reasonRequired => '必须填写理由';

  @override
  String get reasonLengthError => '理由必须至少 10 个字符';

  @override
  String get guidelinesTitle => '指南';

  @override
  String get guidelinesText =>
      '• 仅报告真正有问题的号码\n• 提供准确且详细的理由\n• 根据严重程度选择适当的风险等级\n• 虚假报告可能会导致帐户受限';

  @override
  String get riskLevelCritical => '严重';

  @override
  String get riskLevelMedium => '中等';

  @override
  String get riskLevelVeryLow => '非常低';

  @override
  String get riskDescriptionVeryLow => '非常低 - 轻微的烦恼，不频繁的通话';

  @override
  String get riskDescriptionLow => '低 - 偶尔的不必要电话';

  @override
  String get riskDescriptionMedium => '中等 - 定期垃圾邮件或电话销售';

  @override
  String get riskDescriptionHigh => '高 - 持久的骚扰或诈骗企图';

  @override
  String get riskDescriptionCritical => '严重 - 危险的诈骗或威胁';

  @override
  String get notificationFrequencyTitle => '通知频率';

  @override
  String get notificationFrequencyLabel => '通知频率（小时）';

  @override
  String errorMessage(String error) {
    return '错误：$error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票：$totalVotes（$supportPercentage% 支持）';
  }

  @override
  String supportCount(int supportCount) {
    return '支持（$supportCount）';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反对（$opposeCount）';
  }

  @override
  String get timeJustNow => '刚刚';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours小时前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days天前';
  }

  @override
  String get notificationFrequencyHours => '通知频率（小时）';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票（$supportPercentage% 支持）';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时',
      one: '1 小时',
      zero: '0 小时',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要提示';

  @override
  String get dataSourceDisclaimer =>
      '号码来自互联网和用户提交。我们无法保证某个号码一旦被删除，就不会被其他用户或来源重新提交。请积极搜索和验证信息。';

  @override
  String get avatar => '头像';

  @override
  String get location => '位置';

  @override
  String get simCardTitle => 'SIM 卡';

  @override
  String get liveActivitiesSettingsTitle => '实时活动设置';

  @override
  String get elementsSettingsTitle => '元素设置';

  @override
  String get liveActivityMode => '实时活动';

  @override
  String get liveActivityModeDescription => '在锁定屏幕和灵动岛 (iOS) 上将呼叫信息显示为持久通知。';

  @override
  String get phoneNumberType => '电话号码类型';

  @override
  String get liveActivitiesTestEndActivity => '结束活动';

  @override
  String get liveActivitiesTestSendNewActivity => '发送新活动';

  @override
  String get liveActivitiesTestUpdateActivity => '更新活动';

  @override
  String get liveActivityControlsTitle => '实时活动控件';

  @override
  String get liveActivitiesTestTitle => '实时活动测试';

  @override
  String get liveActivitiesTestSubtitle => '测试实时活动通知。';

  @override
  String get liveNotificationCustomizationTitle => '实时通知自定义';

  @override
  String get liveNotificationCustomizationSubtitle => '自定义实时通知的外观。';

  @override
  String get notification_instructions =>
      '说明：\n1. 点击“发送”以创建或更新通知。\n2. 转到您的主屏幕或下拉通知栏以查看结果。\n3. 点击“结束”以关闭通知。';

  @override
  String get autoCancelNotification => '自动取消通知';

  @override
  String get autoCancelNotificationDescription => '如果选中，当用户点击通知时，通知将自动关闭。';

  @override
  String get setDelayTime => '设置延迟时间';

  @override
  String get proposalDetails => '提案详情';

  @override
  String get filterByStatus => '按状态筛选';

  @override
  String get proposalNotFound => '未找到提案';

  @override
  String get processed => '已处理';

  @override
  String get showAll => '显示全部';

  @override
  String get filterAndSortTitle => '筛选和排序';

  @override
  String get filterVerifiedOwner => '筛选已验证的所有者';

  @override
  String get filterBy => '筛选方式';

  @override
  String get sortOldest => '按最旧排序';

  @override
  String get sortNewest => '按最新排序';

  @override
  String get sortMostPopular => '按最受欢迎排序';

  @override
  String get sortLeastPopular => '按最不受欢迎排序';

  @override
  String get sortBy => '排序方式';

  @override
  String get simRulesNotFound => '未找到 SIM 规则';

  @override
  String get simSlotRules => 'SIM 卡槽规则';

  @override
  String get noSimCardDetected => '未检测到 SIM 卡';

  @override
  String get invalidSimData => '无效的 SIM 数据';

  @override
  String get simCardData => 'SIM 卡数据';

  @override
  String get simSlot => 'SIM 卡槽';

  @override
  String get enableFiltering => '启用筛选';

  @override
  String get detailedSettingsTitle => '详细设置';

  @override
  String get entryPointViewTitle => '入口点视图';

  @override
  String get callTypeRejected => '已拒绝';

  @override
  String get callTypeSilenced => '已静音';

  @override
  String get callTypeVoicemail => '语音邮件';

  @override
  String get callTypeUnknownIntercept => '未知拦截';

  @override
  String andMoreItems(int count) {
    return '以及更多 $count 个项目';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

  @override
  String get localDatabaseSyncDescription =>
      'Connect your personal Supabase database to sync data across devices.';

  @override
  String get supabaseProjectUrl => 'Supabase Project URL';

  @override
  String get supabaseAnonKey => 'Anon Key';

  @override
  String get supabaseAnonKeyHint => 'API Key, anon public key';

  @override
  String get connectionString => 'Connection String (URI)';

  @override
  String get connectionStringHelper =>
      'Only needed for \'Initialize Database\'';

  @override
  String get syncCallHistory => 'Sync Call History';

  @override
  String get syncCallHistorySubtitle => 'Include private call logs in sync';

  @override
  String get requiredField => 'Required';

  @override
  String get requiredInitField => 'Required for initialization';

  @override
  String get initDbButton => 'Initialize Database';

  @override
  String get dbInitSuccess => 'Database Initialized Successfully!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Sync Complete. Sent: $pushed, Received: $pulled';
  }

  @override
  String get errorPrefix => 'Error';

  @override
  String get errorLoadingSettings => 'Error loading settings';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusConnected => 'Connected / Configured';

  @override
  String get statusNotConfigured => 'Not Configured';

  @override
  String get lastSync => 'Last Sync';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get aboutContactSubscription => '关于联系人订阅';

  @override
  String get aboutLabels => '关于标签';

  @override
  String get aboutPhoneSubscriptionRules => '关于电话订阅规则';

  @override
  String get aboutPhoneSubscriptions => '关于电话订阅';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      '通过 URL 订阅电话规则列表，自动更新规则。支持 JSON、CSV 格式的规则文件。';

  @override
  String get aboutSmsFilter => '关于短信过滤';

  @override
  String get aboutSmsSubscriptionRules => '关于短信订阅规则';

  @override
  String get aboutSubtitle => '应用版本和法律信息';

  @override
  String get aboutTitle => '关于';

  @override
  String get action => '操作';

  @override
  String get actionAll => '全部';

  @override
  String get actionAllow => '允许';

  @override
  String get actionBlock => '阻止';

  @override
  String get actionFilterAll => '全部过滤';

  @override
  String get actionFilterTitle => '按操作类型过滤';

  @override
  String get actionFilterTooltip => '操作过滤器';

  @override
  String get actionNone => '无操作';

  @override
  String get actionSilence => '静音';

  @override
  String actionTag(Object actionType) {
    return '操作: $actionType';
  }

  @override
  String get actionType => '操作类型';

  @override
  String get actionUnknown => '未知';

  @override
  String get add => '添加';

  @override
  String get addAllowedBlockedRule => '添加允许/阻止规则';

  @override
  String get addAllowSubscription => '添加允许订阅';

  @override
  String get addBlockSubscription => '添加阻止订阅';

  @override
  String get addContactButton => '添加联系人';

  @override
  String addContactFailed(Object error) {
    return '添加联系人失败: $error';
  }

  @override
  String get addedToAllowedRules => '已添加到允许规则';

  @override
  String get addedToBlacklist => '已添加到黑名单';

  @override
  String get addedToBlockedRules => '已添加到阻止规则';

  @override
  String get addedToFavoriteContacts => '已添加到收藏联系人';

  @override
  String get addedToFavorites => '已添加到收藏联系人';

  @override
  String get addedToWhitelist => '已添加到白名单';

  @override
  String get addFavorite => '添加收藏';

  @override
  String get addFilter => '添加过滤器';

  @override
  String get addLabel => '添加标签';

  @override
  String get addLabelButton => '添加标签';

  @override
  String addLabelFailed(Object error) {
    return '添加标签失败: $error';
  }

  @override
  String get addLabelToCall => '为通话记录添加标签';

  @override
  String get addName => '添加名称';

  @override
  String get addNoneSubscription => '添加无订阅';

  @override
  String get addOrEditContactInfo => '用于添加或编辑联系人信息';

  @override
  String get addPhoneMark => '添加电话标记';

  @override
  String get addPhoneNumberRule => '添加电话号码规则';

  @override
  String get addPlugin => '添加插件';

  @override
  String get addPluginFailed => '添加插件失败';

  @override
  String addPluginFailedWithError(Object error) {
    return '添加插件失败: $error';
  }

  @override
  String get addPluginFromLocalFile => '从本地文件添加插件';

  @override
  String get addPluginFromUrl => '从 URL 添加插件';

  @override
  String get addRegexRule => '添加正则表达式规则';

  @override
  String get addRule => '添加规则';

  @override
  String get addRuleButton => '添加规则';

  @override
  String addRuleFailed(Object error) {
    return '添加规则失败：$error';
  }

  @override
  String get addRuleTooltip => '添加规则';

  @override
  String get addSilenceSubscription => '添加静音订阅';

  @override
  String get addSimRuleButton => '添加 SIM 卡规则';

  @override
  String get addSmsFilterRule => '添加短信过滤规则';

  @override
  String get addSmsRule => '添加短信规则';

  @override
  String get addSmsSubscription => '添加短信订阅';

  @override
  String get addSubscription => '添加订阅';

  @override
  String get addSubscriptionButton => '添加订阅';

  @override
  String addSubscriptionFailed(Object error) {
    return '添加订阅失败：$error';
  }

  @override
  String get addSubscriptionTooltip => '添加订阅';

  @override
  String get addToAllowedRules => '添加到允许规则';

  @override
  String get addToBlacklist => '添加到黑名单';

  @override
  String get addToBlockedRules => '添加到阻止规则';

  @override
  String get addToFavoriteContacts => '添加到收藏联系人';

  @override
  String get addToFavorites => '添加到收藏夹';

  @override
  String get addToRules => '添加到规则';

  @override
  String get addToWhitelist => '添加到白名单';

  @override
  String get adPlaceholder => '广告占位符';

  @override
  String get agent => '代理';

  @override
  String get all => '全部';

  @override
  String get allCallsTab => '全部';

  @override
  String get allDataClearedSuccessfully => '所有数据已成功清除';

  @override
  String get allow => '允许';

  @override
  String get allowAllAllowRules => '允许所有允许规则';

  @override
  String get allowAllAllowRulesDesc => '允许来自允许规则的呼叫';

  @override
  String get allowAllBlacklistedNumbers => '允许所有黑名单号码';

  @override
  String get allowAllBlacklistedNumbersDesc => '允许来自黑名单的呼叫';

  @override
  String get allowAllBlockRules => '允许所有阻止规则';

  @override
  String get allowAllBlockRulesDesc => '允许来自阻止规则的呼叫';

  @override
  String get allowAllowedNumbers => '允许允许的号码';

  @override
  String get allowAllowedNumbersDesc => '允许来自白名单的呼叫';

  @override
  String get allowBlock => '允许/阻止';

  @override
  String get allowBlockedNumbers => '允许阻止的号码';

  @override
  String get allowBlockedNumbersDesc => '允许来自黑名单的呼叫';

  @override
  String get allowedBlockedRule => '允许/阻止规则';

  @override
  String get allowedBlockedRuleEditDialogTitle => '编辑允许/阻止规则';

  @override
  String get allowedBlockedRuleManagement => '允许/阻止规则管理';

  @override
  String get allowNonExceededNumbers => '允许未超出限制的号码';

  @override
  String get allowNonExceededNumbersDescription => '自动允许未超过计数阈值的号码';

  @override
  String get allowRegexAllowRules => '允许正则表达式允许规则';

  @override
  String get allowRegexAllowRulesDesc => '为允许规则启用正则表达式模式匹配';

  @override
  String get allowRegexAllowRulesDescription => '启用基于正则表达式的允许规则';

  @override
  String get allowRegexBlockRules => '允许正则表达式阻止规则';

  @override
  String get allowRegexBlockRulesDesc => '为阻止规则启用正则表达式模式匹配';

  @override
  String get allowRegexBlockRulesDescription => '启用基于正则表达式的阻止规则';

  @override
  String get allowRule => '允许规则';

  @override
  String get allowRules => '允许规则';

  @override
  String get allowWhitelistedNumbers => '允许白名单号码';

  @override
  String get allowWhitelistedNumbersDescription => '允许白名单中的所有号码';

  @override
  String get allPermissionsGranted => '已授予所有权限';

  @override
  String get allSettingsCompleted => '所有设置已完成。';

  @override
  String allUpdateSuccess(Object count) {
    return '所有更新已完成（$count 条规则）';
  }

  @override
  String get answerThenHangup => '接听然后挂断';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule。保留所有权利。';

  @override
  String get applicationSoftware => '应用软件';

  @override
  String get apply => '应用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => '授权失败：请检查客户端 ID 和密钥';

  @override
  String get authorizationFailedMessage => '授权失败';

  @override
  String get authorizationSuccessMessage => '授权成功';

  @override
  String get authorizeLoginButton => '授权登录';

  @override
  String get automotiveIndustry => '汽车工业';

  @override
  String get autoSyncLabel => '自动同步';

  @override
  String get autoUpdate => '自动更新';

  @override
  String get autoUpdateDescription => '设置订阅的自动更新间隔或手动更新';

  @override
  String get autoUpdateSettings => '自动更新设置';

  @override
  String get autoUpdateSettingsSubtitle => '管理规则和插件的自动更新';

  @override
  String get autoUpdateSettingsTitle => '自动更新设置';

  @override
  String get autoUpdateSubtitle => '管理规则和插件的自动更新';

  @override
  String get autoUpdateTitle => '自动更新';

  @override
  String get avatarBorderColor => '头像边框颜色';

  @override
  String get avatarBorderSize => '头像边框大小';

  @override
  String get avatarIconSizesSetting => '头像和图标大小';

  @override
  String get avatarPosition => '头像位置';

  @override
  String get avatarSize => '头像大小';

  @override
  String axisPosition(Object axis) {
    return '$axis 位置';
  }

  @override
  String get backgroundGradientSetting => '背景渐变';

  @override
  String get backup => '备份';

  @override
  String get backupAndRestore => '备份和还原';

  @override
  String get backupAndRestoreSubtitle => '备份或还原应用程序数据';

  @override
  String get backupAndRestoreTitle => '备份和还原';

  @override
  String get backupFailed => '备份失败';

  @override
  String get backupFailedMessage => '备份失败';

  @override
  String backupFailedWithError(Object error) {
    return '备份失败：$error';
  }

  @override
  String get backupRestoreSubtitle => '备份或还原应用程序数据';

  @override
  String get backupRestoreTitle => '备份和还原';

  @override
  String get backupSectionTitle => '备份';

  @override
  String get backupSettings => '备份设置';

  @override
  String get backupSettingsDialogTitle => '备份设置';

  @override
  String get backupSettingsTitle => '备份设置';

  @override
  String get backupSuccessMessage => '成功备份到云';

  @override
  String backupSuccessToLocal(Object path) {
    return '备份成功到：$path';
  }

  @override
  String get backupToCloud => '备份到云';

  @override
  String get backupToCloudDescription => '将设置和规则备份到云存储';

  @override
  String backupToCloudFailed(Object error) {
    return '备份到云失败：$error';
  }

  @override
  String get backupToCloudLabel => '备份到云';

  @override
  String get backupToCloudSuccess => '成功备份到云';

  @override
  String get backupToCloudTitle => '备份到云';

  @override
  String get backupToLocalLabel => '备份到本地';

  @override
  String get bank => '银行';

  @override
  String get basicInfo => '基本信息';

  @override
  String get basicRuleFilter => '基本规则过滤';

  @override
  String get basicRuleFiltering => '基本规则过滤';

  @override
  String get basicRuleFilteringExplanation => '• 基本规则过滤：基于黑名单、白名单和正则表达式的过滤规则';

  @override
  String get basicRuleFilterSettings => '基本规则过滤设置';

  @override
  String get basicRuleFilterSubtitle => '使用黑名单/白名单和正则表达式过滤呼叫';

  @override
  String get batchDeleteContacts => '批量删除联系人';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '确定要删除 $count 个选定的联系人吗？';
  }

  @override
  String get batchDeleteFailed => '批量删除失败';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '确定要删除 $count 个标签吗？';
  }

  @override
  String get blacklist => '黑名单';

  @override
  String get blacklistingAndWhitelisting => '黑名单和白名单';

  @override
  String get blacklistLabel => '黑名单';

  @override
  String get blackWhiteList => '黑/白名单';

  @override
  String get block => '阻止';

  @override
  String get blockCalls => '阻止呼叫';

  @override
  String get blocked => '已阻止';

  @override
  String get blockedCallAction => '已阻止的呼叫操作';

  @override
  String get blockedCalls => '已阻止的呼叫';

  @override
  String get blockedCallsTitle => '已阻止的呼叫';

  @override
  String get blockedCommunications => '已阻止的通讯';

  @override
  String get blockedPhoneLabel => '已阻止的呼叫';

  @override
  String get blockedSpamCalls => '已阻止的垃圾呼叫';

  @override
  String get blockingTrend => '阻止趋势';

  @override
  String get blockInternationalCalls => '匹配不以 + 或 00 开头的号码';

  @override
  String get blockInternationalCallsTitle => '阻止国际呼叫';

  @override
  String get blockLandlineNumbersTitle => '阻止座机号码';

  @override
  String get blockMobileNumbers => '匹配不以 13-19 开头的号码';

  @override
  String get blockMobileNumbersTitle => '阻止手机号码';

  @override
  String get blockPremiumRateNumbers => '匹配不以 118 或 120-190 开头的号码';

  @override
  String get blockPremiumRateNumbersTitle => '阻止高价号码';

  @override
  String get blockRule => '阻止规则';

  @override
  String get blockRules => '阻止规则';

  @override
  String get blockSpecificAreaCodes => '匹配以 0 + 2-3 位数字开头的号码';

  @override
  String get blockSpecificAreaCodesTitle => '阻止特定区号：';

  @override
  String get blockTypeAnalysisTitle => '阻止类型分析';

  @override
  String get both => '两者';

  @override
  String get bulkDelete => '批量删除联系人';

  @override
  String get bulkDeleteContacts => '批量删除联系人';

  @override
  String get bulkDeleteLabels => '批量删除标签';

  @override
  String get call => '呼叫';

  @override
  String get callback => '回拨';

  @override
  String callbackTo(String number) {
    return '回拨至 $number';
  }

  @override
  String get callBlocking => '呼叫阻止';

  @override
  String get callerIdApp => '来电显示应用';

  @override
  String get callerIdCustomizationTitle => '自定义来电显示';

  @override
  String get callerIdDialogTitle => '来电显示信息';

  @override
  String get callerIdDisplayMode => '来电显示模式';

  @override
  String callerIdMarkedByCount(Object count) {
    return '被标记 $count 次';
  }

  @override
  String get callerIdPreview => '来电显示预览';

  @override
  String get callFilter => '来电过滤';

  @override
  String get callFilterDescription =>
      '启用后，来电将根据以下规则列表进行检查。默认情况下，呼叫过滤规则不会在设备之间同步。';

  @override
  String get callFilterRules => '来电过滤规则';

  @override
  String get callFilterRulesDescription => '设置来电过滤的基本规则';

  @override
  String get callFilterSettings => '来电过滤设置';

  @override
  String get callFrequencyInterceptionSubtitle => '设置呼叫频率限制和阻止规则';

  @override
  String get callFrequencyInterceptionTitle => '呼叫频率拦截';

  @override
  String get callHistory => '通话记录';

  @override
  String get callHistoryInfoDesc => '此处显示您的通话记录，包括来电、去电和未接来电。';

  @override
  String get callHistoryInfoTitle => '通话记录';

  @override
  String callHistoryInitFailed(Object error) {
    return '初始化通话记录失败: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '刷新通话记录失败: $error';
  }

  @override
  String get callHistoryTab => '通话记录';

  @override
  String get callHistoryTimelineEarlier => '更早';

  @override
  String get callHistoryTimelineToday => '今天';

  @override
  String get callHistoryTimelineYesterday => '昨天';

  @override
  String get callScreeningPermission => '来电筛选权限';

  @override
  String get callScreeningPermissionDescription => '用于筛选和阻止垃圾电话。';

  @override
  String get callScreeningPermissionNotGranted => '未授予来电筛选权限，可能会影响应用程序功能。';

  @override
  String get callSettingsSubtitle => '来电显示、过滤和阻止设置';

  @override
  String get callSettingsTitle => '通话设置';

  @override
  String get callStatistics => '通话统计';

  @override
  String get callTypeAnswered => '已接听';

  @override
  String get callTypeBlocked => '已阻止';

  @override
  String get callTypeIconColor => '通话类型图标颜色';

  @override
  String get callTypeMissed => '未接来电';

  @override
  String get callTypeOutgoing => '已拨出';

  @override
  String get callTypePosition => '通话类型位置';

  @override
  String get callTypeUnknown => '未知';

  @override
  String get cancelButton => '取消';

  @override
  String get carRental => '汽车租赁';

  @override
  String get carrier => '运营商';

  @override
  String get carrierColor => '运营商颜色';

  @override
  String get carrierFontSize => '运营商字体大小';

  @override
  String get carrierPosition => '运营商位置';

  @override
  String get changeLabel => '更改标签';

  @override
  String changePluginStatusFailed(Object error) {
    return '更改插件状态失败: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '更改订阅状态失败: $error';
  }

  @override
  String get changeTag => '更改标签';

  @override
  String get charity => '慈善机构';

  @override
  String chartMonthFormat(int month) {
    return '月份 $month';
  }

  @override
  String get chartOneDayAgo => '1 天前';

  @override
  String get chartOneMonthAgo => '1 个月前';

  @override
  String get chartOneWeekAgo => '1 周前';

  @override
  String get chartTenDaysAgo => '10 天前';

  @override
  String get chartThreeDaysAgo => '3 天前';

  @override
  String get chartToday => '今天';

  @override
  String get checkFileFormat => '请检查文件格式或权限';

  @override
  String checkPermissionFailed(Object error) {
    return '检查权限失败：$error';
  }

  @override
  String get chooseDefaultInterceptAction => '选择默认拦截操作';

  @override
  String get clearAllData => '清除所有数据';

  @override
  String get clearAllDataConfirmation => '确定要清除所有应用程序数据吗？此操作无法撤销。';

  @override
  String get clearAllDataDescription => '清除所有应用程序数据';

  @override
  String get clearAllDataLabel => '清除所有数据';

  @override
  String get clearFilter => '清除过滤器';

  @override
  String get clearLabelFilter => '清除标签过滤器';

  @override
  String get clearLabelFilterButton => '清除标签过滤器';

  @override
  String get closeButton => '关闭';

  @override
  String get cloudSync => '云同步';

  @override
  String get cloudSyncAndBackupTitle => '云同步和备份';

  @override
  String get cloudSyncSettingsSubtitle => '配置 WebDAV、OneDrive 和 Google Drive';

  @override
  String get cloudSyncSettingsTitle => '云同步设置';

  @override
  String get cloudSyncTitle => '云同步';

  @override
  String get collapseLabelSelector => '折叠标签选择器';

  @override
  String get collection => '催收';

  @override
  String get colorPickerTitle => '选择颜色';

  @override
  String get configManagement => '配置管理';

  @override
  String get configUpdated => '配置已更新';

  @override
  String get configurationAdvice => '通过适当的配置，您可以为工作和个人 SIM 卡设置不同的过滤策略。';

  @override
  String get configureBackupOptions => '配置备份选项';

  @override
  String get configureBackupOptionsSubtitle => '配置备份选项';

  @override
  String get configureCloudSyncService => '配置云同步服务';

  @override
  String get configureCloudSyncServiceHint => '请配置云同步服务以启用多设备同步。';

  @override
  String get configureCloudSyncServiceMessage => '请配置云同步服务以启用多设备同步。';

  @override
  String get configureSimCardFilterRules => '配置 SIM 卡过滤规则';

  @override
  String get configureSyncServiceHint => '请先在云同步设置中配置同步服务';

  @override
  String get confirm => '确认';

  @override
  String get confirmBatchDeleteContacts => '确定要删除所选';

  @override
  String get confirmButton => '确认';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get confirmDeleteContact => '确定要删除';

  @override
  String get confirmDeleteContactName => '确认删除？';

  @override
  String get confirmDeleteFilter => '确定要删除此过滤器吗？';

  @override
  String confirmDeleteLabel(Object name) {
    return '确定要删除标签 \"$name\" 吗';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '确定要删除插件 \"$name\" 吗？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '确定要删除 $count 个插件吗？';
  }

  @override
  String get confirmDeleteRuleMessage => '确定要删除此规则吗？此操作无法撤销。';

  @override
  String get confirmDeleteSelectedContacts => '确定要删除选定的联系人吗？';

  @override
  String get confirmDeleteSmsFilterRule => '确定要删除此短信过滤规则吗？';

  @override
  String get confirmDeleteSmsRule => '确定要删除此短信规则吗？';

  @override
  String get confirmDeleteSubscription => '确定要删除此订阅吗？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get confirmPassword => '确认密码';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get connectedStatus => '已连接';

  @override
  String get connectionFailedCheckCredentialsMessage => '连接失败：请检查服务器地址、用户名和密码';

  @override
  String get connectionFailedMessage => '连接失败';

  @override
  String get connectionStatusLabel => '连接状态';

  @override
  String get connectionSuccessMessage => '连接成功';

  @override
  String get contactAddSuccess => '联系人添加成功';

  @override
  String get contactDeleted => '联系人已删除';

  @override
  String get contactEditDialog => '联系人编辑对话框';

  @override
  String get contactNameHint => '输入联系人姓名（可选）';

  @override
  String get contactNameLabel => '姓名';

  @override
  String get contactNameOptional => '联系人姓名（可选）';

  @override
  String get contactNotFound => '未找到联系人';

  @override
  String get contacts => '联系人';

  @override
  String contactsDeleted(Object count) {
    return '已删除 $count 个联系人';
  }

  @override
  String get contactSettingsSubtitle => '联系人管理和标签设置';

  @override
  String get contactSettingsTitle => '联系人设置';

  @override
  String contactsLoadingFailed(Object error) {
    return '加载联系人失败: $error';
  }

  @override
  String get contactsManagement => '联系人管理';

  @override
  String get contactsManagementPageTitle => '联系人管理页面';

  @override
  String get contactsPageTitle => '联系人管理';

  @override
  String get contactsPermission => '联系人权限';

  @override
  String get contactsPermissionDescription => '用于识别联系人来电。';

  @override
  String get contactsTab => '联系人';

  @override
  String get contactSubscriptionDescription =>
      '通过 URL 订阅联系人列表，自动更新联系人信息和标签。支持 JSON 格式数据。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '加载联系人订阅失败: $error';
  }

  @override
  String get contactSubscriptionPageTitle => '联系人订阅';

  @override
  String get contactUpdateSuccess => '联系人更新成功';

  @override
  String get contactUs => '联系我们';

  @override
  String get content => '内容';

  @override
  String get contentRegex => '内容正则表达式';

  @override
  String get countColor => '计数颜色';

  @override
  String get countFontSize => '计数字体大小';

  @override
  String get countPosition => '计数位置';

  @override
  String get country => '国家/地区';

  @override
  String get countryNameColor => '国家/地区名称颜色';

  @override
  String get countryNameFontSize => '国家/地区名称字体大小';

  @override
  String get countryRegionNamePosition => '国家/地区名称位置';

  @override
  String get countrySelectionDialog => '国家/地区选择对话框';

  @override
  String get countrySelectionDialogDescription => '用于选择国家/地区以查询来电显示信息';

  @override
  String get countThresholdDescription => '设置触发过滤操作所需的最小计数阈值';

  @override
  String get countThresholdLabel => '计数阈值';

  @override
  String get countThresholdSettings => '计数阈值设置';

  @override
  String countThresholdValue(Object count) {
    return '计数阈值: $count';
  }

  @override
  String get createdRules => '已创建规则';

  @override
  String get csvFormat => 'CSV 格式';

  @override
  String get currentDeviceChip => '当前';

  @override
  String get currentDeviceLabel => '当前设备标签';

  @override
  String get currentDeviceTitle => '当前设备';

  @override
  String get currentLabels => '当前标签:';

  @override
  String get currentLanguage => '当前语言';

  @override
  String get currentPasswordLabel => '当前密码';

  @override
  String get customerService => '客户服务';

  @override
  String get customRange => '自定义范围';

  @override
  String get dailyStatistics => '每日统计';

  @override
  String get dailyStatisticsDesc => '接收有关被阻止的呼叫和消息的每日统计信息';

  @override
  String get dashboardTab => '仪表盘';

  @override
  String get dataAnalysis => '数据分析';

  @override
  String get dataAnalysisDashboardPage => '数据分析仪表盘页面';

  @override
  String get dataExport => '数据导出';

  @override
  String dataLoadFailure(Object error) {
    return '数据加载失败：$error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '加载数据失败：$error';
  }

  @override
  String get dataMigration => '数据迁移';

  @override
  String get dataMigrationDescription =>
      '此功能允许您在设备之间传输所有数据。目前，您可以使用备份和还原功能手动迁移数据。';

  @override
  String get dataMigrationDialogContent =>
      '此功能允许您在设备之间传输所有数据。目前，您可以使用备份和还原功能手动迁移数据。';

  @override
  String get dataMigrationDialogTitle => '数据迁移';

  @override
  String get dataMigrationSectionTitle => '数据迁移';

  @override
  String get dataSourceReminder => '数据源提醒';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
      one: '1 天',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 天 VIP';
  }

  @override
  String get debtCollection => '催收';

  @override
  String get defaultPeriod => '周';

  @override
  String get delete => '删除';

  @override
  String get deleteButton => '删除';

  @override
  String get deleteContact => '删除联系人';

  @override
  String deleteContactConfirm(Object name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get deleteContactConfirmation => '确定要删除联系人吗';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '确定要删除 $deviceName 吗？';
  }

  @override
  String get deleteDeviceDialogTitle => '删除设备';

  @override
  String deleteFailed(Object error) {
    return '删除失败：$error';
  }

  @override
  String get deleteFilter => '删除过滤器';

  @override
  String get deleteLabel => '删除标签';

  @override
  String deleteLabelFailed(Object error) {
    return '删除标签失败：$error';
  }

  @override
  String get deletePlugin => '删除插件';

  @override
  String deletePluginFailed(Object error) {
    return '删除插件失败：$error';
  }

  @override
  String get deletePlugins => '删除插件';

  @override
  String deletePluginsFailed(Object error) {
    return '删除插件失败：$error';
  }

  @override
  String get deleteRule => '删除规则';

  @override
  String deleteRuleFailed(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String get deleteSelected => '删除所选';

  @override
  String get deleteSmsRule => '删除短信规则';

  @override
  String get deleteSubscription => '删除订阅';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '确定要删除订阅 \"$name\" 吗？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '删除订阅失败：$error';
  }

  @override
  String get deleteSuccess => '删除成功';

  @override
  String get delivery => '交付';

  @override
  String get deviceDeletedSuccessfully => '设备已成功删除';

  @override
  String get deviceDeletedSuccessfullyMessage => '设备已成功删除';

  @override
  String get deviceIdLabel => '设备 ID';

  @override
  String get deviceIDLabel => '设备 ID';

  @override
  String get deviceManagementSubtitle => '管理多设备同步';

  @override
  String get deviceManagementTitle => '设备管理';

  @override
  String get deviceModelLabel => '设备型号';

  @override
  String get deviceName => '设备名称';

  @override
  String get deviceNameCannotBeEmpty => '设备名称不能为空';

  @override
  String get deviceNameHint => '请输入设备名称';

  @override
  String get deviceNameLabel => '设备名称';

  @override
  String get deviceRenamedSuccessfully => '设备重命名成功';

  @override
  String get deviceRenamedSuccessfullyMessage => '设备重命名成功';

  @override
  String get devicesSyncedSuccessfully => '设备同步成功';

  @override
  String get devicesSyncedSuccessfullyMessage => '设备同步成功';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '设备同步成功';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '设备注销成功';

  @override
  String get dialogTitle => '正则表达式说明';

  @override
  String get differentFromLocalCounter =>
      '此功能与本地计数器过滤器不同，因为它侧重于短时间内的重复呼叫模式，而不是长期标记计数。';

  @override
  String get disabled => '已禁用';

  @override
  String get disabledStatus => '已禁用';

  @override
  String get disableGlobalPlugins => '禁用全局插件';

  @override
  String get disableSubscriptionSuccessfully => '禁用订阅成功';

  @override
  String get disconnectButton => '断开连接';

  @override
  String get disconnectedMessage => '已断开连接';

  @override
  String get disconnectedStatus => '已断开连接';

  @override
  String get disconnectFailedMessage => '断开连接失败';

  @override
  String get done => '完成';

  @override
  String get dualSimAdvice => '此功能对于双 SIM 卡手机尤其有用，可以为工作和个人 SIM 卡设置不同的过滤策略。';

  @override
  String get earlier => '更早';

  @override
  String get ecommerce => '电子商务';

  @override
  String get edit => '编辑';

  @override
  String get editContact => '编辑联系人';

  @override
  String get editFilter => '编辑过滤器';

  @override
  String get editLabel => '编辑标签';

  @override
  String get editPhoneRule => '编辑电话规则';

  @override
  String get editPhoneRules => '用于编辑电话规则';

  @override
  String get editPhoneRuleTitle => '编辑电话规则';

  @override
  String get editRule => '编辑规则';

  @override
  String get editSmsRule => '编辑短信规则';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '元素位置';

  @override
  String get email => '电子邮件';

  @override
  String get emailOptional => '电子邮件（可选）';

  @override
  String get enableCallFilter => '启用呼叫过滤';

  @override
  String get enableCallFilterDescription =>
      '启用后，传入呼叫将根据以下规则列表进行检查。默认情况下，呼叫过滤规则不会在设备之间同步。';

  @override
  String get enabled => '已启用';

  @override
  String get enabledStatus => '已启用';

  @override
  String get enableEncryption => '启用加密';

  @override
  String get enableEncryptionDescription => '加密备份文件';

  @override
  String get enableEncryptionLabel => '启用加密';

  @override
  String get enableEncryptionSubtitle => '备份文件将被加密';

  @override
  String get enableEncryptionTitle => '启用加密';

  @override
  String get enableGlobalPlugins => '启用全局插件';

  @override
  String get enableLocalCountFilter => '启用本地计数过滤器';

  @override
  String get enableLocalCountFilterDescription => '根据呼叫标记计数自动过滤垃圾呼叫';

  @override
  String get enableLocalNotification => '使用本地通知';

  @override
  String get enableLocalNotificationDescription => '启用后，过滤后的消息的通知将显示在设备上';

  @override
  String get enableLocationSummary => '位置';

  @override
  String get enableMuteRules => '启用静音规则';

  @override
  String get enableMuteRulesDesc => '应用静音拦截规则配置';

  @override
  String get enableNoneActionRules => '启用无操作规则';

  @override
  String get enableNoneActionRulesDesc => '允许没有拦截操作的规则配置';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get enableRemoteNumberFilter => '启用远程号码过滤';

  @override
  String get enableRemoteNumberFilterDescription => '使用远程数据库过滤号码';

  @override
  String get enableRule => '启用规则';

  @override
  String get enableSmsFilter => '启用短信过滤';

  @override
  String get enableSmsFilterDescription => '启用后，消息将根据规则自动过滤';

  @override
  String get enableStatisticsNotifications => '启用统计通知';

  @override
  String get enableSubscriptionSuccessfully => '成功启用订阅';

  @override
  String get enableTimeInterception => '启用时间拦截';

  @override
  String get enableTimeInterceptionDescription => '在短时间内拦截重复呼叫';

  @override
  String get enableTimeInterceptor => '启用时间拦截器';

  @override
  String get endCallImmediately => '立即结束通话';

  @override
  String get endColor => '结束颜色';

  @override
  String get endDate => '结束日期';

  @override
  String get enhancedFilterInstructionsTitle => '增强型过滤系统';

  @override
  String get enhancedFilterSettings => '增强型过滤设置';

  @override
  String get enhancedFilterSettingsTitle => '增强型过滤设置';

  @override
  String get enhancedFilterSystemDescription => '增强型过滤系统支持全局规则和每个 SIM 卡的过滤配置。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '请输入电话号码和正则表达式模式';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => '请输入电话号码和正则表达式模式。';

  @override
  String get enterContactName => '请输入联系人姓名';

  @override
  String get enterCurrentPasswordHint => '请输入当前密码';

  @override
  String get enterDeviceName => '输入设备名称';

  @override
  String get enterDeviceNameHint => '请输入设备名称';

  @override
  String get enterEmail => '请输入电子邮件';

  @override
  String get enterEmailOptional => '请输入电子邮件（可选）';

  @override
  String get enterEncryptionPasswordHint => '输入加密密码';

  @override
  String get enterEncryptionPasswordTitle => '输入加密密码';

  @override
  String get enterFilterName => '请输入过滤器名称';

  @override
  String get enterFilterPattern => '请输入过滤模式';

  @override
  String get enterIconCode => '输入图标代码';

  @override
  String get enterName => '输入联系人姓名';

  @override
  String get enterNewDeviceNameHint => '输入此设备的新名称';

  @override
  String get enterNewPasswordHint => '请输入新密码';

  @override
  String get enterPasswordAgain => '再次输入密码';

  @override
  String get enterPasswordHint => '请输入密码';

  @override
  String get enterPhoneNumber => '输入电话号码';

  @override
  String get enterPhoneNumberHint => '输入电话号码进行测试';

  @override
  String get enterPhoneNumberMultiple => '请输入电话号码，多个号码用逗号分隔';

  @override
  String get enterPhoneNumberToStartSearch => '输入电话号码以开始搜索';

  @override
  String get enterPhoneNumberToVerify => '输入电话号码以验证';

  @override
  String get enterPluginName => '输入插件名称';

  @override
  String get enterPluginUrl => '输入插件 URL 地址';

  @override
  String get enterRegexHint => '输入正则表达式模式';

  @override
  String get enterRuleNameAndPattern => '请输入规则名称和模式';

  @override
  String get enterRuleNameAndPatternMessage => '请输入规则名称和正则表达式模式。';

  @override
  String get enterRuleNameHint => '输入规则名称';

  @override
  String get enterSearchContent => '请输入搜索内容';

  @override
  String get enterSubscriptionName => '输入订阅名称';

  @override
  String get enterSubscriptionUrl => '输入订阅 URL';

  @override
  String get enterSyncFolderNameHint => '请输入同步文件夹名称（默认：NotificationManager）';

  @override
  String get entertainment => '娱乐';

  @override
  String get enterValidNameAndUrl => '请输入有效的名称和 URL';

  @override
  String get enterValidUrl => '请输入有效的 URL';

  @override
  String get enterVersion => '输入版本';

  @override
  String get enterWebDAVPasswordHint => '请输入 WebDAV 密码';

  @override
  String get enterWebDAVServerAddressHint => '请输入 WebDAV 服务器地址';

  @override
  String get enterWebDAVUsernameHint => '请输入 WebDAV 用户名';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '删除设备时出错：$error';
  }

  @override
  String get errorLoadingPlugin => '加载插件时出错';

  @override
  String errorOccurredMessage(Object error) {
    return '发生错误：$error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '重命名设备时出错：$error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '同步设备时出错：$error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '同步设备时出错：$error';
  }

  @override
  String get errorText => '错误';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '注销设备时出错：$error';
  }

  @override
  String get exampleBlock400Prefix => '例如，阻止 400 前缀号码';

  @override
  String get exampleBlockMarketingSms => '例如，阻止营销短信';

  @override
  String get exampleContentRegex => '例如，.*offer.*';

  @override
  String get exampleContentRegexHint => '内容正则表达式示例';

  @override
  String get exampleCouponPromotionDiscount => '例如，.*(优惠券|促销|折扣).*';

  @override
  String get exampleFamilyFriends => '例如，家人、朋友等';

  @override
  String get examplePhoneNumber => '例如，10086、12345 等';

  @override
  String get exampleRegex400Prefix => '400 前缀的正则表达式示例';

  @override
  String get exampleRegexFormat => '示例：^10086\$ 格式';

  @override
  String get exampleSenderRegexHint => '示例';

  @override
  String get exchange => '兑换';

  @override
  String get exchangeNow => '立即兑换';

  @override
  String get exchangeVip => '兑换 VIP';

  @override
  String get expandLabelSelector => '展开标签选择器';

  @override
  String expiryTime(Object time) {
    return '到期时间：$time';
  }

  @override
  String get export => '导出';

  @override
  String get exportAllApplicationSettings => '导出所有应用程序设置';

  @override
  String get exportAllApplicationSettingsSubtitle => '导出所有应用程序设置';

  @override
  String get exportAllRuleConfigurations => '导出所有规则配置';

  @override
  String get exportAllRuleConfigurationsSubtitle => '导出所有规则配置';

  @override
  String get exportComplete => '导出完成';

  @override
  String get exportConfig => '导出配置';

  @override
  String get exportContacts => '导出联系人';

  @override
  String get exportData => '导出数据';

  @override
  String get exportError => '导出错误';

  @override
  String get exportFailed => '导出失败';

  @override
  String get exportFailure => '导出配置失败';

  @override
  String get exportFeatureComingSoon => '导出功能即将推出';

  @override
  String get exporting => '正在导出...';

  @override
  String get exportLabels => '导出标签';

  @override
  String exportLabelsFailed(Object error) {
    return '导出标签失败: $error';
  }

  @override
  String get exportPluginList => '导出插件列表';

  @override
  String exportPluginListFailed(Object error) {
    return '导出插件列表失败: $error';
  }

  @override
  String get exportRules => '导出规则';

  @override
  String get exportRulesDialogTitle => '导出规则';

  @override
  String get exportRulesTitle => '导出规则';

  @override
  String get exportSmsRules => '导出短信规则';

  @override
  String get exportStatisticsData => '导出统计数据';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get exportSuccesslly => '配置导出成功';

  @override
  String get failedToAddContact => '添加联系人失败';

  @override
  String failedToAddRule(Object error) {
    return '添加规则失败: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return '添加短信规则失败: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return '添加短信订阅失败: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '备份设置失败: $error';
  }

  @override
  String get failedToDecryptBackupFile => '解密备份文件失败';

  @override
  String get failedToDeleteDevice => '删除设备失败';

  @override
  String failedToDeleteSmsRule(Object error) {
    return '删除短信规则失败: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return '导出规则失败: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return '导出短信规则失败: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '获取来电显示信息失败: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return '导入规则失败: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return '导入短信规则失败: $error';
  }

  @override
  String get failedToLoadContacts => '加载联系人失败';

  @override
  String get failedToLoadPlugin => '加载插件失败';

  @override
  String get failedToRenameDevice => '重命名设备失败';

  @override
  String get failedToRestoreSettings => '恢复设置失败';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '恢复设置失败: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '设置密码失败: $error';
  }

  @override
  String get failedToSyncDevices => '同步设备失败';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '切换规则状态失败: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '切换订阅状态失败';

  @override
  String get failedToUpdateContact => '更新联系人失败';

  @override
  String failedToUpdateSmsRule(Object error) {
    return '更新短信规则失败: $error';
  }

  @override
  String get failure => '失败';

  @override
  String get favoriteContacts => '收藏的联系人';

  @override
  String get featureAddRules => '• 添加特定电话号码的规则';

  @override
  String get featureCenter => '功能中心';

  @override
  String get featureEnableDisable => '• 启用/禁用每个SIM卡的不同过滤器';

  @override
  String get featureListTitle => '功能：';

  @override
  String get featureManageRules => '• 管理每个SIM卡的规则列表';

  @override
  String get features => '功能';

  @override
  String get fetchingCallerIdInfo => '正在获取来电显示信息...';

  @override
  String fileSavedTo(Object path) {
    return '文件保存到：$path';
  }

  @override
  String get filter => '过滤器';

  @override
  String get filterByLabel => '按标签过滤';

  @override
  String get filterClear => '清除过滤器';

  @override
  String get filterControlPanelTitle => '过滤器控制面板';

  @override
  String get filterControlSubtitle => '管理所有过滤器的开启/关闭状态';

  @override
  String get filterControlTitle => '筛选器控制';

  @override
  String get filterDeleteFailed => '筛选器删除失败';

  @override
  String get filterDeleteSuccess => '筛选器删除成功';

  @override
  String get filterDetails => '筛选器详情';

  @override
  String get filtered => '已筛选';

  @override
  String get filteredSms => '已筛选短信';

  @override
  String get filteredSmsLabel => '已筛选短信';

  @override
  String get filterExplanation => '筛选器说明';

  @override
  String get filterManagement => '筛选器管理';

  @override
  String get filterName => '筛选器名称';

  @override
  String get filterPattern => '筛选器模式';

  @override
  String get filterPriorityNote => '注意：筛选器之间存在优先级关系，详情请参考帮助文档';

  @override
  String get filterSaveFailed => '筛选器保存失败';

  @override
  String get filterSaveSuccess => '筛选器保存成功';

  @override
  String get filterSettings => '筛选器设置';

  @override
  String get filterSettingsTitle => '筛选器设置';

  @override
  String get filterSMS => '筛选短信';

  @override
  String get filterToggleInstructions => '为此 SIM 卡槽启用或禁用筛选器：';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status 筛选器：$filterName';
  }

  @override
  String get filterType => '筛选器类型';

  @override
  String get financial => '金融';

  @override
  String get flexibleCombinationFeature => '• 灵活组合：为每个 SIM 卡槽启用/禁用筛选器';

  @override
  String get fontSizesSetting => '字体大小';

  @override
  String foundRules(Object count) {
    return '找到 $count 条规则';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '找到 $count 条规则。是否要导入它们？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '找到 $count 条规则。是否要导入它们？';
  }

  @override
  String get fraudAlert => '欺诈警报 - 挂断电话';

  @override
  String get fraudScamLikely => '疑似欺诈诈骗';

  @override
  String get free => '免费';

  @override
  String get functionSettingsTitle => '功能设置';

  @override
  String generalUpdateFailure(Object error) {
    return '更新失败：$error';
  }

  @override
  String get getFree => '获取免费';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '配置所有 SIM 卡的全局筛选器：';

  @override
  String get globalFilterFeature => '• 全局筛选器：所有来电的基本规则';

  @override
  String get globalFilterSettings => '全局筛选器设置';

  @override
  String get globalFilterToggleInstructions => '配置应用于所有 SIM 卡槽的全局筛选器设置：';

  @override
  String get globalSearchSubtitle => '搜索联系人、标签、黑名单、白名单等';

  @override
  String get globalSearchTitle => '全局搜索';

  @override
  String get globalSettings => '全局设置';

  @override
  String get googleAdDisplayPosition => 'Google 广告展示位置';

  @override
  String get googleAdMobIntegrationText => '可以在此处集成 Google AdMob 广告';

  @override
  String get googleDriveAuthDescription =>
      '使用系统配置的 Google Drive 客户端 ID 和密钥进行授权';

  @override
  String get googleDriveAuthorizationHint =>
      '使用系统配置的 Google Drive 客户端 ID 和密钥进行授权';

  @override
  String get googleDriveConfigTitle => 'Google Drive 配置';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive 配置';

  @override
  String get government => '政府';

  @override
  String get granted => '已授予';

  @override
  String get grantNecessaryPermissions => '授予必要的权限';

  @override
  String get grantPermissions => '授予权限';

  @override
  String get headhunter => '猎头';

  @override
  String get height => '身高';

  @override
  String get homePageTitle => '主页';

  @override
  String get homeTab => '主页';

  @override
  String get howItWorksPoint1 => '• 系统将自动允许在设定的时间窗口内来自同一号码的呼叫';

  @override
  String get howItWorksPoint2 => '• 较短的时间窗口会导致更严格的拦截；较长的时间窗口会导致更宽松的拦截';

  @override
  String get howItWorksPoint3 => '• 系统检查通话记录以确定是否是重复呼叫';

  @override
  String get howItWorksTitle => '工作原理：';

  @override
  String get iconCodeOptional => '图标代码（可选）';

  @override
  String get iconSize => '图标大小';

  @override
  String get import => '导入';

  @override
  String get important => '重要';

  @override
  String get importButton => '导入';

  @override
  String get importConfig => '导入配置';

  @override
  String get importContacts => '导入联系人';

  @override
  String get importExportContacts => '导入/导出联系人';

  @override
  String get importExportContactsTooltip => '导入/导出联系人';

  @override
  String get importExportRules => '导入/导出规则';

  @override
  String importFailed(Object error) {
    return '导入失败：$error';
  }

  @override
  String get importFailure => '导入配置失败';

  @override
  String get importFeatureComingSoon => '导入功能即将推出';

  @override
  String get importLabels => '导入标签';

  @override
  String importLabelsFailed(Object error) {
    return '导入标签失败：$error';
  }

  @override
  String get importPluginList => '导入插件列表';

  @override
  String importPluginListFailed(Object error) {
    return '导入插件列表失败：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '成功导入 $count 个插件';
  }

  @override
  String get importRuleConfigurationsFromFile => '从文件导入规则配置';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '从文件导入规则配置';

  @override
  String get importRules => '导入规则';

  @override
  String get importRulesButton => '导入规则';

  @override
  String get importRulesDialogTitle => '导入规则';

  @override
  String importRulesError(Object error) {
    return '导入规则失败：$error';
  }

  @override
  String get importRulesInstructions => '从 CSV 文件导入规则';

  @override
  String get importRulesSuccess => '规则导入成功';

  @override
  String get importRulesTitle => '导入规则';

  @override
  String get importSuccess => '导入成功';

  @override
  String get incomingCallInterceptAction => '来电拦截动作';

  @override
  String get incomingCallNotification => '来电通知';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get initializing => '正在初始化';

  @override
  String get installed => '已安装';

  @override
  String get insufficientMarks => '分数不足';

  @override
  String get insurance => '保险';

  @override
  String get interceptAction => '拦截动作';

  @override
  String get interceptionActionSettingsSubtitle => '设置如何处理被阻止的呼叫';

  @override
  String get interceptionActionSettingsTitle => '拦截动作设置';

  @override
  String get interceptionTimeInterval => '拦截时间间隔';

  @override
  String get internet => '互联网';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 更新间隔设置为 $days 天';
  }

  @override
  String get invalidContentRegex => '无效的内容正则表达式';

  @override
  String get invalidLabel => '无效标签';

  @override
  String get invalidRegexPattern => '无效的正则表达式模式';

  @override
  String get invalidSenderRegex => '无效的发件人正则表达式';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '加入 Telegram 频道和群组以获取更多信息';

  @override
  String get jsLogsTitle => 'JS 日志';

  @override
  String get jsonFormat => 'JSON 格式';

  @override
  String get keepAllVersions => '保留所有版本';

  @override
  String get keepAllVersionsDescription => '保留每个备份的所有历史版本';

  @override
  String get keepAllVersionsLabel => '保留所有版本';

  @override
  String get keepAllVersionsSubtitle => '保留每个备份的历史版本';

  @override
  String get keepAllVersionsTitle => '保留所有版本';

  @override
  String get label => '标签';

  @override
  String labelAddedSuccessfully(Object name) {
    return '成功添加标签 \"$name\"';
  }

  @override
  String get labelCategories => '标签类别';

  @override
  String get labelDeleted => '标签已删除';

  @override
  String get labelDescription => '标签可帮助您更好地管理联系人，将自定义标签添加到电话号码，以便于识别来电和消息。';

  @override
  String get labelFilter => '标签筛选';

  @override
  String get labelFilterTooltip => '标签筛选';

  @override
  String get labelIconColor => '标签图标颜色';

  @override
  String get labelManagement => '标签管理';

  @override
  String get labelNotFound => '未找到标签';

  @override
  String get labelRemoved => '标签已移除';

  @override
  String labelRemoveFailed(Object error) {
    return '移除标签失败：$error';
  }

  @override
  String get labels => '标签';

  @override
  String get labelsColor => '标签颜色';

  @override
  String labelsDeleted(Object count) {
    return '已删除 $count 个标签';
  }

  @override
  String get labelsExportedSuccessfully => '标签导出成功';

  @override
  String get labelsFontSize => '标签字体大小';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '成功导入 $count 个标签';
  }

  @override
  String get labelsPosition => '标签位置';

  @override
  String labelTag(Object labelId) {
    return '标签: $labelId';
  }

  @override
  String get labelUpdated => '标签已更新';

  @override
  String labelUpdateFailed(Object error) {
    return '更新标签失败：$error';
  }

  @override
  String get labelUpdateSuccess => '标签 \"\$labelText\" 更新成功';

  @override
  String get languageSettings => '语言设置';

  @override
  String get languageSettingsSubtitle => '更改应用程序显示语言';

  @override
  String get languageSettingsTitle => '语言设置';

  @override
  String get last30Days => '最近 30 天';

  @override
  String get last7Days => '最近 7 天';

  @override
  String get lastSyncLabel => '上次同步';

  @override
  String lastUpdated(Object date) {
    return '上次更新时间：$date';
  }

  @override
  String get lifetimeMembership => '终身会员';

  @override
  String get lifetimeMembershipDescription => '一次性购买，永久解锁所有高级功能和未来更新';

  @override
  String loadContactsFailed(Object error) {
    return '加载联系人失败：$error';
  }

  @override
  String get loadDataFailed => '加载数据失败';

  @override
  String get loadFailed => '加载失败';

  @override
  String get loading => '加载中...';

  @override
  String get loadingData => '正在加载数据...';

  @override
  String get loadingTags => '正在加载标签...';

  @override
  String loadLabelFailed(Object error) {
    return '加载标签失败：$error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '加载标签失败：$error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '加载标记的电话号码失败：$error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '加载标记的电话失败：$error';
  }

  @override
  String get loadMore => '加载更多';

  @override
  String get loadPluginButton => '加载插件';

  @override
  String loadPluginsFailed(Object error) {
    return '加载插件失败：$error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '加载设置失败：$error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return '加载短信规则失败：$error';
  }

  @override
  String get loadStatusFailedMessage => '加载状态失败';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String get loan => '贷款';

  @override
  String get localBackupTitle => '本地备份';

  @override
  String get localCounterFilter => '本地计数器过滤器';

  @override
  String get localCounterFilterSubtitle => '根据通话频率自动过滤垃圾电话';

  @override
  String get localCountFilter => '本地计数过滤器';

  @override
  String get localCountFilterDescription => '根据本地号码计数拦截频繁的呼叫';

  @override
  String get localCountFilterExplanationContent =>
      '本地计数过滤器分析通话历史记录，以自动识别和阻止频繁的垃圾电话。';

  @override
  String get localCountFilterExplanationTitle => '本地计数过滤器说明';

  @override
  String get localCountFilterHowItWorksPoint1 => '• 确定是否根据号码的计数值进行阻止';

  @override
  String get localCountFilterHowItWorksPoint2 => '• 当号码的计数超过设置的阈值时，您可以选择自动阻止它';

  @override
  String get localCountFilterHowItWorksPoint3 => '• 您可以选择允许未超过阈值的号码';

  @override
  String get localCountFilterHowItWorksPoint4 => '• 您可以选择是否记录所有查询日志';

  @override
  String get localCountFiltering => '本地计数过滤';

  @override
  String get localCountFilteringExplanation => '• 本地计数过滤：基于本地标记计数的过滤规则';

  @override
  String get localCountFilterSettings => '本地计数过滤器设置';

  @override
  String get localCountFilterUseCases => '此过滤器特别适合于识别自动拨打的垃圾电话和营销电话。';

  @override
  String get localFilterSettings => '本地过滤器设置';

  @override
  String get localNotificationDisabled => '本地通知已禁用';

  @override
  String get localNotificationEnabled => '本地通知已启用';

  @override
  String get localServices => '本地服务';

  @override
  String get locationColor => '位置颜色';

  @override
  String get locationFontSize => '位置字体大小';

  @override
  String get locationIconColor => '位置图标颜色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => '记录所有本地查询';

  @override
  String get logAllLocalQueriesDescription => '记录所有本地号码查询的日志';

  @override
  String get logAllRemoteQueries => '记录所有远程查询';

  @override
  String get logAllRemoteQueriesDescription => '记录所有远程号码查询操作';

  @override
  String get manage => '管理联系人';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => '管理收藏联系人';

  @override
  String get manageFilterRules => '管理过滤规则';

  @override
  String get manageFilterRulesDescription => '添加、编辑或删除短信过滤规则';

  @override
  String get manageFrequentContacts => '管理常用联系人';

  @override
  String get markCounts => '标记计数';

  @override
  String get markCount => '标记计数';

  @override
  String markedByCount(Object count) {
    return '标记为 $count';
  }

  @override
  String get markedPhonesList => '标记的电话号码';

  @override
  String get markExchange => '标记交换';

  @override
  String get markPhone => '标记电话号码';

  @override
  String markPhoneFailed(Object error) {
    return '标记电话号码失败: $error';
  }

  @override
  String get markPhoneManagementSubtitle => '标记电话号码';

  @override
  String get markPhoneManagementTitle => '标记电话管理';

  @override
  String get markPhoneSuccess => '电话号码标记成功';

  @override
  String get matchFailed => '匹配失败!';

  @override
  String get matchFailedMessage => '匹配失败。';

  @override
  String get matchNumbersWithSpecialCharacters => '匹配特定的号码格式';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '匹配带特殊字符的号码:';

  @override
  String get matchSpecificDigitPatterns => '匹配 XXX-XXXX-XXXX 格式';

  @override
  String get matchSpecificDigitPatternsTitle => '匹配特定的数字模式:';

  @override
  String get matchSuccessful => '匹配成功!';

  @override
  String get matchSuccessfulMessage => '匹配成功!';

  @override
  String get medical => '医疗';

  @override
  String get membershipPrivileges => '会员特权';

  @override
  String get migrationTool => '迁移工具';

  @override
  String get migrationToolTitle => '迁移工具';

  @override
  String get minutes => '分钟';

  @override
  String get month => '月';

  @override
  String get monthly => '每月';

  @override
  String get monthlyCallCount => '每月通话';

  @override
  String get monthlyChartTitle => '每月拦截的通话';

  @override
  String get monthlyMembership => '每月会员';

  @override
  String get monthlyMembershipDescription => '解锁所有高级功能，每月自动续订';

  @override
  String get monthlyTotal => '每月总计';

  @override
  String get monthlyTotalLabel => '每月总计';

  @override
  String get moreOptions => '更多选项';

  @override
  String get mute => '静音';

  @override
  String get name => '名称';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '名称和电话号码不能为空';

  @override
  String get nameAndPhoneNumberRequired => '名称和电话号码不能为空';

  @override
  String get nameColor => '姓名颜色';

  @override
  String get nameFontSize => '姓名字体大小';

  @override
  String nameLabel(Object name) {
    return '姓名: $name';
  }

  @override
  String get namePosition => '姓名位置';

  @override
  String get nameUnknown => '姓名：未知';

  @override
  String nameWithValue(String name) {
    return '姓名: $name';
  }

  @override
  String get newPasswordLabel => '新密码';

  @override
  String get nextStep => '下一步';

  @override
  String get noAction => '无操作';

  @override
  String get noActionRules => '无操作规则';

  @override
  String get noActiveCloudSyncServiceMessage => '没有活动的云同步服务';

  @override
  String get noCallLogs => '没有通话记录';

  @override
  String get noCallRecords => '没有通话记录';

  @override
  String get noContacts => '还没有联系人';

  @override
  String get noContactsYet => '还没有联系人';

  @override
  String get noData => '没有数据';

  @override
  String get noDevicesRegisteredMessage => '没有注册的设备';

  @override
  String get noDevicesRegisteredYet => '还没有注册的设备。';

  @override
  String get noFilters => '还没有过滤器';

  @override
  String get noLabels => '还没有标签';

  @override
  String get noMarkedPhones => '没有标记的电话号码';

  @override
  String get noMatchingContacts => '没有匹配的联系人';

  @override
  String get noMatchingContactsFound => '没有找到匹配的联系人';

  @override
  String get noMatchingNumbersFound => '没有找到匹配的号码';

  @override
  String get noMatchingRecords => '没有匹配的通话记录';

  @override
  String noMatchingRules(Object ruleType) {
    return '没有匹配的 $ruleType';
  }

  @override
  String get none => '无';

  @override
  String get noneServiceType => '无';

  @override
  String get noPlugins => '暂无插件';

  @override
  String get noRecords => '没有通话记录';

  @override
  String get noResultReturned => '没有返回结果';

  @override
  String get noResultReturnedLog => '插件没有返回结果';

  @override
  String noRules(Object ruleType) {
    return '暂无 $ruleType';
  }

  @override
  String get noRulesPrompt => '未找到规则，请添加规则';

  @override
  String get noRulesToExport => '没有要导出的规则';

  @override
  String get noSmsFilterRulesYet => '还没有短信过滤规则';

  @override
  String get noSmsRulesYet => '还没有短信规则';

  @override
  String get noSubscriptions => '没有订阅';

  @override
  String get noSubscriptionsYet => '还没有订阅';

  @override
  String get notGranted => '未授权';

  @override
  String get notificationMode => '通知模式';

  @override
  String get notificationModeDescription => '在通知栏中显示来电信息';

  @override
  String get notificationPermission => '通知权限';

  @override
  String get notificationPermissionDescription => '用于显示来电和消息通知。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知设置';

  @override
  String get notificationSettingsSaved => '通知设置保存成功';

  @override
  String get notSet => '未设置';

  @override
  String get notVerifiedText => '未验证';

  @override
  String get noValidSmsRulesFoundInFile => '文件中未找到有效的短信规则';

  @override
  String get number => '号码';

  @override
  String get numberColor => '号码颜色';

  @override
  String get numberFontSize => '号码字体大小';

  @override
  String get numberPosition => '号码位置';

  @override
  String get numberSearch => '号码搜索';

  @override
  String get numberTypeColor => '号码类型颜色';

  @override
  String get numberTypeFontSize => '号码类型字体大小';

  @override
  String get numberTypePosition => '号码类型位置';

  @override
  String get ok => '确定';

  @override
  String get okButton => '确定';

  @override
  String get onboardingCompleteDescription => '您的通话安全管家已准备就绪，开始享受安全的通话体验！';

  @override
  String get onboardingLanguageDescription => '选择您喜欢的语言，以获得最佳体验。';

  @override
  String get onboardingPermissionsDescription => '为了提供完整的服务，我们需要以下权限：';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '一键拦截垃圾来电和短信，自定义拦截规则，给您一个安静的环境。';

  @override
  String get onboardingSmartCallerIdDescription => '自动识别未知来电，标记可疑号码，保护您的通话安全。';

  @override
  String get onboardingWelcomeDescription => '您的通话管理专家，提供全面的来电识别和拦截服务。';

  @override
  String get oneDriveAuthDescription => '使用系统配置的 OneDrive 客户端 ID 和密钥进行授权';

  @override
  String get oneDriveAuthorizationHint => '使用系统配置的 OneDrive 客户端 ID 和密钥进行授权';

  @override
  String get oneDriveConfigTitle => 'OneDrive 配置';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 配置';

  @override
  String get onlineCallerIdSubscription => '在线来电显示订阅';

  @override
  String get openAppSettings => '打开应用设置';

  @override
  String openAppSettingsFailed(Object error) {
    return '打开应用设置失败：$error';
  }

  @override
  String operationFailed(Object error) {
    return '操作失败：$error';
  }

  @override
  String get operationFailure => '操作失败';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get other => '其他';

  @override
  String get ourOtherApps => '我们的其他应用';

  @override
  String get overlayMode => '悬浮窗';

  @override
  String get overlayModeDescription => '在悬浮窗中显示来电信息';

  @override
  String get overlayPermission => '悬浮窗权限';

  @override
  String get overlayPermissionDescription => '用于显示来电悬浮窗。';

  @override
  String get overview => '概览';

  @override
  String get password => '密码';

  @override
  String get passwordCannotBeEmpty => '密码不能为空';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordsDoNotMatch => '密码不匹配';

  @override
  String get passwordSetSuccessfully => '密码设置成功';

  @override
  String get pattern => '模式';

  @override
  String get pendingSync => '待同步';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '周';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '权限请求被拒绝';

  @override
  String get permissionGranted => '权限已授予';

  @override
  String get permissionManagement => '权限管理';

  @override
  String get phoneCallsTab => '电话';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get phoneNumberCannotBeEmpty => '电话号码不能为空';

  @override
  String get phoneNumberHint => '输入电话号码';

  @override
  String get phoneNumberHintText => '输入要添加规则的电话号码';

  @override
  String get phoneNumberLabel => '电话号码';

  @override
  String get phoneNumberRegexRequired => '请输入电话号码和正则表达式';

  @override
  String get phoneNumberRequired => '电话号码是必需的';

  @override
  String get phoneNumberTypeFixedLine => '固定电话';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定电话或移动电话';

  @override
  String get phoneNumberTypeMobile => '移动电话';

  @override
  String get phoneNumberTypePager => '寻呼机';

  @override
  String get phoneNumberTypePersonalNumber => '个人号码';

  @override
  String get phoneNumberTypePremiumRate => '高价电话';

  @override
  String get phoneNumberTypeSharedCost => '分摊费用电话';

  @override
  String get phoneNumberTypeTollFree => '免费电话';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '未知';

  @override
  String get phoneNumberTypeVoicemail => '语音邮件';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '电话权限';

  @override
  String get phonePermissionDescription => '用于识别和阻止来电。';

  @override
  String get phoneRule => '电话规则';

  @override
  String get phoneRuleEditDialog => '电话规则编辑对话框';

  @override
  String get phoneRuleManagement => '电话规则管理';

  @override
  String get phoneRuleSubscription => '电话规则订阅';

  @override
  String get phoneSubscription => '电话订阅';

  @override
  String get phoneSubscriptionRulesDescription =>
      '通过 URL 订阅电话规则列表，以自动更新白名单和黑名单规则。支持 JSON 格式的规则文件。';

  @override
  String get phoneSubscriptionTitle => '电话规则订阅';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => '请选择一个标签并输入有效的电话号码';

  @override
  String pluginAddedSuccess(Object name) {
    return '插件 \"$name\" 添加成功';
  }

  @override
  String get pluginDeleted => '插件已删除';

  @override
  String get pluginLatestVersion => '插件已是最新版本';

  @override
  String get pluginListExportSuccess => '插件列表导出成功';

  @override
  String get pluginLoadedSuccessfully => '插件加载成功';

  @override
  String get pluginManagement => '插件管理';

  @override
  String get pluginManagementSubtitle => '管理和配置第三方插件';

  @override
  String get pluginManagementTitle => '插件管理';

  @override
  String get pluginName => '插件名称';

  @override
  String get pluginNotLoaded => '插件尚未加载。请先加载插件。';

  @override
  String pluginsDeleted(Object count) {
    return '成功删除 $count 个插件。';
  }

  @override
  String get pluginService => '插件服务';

  @override
  String get pluginTestPageTitle => '插件测试';

  @override
  String get pluginUpdateSuccess => '插件更新成功';

  @override
  String get pluginUrl => '插件 URL';

  @override
  String get pluginUrlCannotBeEmpty => '插件 URL 不能为空';

  @override
  String get pluginUrlHint => '输入插件 URL';

  @override
  String get pluginUrlLabel => '插件 URL';

  @override
  String get pluginVersion => '插件版本';

  @override
  String get political => '政治';

  @override
  String get powerfulSpamBlocking => '强大的垃圾邮件拦截';

  @override
  String get previousStep => '上一步';

  @override
  String get prioritizeRemoteAction => '优先使用远程操作设置';

  @override
  String get prioritizeRemoteActionDescription => '优先使用来自远程数据库的操作设置';

  @override
  String get processing => '处理中...';

  @override
  String get processingOperation => '处理中...';

  @override
  String get purchase => '购买';

  @override
  String get quarterlyMembership => '季度会员';

  @override
  String get quarterlyMembershipDescription => '解锁所有高级功能，每季度自动续订';

  @override
  String get queryButton => '查询';

  @override
  String get queryFailed => '查询失败';

  @override
  String get queryFailedLog => '查询失败';

  @override
  String get querying => '查询中...';

  @override
  String get queryingPhoneNumber => '查询电话号码';

  @override
  String get queryResultTitle => '查询结果';

  @override
  String get ready => '准备就绪！';

  @override
  String get receiveWeeklyStatistics => '接收每周统计信息';

  @override
  String get recruiter => '招聘人员';

  @override
  String get reEnterPasswordHint => '请重新输入密码';

  @override
  String get refresh => '刷新';

  @override
  String get refreshPermissionStatus => '刷新权限状态';

  @override
  String get refreshTooltip => '刷新';

  @override
  String regexError(Object error) {
    return '正则表达式错误：$error';
  }

  @override
  String regexErrorMessage(Object error) {
    return '正则表达式错误：$error';
  }

  @override
  String get regexPattern => '正则表达式';

  @override
  String get regexPatternExplanation => '正则表达式解释';

  @override
  String get regexPatternExplanationButton => '正则表达式解释';

  @override
  String get regexPatternLabel => '正则表达式';

  @override
  String get regexPatternsExamples => '使用标准正则表达式语法定义模式。例如：';

  @override
  String get regexPatternsForPhoneNumberMatching => '用于电话号码匹配的正则表达式';

  @override
  String get regexRule => '正则表达式规则';

  @override
  String regexRuleAddFailed(Object error) {
    return '添加正则表达式规则失败：$error';
  }

  @override
  String get regexRuleAddSuccess => '正则表达式规则添加成功';

  @override
  String get regexRuleManagement => '正则表达式规则管理';

  @override
  String get regexRuleNamePatternRequired => '规则名称和正则表达式不能为空';

  @override
  String get regexRules => '正则表达式规则';

  @override
  String get regexTesterTitle => '正则表达式测试器';

  @override
  String regexValidationFailed(Object error) {
    return '正则表达式验证失败：$error';
  }

  @override
  String get regexValidationSuccess => '正则表达式验证成功';

  @override
  String get region => '地区';

  @override
  String get registeredDevicesTitle => '注册设备';

  @override
  String get rejectAllCalls => '拒绝所有来电';

  @override
  String get rejectAllCallsDescription => '启用后，所有来电都将被以最高优先级拒绝';

  @override
  String get rejectAllNumbers => '拒绝所有号码';

  @override
  String get rejectAllNumbersDesc => '启用后，拒绝所有来电';

  @override
  String get rejectExceededNumbers => '拒绝超出数量的号码';

  @override
  String get rejectExceededNumbersDescription => '自动拒绝超过数量阈值的号码';

  @override
  String get remoteFilterSettings => '远程过滤设置';

  @override
  String get remoteFilterSettingsPageTitle => '远程号码过滤设置';

  @override
  String get remoteNumberFilter => '远程号码过滤';

  @override
  String get remoteNumberFilterDatabaseInfo => '此过滤器使用独立的远程数据库来获取最新的号码信息。';

  @override
  String get remoteNumberFilterDescription => '根据远程数据库信息拦截骚扰电话';

  @override
  String get remoteNumberFilterExplanationContent =>
      '远程号码过滤器通过查询基于号码计数的远程数据库来识别和阻止垃圾电话。';

  @override
  String get remoteNumberFilterExplanationTitle => '远程号码过滤说明';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• 数量阈值：根据号码出现频率确定';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• 过滤操作：配置如何处理超过阈值的号码';

  @override
  String get remoteNumberFilterFeaturePriority => '• 优先级设置：设置远程操作的优先级';

  @override
  String get remoteNumberFilterFeatures => '功能：';

  @override
  String get remoteNumberFiltering => '远程号码过滤';

  @override
  String get remoteNumberFilteringExplanation => '• 远程号码过滤：基于远程数据库信息的过滤规则';

  @override
  String get remoteNumberFilterSubtitle => '使用云数据库和社区报告识别垃圾电话';

  @override
  String get removeAdsDescription => '永久删除应用程序中的所有广告，以获得更流畅的体验';

  @override
  String get removeAdsTitle => '移除广告';

  @override
  String get removedFromFavoriteContacts => '从收藏联系人中移除';

  @override
  String get removedFromFavorites => '从收藏夹中移除';

  @override
  String get removeFavorite => '移除收藏';

  @override
  String get removeFromFavorites => '从收藏夹中移除';

  @override
  String get renameButton => '重命名';

  @override
  String get renameDeviceDialogTitle => '重命名设备';

  @override
  String get renameDeviceTitle => '重命名设备';

  @override
  String get replaceCurrentSettingsConfirmation => '这将替换您当前的所有设置。您确定要继续吗？';

  @override
  String get requestAllPermissions => '请求所有权限';

  @override
  String get requestPermission => '请求权限';

  @override
  String requestPermissionFailed(Object error) {
    return '请求权限失败：$error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 个标记';
  }

  @override
  String get reset => '重置';

  @override
  String get restore => '恢复';

  @override
  String get restoreApplicationSettingsFromBackup => '从备份恢复应用程序设置';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '从备份恢复应用程序设置';

  @override
  String get restoreButton => '恢复';

  @override
  String restoreFailedWithError(Object error) {
    return '从云恢复失败：$error';
  }

  @override
  String get restoreFromCloud => '从云恢复';

  @override
  String get restoreFromCloudDescription => '从云存储恢复设置和规则';

  @override
  String restoreFromCloudFailed(Object error) {
    return '从云恢复失败：$error';
  }

  @override
  String get restoreFromCloudLabel => '从云恢复';

  @override
  String get restoreFromCloudSuccess => '从云恢复成功';

  @override
  String get restoreFromCloudTitle => '从云恢复';

  @override
  String get restoreFromLocal => '从本地恢复';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restoreSectionTitle => '恢复';

  @override
  String get restoreSettings => '恢复设置';

  @override
  String get restoreSettingsConfirmation => '这将替换您当前的所有设置。您确定要继续吗？';

  @override
  String get restoreSettingsDialogTitle => '恢复设置';

  @override
  String get restoreSettingsTitle => '恢复设置';

  @override
  String get restoreSuccessFromLocal => '从本地恢复成功';

  @override
  String get restoreSuccessMessage => '从云恢复成功';

  @override
  String get retry => '重试';

  @override
  String get ridesharing => '共享出行';

  @override
  String get risk => '风险';

  @override
  String get robocall => '自动电话';

  @override
  String get ruleAction => '规则操作';

  @override
  String get ruleAddButton => '添加规则';

  @override
  String get ruleAddedSuccess => '规则添加成功';

  @override
  String ruleAddFailure(Object error) {
    return '添加规则失败：$error';
  }

  @override
  String get ruleAddSuccess => '规则添加成功';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '您确定要删除此$ruleType吗？';
  }

  @override
  String get ruleDeleteConfirmTitle => '删除规则';

  @override
  String get ruleDeletedSuccess => '规则删除成功';

  @override
  String get ruleDeletedSuccessfully => '规则删除成功';

  @override
  String ruleDeleteFailed(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '删除规则失败：$error';
  }

  @override
  String get ruleDeleteSuccess => '规则删除成功';

  @override
  String get ruleDisabledSuccessfully => '规则已成功禁用';

  @override
  String get ruleEnabledSuccessfully => '规则已成功启用';

  @override
  String ruleLoadFailed(Object error) {
    return '加载规则失败：$error';
  }

  @override
  String get ruleManagement => '规则管理';

  @override
  String get ruleManagementTitle => '规则管理';

  @override
  String get ruleName => '规则名称';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => '规则名称和内容正则表达式不能为空';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '规则名称和电话号码不能为空';

  @override
  String get ruleNameHint => '例如，家人、朋友等。';

  @override
  String get ruleNameLabel => '规则名称';

  @override
  String get ruleNamePatternRequired => '请输入规则名称和模式';

  @override
  String get ruleNameRequired => '规则名称和电话号码不能为空';

  @override
  String get ruleNotExist => '规则不存在或已被删除';

  @override
  String ruleNotFound(Object error) {
    return '未找到规则：$error';
  }

  @override
  String get ruleSavedSuccessfully => '规则保存成功！';

  @override
  String get ruleSavedSuccessMessage => '规则保存成功！';

  @override
  String ruleSaveFailed(Object error) {
    return '保存失败: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '保存失败: $error';
  }

  @override
  String get ruleSaveSuccess => '规则保存成功！';

  @override
  String get rulesExportedSuccessfully => '规则导出成功';

  @override
  String rulesExportedTo(Object path) {
    return '规则导出到: $path';
  }

  @override
  String get rulesImported => '规则导入成功';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count 条规则导入成功';
  }

  @override
  String rulesImportFailed(Object error) {
    return '导入规则失败: $error';
  }

  @override
  String get ruleStatistics => '规则统计';

  @override
  String ruleStatusChanged(Object status) {
    return '规则 $status 成功';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作失败: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '规则 $status 成功';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '更新规则失败: $error';
  }

  @override
  String get ruleUpdateSuccess => '规则更新成功';

  @override
  String get ruleVerification => '规则验证';

  @override
  String get save => '保存';

  @override
  String get saveButton => '保存';

  @override
  String get saveButtonLabel => '保存';

  @override
  String get saveButtonText => '保存';

  @override
  String saveFailed(Object error) {
    return '保存失败: $error';
  }

  @override
  String get saveFilter => '保存过滤器';

  @override
  String get saveSettings => '保存设置';

  @override
  String saveSettingsFailed(Object error) {
    return '保存设置失败: $error';
  }

  @override
  String get scamsLikely => '疑似诈骗';

  @override
  String get search => '搜索';

  @override
  String get searchContacts => '搜索联系人';

  @override
  String searchError(Object error) {
    return '搜索错误: $error';
  }

  @override
  String get searchFilters => '搜索过滤器';

  @override
  String get searchForContacts => '搜索联系人';

  @override
  String get searchHint => '搜索...';

  @override
  String get searchSettingsSubtitle => '搜索联系人、标签、黑名单、白名单等。';

  @override
  String get searchSettingsTitle => '搜索设置';

  @override
  String get securityMessage => '不要相信任何电话。始终独立验证客户服务号码。切勿分享密码、验证码、银行卡号或个人信息。';

  @override
  String get selectActionToPerform => '选择规则匹配时要执行的操作';

  @override
  String get selectActionWhenBlockingCalls => '选择阻止呼叫时的操作';

  @override
  String get selectActionWhenRuleMatches => '选择规则匹配时的操作';

  @override
  String get selectAll => '全选';

  @override
  String get selectCountry => '选择国家';

  @override
  String get selectDateRange => '选择日期范围';

  @override
  String get selectedDateRange => '所选日期范围';

  @override
  String selectedItems(Object count) {
    return '已选择 $count 项';
  }

  @override
  String get selectedLabel => '已选择：';

  @override
  String get selectExportFormat => '选择导出格式';

  @override
  String get selectLabel => '选择标签';

  @override
  String get selectLabelAndEnterPhoneNumber => '请选择一个标签并输入有效的电话号码';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selectMultiple => '选择多个';

  @override
  String get selectPeriod => '选择时间段';

  @override
  String get selectSimCard => '选择 SIM 卡';

  @override
  String get selectSimSlot => '选择 SIM 卡槽';

  @override
  String get selectSpecificActionForBlockedCalls => '选择阻止来电时要执行的特定操作';

  @override
  String get selectTag => '选择标签';

  @override
  String get selectTags => '选择标签';

  @override
  String get selectTrustedDataSource => '请选择受信任的数据源';

  @override
  String get selectYourLanguage => '选择您的语言';

  @override
  String get sender => '发送者';

  @override
  String get senderRegexOptional => '发送者正则表达式（可选）';

  @override
  String get serverAddressLabel => '服务器地址';

  @override
  String get serviceTypeContact => '联系人订阅';

  @override
  String get serviceTypeLabel => '服务类型';

  @override
  String get serviceTypePhone => '电话订阅';

  @override
  String get serviceTypePlugin => '插件更新';

  @override
  String get serviceTypeSms => '短信订阅';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '设置';

  @override
  String get setEncryptionPassword => '设置加密密码';

  @override
  String get setEncryptionPasswordDescription => '设置用于备份和恢复的加密密码';

  @override
  String get setEncryptionPasswordLabel => '设置加密密码';

  @override
  String get setEncryptionPasswordTitle => '设置加密密码';

  @override
  String get setPasswordButton => '设置';

  @override
  String get settings => '设置';

  @override
  String settingsBackedUpTo(Object path) {
    return '设置已备份到：$path';
  }

  @override
  String get settingsLoaded => '设置已加载';

  @override
  String settingsLoadFailed(Object error) {
    return '加载设置失败：$error';
  }

  @override
  String get settingsRestoredSuccessfully => '设置已成功恢复。请重启应用以使更改生效。';

  @override
  String get settingsSaved => '设置已保存';

  @override
  String settingsSaveFailed(Object error) {
    return '保存设置失败：$error';
  }

  @override
  String get settingsTab => '设置';

  @override
  String get settingsTitle => '设置';

  @override
  String get setup => '设置';

  @override
  String get showContactEditDialogStaticMethod => '用于显示联系人编辑对话框的静态方法';

  @override
  String get showExplanation => '显示说明';

  @override
  String get silence => '静音';

  @override
  String get silenceAndNoAnswer => '静音且不接听';

  @override
  String get silenceNoAnswer => '静音不接听';

  @override
  String get silentCallVoiceClone => '静音呼叫语音克隆';

  @override
  String get silentRules => '静音规则';

  @override
  String simCard(Object simNumber) {
    return 'SIM 卡 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 卡颜色';

  @override
  String get simCardConfigurationExplanation => '• SIM 卡配置：为每个 SIM 卡设置独立的过滤规则';

  @override
  String get simCardFilterRules => 'SIM 卡过滤规则';

  @override
  String get simCardFilterRulesDescription => '根据 SIM 卡槽设置不同的过滤规则';

  @override
  String get simCardFontSize => 'SIM 卡字体大小';

  @override
  String get simCardPosition => 'SIM 卡位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return '加载 SIM 卡信息失败：$error';
  }

  @override
  String get simRuleInstructions => 'SIM 卡槽规则允许您为每个 SIM 卡槽配置独立的过滤规则。';

  @override
  String get simRuleInstructionsTitle => 'SIM 卡槽规则';

  @override
  String get simRuleManagement => 'SIM卡槽规则管理';

  @override
  String simSlot1(String countryIso) {
    return 'SIM卡 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM卡 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return '加载SIM数据失败: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM卡槽过滤配置';

  @override
  String get simSlotFilterConfigurationDescription => '允许按SIM卡槽设置过滤规则';

  @override
  String get simSlotFilterDescription => '为每个SIM卡配置独立的过滤规则：';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM卡槽 $slotNumber 过滤设置';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return '加载SIM卡槽失败: $error';
  }

  @override
  String get simSlotManagement => 'SIM卡槽管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM卡槽操作失败: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM卡槽位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM卡槽规则：每个SIM卡独立的过滤策略';

  @override
  String get simSlotRuleListTitle => 'SIM卡槽规则列表';

  @override
  String get simSlotRuleManagement => 'SIM卡槽规则';

  @override
  String get simSlotRuleManagementTitle => '规则管理';

  @override
  String get simSlotSettings => 'SIM卡槽设置';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM卡槽 $slotNumber';
  }

  @override
  String get skip => '跳过';

  @override
  String get smartCallerId => '智能来电识别';

  @override
  String get sms => '短信';

  @override
  String get smsFilterDescription =>
      '短信过滤可帮助您自动过滤垃圾短信，并保持您的短信列表干净。您可以设置过滤规则和通知方法。';

  @override
  String get smsFilterDisabled => '短信过滤已禁用';

  @override
  String get smsFilterEnabled => '短信过滤已启用';

  @override
  String get smsFilterRuleAddedSuccessfully => '短信过滤规则添加成功';

  @override
  String get smsFilterRules => '短信过滤规则';

  @override
  String get smsFilterSettings => '短信过滤设置';

  @override
  String get smsHistory => '短信历史';

  @override
  String get smsManagement => '短信管理';

  @override
  String get smsPermission => '短信权限';

  @override
  String get smsPermissionDescription => '用于过滤垃圾短信。';

  @override
  String get smsRuleAddedSuccessfully => '短信规则添加成功';

  @override
  String get smsRuleDeletedSuccessfully => '短信规则删除成功';

  @override
  String smsRuleLoadFailed(Object error) {
    return '加载短信规则失败: $error';
  }

  @override
  String get smsRuleManagement => '短信规则管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return '短信规则已成功导出到 $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => '短信规则已成功导入';

  @override
  String get smsRuleSubscription => '短信规则订阅';

  @override
  String get smsRuleUpdatedSuccessfully => '短信规则更新成功';

  @override
  String get smsSettingsSubtitle => '短信过滤和关键词阻止';

  @override
  String get smsSettingsTitle => '短信设置';

  @override
  String get smsSubscription => '短信订阅';

  @override
  String get smsSubscriptionAddedSuccessfully => '短信订阅添加成功';

  @override
  String get smsSubscriptionRulesDescription =>
      '通过URL订阅短信规则列表，支持正则表达式匹配。您可以设置阻止或允许操作。';

  @override
  String get smsTab => '短信';

  @override
  String get somePermissionsDenied => '某些权限请求被拒绝';

  @override
  String get spamLikely => '可能是垃圾信息';

  @override
  String get startColor => '起始颜色';

  @override
  String get startDate => '开始日期';

  @override
  String get startUsing => '开始使用';

  @override
  String get statAnswered => '已接听';

  @override
  String get statBlocked => '已阻止';

  @override
  String get staticMethodShowCallerIdDialog => '用于显示来电显示信息对话框的静态方法';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      '用于显示国家/地区选择对话框的静态方法';

  @override
  String get staticMethodToDisplayDialog => '用于显示对话框的静态方法';

  @override
  String get statistics => '统计';

  @override
  String get statisticsExportFeatureComingSoon => '统计导出功能即将推出';

  @override
  String get statisticsGrid => '统计网格';

  @override
  String get statisticsPageTitle => '数据分析';

  @override
  String get stirColor => 'STIR 颜色';

  @override
  String get stirFontSize => 'STIR 字体大小';

  @override
  String get stirPosition => 'STIR 位置';

  @override
  String get storagePermission => '存储权限';

  @override
  String get storagePermissionDescription => '用于保存设置和规则。';

  @override
  String get subscribe => '订阅';

  @override
  String subscriptionAddSuccess(Object name) {
    return '成功添加订阅 \"$name\"';
  }

  @override
  String get subscriptionDeleteConfirmContent => '确定要删除此订阅吗？';

  @override
  String get subscriptionDeleteConfirmTitle => '删除订阅';

  @override
  String get subscriptionDeleted => '订阅已删除';

  @override
  String get subscriptionDeletedSuccessfully => '订阅已成功删除';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '删除订阅失败：$error';
  }

  @override
  String get subscriptionDeleteSuccess => '订阅已删除';

  @override
  String get subscriptionEmptyState => '没有可用的订阅';

  @override
  String get subscriptionEmptyText => '尚无订阅';

  @override
  String subscriptionLoadFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '加载订阅失败：$error';
  }

  @override
  String get subscriptionManagementTitle => '订阅管理';

  @override
  String get subscriptionName => '订阅名称';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '订阅名称和 URL 不能为空';

  @override
  String get subscriptionNameHint => '输入订阅名称';

  @override
  String get subscriptionPageTitle => '订阅管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '更改订阅状态失败：$error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '切换订阅状态失败：$error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '更新订阅失败：$error';
  }

  @override
  String get subscriptionUpdateSuccess => '订阅已成功更新';

  @override
  String get subscriptionUrl => '订阅 URL';

  @override
  String get subscriptionUrlHint => '输入订阅 URL';

  @override
  String successfullyImportedRules(Object count) {
    return '成功导入 $count 条规则';
  }

  @override
  String get supportSync => '支持同步';

  @override
  String get survey => '调查';

  @override
  String get syncDevicesButton => '同步设备';

  @override
  String get syncFailed => '同步失败';

  @override
  String get syncFailedMessage => '同步失败';

  @override
  String get syncFolderNameHint => '请输入同步文件夹名称 (默认: NotificationManager)';

  @override
  String get syncFolderNameLabel => '同步文件夹名称';

  @override
  String get synchronized => '已同步';

  @override
  String get syncing => '正在同步...';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncStatusTitle => '同步状态';

  @override
  String get syncStatusUpdatedMessage => '同步状态已更新';

  @override
  String get syncSuccessful => '同步成功';

  @override
  String get syncSuccessMessage => '同步成功';

  @override
  String get syncWithCloudStorage => '与云存储同步';

  @override
  String get syncWithCloudStorageSubtitle => '与云存储同步';

  @override
  String get systemFeatures => '系统功能：';

  @override
  String get systemSettingsTitle => '系统设置';

  @override
  String get tabAll => '全部';

  @override
  String get tabAnswered => '已接听';

  @override
  String get tabBlocked => '已拦截';

  @override
  String get tabMissed => '未接来电';

  @override
  String get tabOutgoing => '已拨出';

  @override
  String tagLabel(String tag) {
    return '标签：$tag';
  }

  @override
  String get tagsUpdated => '标签已更新';

  @override
  String get takeaway => '外卖';

  @override
  String get telecommunication => '电信';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => '电话销售';

  @override
  String get testButton => '测试';

  @override
  String get testButtonLabel => '测试';

  @override
  String get testConnectionButton => '测试连接';

  @override
  String get textColorsSetting => '文本和标签颜色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '这款应用是一款强大的来电显示工具，可以识别并拦截不需要的来电。';

  @override
  String get thisWeek => '本周';

  @override
  String get timeInterceptor => '时间拦截器';

  @override
  String get timeInterceptorDescription => '根据呼叫频率自动拦截/允许潜在的呼叫';

  @override
  String get timeInterceptorExplanation => '• 时间拦截器：在短时间内拦截/允许重复呼叫';

  @override
  String get timeInterceptorExplanationContent =>
      '呼叫频率拦截功能分析呼叫频率，以自动识别和拦截/允许频繁的垃圾电话。';

  @override
  String get timeInterceptorExplanationTitle => '呼叫频率拦截说明';

  @override
  String get timeInterceptorSettingsTitle => '呼叫频率拦截设置';

  @override
  String get timeInterceptorSubtitle => '根据呼叫频率自动拦截潜在的垃圾电话';

  @override
  String get timeInterceptorTitle => '启用呼叫频率拦截';

  @override
  String get timeWindowDescription => '设置允许重复呼叫的时间窗口大小。来自同一号码在此窗口内的呼叫将被允许';

  @override
  String timeWindowLabel(int minutes) {
    return '拦截时间窗口（分钟）：$minutes';
  }

  @override
  String get timeWindowSetting => '设置允许重复呼叫的时间窗口大小。来自同一号码在此窗口内的呼叫将被允许';

  @override
  String get today => '今天';

  @override
  String get total => '总计';

  @override
  String get totalBlocked => '总拦截';

  @override
  String get totalFiltered => '总过滤';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '在设备或平台之间传输数据';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => '在设备或平台之间传输数据';

  @override
  String get travelTicketing => '旅游票务';

  @override
  String get trend => '趋势';

  @override
  String get trendChart => '趋势图';

  @override
  String get tutorial => '教程';

  @override
  String get type => '类型';

  @override
  String get unassignedSIMCard => '未分配的 SIM 卡';

  @override
  String get unknown => '未知';

  @override
  String get unknownLabel => '未知标签';

  @override
  String get unknownTag => '标签：未知';

  @override
  String get unregisterButton => '取消注册';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '确定要取消注册 $deviceName 吗？';
  }

  @override
  String get unregisterDeviceTitle => '取消注册设备';

  @override
  String get unsupportedFileFormat => '不支持的文件格式';

  @override
  String get update => '更新';

  @override
  String get updateAllNow => '立即全部更新';

  @override
  String get updateCallFilterConfig => '更新呼叫过滤配置';

  @override
  String updateContactFailed(Object error) {
    return '更新联系人失败：$error';
  }

  @override
  String get updateFavoriteStatus => '更新收藏状态';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '更新收藏状态失败：$error';
  }

  @override
  String get updateInterval => '更新间隔';

  @override
  String get updateLabelFailed => '更新标签失败';

  @override
  String get updateNow => '立即更新';

  @override
  String get updatePlugin => '更新插件';

  @override
  String updatePluginFailed(Object error) {
    return '更新插件失败：$error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '更新规则失败：$error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '更新订阅失败：$error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service 成功更新（$count 条规则）';
  }

  @override
  String get updateTags => '更新标签';

  @override
  String get useCasesPoint1 => '• 识别自动重拨的垃圾电话';

  @override
  String get useCasesPoint2 => '• 拦截在短时间内多次拨打的营销电话';

  @override
  String get useCasesPoint3 => '• 阻止电话轰炸和骚扰';

  @override
  String get useCasesTitle => '使用场景：';

  @override
  String get useGlobalSettings => '使用全局设置';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '用户名';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '使用标准正则表达式语法来定义模式。例如：';

  @override
  String get validateRegex => '验证正则表达式';

  @override
  String get verificationFailedText => '失败';

  @override
  String get verifiedText => '已验证';

  @override
  String get verify => '验证';

  @override
  String version(Object version) {
    return '版本：$version';
  }

  @override
  String get vipExchangeDescription => '用电话号码标记计数交换 VIP 会员资格';

  @override
  String get vipExchangeTitle => '标记交换 VIP';

  @override
  String get watchAd => '观看广告';

  @override
  String get watchAdForTemp => '观看广告以获得临时权限';

  @override
  String get watchAdForTempDescription => '观看一个短片广告，以暂时解锁一些高级功能';

  @override
  String get webDAVConfigTitle => 'WebDAV 配置';

  @override
  String get webdavConfigurationTitle => 'WebDAV 配置';

  @override
  String get webdavPasswordHint => '请输入 WebDAV 密码';

  @override
  String get webdavServerAddressHint => '请输入 WebDAV 服务器地址';

  @override
  String get webdavUsernameHint => '请输入 WebDAV 用户名';

  @override
  String get week => '周';

  @override
  String get weekly => '每周';

  @override
  String get weeklyBlockedCallsSummary => '每周拦截电话摘要';

  @override
  String get weeklyChartTitle => '每周拦截电话';

  @override
  String get weeklyReport => '每周报告';

  @override
  String get weeklyReportDesc => '接收每周的呼叫阻止活动总结报告';

  @override
  String get welcome => '欢迎';

  @override
  String get whitelist => '白名单';

  @override
  String get whitelistLabel => '白名单';

  @override
  String get width => '宽度';

  @override
  String get wildcardMatchingDescription =>
      '使用 \'.\' 匹配任何字符 (例如 \'123.456\' 匹配 123-456)';

  @override
  String get wildcardMatchingTitle => '通配符匹配:';

  @override
  String get wildcardSupportForFlexibleFiltering => '通配符支持灵活过滤';

  @override
  String get windowSizeSetting => '窗口大小';

  @override
  String get year => '年';

  @override
  String get yearly => '每年';

  @override
  String get yearlyChartTitle => '年度拦截通话';

  @override
  String get noSimCardsDetected => '未检测到 SIM 卡';

  @override
  String get filterManagementDescription => '设置呼叫过滤';

  @override
  String get callerIdCustomizationSubtitle => '自定义来电显示布局';

  @override
  String get fraudAlerSettingTitle => '欺诈警报设置';

  @override
  String get fraudAlerSettingSubtitle => '设置欺诈警报';

  @override
  String get enableFraudAlert => '启用欺诈警报';

  @override
  String get enableFraudAlertDescription => '疑似诈骗电话警报';

  @override
  String get enableVibration => '启用震动';

  @override
  String get enableVibrationDescription => '当呼叫疑似诈骗电话时震动';

  @override
  String get notificationSettingsTitle => '通知设置';

  @override
  String get useLocalNotification => '使用本地通知';

  @override
  String get useLocalNotificationDescription => '为来电启用本地通知';

  @override
  String get cancelLocalNotification => '关闭本地通知';

  @override
  String get useStirNotification => '使用来自 STIR 的通知';

  @override
  String get useStirNotificationDescription => '启用来自 STIR 的通知来电';

  @override
  String get cancelLocalNotificationDescription => '自动关闭本地通知';

  @override
  String get callerIdSettingsTitle => '来电显示设置';

  @override
  String get callerIdSettingsSubtitle => '设置来电通知和显示模式';

  @override
  String get purchaseTitle => '购买';

  @override
  String get purchaseSubtitle => '购买服务';

  @override
  String get callerIdNotificationTitle => '来电信息';

  @override
  String callerIdBody(String phoneNumber) {
    return '号码: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '已阻止的呼叫';

  @override
  String blockedCallBody(String phoneNumber) {
    return '已阻止来自 $phoneNumber 的呼叫';
  }

  @override
  String get stirVerified => '已验证';

  @override
  String get stirNotVerified => '未验证';

  @override
  String get stirFailed => '验证失败';

  @override
  String get stirUnknown => '未知的验证状态';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 验证';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '号码 $phoneNumber 的 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '滚动安全消息设置';

  @override
  String get messageColor => '消息颜色';

  @override
  String get messageFontSize => '消息字体大小';

  @override
  String get messagePosition => '消息位置';

  @override
  String get containerWidth => '容器宽度';

  @override
  String get scrollSpeed => '滚动速度';

  @override
  String get enableSecurityMessage => '启用安全消息';

  @override
  String get fraudAlertTitle => '欺诈警报';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '来自 $phoneNumber 的潜在欺诈电话';
  }

  @override
  String loadRulesFailed(Object error) {
    return '加载规则失败: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '加载通话记录失败: $error';
  }

  @override
  String get noBlockedTypeData => '无可用阻止类型数据';

  @override
  String importEntity(Object entityTypeName) {
    return '导入 $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName 导入成功，共导入 $count 条记录';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '导入 $entityTypeName 失败: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '导出 $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName 导出成功';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '导出 $entityTypeName 失败: $error';
  }

  @override
  String get cloudSyncService => '云同步服务';

  @override
  String get membershipCenter => '会员中心';

  @override
  String get redeemVipWithMarks => '使用积分兑换 VIP';

  @override
  String get currentMarkCount => '当前积分数量';

  @override
  String get markMoreNumbersForMore => '标记更多号码以获得更多积分';

  @override
  String get noAds => '无广告';

  @override
  String get cloudBackup => '云备份';

  @override
  String get callerIdEnhancement => '来电显示增强';

  @override
  String get voiceRecognition => '语音识别';

  @override
  String get feature => '功能';

  @override
  String get normalUser => '普通用户';

  @override
  String get vipUser => 'VIP 用户';

  @override
  String get temporaryVip => '临时 VIP';

  @override
  String get removeAds => '移除广告';

  @override
  String get unknownAction => '未知操作';

  @override
  String get settingsBackup => '设置备份';

  @override
  String get allServicesStatusTitle => '当前服务状态';

  @override
  String get allServicesStatusSubtitle => '每个云服务的当前状态';

  @override
  String get redirect => '重定向';

  @override
  String get notify => '通知';

  @override
  String get log => '日志';

  @override
  String get custom => '自定义';

  @override
  String get allowActionDescription => '即使号码在黑名单中，也将允许呼叫。';

  @override
  String get blockActionDescription => '呼叫将被阻止并显示在通话记录中。';

  @override
  String get silenceActionDescription => '呼叫将被静音但显示在通话记录中。';

  @override
  String get noneActionDescription => '不会对呼叫采取任何特殊操作。';

  @override
  String get redirectActionDescription => '将呼叫重定向到指定的号码。';

  @override
  String get labelActionDescription => '为呼叫添加标签，以便于识别。';

  @override
  String get notifyActionDescription => '收到呼叫时发送通知。';

  @override
  String get logActionDescription => '记录呼叫信息而不采取任何其他操作。';

  @override
  String get customActionDescription => '执行自定义操作。';

  @override
  String get synced => '已同步';

  @override
  String get needVipAccess => '您需要 VIP 权限才能使用此功能';

  @override
  String importExportDescription(Object entityTypeName) {
    return '导入或导出 $entityTypeName 数据';
  }

  @override
  String get importExportTitle => '导入/导出';

  @override
  String get noPhoneRules => '未找到电话规则';

  @override
  String get noRegexRules => '未找到正则表达式规则';

  @override
  String get noAllowedBlockedRules => '未找到允许/阻止规则';

  @override
  String get importExport => '导入/导出';

  @override
  String get filterByAction => '按操作筛选';

  @override
  String get upgradeToVip => '升级到 VIP';

  @override
  String get batteryOptimizationPermission => '电池优化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '允许应用程序在后台运行以提供来电显示等服务。';

  @override
  String get permissionTitle => '特殊权限';

  @override
  String get permissionSubtitle => '管理悬浮窗和电池优化权限';

  @override
  String get themeSettingsTitle => '主题设置';

  @override
  String get themeSettingsSubtitle => '选择你喜欢的主题';

  @override
  String get databaseSyncTitle => '数据库同步';

  @override
  String get countrySyncSettingsTitle => '基于国家的数据库同步设置';

  @override
  String get countrySyncSettingsSubtitle => '选择用于数据同步的国家';

  @override
  String get countryDataDisclaimer => '请注意：数据库可能不包含所有特定国家或地区的数据。';

  @override
  String get editSubscription => '编辑订阅';

  @override
  String get searchByNameOrPhoneNumber => '按姓名或电话号码搜索';

  @override
  String get allowedBlockedRulesInfo => '允许/阻止规则用于匹配特定电话号码的呼叫，具有最高优先级。';

  @override
  String get searchPhoneRulesHint => '搜索电话规则';

  @override
  String get phoneRulesInfo => '电话规则用于匹配特定电话号码的呼叫，优先级较低。有些来自 phoneRule 订阅';

  @override
  String get searchSubscriptionsHint => '搜索订阅';

  @override
  String get searchPluginsHint => '搜索插件';

  @override
  String get searchLabelsHint => '搜索标签';

  @override
  String get pluginDescription => '插件描述';

  @override
  String get enterPluginDescription => '输入插件描述';

  @override
  String get searchRegexRulesHint => '搜索正则表达式规则';

  @override
  String get regexRulesInfo => '正则表达式规则用于基于正则表达式模式过滤呼叫。';

  @override
  String get searchMarkedPhonesHint => '搜索标记的电话';

  @override
  String get searchContactSubscriptionsHint => '搜索联系人订阅';

  @override
  String get showAllContacts => '显示所有联系人';

  @override
  String get showFavorites => '显示收藏夹';

  @override
  String get manualEntry => '手动输入信息';

  @override
  String get scriptSaved => '脚本已保存';

  @override
  String editScriptFor(String pluginName) {
    return '编辑 $pluginName 的脚本';
  }

  @override
  String get saveScript => '保存脚本';

  @override
  String get testPlugin => '测试插件';

  @override
  String get description => '描述';

  @override
  String get accessTargetUrl => '访问目标 URL';

  @override
  String get result => '结果';

  @override
  String get editScript => '编辑脚本';

  @override
  String get numberFormat => '号码格式';

  @override
  String get nationalNumber => '国内号码';

  @override
  String get e164Number => 'E.164 号码';

  @override
  String get pluginRulesInfo => '为了安全起见，请仅使用来自可信来源的插件。 欢迎使用我们的模板创建您自己的自定义插件！';

  @override
  String get advancedMode => '高级模式';

  @override
  String get pleaseEnterAtLeastOneNumber => '请至少输入一个号码。';

  @override
  String get openInWebView => '在 WebView 中打开';

  @override
  String get pluginLabel => '插件标签';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '消息背景颜色';

  @override
  String get clearAllCallLogs => '清除所有通话记录';

  @override
  String get clearAllCallLogsConfirmation => '确认清除所有通话记录';

  @override
  String get allCallLogsCleared => '所有通话记录已清除';

  @override
  String get unblocked => '已取消阻止';

  @override
  String get blockNumber => '阻止号码';

  @override
  String get blockNumberSuccess => '阻止号码成功';

  @override
  String get blockNumberFailed => '阻止号码失败';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '确定要取消阻止 $phoneNumber 吗？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '正在呼叫 $phoneNumber...';
  }

  @override
  String get viewDetails => '查看详情';

  @override
  String get unblock => '取消阻止';

  @override
  String get unblockNumber => '取消阻止号码';

  @override
  String get unblockNumberSuccess => '号码已成功取消阻止';

  @override
  String get unblockNumberFailed => '取消阻止号码失败';

  @override
  String get serviceNotAvailable => '服务不可用';

  @override
  String get callingNumberFailed => '呼叫号码失败';

  @override
  String get listView => '列表视图';

  @override
  String get timelineView => '时间线视图';

  @override
  String get nameCannotBeEmpty => '名称不能为空';

  @override
  String get selectAction => '选择操作';

  @override
  String get selectTargetService => '选择目标服务';

  @override
  String get callDetails => '通话详情';

  @override
  String get callType => '通话类型';

  @override
  String get callTime => '通话时间';

  @override
  String get numberInvalidFormat => '号码格式无效';

  @override
  String get membershipFeature => '会员功能';

  @override
  String get medium => '媒介';

  @override
  String get verificationReport => '验证报告';

  @override
  String get finalRisk => '最终风险';

  @override
  String get simState => 'SIM 卡状态';

  @override
  String get ipCountry => 'IP 国家/地区';

  @override
  String get simCountry => 'SIM 卡国家/地区';

  @override
  String get isRoaming => '正在漫游';

  @override
  String get isNumberMatch => '号码匹配';

  @override
  String get support => '支持';

  @override
  String get rewardedAdService => '激励广告服务';

  @override
  String get hasVipPrivilegeExceptAds => '您已经拥有 VIP 权限（广告除外）';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '您已经拥有临时权限，到期日期：$expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '您需要观看 $count 个广告才能获得临时 VIP 权限';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '您已获得 $days 天的临时购买权限。到期日期：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '临时购买权限已过期';

  @override
  String get loadingAd => '正在加载广告...';

  @override
  String get earnedTempVip => '获得临时 VIP';

  @override
  String get vipExchangeService => 'VIP 兑换服务';

  @override
  String get marksInsufficient => '兑换积分不足';

  @override
  String get invalidExchangeRule => '无效的兑换规则';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '成功兑换 $description，到期日期：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '兑换失败：$error';
  }

  @override
  String get vip3DaysWithAds => '3 天 VIP（含广告，仅同步）';

  @override
  String get vip5DaysNoAds => '5 天全功能无广告 VIP';

  @override
  String get vip7DaysNoAds => '7 天全功能无广告 VIP';

  @override
  String get noNotifications => '没有通知';

  @override
  String get clearAllNotifications => '清除所有通知';

  @override
  String get clearAllNotificationsConfirmation => '确认清除所有通知';

  @override
  String get allNotificationsCleared => '所有通知已清除';

  @override
  String get clearButton => '清除';

  @override
  String get justNow => '刚刚';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟前',
      one: '1 分钟前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时前',
      one: '1 小时前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天前',
      one: '1 天前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨天';

  @override
  String get deletionProposal => '删除提议';

  @override
  String get deletionProposals => '删除提议';

  @override
  String get createProposal => '创建提议';

  @override
  String get createProposalTitle => '创建删除提议';

  @override
  String get reason => '原因';

  @override
  String get reasonOutdated => '号码已过期';

  @override
  String get reasonPrivacy => '隐私问题';

  @override
  String get reasonNotInService => '停止服务';

  @override
  String get reasonWronglyIdentified => '错误识别';

  @override
  String get reasonInaccurateInfo => '信息不准确';

  @override
  String get reasonWrongMarked => '标记错误';

  @override
  String get reasonOther => '其他';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get proposalStatus => '状态';

  @override
  String get statusPending => '待处理';

  @override
  String get statusActive => '进行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusExpired => '已过期';

  @override
  String get riskLevel => '风险等级';

  @override
  String get riskLevelVerified => '已验证';

  @override
  String get riskLevelLow => '低风险';

  @override
  String get riskLevelHigh => '高风险';

  @override
  String get riskLevelUnknown => '未知';

  @override
  String get votingProgress => '投票进度';

  @override
  String agreeVotes(int count) {
    return '同意: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反对: $count';
  }

  @override
  String totalVotes(int count) {
    return '总计: $count';
  }

  @override
  String get voteAgree => '同意';

  @override
  String get voteDisagree => '反对';

  @override
  String createdAt(String date) {
    return '创建时间: $date';
  }

  @override
  String get showReport => '显示报告';

  @override
  String get hideReport => '隐藏报告';

  @override
  String get proposalStatistics => '提议统计';

  @override
  String get totalProposals => '总提议数';

  @override
  String get activeProposals => '进行中提议';

  @override
  String get completedProposals => '已完成提议';

  @override
  String get myVotes => '我的投票';

  @override
  String get proposalCreated => '提议创建成功';

  @override
  String get proposalCreateFailed => '创建提议失败';

  @override
  String get voteSubmitted => '投票提交成功';

  @override
  String get voteSubmitFailed => '投票提交失败';

  @override
  String get noProposalsFound => '未找到提议';

  @override
  String get loadingProposals => '正在加载提议...';

  @override
  String get refreshProposals => '刷新提议';

  @override
  String get totalPendingProposals => '待处理提议总数';

  @override
  String get highRisk => '高风险';

  @override
  String get mediumRisk => '中风险';

  @override
  String get lowRisk => '低风险';

  @override
  String get communityImpact => '社区影响';

  @override
  String get criticalIssues => '关键问题';

  @override
  String get communityParticipation => '社区参与度';

  @override
  String get noActivity => '无活动';

  @override
  String get low => '低';

  @override
  String get moderate => '中等';

  @override
  String get high => '高';

  @override
  String get veryHigh => '很高';

  @override
  String get voted => '已投票';

  @override
  String get communityVotes => '社区投票';

  @override
  String get waitingForMoreVotes => '等待更多社区投票';

  @override
  String get proposalProcessed => '此提案已处理完成';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反对';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒绝';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待处理';

  @override
  String get critical => '严重';

  @override
  String get oppose => '反对';

  @override
  String get veryLow => '极低';

  @override
  String get deletionProposalNotificationDescription => '关于删除提议投票结果和更新的通知。';

  @override
  String get deletionProposalCreated => '删除提议已创建';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '您对 $phoneNumber 的删除提议已提交社区审核。';
  }

  @override
  String get proposalApproved => '提议已通过 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '对 $phoneNumber 的删除提议已被社区通过（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get proposalRejected => '提议已拒绝 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '对 $phoneNumber 的删除提议已被社区拒绝（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get communityVotingStarted => '社区投票已开始';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '对 $phoneNumber 的新删除提议现已开放社区投票。';
  }

  @override
  String get votingCompleted => '投票已完成';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '对 $phoneNumber 的社区投票已结束。结果：$result（$supportPercentage% 支持）。';
  }

  @override
  String get newVoteReceived => '收到新投票';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '有人投票$voteType删除 $phoneNumber。当前票数：$totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '加载投票数失败';

  @override
  String get voteCount => '投票数';

  @override
  String get deletionProposalInfo => '删除建议信息';

  @override
  String get deletionProposalDescription => '建议删除违反社区准则的号码。您的参与有助于保持平台安全。';

  @override
  String get voteToEarnVip => '对提案进行投票以赚取 VIP 特权！';

  @override
  String get voteFailed => '投票失败';

  @override
  String get searchProposals => '搜索建议';

  @override
  String get defaultNotifications => '默认通知';

  @override
  String get defaultNotificationsDescription => '应用程序的默认通知通道。';

  @override
  String get blockedCallNotifications => '拦截来电通知';

  @override
  String get blockedCallNotificationsDescription => '显示有关被阻止的呼叫的信息。';

  @override
  String get stirVerification => 'STIR/SHAKEN 验证';

  @override
  String get stirVerificationDescription => '显示号码的 STIR/SHAKEN 验证结果。';

  @override
  String get fraudAlerts => '欺诈警报';

  @override
  String get fraudAlertsDescription => '显示潜在欺诈呼叫的警告。';

  @override
  String get notificationFrequencyDescription =>
      '选择您接收有关新删除建议的通知频率。您可以立即、批量或按自定义间隔接收它们。';

  @override
  String get immediateNotifications => '立即';

  @override
  String get immediateNotificationsDescription => '一旦创建提案，立即收到通知。';

  @override
  String get batchNotifications => '批量';

  @override
  String get batchNotificationsDescription => '定期接收通知摘要。';

  @override
  String get customNotifications => '自定义';

  @override
  String get customNotificationsDescription => '定义您自己的接收通知的间隔。';

  @override
  String get customFrequency => '自定义频率';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 小时';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 小时 $minutes 分钟';
  }

  @override
  String get pendingProposals => '待定提案';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个待定提案',
      one: '1 个待定提案',
      zero: '没有待定提案',
    );
    return '您有 $_temp0。';
  }

  @override
  String get guidelinesLabel => '指南';

  @override
  String get reportingGuidelines =>
      '• 仅报告真正有问题的号码\n• 提供准确和详细的原因\n• 根据严重程度选择适当的风险等级\n• 虚假报告可能会导致帐户受限';

  @override
  String get riskLevelLabel => '风险等级';

  @override
  String get riskLevelDescription => '号码的风险等级';

  @override
  String get phoneNumberMinDigits => '电话号码必须至少为 7 位数字';

  @override
  String get provideDetailedExplanation => '提供详细的解释（最少 10 个字符）';

  @override
  String get reasonMinCharacters => '原因必须至少 10 个字符';

  @override
  String get countryCodeTwoLetters => '国家代码 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '国家代码 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '例如，US, CN, GB';

  @override
  String get countryCodeRequired => '需要国家代码';

  @override
  String get countryCodeLengthError => '国家代码必须为 2 个字母';

  @override
  String get phoneNumberLengthError => '电话号码必须至少为 7 位数字';

  @override
  String get reasonHint => '提供详细解释（至少 10 个字符）';

  @override
  String get reasonRequired => '必须填写理由';

  @override
  String get reasonLengthError => '理由必须至少 10 个字符';

  @override
  String get guidelinesTitle => '指南';

  @override
  String get guidelinesText =>
      '• 仅报告真正有问题的号码\n• 提供准确且详细的理由\n• 根据严重程度选择适当的风险等级\n• 虚假报告可能会导致帐户受限';

  @override
  String get riskLevelCritical => '严重';

  @override
  String get riskLevelMedium => '中等';

  @override
  String get riskLevelVeryLow => '非常低';

  @override
  String get riskDescriptionVeryLow => '非常低 - 轻微的烦恼，不频繁的通话';

  @override
  String get riskDescriptionLow => '低 - 偶尔的不必要电话';

  @override
  String get riskDescriptionMedium => '中等 - 定期垃圾邮件或电话销售';

  @override
  String get riskDescriptionHigh => '高 - 持久的骚扰或诈骗企图';

  @override
  String get riskDescriptionCritical => '严重 - 危险的诈骗或威胁';

  @override
  String get notificationFrequencyTitle => '通知频率';

  @override
  String get notificationFrequencyLabel => '通知频率（小时）';

  @override
  String errorMessage(String error) {
    return '错误：$error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票：$totalVotes（$supportPercentage% 支持）';
  }

  @override
  String supportCount(int supportCount) {
    return '支持（$supportCount）';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反对（$opposeCount）';
  }

  @override
  String get timeJustNow => '刚刚';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours小时前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days天前';
  }

  @override
  String get notificationFrequencyHours => '通知频率（小时）';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票（$supportPercentage% 支持）';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时',
      one: '1 小时',
      zero: '0 小时',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要提示';

  @override
  String get dataSourceDisclaimer =>
      '号码来自互联网和用户提交。我们无法保证某个号码一旦被删除，就不会被其他用户或来源重新提交。请积极搜索和验证信息。';

  @override
  String get avatar => '头像';

  @override
  String get location => '位置';

  @override
  String get simCardTitle => 'SIM 卡';

  @override
  String get liveActivitiesSettingsTitle => '实时活动设置';

  @override
  String get elementsSettingsTitle => '元素设置';

  @override
  String get liveActivityMode => '实时活动';

  @override
  String get liveActivityModeDescription => '在锁定屏幕和灵动岛 (iOS) 上将呼叫信息显示为持久通知。';

  @override
  String get phoneNumberType => '电话号码类型';

  @override
  String get liveActivitiesTestEndActivity => '结束活动';

  @override
  String get liveActivitiesTestSendNewActivity => '发送新活动';

  @override
  String get liveActivitiesTestUpdateActivity => '更新活动';

  @override
  String get liveActivityControlsTitle => '实时活动控件';

  @override
  String get liveActivitiesTestTitle => '实时活动测试';

  @override
  String get liveActivitiesTestSubtitle => '测试实时活动通知。';

  @override
  String get liveNotificationCustomizationTitle => '实时通知自定义';

  @override
  String get liveNotificationCustomizationSubtitle => '自定义实时通知的外观。';

  @override
  String get notification_instructions =>
      '说明：\n1. 点击“发送”以创建或更新通知。\n2. 转到您的主屏幕或下拉通知栏以查看结果。\n3. 点击“结束”以关闭通知。';

  @override
  String get autoCancelNotification => '自动取消通知';

  @override
  String get autoCancelNotificationDescription => '如果选中，当用户点击通知时，通知将自动关闭。';

  @override
  String get setDelayTime => '设置延迟时间';

  @override
  String get proposalDetails => '提案详情';

  @override
  String get filterByStatus => '按状态筛选';

  @override
  String get proposalNotFound => '未找到提案';

  @override
  String get processed => '已处理';

  @override
  String get showAll => '显示全部';

  @override
  String get filterAndSortTitle => '筛选和排序';

  @override
  String get filterVerifiedOwner => '筛选已验证的所有者';

  @override
  String get filterBy => '筛选方式';

  @override
  String get sortOldest => '按最旧排序';

  @override
  String get sortNewest => '按最新排序';

  @override
  String get sortMostPopular => '按最受欢迎排序';

  @override
  String get sortLeastPopular => '按最不受欢迎排序';

  @override
  String get sortBy => '排序方式';

  @override
  String get simRulesNotFound => '未找到 SIM 规则';

  @override
  String get simSlotRules => 'SIM 卡槽规则';

  @override
  String get noSimCardDetected => '未检测到 SIM 卡';

  @override
  String get invalidSimData => '无效的 SIM 数据';

  @override
  String get simCardData => 'SIM 卡数据';

  @override
  String get simSlot => 'SIM 卡槽';

  @override
  String get enableFiltering => '启用筛选';

  @override
  String get detailedSettingsTitle => '详细设置';

  @override
  String get entryPointViewTitle => '入口点视图';

  @override
  String get callTypeRejected => '已拒绝';

  @override
  String get callTypeSilenced => '已静音';

  @override
  String get callTypeVoicemail => '语音邮件';

  @override
  String get callTypeUnknownIntercept => '未知拦截';

  @override
  String andMoreItems(int count) {
    return '以及更多 $count 个项目';
  }
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get aboutContactSubscription => '關於聯絡人訂閱';

  @override
  String get aboutLabels => '關於標籤';

  @override
  String get aboutPhoneSubscriptionRules => '關於電話訂閱規則';

  @override
  String get aboutPhoneSubscriptions => '關於電話訂閱';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      '通過 URL 訂閱電話規則列表，自動更新規則。支持 JSON、CSV 格式規則文件。';

  @override
  String get aboutSmsFilter => '關於 SMS 過濾';

  @override
  String get aboutSmsSubscriptionRules => '關於 SMS 訂閱規則';

  @override
  String get aboutSubtitle => '應用程式版本和法律資訊';

  @override
  String get aboutTitle => '關於';

  @override
  String get action => '操作';

  @override
  String get actionAll => '全部';

  @override
  String get actionAllow => '允許';

  @override
  String get actionBlock => '封鎖';

  @override
  String get actionFilterAll => '全部過濾';

  @override
  String get actionFilterTitle => '按操作類型過濾';

  @override
  String get actionFilterTooltip => '操作過濾器';

  @override
  String get actionNone => '無操作';

  @override
  String get actionSilence => '靜音';

  @override
  String actionTag(Object actionType) {
    return '操作：$actionType';
  }

  @override
  String get actionType => '操作類型';

  @override
  String get actionUnknown => '未知';

  @override
  String get add => '新增';

  @override
  String get addAllowedBlockedRule => '新增允許/封鎖規則';

  @override
  String get addAllowSubscription => '新增允許訂閱';

  @override
  String get addBlockSubscription => '新增封鎖訂閱';

  @override
  String get addContactButton => '新增聯絡人';

  @override
  String addContactFailed(Object error) {
    return '新增聯絡人失敗：$error';
  }

  @override
  String get addedToAllowedRules => '已新增至允許規則';

  @override
  String get addedToBlacklist => '已新增至黑名單';

  @override
  String get addedToBlockedRules => '已新增至封鎖規則';

  @override
  String get addedToFavoriteContacts => '已新增至收藏聯絡人';

  @override
  String get addedToFavorites => '已新增至收藏聯絡人';

  @override
  String get addedToWhitelist => '已新增至白名單';

  @override
  String get addFavorite => '新增收藏';

  @override
  String get addFilter => '新增過濾器';

  @override
  String get addLabel => '新增標籤';

  @override
  String get addLabelButton => '新增標籤';

  @override
  String addLabelFailed(Object error) {
    return '新增標籤失敗：$error';
  }

  @override
  String get addLabelToCall => '新增標籤至通話記錄';

  @override
  String get addName => '新增名稱';

  @override
  String get addNoneSubscription => '新增無訂閱';

  @override
  String get addOrEditContactInfo => '用於新增或編輯聯絡人資訊';

  @override
  String get addPhoneMark => '新增電話標記';

  @override
  String get addPhoneNumberRule => '新增電話號碼規則';

  @override
  String get addPlugin => '新增插件';

  @override
  String get addPluginFailed => '新增插件失敗';

  @override
  String addPluginFailedWithError(Object error) {
    return '新增插件失敗：$error';
  }

  @override
  String get addPluginFromLocalFile => '從本地檔案新增插件';

  @override
  String get addPluginFromUrl => '從 URL 新增插件';

  @override
  String get addRegexRule => '新增正則表達式規則';

  @override
  String get addRule => '新增規則';

  @override
  String get addRuleButton => '新增規則';

  @override
  String addRuleFailed(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String get addRuleTooltip => '新增規則';

  @override
  String get addSilenceSubscription => '新增靜音訂閱';

  @override
  String get addSimRuleButton => '新增 SIM 卡規則';

  @override
  String get addSmsFilterRule => '新增 SMS 過濾規則';

  @override
  String get addSmsRule => '新增 SMS 規則';

  @override
  String get addSmsSubscription => '新增 SMS 訂閱';

  @override
  String get addSubscription => '新增訂閱';

  @override
  String get addSubscriptionButton => '新增訂閱';

  @override
  String addSubscriptionFailed(Object error) {
    return '新增訂閱失敗：$error';
  }

  @override
  String get addSubscriptionTooltip => '新增訂閱';

  @override
  String get addToAllowedRules => '新增至允許規則';

  @override
  String get addToBlacklist => '新增至黑名單';

  @override
  String get addToBlockedRules => '新增至封鎖規則';

  @override
  String get addToFavoriteContacts => '新增至常用聯絡人';

  @override
  String get addToFavorites => '新增至我的最愛';

  @override
  String get addToRules => '新增至規則';

  @override
  String get addToWhitelist => '新增至白名單';

  @override
  String get adPlaceholder => '廣告佔位符';

  @override
  String get agent => '代理';

  @override
  String get all => '全部';

  @override
  String get allCallsTab => '全部';

  @override
  String get allDataClearedSuccessfully => '已成功清除所有資料';

  @override
  String get allow => '允許';

  @override
  String get allowAllAllowRules => '允許所有允許規則';

  @override
  String get allowAllAllowRulesDesc => '允許來自允許規則的通話';

  @override
  String get allowAllBlacklistedNumbers => '允許所有黑名單號碼';

  @override
  String get allowAllBlacklistedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowAllBlockRules => '允許所有封鎖規則';

  @override
  String get allowAllBlockRulesDesc => '允許來自封鎖規則的通話';

  @override
  String get allowAllowedNumbers => '允許允許的號碼';

  @override
  String get allowAllowedNumbersDesc => '允許來自白名單的通話';

  @override
  String get allowBlock => '允許/封鎖';

  @override
  String get allowBlockedNumbers => '允許封鎖的號碼';

  @override
  String get allowBlockedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowedBlockedRule => '允許/封鎖規則';

  @override
  String get allowedBlockedRuleEditDialogTitle => '編輯允許/封鎖規則';

  @override
  String get allowedBlockedRuleManagement => '允許/封鎖規則管理';

  @override
  String get allowNonExceededNumbers => '允許未超出限制的號碼';

  @override
  String get allowNonExceededNumbersDescription => '自動允許未超出計數閾值的號碼';

  @override
  String get allowRegexAllowRules => '允許Regex允許規則';

  @override
  String get allowRegexAllowRulesDesc => '啟用允許規則的Regex模式匹配';

  @override
  String get allowRegexAllowRulesDescription => '啟用基於Regex的允許規則';

  @override
  String get allowRegexBlockRules => '允許Regex封鎖規則';

  @override
  String get allowRegexBlockRulesDesc => '啟用封鎖規則的Regex模式匹配';

  @override
  String get allowRegexBlockRulesDescription => '啟用基於Regex的封鎖規則';

  @override
  String get allowRule => '允許規則';

  @override
  String get allowRules => '允許規則';

  @override
  String get allowWhitelistedNumbers => '允許白名單號碼';

  @override
  String get allowWhitelistedNumbersDescription => '允許白名單中的所有號碼';

  @override
  String get allPermissionsGranted => '已授予所有權限';

  @override
  String get allSettingsCompleted => '所有設定已完成。';

  @override
  String allUpdateSuccess(Object count) {
    return '所有更新已完成（$count 條規則）';
  }

  @override
  String get answerThenHangup => '接聽後掛斷';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule。保留所有權利。';

  @override
  String get applicationSoftware => '應用程式軟件';

  @override
  String get apply => '應用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => '授權失敗：請檢查客戶端 ID 和金鑰';

  @override
  String get authorizationFailedMessage => '授權失敗';

  @override
  String get authorizationSuccessMessage => '授權成功';

  @override
  String get authorizeLoginButton => '授權登入';

  @override
  String get automotiveIndustry => '汽車工業';

  @override
  String get autoSyncLabel => '自動同步';

  @override
  String get autoUpdate => '自動更新';

  @override
  String get autoUpdateDescription => '設定訂閱的自動更新間隔或手動更新';

  @override
  String get autoUpdateSettings => '自動更新設定';

  @override
  String get autoUpdateSettingsSubtitle => '管理規則和插件的自動更新';

  @override
  String get autoUpdateSettingsTitle => '自動更新設定';

  @override
  String get autoUpdateSubtitle => '管理規則和插件的自動更新';

  @override
  String get autoUpdateTitle => '自動更新';

  @override
  String get avatarBorderColor => '頭像邊框顏色';

  @override
  String get avatarBorderSize => '頭像邊框大小';

  @override
  String get avatarIconSizesSetting => '頭像和圖標大小';

  @override
  String get avatarPosition => '頭像位置';

  @override
  String get avatarSize => '頭像大小';

  @override
  String axisPosition(Object axis) {
    return '$axis 位置';
  }

  @override
  String get backgroundGradientSetting => '背景漸變';

  @override
  String get backup => '備份';

  @override
  String get backupAndRestore => '備份和還原';

  @override
  String get backupAndRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupAndRestoreTitle => '備份和還原';

  @override
  String get backupFailed => '備份失敗';

  @override
  String get backupFailedMessage => '備份失敗';

  @override
  String backupFailedWithError(Object error) {
    return '備份失敗：$error';
  }

  @override
  String get backupRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupRestoreTitle => '備份和還原';

  @override
  String get backupSectionTitle => '備份';

  @override
  String get backupSettings => '備份設定';

  @override
  String get backupSettingsDialogTitle => '備份設定';

  @override
  String get backupSettingsTitle => '備份設定';

  @override
  String get backupSuccessMessage => '成功備份到雲端';

  @override
  String backupSuccessToLocal(Object path) {
    return '成功備份到：$path';
  }

  @override
  String get backupToCloud => '備份到雲端';

  @override
  String get backupToCloudDescription => '備份設定和規則到雲端儲存';

  @override
  String backupToCloudFailed(Object error) {
    return '備份到雲端失敗：$error';
  }

  @override
  String get backupToCloudLabel => '備份到雲端';

  @override
  String get backupToCloudSuccess => '成功備份到雲端';

  @override
  String get backupToCloudTitle => '備份到雲端';

  @override
  String get backupToLocalLabel => '備份到本地';

  @override
  String get bank => '銀行';

  @override
  String get basicInfo => '基本信息';

  @override
  String get basicRuleFilter => '基本規則過濾器';

  @override
  String get basicRuleFiltering => '基本規則過濾';

  @override
  String get basicRuleFilteringExplanation => '• 基本規則過濾：基於黑名單、白名單和正則表達式的過濾規則';

  @override
  String get basicRuleFilterSettings => '基本規則過濾器設置';

  @override
  String get basicRuleFilterSubtitle => '使用黑名單/白名單和正則表達式過濾通話';

  @override
  String get batchDeleteContacts => '批量刪除聯絡人';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '您確定要刪除 $count 個選定的聯絡人嗎？';
  }

  @override
  String get batchDeleteFailed => '批量刪除失敗';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '您確定要刪除 $count 個標籤嗎？';
  }

  @override
  String get blacklist => '黑名單';

  @override
  String get blacklistingAndWhitelisting => '黑名單和白名單';

  @override
  String get blacklistLabel => '黑名單';

  @override
  String get blackWhiteList => '黑/白名單';

  @override
  String get block => '封鎖';

  @override
  String get blockCalls => '封鎖通話';

  @override
  String get blocked => '已封鎖';

  @override
  String get blockedCallAction => '已封鎖通話操作';

  @override
  String get blockedCalls => '已封鎖通話';

  @override
  String get blockedCallsTitle => '已封鎖通話';

  @override
  String get blockedCommunications => '已封鎖通訊';

  @override
  String get blockedPhoneLabel => '已封鎖通話';

  @override
  String get blockedSpamCalls => '已封鎖垃圾電話';

  @override
  String get blockingTrend => '封鎖趨勢';

  @override
  String get blockInternationalCalls => '匹配不以 + 或 00 開頭的號碼';

  @override
  String get blockInternationalCallsTitle => '封鎖國際電話';

  @override
  String get blockLandlineNumbersTitle => '封鎖固網電話號碼';

  @override
  String get blockMobileNumbers => '匹配不以 13-19 開頭的號碼';

  @override
  String get blockMobileNumbersTitle => '封鎖手機號碼';

  @override
  String get blockPremiumRateNumbers => '匹配不以 118 或 120-190 開頭的號碼';

  @override
  String get blockPremiumRateNumbersTitle => '封鎖高收費電話號碼';

  @override
  String get blockRule => '封鎖規則';

  @override
  String get blockRules => '封鎖規則';

  @override
  String get blockSpecificAreaCodes => '匹配以 0 + 2-3 位數字開頭的號碼';

  @override
  String get blockSpecificAreaCodesTitle => '封鎖特定地區代碼：';

  @override
  String get blockTypeAnalysisTitle => '封鎖類型分析';

  @override
  String get both => '兩者';

  @override
  String get bulkDelete => '批量刪除聯絡人';

  @override
  String get bulkDeleteContacts => '批量刪除聯絡人';

  @override
  String get bulkDeleteLabels => '批量刪除標籤';

  @override
  String get call => '通話';

  @override
  String get callback => '回撥';

  @override
  String callbackTo(String number) {
    return '回撥至 $number';
  }

  @override
  String get callBlocking => '通話封鎖';

  @override
  String get callerIdApp => '來電顯示應用程式';

  @override
  String get callerIdCustomizationTitle => '自訂來電顯示';

  @override
  String get callerIdDialogTitle => '來電顯示信息';

  @override
  String get callerIdDisplayMode => '來電顯示模式';

  @override
  String callerIdMarkedByCount(Object count) {
    return '被標記 $count 次';
  }

  @override
  String get callerIdPreview => '來電顯示預覽';

  @override
  String get callFilter => '來電過濾';

  @override
  String get callFilterDescription =>
      '啟用後，來電會根據以下規則列表進行檢查。 預設情況下，來電過濾規則不會在裝置之間同步。';

  @override
  String get callFilterRules => '來電過濾規則';

  @override
  String get callFilterRulesDescription => '設定來電過濾的基本規則';

  @override
  String get callFilterSettings => '來電過濾設定';

  @override
  String get callFrequencyInterceptionSubtitle => '設定通話頻率限制和封鎖規則';

  @override
  String get callFrequencyInterceptionTitle => '通話頻率攔截';

  @override
  String get callHistory => '通話記錄';

  @override
  String get callHistoryInfoDesc => '此處顯示您的通話記錄，包括來電、去電和未接來電。';

  @override
  String get callHistoryInfoTitle => '通話記錄';

  @override
  String callHistoryInitFailed(Object error) {
    return '初始化通話記錄失敗：$error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '刷新通話記錄失敗：$error';
  }

  @override
  String get callHistoryTab => '通話記錄';

  @override
  String get callHistoryTimelineEarlier => '更早';

  @override
  String get callHistoryTimelineToday => '今天';

  @override
  String get callHistoryTimelineYesterday => '昨天';

  @override
  String get callScreeningPermission => '來電篩選權限';

  @override
  String get callScreeningPermissionDescription => '用於篩選和封鎖垃圾電話。';

  @override
  String get callScreeningPermissionNotGranted => '未授予來電篩選權限，可能會影響應用程式功能。';

  @override
  String get callSettingsSubtitle => '來電顯示、過濾和封鎖設定';

  @override
  String get callSettingsTitle => '通話設定';

  @override
  String get callStatistics => '通話統計';

  @override
  String get callTypeAnswered => '已接聽';

  @override
  String get callTypeBlocked => '已封鎖';

  @override
  String get callTypeIconColor => '通話類型圖示顏色';

  @override
  String get callTypeMissed => '未接來電';

  @override
  String get callTypeOutgoing => '去電';

  @override
  String get callTypePosition => '通話類型位置';

  @override
  String get callTypeUnknown => '未知';

  @override
  String get cancelButton => '取消';

  @override
  String get carRental => '汽車租賃';

  @override
  String get carrier => '運營商';

  @override
  String get carrierColor => '運營商顏色';

  @override
  String get carrierFontSize => '運營商字體大小';

  @override
  String get carrierPosition => '運營商位置';

  @override
  String get changeLabel => '更改標籤';

  @override
  String changePluginStatusFailed(Object error) {
    return '更改插件狀態失敗：$error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '更改訂閱狀態失敗：$error';
  }

  @override
  String get changeTag => '更改標籤';

  @override
  String get charity => '慈善機構';

  @override
  String chartMonthFormat(int month) {
    return '月份 $month';
  }

  @override
  String get chartOneDayAgo => '1 天前';

  @override
  String get chartOneMonthAgo => '1 個月前';

  @override
  String get chartOneWeekAgo => '1 週前';

  @override
  String get chartTenDaysAgo => '10 天前';

  @override
  String get chartThreeDaysAgo => '3 天前';

  @override
  String get chartToday => '今天';

  @override
  String get checkFileFormat => '請檢查檔案格式或權限';

  @override
  String checkPermissionFailed(Object error) {
    return '檢查權限失敗：$error';
  }

  @override
  String get chooseDefaultInterceptAction => '選擇預設攔截動作';

  @override
  String get clearAllData => '清除所有數據';

  @override
  String get clearAllDataConfirmation => '您確定要清除所有應用程式數據嗎？ 此操作無法撤銷。';

  @override
  String get clearAllDataDescription => '清除所有應用程式數據';

  @override
  String get clearAllDataLabel => '清除所有數據';

  @override
  String get clearFilter => '清除篩選器';

  @override
  String get clearLabelFilter => '清除標籤篩選器';

  @override
  String get clearLabelFilterButton => '清除標籤篩選器';

  @override
  String get closeButton => '關閉';

  @override
  String get cloudSync => '雲端同步';

  @override
  String get cloudSyncAndBackupTitle => '雲端同步與備份';

  @override
  String get cloudSyncSettingsSubtitle => '設定 WebDAV、OneDrive 和 Google Drive';

  @override
  String get cloudSyncSettingsTitle => '雲端同步設定';

  @override
  String get cloudSyncTitle => '雲端同步';

  @override
  String get collapseLabelSelector => '摺疊標籤選擇器';

  @override
  String get collection => '催收';

  @override
  String get colorPickerTitle => '選擇顏色';

  @override
  String get configManagement => '配置管理';

  @override
  String get configUpdated => '配置已更新';

  @override
  String get configurationAdvice => '透過正確的配置，您可以為工作和個人 SIM 卡設定不同的篩選策略。';

  @override
  String get configureBackupOptions => '設定備份選項';

  @override
  String get configureBackupOptionsSubtitle => '設定備份選項';

  @override
  String get configureCloudSyncService => '設定雲端同步服務';

  @override
  String get configureCloudSyncServiceHint => '請設定雲端同步服務以啟用多設備同步。';

  @override
  String get configureCloudSyncServiceMessage => '請設定雲端同步服務以啟用多設備同步。';

  @override
  String get configureSimCardFilterRules => '設定 SIM 卡篩選規則';

  @override
  String get configureSyncServiceHint => '請先在雲端同步設定中配置同步服務';

  @override
  String get confirm => '確認';

  @override
  String get confirmBatchDeleteContacts => '您確定要刪除所選的';

  @override
  String get confirmButton => '確認';

  @override
  String get confirmDelete => '確認刪除';

  @override
  String get confirmDeleteContact => '您確定要刪除';

  @override
  String get confirmDeleteContactName => '確認刪除？';

  @override
  String get confirmDeleteFilter => '您確定要刪除此篩選器嗎？';

  @override
  String confirmDeleteLabel(Object name) {
    return '您確定要刪除標籤 \"$name\" 嗎？';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '您確定要刪除插件 \"$name\" 嗎？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '您確定要刪除 $count 個插件嗎？';
  }

  @override
  String get confirmDeleteRuleMessage => '您確定要刪除此規則嗎？ 此操作無法撤銷。';

  @override
  String get confirmDeleteSelectedContacts => '您確定要刪除選定的聯絡人嗎？';

  @override
  String get confirmDeleteSmsFilterRule => '您確定要刪除此簡訊篩選規則嗎？';

  @override
  String get confirmDeleteSmsRule => '您確定要刪除此簡訊規則嗎？';

  @override
  String get confirmDeleteSubscription => '您確定要刪除此訂閱嗎？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '您確定要刪除 $name？';
  }

  @override
  String get confirmPassword => '確認密碼';

  @override
  String get confirmPasswordLabel => '確認密碼';

  @override
  String get connectedStatus => '已連接';

  @override
  String get connectionFailedCheckCredentialsMessage => '連接失敗：請檢查伺服器地址、用戶名和密碼';

  @override
  String get connectionFailedMessage => '連接失敗';

  @override
  String get connectionStatusLabel => '連線狀態';

  @override
  String get connectionSuccessMessage => '連線成功';

  @override
  String get contactAddSuccess => '成功新增聯絡人';

  @override
  String get contactDeleted => '已刪除聯絡人';

  @override
  String get contactEditDialog => '編輯聯絡人對話框';

  @override
  String get contactNameHint => '輸入聯絡人姓名（可選）';

  @override
  String get contactNameLabel => '姓名';

  @override
  String get contactNameOptional => '聯絡人姓名（可選）';

  @override
  String get contactNotFound => '找不到聯絡人';

  @override
  String get contacts => '聯絡人';

  @override
  String contactsDeleted(Object count) {
    return '已刪除 $count 個聯絡人';
  }

  @override
  String get contactSettingsSubtitle => '聯絡人管理和標籤設定';

  @override
  String get contactSettingsTitle => '聯絡人設定';

  @override
  String contactsLoadingFailed(Object error) {
    return '載入聯絡人失敗：$error';
  }

  @override
  String get contactsManagement => '聯絡人管理';

  @override
  String get contactsManagementPageTitle => '聯絡人管理頁面';

  @override
  String get contactsPageTitle => '聯絡人管理';

  @override
  String get contactsPermission => '聯絡人權限';

  @override
  String get contactsPermissionDescription => '用於識別聯絡人通話。';

  @override
  String get contactsTab => '聯絡人';

  @override
  String get contactSubscriptionDescription =>
      '通過 URL 訂閱聯絡人列表，自動更新聯絡人信息和標籤。支持 JSON 格式數據。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '載入聯絡人訂閱失敗：$error';
  }

  @override
  String get contactSubscriptionPageTitle => '聯絡人訂閱';

  @override
  String get contactUpdateSuccess => '成功更新聯絡人';

  @override
  String get contactUs => '聯絡我們';

  @override
  String get content => '內容';

  @override
  String get contentRegex => '內容正則表達式';

  @override
  String get countColor => '計數顏色';

  @override
  String get countFontSize => '計數字體大小';

  @override
  String get countPosition => '計數位置';

  @override
  String get country => '國家';

  @override
  String get countryNameColor => '國家名稱顏色';

  @override
  String get countryNameFontSize => '國家名稱字體大小';

  @override
  String get countryRegionNamePosition => '國家/地區名稱位置';

  @override
  String get countrySelectionDialog => '國家選擇對話框';

  @override
  String get countrySelectionDialogDescription => '用於選擇國家以查詢來電顯示信息';

  @override
  String get countThresholdDescription => '設置觸發過濾操作所需的最小計數閾值';

  @override
  String get countThresholdLabel => '計數閾值';

  @override
  String get countThresholdSettings => '計數閾值設定';

  @override
  String countThresholdValue(Object count) {
    return '計數閾值：$count';
  }

  @override
  String get createdRules => '已創建規則';

  @override
  String get csvFormat => 'CSV 格式';

  @override
  String get currentDeviceChip => '目前';

  @override
  String get currentDeviceLabel => '目前裝置標籤';

  @override
  String get currentDeviceTitle => '目前裝置';

  @override
  String get currentLabels => '目前標籤：';

  @override
  String get currentLanguage => '目前語言';

  @override
  String get currentPasswordLabel => '目前密碼';

  @override
  String get customerService => '客戶服務';

  @override
  String get customRange => '自定義範圍';

  @override
  String get dailyStatistics => '每日統計';

  @override
  String get dailyStatisticsDesc => '接收有關已封鎖的通話和訊息的每日統計資訊';

  @override
  String get dashboardTab => '儀表板';

  @override
  String get dataAnalysis => '數據分析';

  @override
  String get dataAnalysisDashboardPage => '數據分析儀表板頁面';

  @override
  String get dataExport => '數據匯出';

  @override
  String dataLoadFailure(Object error) {
    return '數據加載失敗：$error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '數據加載失敗：$error';
  }

  @override
  String get dataMigration => '數據遷移';

  @override
  String get dataMigrationDescription =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和還原功能手動遷移數據。';

  @override
  String get dataMigrationDialogContent =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和還原功能手動遷移數據。';

  @override
  String get dataMigrationDialogTitle => '數據遷移';

  @override
  String get dataMigrationSectionTitle => '數據遷移';

  @override
  String get dataSourceReminder => '數據源提示';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日',
      one: '1 日',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 天 VIP';
  }

  @override
  String get debtCollection => '債務催收';

  @override
  String get defaultPeriod => '週';

  @override
  String get delete => '刪除';

  @override
  String get deleteButton => '刪除';

  @override
  String get deleteContact => '刪除聯絡人';

  @override
  String deleteContactConfirm(Object name) {
    return '確定要刪除 $name 嗎？';
  }

  @override
  String get deleteContactConfirmation => '確定要刪除聯絡人嗎';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '確定要刪除 $deviceName 嗎？';
  }

  @override
  String get deleteDeviceDialogTitle => '刪除裝置';

  @override
  String deleteFailed(Object error) {
    return '刪除失敗：$error';
  }

  @override
  String get deleteFilter => '刪除篩選器';

  @override
  String get deleteLabel => '刪除標籤';

  @override
  String deleteLabelFailed(Object error) {
    return '刪除標籤失敗：$error';
  }

  @override
  String get deletePlugin => '刪除插件';

  @override
  String deletePluginFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deletePlugins => '刪除插件';

  @override
  String deletePluginsFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deleteRule => '刪除規則';

  @override
  String deleteRuleFailed(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String get deleteSelected => '刪除選定';

  @override
  String get deleteSmsRule => '刪除 SMS 規則';

  @override
  String get deleteSubscription => '刪除訂閱';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '確定要刪除訂閱 \"$name\" 嗎？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '刪除訂閱失敗：$error';
  }

  @override
  String get deleteSuccess => '刪除成功';

  @override
  String get delivery => '交付';

  @override
  String get deviceDeletedSuccessfully => '裝置已成功刪除';

  @override
  String get deviceDeletedSuccessfullyMessage => '裝置已成功刪除';

  @override
  String get deviceIdLabel => '裝置 ID';

  @override
  String get deviceIDLabel => '裝置 ID';

  @override
  String get deviceManagementSubtitle => '管理多裝置同步';

  @override
  String get deviceManagementTitle => '裝置管理';

  @override
  String get deviceModelLabel => '裝置型號';

  @override
  String get deviceName => '裝置名稱';

  @override
  String get deviceNameCannotBeEmpty => '設備名稱不能為空';

  @override
  String get deviceNameHint => '請輸入設備名稱';

  @override
  String get deviceNameLabel => '設備名稱';

  @override
  String get deviceRenamedSuccessfully => '設備已成功重新命名';

  @override
  String get deviceRenamedSuccessfullyMessage => '設備已成功重新命名';

  @override
  String get devicesSyncedSuccessfully => '設備已成功同步';

  @override
  String get devicesSyncedSuccessfullyMessage => '設備已成功同步';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '設備已成功同步';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '設備已成功取消註冊';

  @override
  String get dialogTitle => '正則表達式模式說明';

  @override
  String get differentFromLocalCounter =>
      '此功能與本地計數器過濾器不同，它側重於短時間內重複的通話模式，而不是長期標記計數。';

  @override
  String get disabled => '已停用';

  @override
  String get disabledStatus => '已停用';

  @override
  String get disableGlobalPlugins => '停用全域外掛程式';

  @override
  String get disableSubscriptionSuccessfully => '已成功停用訂閱';

  @override
  String get disconnectButton => '中斷連線';

  @override
  String get disconnectedMessage => '已中斷連線';

  @override
  String get disconnectedStatus => '已中斷連線';

  @override
  String get disconnectFailedMessage => '中斷連線失敗';

  @override
  String get done => '完成';

  @override
  String get dualSimAdvice => '此功能對於雙 SIM 卡手機特別有用，可以為工作和個人 SIM 卡設定不同的過濾策略。';

  @override
  String get earlier => '更早';

  @override
  String get ecommerce => '電子商務';

  @override
  String get edit => '編輯';

  @override
  String get editContact => '編輯聯絡人';

  @override
  String get editFilter => '編輯過濾器';

  @override
  String get editLabel => '編輯標籤';

  @override
  String get editPhoneRule => '編輯電話規則';

  @override
  String get editPhoneRules => '用於編輯電話規則';

  @override
  String get editPhoneRuleTitle => '編輯電話規則';

  @override
  String get editRule => '編輯規則';

  @override
  String get editSmsRule => '編輯 SMS 規則';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '元素位置';

  @override
  String get email => '電子郵件';

  @override
  String get emailOptional => '電子郵件 (可選)';

  @override
  String get enableCallFilter => '啟用通話過濾器';

  @override
  String get enableCallFilterDescription =>
      '啟用後，來電會根據下面的規則列表進行檢查。預設情況下，通話過濾規則不會在設備之間同步。';

  @override
  String get enabled => '已啟用';

  @override
  String get enabledStatus => '已啟用';

  @override
  String get enableEncryption => '啟用加密';

  @override
  String get enableEncryptionDescription => '加密備份檔案';

  @override
  String get enableEncryptionLabel => '啟用加密';

  @override
  String get enableEncryptionSubtitle => '備份檔案將被加密';

  @override
  String get enableEncryptionTitle => '啟用加密';

  @override
  String get enableGlobalPlugins => '啟用全域外掛程式';

  @override
  String get enableLocalCountFilter => '啟用本地計數過濾器';

  @override
  String get enableLocalCountFilterDescription => '根據通話標記計數自動過濾垃圾電話';

  @override
  String get enableLocalNotification => '使用本地通知';

  @override
  String get enableLocalNotificationDescription => '啟用後，將在設備上顯示已過濾訊息的通知';

  @override
  String get enableLocationSummary => '位置';

  @override
  String get enableMuteRules => '啟用靜音規則';

  @override
  String get enableMuteRulesDesc => '應用靜音攔截規則配置';

  @override
  String get enableNoneActionRules => '啟用無操作規則';

  @override
  String get enableNoneActionRulesDesc => '允許無攔截操作的規則配置';

  @override
  String get enableNotifications => '啟用通知';

  @override
  String get enableRemoteNumberFilter => '啟用遠端號碼過濾';

  @override
  String get enableRemoteNumberFilterDescription => '使用遠端資料庫過濾號碼';

  @override
  String get enableRule => '啟用規則';

  @override
  String get enableSmsFilter => '啟用短訊過濾';

  @override
  String get enableSmsFilterDescription => '啟用後，訊息將根據規則自動過濾';

  @override
  String get enableStatisticsNotifications => '啟用統計通知';

  @override
  String get enableSubscriptionSuccessfully => '成功啟用訂閱';

  @override
  String get enableTimeInterception => '啟用時間攔截';

  @override
  String get enableTimeInterceptionDescription => '短時間內攔截重複來電';

  @override
  String get enableTimeInterceptor => '啟用時間攔截器';

  @override
  String get endCallImmediately => '立即結束通話';

  @override
  String get endColor => '結束顏色';

  @override
  String get endDate => '結束日期';

  @override
  String get enhancedFilterInstructionsTitle => '增強型過濾系統';

  @override
  String get enhancedFilterSettings => '增強型過濾設定';

  @override
  String get enhancedFilterSettingsTitle => '增強型過濾設定';

  @override
  String get enhancedFilterSystemDescription => '增強型過濾系統支援全域規則和每張 SIM 卡的過濾配置。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '請同時輸入電話號碼和正則表達式';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => '請同時輸入電話號碼和正則表達式。';

  @override
  String get enterContactName => '請輸入聯絡人姓名';

  @override
  String get enterCurrentPasswordHint => '請輸入當前密碼';

  @override
  String get enterDeviceName => '輸入裝置名稱';

  @override
  String get enterDeviceNameHint => '請輸入裝置名稱';

  @override
  String get enterEmail => '請輸入電郵';

  @override
  String get enterEmailOptional => '請輸入電郵 (可選)';

  @override
  String get enterEncryptionPasswordHint => '輸入加密密碼';

  @override
  String get enterEncryptionPasswordTitle => '輸入加密密碼';

  @override
  String get enterFilterName => '請輸入過濾器名稱';

  @override
  String get enterFilterPattern => '請輸入過濾器模式';

  @override
  String get enterIconCode => '輸入圖標代碼';

  @override
  String get enterName => '輸入聯絡人姓名';

  @override
  String get enterNewDeviceNameHint => '輸入此裝置的新名稱';

  @override
  String get enterNewPasswordHint => '請輸入新密碼';

  @override
  String get enterPasswordAgain => '再次輸入密碼';

  @override
  String get enterPasswordHint => '請輸入密碼';

  @override
  String get enterPhoneNumber => '輸入電話號碼';

  @override
  String get enterPhoneNumberHint => '輸入要測試的電話號碼';

  @override
  String get enterPhoneNumberMultiple => '請輸入電話號碼，多個號碼用逗號分隔';

  @override
  String get enterPhoneNumberToStartSearch => '輸入電話號碼以開始搜尋';

  @override
  String get enterPhoneNumberToVerify => '輸入要驗證的電話號碼';

  @override
  String get enterPluginName => '輸入插件名稱';

  @override
  String get enterPluginUrl => '輸入插件 URL 地址';

  @override
  String get enterRegexHint => '輸入正則表達式';

  @override
  String get enterRuleNameAndPattern => '請輸入規則名稱和模式';

  @override
  String get enterRuleNameAndPatternMessage => '請輸入規則名稱和正則表達式。';

  @override
  String get enterRuleNameHint => '輸入規則名稱';

  @override
  String get enterSearchContent => '請輸入搜尋內容';

  @override
  String get enterSubscriptionName => '輸入訂閱名稱';

  @override
  String get enterSubscriptionUrl => '輸入訂閱 URL';

  @override
  String get enterSyncFolderNameHint => '請輸入同步資料夾名稱 (預設: NotificationManager)';

  @override
  String get entertainment => '娛樂';

  @override
  String get enterValidNameAndUrl => '請輸入有效的名稱和 URL';

  @override
  String get enterValidUrl => '請輸入有效的 URL';

  @override
  String get enterVersion => '輸入版本';

  @override
  String get enterWebDAVPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get enterWebDAVServerAddressHint => '請輸入 WebDAV 伺服器地址';

  @override
  String get enterWebDAVUsernameHint => '請輸入 WebDAV 用戶名';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '刪除設備時出錯: $error';
  }

  @override
  String get errorLoadingPlugin => '載入外掛程式時出錯';

  @override
  String errorOccurredMessage(Object error) {
    return '發生錯誤: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '重命名設備時出錯: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '同步設備時出錯: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '同步設備時出錯: $error';
  }

  @override
  String get errorText => '錯誤';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '取消註冊設備時出錯: $error';
  }

  @override
  String get exampleBlock400Prefix => '例如：攔截 400 字頭號碼';

  @override
  String get exampleBlockMarketingSms => '例如：攔截促銷短信';

  @override
  String get exampleContentRegex => '例如：.*offer.*';

  @override
  String get exampleContentRegexHint => '內容正則表達式範例';

  @override
  String get exampleCouponPromotionDiscount =>
      '例如：.*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => '例如：家人、朋友等';

  @override
  String get examplePhoneNumber => '例如：10086、12345 等';

  @override
  String get exampleRegex400Prefix => '400 字頭正則表達式範例';

  @override
  String get exampleRegexFormat => '範例：^10086\$ 格式';

  @override
  String get exampleSenderRegexHint => '範例';

  @override
  String get exchange => '兌換';

  @override
  String get exchangeNow => '立即兌換';

  @override
  String get exchangeVip => '兌換 VIP';

  @override
  String get expandLabelSelector => '展開標籤選擇器';

  @override
  String expiryTime(Object time) {
    return '到期時間: $time';
  }

  @override
  String get export => '匯出';

  @override
  String get exportAllApplicationSettings => '匯出所有應用程式設定';

  @override
  String get exportAllApplicationSettingsSubtitle => '匯出所有應用程式設定';

  @override
  String get exportAllRuleConfigurations => '匯出所有規則配置';

  @override
  String get exportAllRuleConfigurationsSubtitle => '匯出所有規則配置';

  @override
  String get exportComplete => '匯出完成';

  @override
  String get exportConfig => '匯出配置';

  @override
  String get exportContacts => '匯出聯絡人';

  @override
  String get exportData => '匯出資料';

  @override
  String get exportError => '匯出錯誤';

  @override
  String get exportFailed => '匯出失敗';

  @override
  String get exportFailure => '匯出配置失敗';

  @override
  String get exportFeatureComingSoon => '匯出功能即將推出';

  @override
  String get exporting => '匯出中...';

  @override
  String get exportLabels => '匯出標籤';

  @override
  String exportLabelsFailed(Object error) {
    return '匯出標籤失敗：$error';
  }

  @override
  String get exportPluginList => '匯出插件列表';

  @override
  String exportPluginListFailed(Object error) {
    return '匯出插件列表失敗：$error';
  }

  @override
  String get exportRules => '匯出規則';

  @override
  String get exportRulesDialogTitle => '匯出規則';

  @override
  String get exportRulesTitle => '匯出規則';

  @override
  String get exportSmsRules => '匯出 SMS 規則';

  @override
  String get exportStatisticsData => '匯出統計數據';

  @override
  String get exportSuccess => '匯出成功';

  @override
  String get exportSuccesslly => '配置匯出成功';

  @override
  String get failedToAddContact => '新增聯絡人失敗';

  @override
  String failedToAddRule(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return '新增 SMS 規則失敗：$error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return '新增 SMS 訂閱失敗：$error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '備份設定失敗：$error';
  }

  @override
  String get failedToDecryptBackupFile => '解密備份檔案失敗';

  @override
  String get failedToDeleteDevice => '刪除裝置失敗';

  @override
  String failedToDeleteSmsRule(Object error) {
    return '刪除 SMS 規則失敗：$error';
  }

  @override
  String failedToExportRules(Object error) {
    return '匯出規則失敗：$error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return '匯出 SMS 規則失敗：$error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '獲取來電顯示資訊失敗：$error';
  }

  @override
  String failedToImportRules(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return '匯入 SMS 規則失敗：$error';
  }

  @override
  String get failedToLoadContacts => '載入聯絡人失敗';

  @override
  String get failedToLoadPlugin => '載入插件失敗';

  @override
  String get failedToRenameDevice => '重新命名裝置失敗';

  @override
  String get failedToRestoreSettings => '還原設定失敗';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '還原設定失敗：$error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '設定密碼失敗：$error';
  }

  @override
  String get failedToSyncDevices => '同步裝置失敗';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '切換規則狀態失敗：$error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '切換訂閱狀態失敗';

  @override
  String get failedToUpdateContact => '更新聯絡人失敗';

  @override
  String failedToUpdateSmsRule(Object error) {
    return '更新 SMS 規則失敗：$error';
  }

  @override
  String get failure => '失敗';

  @override
  String get favoriteContacts => '我的最愛聯絡人';

  @override
  String get featureAddRules => '• 新增特定電話號碼規則';

  @override
  String get featureCenter => '功能中心';

  @override
  String get featureEnableDisable => '• 啟用/停用每個 SIM 卡的不同過濾器';

  @override
  String get featureListTitle => '功能：';

  @override
  String get featureManageRules => '• 管理每個 SIM 卡的規則列表';

  @override
  String get features => '功能';

  @override
  String get fetchingCallerIdInfo => '正在獲取來電顯示資訊...';

  @override
  String fileSavedTo(Object path) {
    return '檔案已儲存至：$path';
  }

  @override
  String get filter => '過濾器';

  @override
  String get filterByLabel => '按標籤過濾';

  @override
  String get filterClear => '清除過濾器';

  @override
  String get filterControlPanelTitle => '過濾器控制面板';

  @override
  String get filterControlSubtitle => '管理所有過濾器的開啟/關閉狀態';

  @override
  String get filterControlTitle => '篩選控制';

  @override
  String get filterDeleteFailed => '篩選刪除失敗';

  @override
  String get filterDeleteSuccess => '篩選刪除成功';

  @override
  String get filterDetails => '篩選詳細資料';

  @override
  String get filtered => '已篩選';

  @override
  String get filteredSms => '已篩選 SMS';

  @override
  String get filteredSmsLabel => '已篩選 SMS';

  @override
  String get filterExplanation => '篩選說明';

  @override
  String get filterManagement => '篩選管理';

  @override
  String get filterName => '篩選名稱';

  @override
  String get filterPattern => '篩選模式';

  @override
  String get filterPriorityNote => '注意：篩選器之間存在優先關係，詳情請參閱幫助文檔';

  @override
  String get filterSaveFailed => '篩選儲存失敗';

  @override
  String get filterSaveSuccess => '篩選儲存成功';

  @override
  String get filterSettings => '篩選設定';

  @override
  String get filterSettingsTitle => '篩選設定';

  @override
  String get filterSMS => '篩選 SMS';

  @override
  String get filterToggleInstructions => '啟用或停用此 SIM 卡槽的篩選器：';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status 篩選器：$filterName';
  }

  @override
  String get filterType => '篩選類型';

  @override
  String get financial => '財務';

  @override
  String get flexibleCombinationFeature => '• 靈活組合：啟用/停用每個 SIM 卡槽的篩選器';

  @override
  String get fontSizesSetting => '字體大小';

  @override
  String foundRules(Object count) {
    return '找到 $count 條規則';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '找到 $count 條規則。您想導入它們嗎？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '找到 $count 條規則。您想導入它們嗎？';
  }

  @override
  String get fraudAlert => '詐騙警報 - 掛斷電話';

  @override
  String get fraudScamLikely => '詐騙可能';

  @override
  String get free => '免費';

  @override
  String get functionSettingsTitle => '功能設定';

  @override
  String generalUpdateFailure(Object error) {
    return '更新失敗：$error';
  }

  @override
  String get getFree => '取得免費';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '配置所有 SIM 卡的全局篩選器：';

  @override
  String get globalFilterFeature => '• 全局篩選器：所有來電的基本規則';

  @override
  String get globalFilterSettings => '全局篩選設定';

  @override
  String get globalFilterToggleInstructions => '配置應用於所有 SIM 卡槽的全局篩選設定：';

  @override
  String get globalSearchSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get globalSearchTitle => '全局搜尋';

  @override
  String get globalSettings => '全局設定';

  @override
  String get googleAdDisplayPosition => 'Google 廣告顯示位置';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob 廣告可以在此處整合';

  @override
  String get googleDriveAuthDescription =>
      '使用系統配置的 Google Drive 客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveAuthorizationHint =>
      '使用系統配置的 Google Drive 客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveConfigTitle => 'Google Drive 配置';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive 配置';

  @override
  String get government => '政府';

  @override
  String get granted => '已授權';

  @override
  String get grantNecessaryPermissions => '授予必要的權限';

  @override
  String get grantPermissions => '授予權限';

  @override
  String get headhunter => '獵頭';

  @override
  String get height => '身高';

  @override
  String get homePageTitle => '主頁';

  @override
  String get homeTab => '首頁';

  @override
  String get howItWorksPoint1 => '• 系統將自動允許在設定的時間範圍內來自同一號碼的呼叫';

  @override
  String get howItWorksPoint2 => '• 較短的時間範圍會導致更嚴格的攔截；較長的時間範圍會導致較寬鬆的攔截';

  @override
  String get howItWorksPoint3 => '• 系統檢查通話記錄以確定是否為重複呼叫';

  @override
  String get howItWorksTitle => '運作方式：';

  @override
  String get iconCodeOptional => '圖示代碼（可選）';

  @override
  String get iconSize => '圖示大小';

  @override
  String get import => '導入';

  @override
  String get important => '重要';

  @override
  String get importButton => '導入';

  @override
  String get importConfig => '導入配置';

  @override
  String get importContacts => '導入聯絡人';

  @override
  String get importExportContacts => '導入/導出聯絡人';

  @override
  String get importExportContactsTooltip => '導入/導出聯絡人';

  @override
  String get importExportRules => '導入/導出規則';

  @override
  String importFailed(Object error) {
    return '導入失敗：$error';
  }

  @override
  String get importFailure => '導入配置失敗';

  @override
  String get importFeatureComingSoon => '導入功能即將推出';

  @override
  String get importLabels => '導入標籤';

  @override
  String importLabelsFailed(Object error) {
    return '導入標籤失敗：$error';
  }

  @override
  String get importPluginList => '導入插件列表';

  @override
  String importPluginListFailed(Object error) {
    return '導入插件列表失敗：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '成功導入 $count 個插件';
  }

  @override
  String get importRuleConfigurationsFromFile => '從檔案導入規則配置';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '從檔案導入規則配置';

  @override
  String get importRules => '導入規則';

  @override
  String get importRulesButton => '導入規則';

  @override
  String get importRulesDialogTitle => '導入規則';

  @override
  String importRulesError(Object error) {
    return '導入規則失敗：$error';
  }

  @override
  String get importRulesInstructions => '從 CSV 檔案導入規則';

  @override
  String get importRulesSuccess => '規則導入成功';

  @override
  String get importRulesTitle => '導入規則';

  @override
  String get importSuccess => '導入成功';

  @override
  String get incomingCallInterceptAction => '來電攔截操作';

  @override
  String get incomingCallNotification => '來電通知';

  @override
  String get incorrectPassword => '密碼錯誤';

  @override
  String get initializing => '正在初始化';

  @override
  String get installed => '已安裝';

  @override
  String get insufficientMarks => '分數不足';

  @override
  String get insurance => '保險';

  @override
  String get interceptAction => '攔截操作';

  @override
  String get interceptionActionSettingsSubtitle => '設定如何處理被封鎖的呼叫';

  @override
  String get interceptionActionSettingsTitle => '攔截操作設定';

  @override
  String get interceptionTimeInterval => '攔截時間間隔';

  @override
  String get internet => '網路';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 更新間隔設定為 $days 天';
  }

  @override
  String get invalidContentRegex => '無效的內容正則表達式';

  @override
  String get invalidLabel => '無效標籤';

  @override
  String get invalidRegexPattern => '無效的 Regex 模式';

  @override
  String get invalidSenderRegex => '無效的發送者 Regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '加入 Telegram 頻道和群組以獲取更多資訊';

  @override
  String get jsLogsTitle => 'JS 日誌';

  @override
  String get jsonFormat => 'JSON 格式';

  @override
  String get keepAllVersions => '保留所有版本';

  @override
  String get keepAllVersionsDescription => '保留每個備份的所有歷史版本';

  @override
  String get keepAllVersionsLabel => '保留所有版本';

  @override
  String get keepAllVersionsSubtitle => '保留每個備份的歷史版本';

  @override
  String get keepAllVersionsTitle => '保留所有版本';

  @override
  String get label => '標籤';

  @override
  String labelAddedSuccessfully(Object name) {
    return '成功新增標籤 \"$name\"';
  }

  @override
  String get labelCategories => '標籤分類';

  @override
  String get labelDeleted => '標籤已刪除';

  @override
  String get labelDescription => '標籤可幫助您更好地管理聯絡人，為電話號碼新增自訂標籤，以便輕鬆識別來電和訊息。';

  @override
  String get labelFilter => '標籤篩選器';

  @override
  String get labelFilterTooltip => '標籤篩選器';

  @override
  String get labelIconColor => '標籤圖示顏色';

  @override
  String get labelManagement => '標籤管理';

  @override
  String get labelNotFound => '找不到標籤';

  @override
  String get labelRemoved => '標籤已移除';

  @override
  String labelRemoveFailed(Object error) {
    return '移除標籤失敗：$error';
  }

  @override
  String get labels => '標籤';

  @override
  String get labelsColor => '標籤顏色';

  @override
  String labelsDeleted(Object count) {
    return '已刪除 $count 個標籤';
  }

  @override
  String get labelsExportedSuccessfully => '標籤匯出成功';

  @override
  String get labelsFontSize => '標籤字體大小';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '成功匯入 $count 個標籤';
  }

  @override
  String get labelsPosition => '標籤位置';

  @override
  String labelTag(Object labelId) {
    return '標籤：$labelId';
  }

  @override
  String get labelUpdated => '標籤已更新';

  @override
  String labelUpdateFailed(Object error) {
    return '更新標籤失敗：$error';
  }

  @override
  String get labelUpdateSuccess => '標籤 \"\$labelText\" 更新成功';

  @override
  String get languageSettings => '語言設定';

  @override
  String get languageSettingsSubtitle => '更改應用程式顯示語言';

  @override
  String get languageSettingsTitle => '語言設定';

  @override
  String get last30Days => '過去 30 天';

  @override
  String get last7Days => '過去 7 天';

  @override
  String get lastSyncLabel => '上次同步';

  @override
  String lastUpdated(Object date) {
    return '上次更新：$date';
  }

  @override
  String get lifetimeMembership => '終身會員';

  @override
  String get lifetimeMembershipDescription => '一次性購買，永久解鎖所有高級功能和未來更新';

  @override
  String loadContactsFailed(Object error) {
    return '載入聯絡人失敗：$error';
  }

  @override
  String get loadDataFailed => '載入資料失敗';

  @override
  String get loadFailed => '載入失敗';

  @override
  String get loading => '載入中...';

  @override
  String get loadingData => '載入資料中...';

  @override
  String get loadingTags => '載入標籤中...';

  @override
  String loadLabelFailed(Object error) {
    return '載入標籤失敗：$error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '載入標籤失敗：$error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '載入已標記電話號碼數量失敗：$error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '載入已標記電話失敗：$error';
  }

  @override
  String get loadMore => '載入更多';

  @override
  String get loadPluginButton => '載入插件';

  @override
  String loadPluginsFailed(Object error) {
    return '載入插件失敗：$error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '載入設定失敗：$error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return '載入 SMS 規則失敗：$error';
  }

  @override
  String get loadStatusFailedMessage => '載入狀態失敗';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String get loan => '貸款';

  @override
  String get localBackupTitle => '本地備份';

  @override
  String get localCounterFilter => '本地計數器過濾';

  @override
  String get localCounterFilterSubtitle => '根據通話頻率自動過濾垃圾電話';

  @override
  String get localCountFilter => '本地計數過濾';

  @override
  String get localCountFilterDescription => '根據本地號碼計數攔截頻繁通話';

  @override
  String get localCountFilterExplanationContent =>
      '本地計數過濾器分析通話記錄，以自動識別和阻止頻繁的垃圾電話。';

  @override
  String get localCountFilterExplanationTitle => '本地計數過濾器說明';

  @override
  String get localCountFilterHowItWorksPoint1 => '• 確定是否基於號碼的計數值進行阻止';

  @override
  String get localCountFilterHowItWorksPoint2 => '• 當號碼的計數超過設定的閾值時，您可以選擇自動阻止它';

  @override
  String get localCountFilterHowItWorksPoint3 => '• 您可以選擇性地允許不超過閾值的號碼';

  @override
  String get localCountFilterHowItWorksPoint4 => '• 您可以選擇是否記錄所有查詢日誌';

  @override
  String get localCountFiltering => '本地計數過濾';

  @override
  String get localCountFilteringExplanation => '• 本地計數過濾：基於本地標記計數的過濾規則';

  @override
  String get localCountFilterSettings => '本地計數過濾器設定';

  @override
  String get localCountFilterUseCases => '此過濾器特別適合於識別自動撥號的垃圾電話和營銷電話。';

  @override
  String get localFilterSettings => '本地過濾器設定';

  @override
  String get localNotificationDisabled => '本地通知已停用';

  @override
  String get localNotificationEnabled => '本地通知已啟用';

  @override
  String get localServices => '本地服務';

  @override
  String get locationColor => '位置顏色';

  @override
  String get locationFontSize => '位置字體大小';

  @override
  String get locationIconColor => '位置圖示顏色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => '記錄所有本地查詢';

  @override
  String get logAllLocalQueriesDescription => '記錄所有本地號碼查詢的日誌';

  @override
  String get logAllRemoteQueries => '記錄所有遠程查詢';

  @override
  String get logAllRemoteQueriesDescription => '記錄所有遠程號碼查詢操作';

  @override
  String get manage => '管理聯絡人';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => '管理我的最愛聯絡人';

  @override
  String get manageFilterRules => '管理過濾規則';

  @override
  String get manageFilterRulesDescription => '新增、編輯或刪除 SMS 過濾規則';

  @override
  String get manageFrequentContacts => '管理常用聯絡人';

  @override
  String get markCounts => '標記計數';

  @override
  String get markCount => '標記計數';

  @override
  String markedByCount(Object count) {
    return '被 $count 標記';
  }

  @override
  String get markedPhonesList => '已標記電話號碼';

  @override
  String get markExchange => '標記交換';

  @override
  String get markPhone => '標記電話號碼';

  @override
  String markPhoneFailed(Object error) {
    return '標記電話號碼失敗：$error';
  }

  @override
  String get markPhoneManagementSubtitle => '標記電話號碼';

  @override
  String get markPhoneManagementTitle => '標記電話管理';

  @override
  String get markPhoneSuccess => '電話號碼標記成功';

  @override
  String get matchFailed => '匹配失敗！';

  @override
  String get matchFailedMessage => '匹配失敗。';

  @override
  String get matchNumbersWithSpecialCharacters => '匹配特定號碼格式';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '匹配帶特殊字符的號碼：';

  @override
  String get matchSpecificDigitPatterns => '匹配 XXX-XXXX-XXXX 格式';

  @override
  String get matchSpecificDigitPatternsTitle => '匹配特定數字模式：';

  @override
  String get matchSuccessful => '匹配成功！';

  @override
  String get matchSuccessfulMessage => '匹配成功！';

  @override
  String get medical => '醫療';

  @override
  String get membershipPrivileges => '會員權益';

  @override
  String get migrationTool => '遷移工具';

  @override
  String get migrationToolTitle => '遷移工具';

  @override
  String get minutes => '分鐘';

  @override
  String get month => '月';

  @override
  String get monthly => '每月';

  @override
  String get monthlyCallCount => '每月通話次數';

  @override
  String get monthlyChartTitle => '每月攔截通話';

  @override
  String get monthlyMembership => '每月會員';

  @override
  String get monthlyMembershipDescription => '解鎖所有高級功能，每月自動續訂';

  @override
  String get monthlyTotal => '每月總計';

  @override
  String get monthlyTotalLabel => '每月總計';

  @override
  String get moreOptions => '更多選項';

  @override
  String get mute => '靜音';

  @override
  String get name => '名稱';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '名稱和電話號碼不能為空';

  @override
  String get nameAndPhoneNumberRequired => '名稱和電話號碼不能為空';

  @override
  String get nameColor => '名稱顏色';

  @override
  String get nameFontSize => '名稱字體大小';

  @override
  String nameLabel(Object name) {
    return '名稱：$name';
  }

  @override
  String get namePosition => '名稱位置';

  @override
  String get nameUnknown => '名稱：未知';

  @override
  String nameWithValue(String name) {
    return '名稱：$name';
  }

  @override
  String get newPasswordLabel => '新密碼';

  @override
  String get nextStep => '下一步';

  @override
  String get noAction => '無操作';

  @override
  String get noActionRules => '無操作規則';

  @override
  String get noActiveCloudSyncServiceMessage => '沒有啟用的雲同步服務';

  @override
  String get noCallLogs => '沒有通話記錄';

  @override
  String get noCallRecords => '沒有通話紀錄';

  @override
  String get noContacts => '還沒有聯絡人';

  @override
  String get noContactsYet => '還沒有聯絡人';

  @override
  String get noData => '沒有數據';

  @override
  String get noDevicesRegisteredMessage => '沒有註冊的設備';

  @override
  String get noDevicesRegisteredYet => '還沒有註冊的設備。';

  @override
  String get noFilters => '還沒有篩選器';

  @override
  String get noLabels => '還沒有標籤';

  @override
  String get noMarkedPhones => '沒有已標記的電話號碼';

  @override
  String get noMatchingContacts => '沒有匹配的聯絡人';

  @override
  String get noMatchingContactsFound => '找不到匹配的聯絡人';

  @override
  String get noMatchingNumbersFound => '找不到匹配的號碼';

  @override
  String get noMatchingRecords => '沒有匹配的通話記錄';

  @override
  String noMatchingRules(Object ruleType) {
    return '沒有匹配的 $ruleType';
  }

  @override
  String get none => '無';

  @override
  String get noneServiceType => '無';

  @override
  String get noPlugins => '暫時沒有插件';

  @override
  String get noRecords => '沒有通話記錄';

  @override
  String get noResultReturned => '沒有返回結果';

  @override
  String get noResultReturnedLog => '插件沒有返回結果';

  @override
  String noRules(Object ruleType) {
    return '暫時沒有 $ruleType';
  }

  @override
  String get noRulesPrompt => '沒有找到規則，請新增規則';

  @override
  String get noRulesToExport => '沒有要匯出的規則';

  @override
  String get noSmsFilterRulesYet => '暫時沒有簡訊過濾規則';

  @override
  String get noSmsRulesYet => '暫時沒有簡訊規則';

  @override
  String get noSubscriptions => '沒有訂閱';

  @override
  String get noSubscriptionsYet => '暫時沒有訂閱';

  @override
  String get notGranted => '未授權';

  @override
  String get notificationMode => '通知模式';

  @override
  String get notificationModeDescription => '在通知欄中顯示來電者資訊';

  @override
  String get notificationPermission => '通知權限';

  @override
  String get notificationPermissionDescription => '用於顯示來電和訊息通知。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知設定';

  @override
  String get notificationSettingsSaved => '通知設定已成功儲存';

  @override
  String get notSet => '未設定';

  @override
  String get notVerifiedText => '未驗證';

  @override
  String get noValidSmsRulesFoundInFile => '在檔案中找不到有效的簡訊規則';

  @override
  String get number => '號碼';

  @override
  String get numberColor => '號碼顏色';

  @override
  String get numberFontSize => '號碼字體大小';

  @override
  String get numberPosition => '號碼位置';

  @override
  String get numberSearch => '號碼搜尋';

  @override
  String get numberTypeColor => '號碼類型顏色';

  @override
  String get numberTypeFontSize => '號碼類型字體大小';

  @override
  String get numberTypePosition => '號碼類型位置';

  @override
  String get ok => '確定';

  @override
  String get okButton => '確定';

  @override
  String get onboardingCompleteDescription => '您的通話安全管理員已準備就緒，開始享受安全的通話體驗！';

  @override
  String get onboardingLanguageDescription => '選擇您偏好的語言以獲得最佳體驗。';

  @override
  String get onboardingPermissionsDescription => '為了提供完整的服務，我們需要以下權限：';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '一鍵封鎖垃圾電話和訊息，自訂封鎖規則，為您提供一個安靜的環境。';

  @override
  String get onboardingSmartCallerIdDescription => '自動識別未知來電，標記可疑號碼，保護您的通話安全。';

  @override
  String get onboardingWelcomeDescription => '您的通話管理專家，提供全面的來電識別和封鎖服務。';

  @override
  String get oneDriveAuthDescription => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveAuthorizationHint => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveConfigTitle => 'OneDrive 配置';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 配置';

  @override
  String get onlineCallerIdSubscription => '線上來電顯示訂閱';

  @override
  String get openAppSettings => '開啟應用程式設定';

  @override
  String openAppSettingsFailed(Object error) {
    return '無法開啟應用程式設定：$error';
  }

  @override
  String operationFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String get operationFailure => '操作失敗';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get other => '其他';

  @override
  String get ourOtherApps => '我們的其他應用程式';

  @override
  String get overlayMode => '浮動視窗';

  @override
  String get overlayModeDescription => '在浮動視窗中顯示來電者資訊';

  @override
  String get overlayPermission => '覆蓋層權限';

  @override
  String get overlayPermissionDescription => '用於顯示來電覆蓋層。';

  @override
  String get overview => '概覽';

  @override
  String get password => '密碼';

  @override
  String get passwordCannotBeEmpty => '密碼不能為空';

  @override
  String get passwordLabel => '密碼';

  @override
  String get passwordsDoNotMatch => '密碼不匹配';

  @override
  String get passwordSetSuccessfully => '密碼設定成功';

  @override
  String get pattern => '模式';

  @override
  String get pendingSync => '等待同步';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '週';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '權限請求被拒絕';

  @override
  String get permissionGranted => '權限已授予';

  @override
  String get permissionManagement => '權限管理';

  @override
  String get phoneCallsTab => '電話';

  @override
  String get phoneNumber => '電話號碼';

  @override
  String get phoneNumberCannotBeEmpty => '電話號碼不能為空';

  @override
  String get phoneNumberHint => '輸入電話號碼';

  @override
  String get phoneNumberHintText => '輸入電話號碼以新增規則';

  @override
  String get phoneNumberLabel => '電話號碼';

  @override
  String get phoneNumberRegexRequired => '請輸入電話號碼和正則表達式';

  @override
  String get phoneNumberRequired => '電話號碼是必需的';

  @override
  String get phoneNumberTypeFixedLine => '固定電話';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定電話或行動電話';

  @override
  String get phoneNumberTypeMobile => '行動電話';

  @override
  String get phoneNumberTypePager => '傳呼機';

  @override
  String get phoneNumberTypePersonalNumber => '個人號碼';

  @override
  String get phoneNumberTypePremiumRate => '高價電話';

  @override
  String get phoneNumberTypeSharedCost => '分攤費用';

  @override
  String get phoneNumberTypeTollFree => '免費電話';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '未知';

  @override
  String get phoneNumberTypeVoicemail => '語音信箱';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '電話權限';

  @override
  String get phonePermissionDescription => '用於識別和阻止來電。';

  @override
  String get phoneRule => '電話規則';

  @override
  String get phoneRuleEditDialog => '電話規則編輯對話框';

  @override
  String get phoneRuleManagement => '電話規則管理';

  @override
  String get phoneRuleSubscription => '電話規則訂閱';

  @override
  String get phoneSubscription => '電話訂閱';

  @override
  String get phoneSubscriptionRulesDescription =>
      '通過 URL 訂閱電話規則列表，以自動更新白名單和黑名單規則。支持 JSON 格式的規則文件。';

  @override
  String get phoneSubscriptionTitle => '電話規則訂閱';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => '請選擇一個標籤並輸入有效的電話號碼';

  @override
  String pluginAddedSuccess(Object name) {
    return '插件 \"$name\" 添加成功';
  }

  @override
  String get pluginDeleted => '插件已刪除';

  @override
  String get pluginLatestVersion => '插件已是最新版本';

  @override
  String get pluginListExportSuccess => '插件列表導出成功';

  @override
  String get pluginLoadedSuccessfully => '插件加載成功';

  @override
  String get pluginManagement => '插件管理';

  @override
  String get pluginManagementSubtitle => '管理和配置第三方插件';

  @override
  String get pluginManagementTitle => '插件管理';

  @override
  String get pluginName => '插件名稱';

  @override
  String get pluginNotLoaded => '插件尚未加載。請先加載插件。';

  @override
  String pluginsDeleted(Object count) {
    return '$count 個插件已成功刪除。';
  }

  @override
  String get pluginService => '插件服務';

  @override
  String get pluginTestPageTitle => '插件測試';

  @override
  String get pluginUpdateSuccess => '插件更新成功';

  @override
  String get pluginUrl => '插件 URL';

  @override
  String get pluginUrlCannotBeEmpty => '插件 URL 不能為空';

  @override
  String get pluginUrlHint => '輸入插件 URL';

  @override
  String get pluginUrlLabel => '插件 URL';

  @override
  String get pluginVersion => '插件版本';

  @override
  String get political => '政治';

  @override
  String get powerfulSpamBlocking => '強大的垃圾郵件攔截功能';

  @override
  String get previousStep => '上一步';

  @override
  String get prioritizeRemoteAction => '優先處理遠程操作設定';

  @override
  String get prioritizeRemoteActionDescription => '優先處理來自遠程資料庫的操作設定';

  @override
  String get processing => '處理中...';

  @override
  String get processingOperation => '處理中...';

  @override
  String get purchase => '購買';

  @override
  String get quarterlyMembership => '季度會員';

  @override
  String get quarterlyMembershipDescription => '解鎖所有高級功能，每季自動續訂';

  @override
  String get queryButton => '查詢';

  @override
  String get queryFailed => '查詢失敗';

  @override
  String get queryFailedLog => '查詢失敗';

  @override
  String get querying => '查詢中...';

  @override
  String get queryingPhoneNumber => '查詢電話號碼';

  @override
  String get queryResultTitle => '查詢結果';

  @override
  String get ready => '準備就緒！';

  @override
  String get receiveWeeklyStatistics => '接收每週統計數據';

  @override
  String get recruiter => '招聘人員';

  @override
  String get reEnterPasswordHint => '請重新輸入密碼';

  @override
  String get refresh => '刷新';

  @override
  String get refreshPermissionStatus => '刷新權限狀態';

  @override
  String get refreshTooltip => '刷新';

  @override
  String regexError(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String get regexPattern => '正則表達式模式';

  @override
  String get regexPatternExplanation => '正則表達式模式說明';

  @override
  String get regexPatternExplanationButton => '正則表達式模式說明';

  @override
  String get regexPatternLabel => '正則表達式模式';

  @override
  String get regexPatternsExamples => '使用標準正則表達式語法來定義模式。例如：';

  @override
  String get regexPatternsForPhoneNumberMatching => '用於電話號碼匹配的正則表達式模式';

  @override
  String get regexRule => '正則表達式規則';

  @override
  String regexRuleAddFailed(Object error) {
    return '添加正則表達式規則失敗：$error';
  }

  @override
  String get regexRuleAddSuccess => '正則表達式規則添加成功';

  @override
  String get regexRuleManagement => '正則表達式規則管理';

  @override
  String get regexRuleNamePatternRequired => '規則名稱和正則表達式模式不能為空';

  @override
  String get regexRules => '正則表達式規則';

  @override
  String get regexTesterTitle => '正則表達式測試器';

  @override
  String regexValidationFailed(Object error) {
    return '正則表達式驗證失敗：$error';
  }

  @override
  String get regexValidationSuccess => '正則表達式驗證成功';

  @override
  String get region => '地區';

  @override
  String get registeredDevicesTitle => '已註冊設備';

  @override
  String get rejectAllCalls => '拒絕所有來電';

  @override
  String get rejectAllCallsDescription => '啟用後，所有來電將以最高優先級被拒絕';

  @override
  String get rejectAllNumbers => '拒絕所有號碼';

  @override
  String get rejectAllNumbersDesc => '啟用後，拒絕所有來電';

  @override
  String get rejectExceededNumbers => '拒絕超出次數的號碼';

  @override
  String get rejectExceededNumbersDescription => '自動拒絕超出次數閾值的號碼';

  @override
  String get remoteFilterSettings => '遠程過濾器設定';

  @override
  String get remoteFilterSettingsPageTitle => '遠程號碼過濾器設定';

  @override
  String get remoteNumberFilter => '遠程號碼過濾器';

  @override
  String get remoteNumberFilterDatabaseInfo => '此過濾器使用獨立的遠程數據庫來獲取最新的號碼信息。';

  @override
  String get remoteNumberFilterDescription => '基於遠程數據庫信息攔截騷擾電話';

  @override
  String get remoteNumberFilterExplanationContent =>
      '遠程號碼過濾器通過查詢基於號碼次數的遠程數據庫來識別和阻止垃圾電話。';

  @override
  String get remoteNumberFilterExplanationTitle => '遠程號碼過濾器說明';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• 次數閾值：根據號碼出現頻率確定';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• 過濾操作：配置如何處理超過閾值的號碼';

  @override
  String get remoteNumberFilterFeaturePriority => '• 優先級設定：設置遠程操作的優先級';

  @override
  String get remoteNumberFilterFeatures => '功能：';

  @override
  String get remoteNumberFiltering => '遠程號碼過濾';

  @override
  String get remoteNumberFilteringExplanation => '• 遠程號碼過濾：基於遠程數據庫信息的過濾規則';

  @override
  String get remoteNumberFilterSubtitle => '使用雲數據庫和社區報告識別垃圾電話';

  @override
  String get removeAdsDescription => '永久移除應用程式中的所有廣告，以獲得更流暢的體驗';

  @override
  String get removeAdsTitle => '移除廣告';

  @override
  String get removedFromFavoriteContacts => '已從收藏聯絡人中移除';

  @override
  String get removedFromFavorites => '已從收藏聯絡人中移除';

  @override
  String get removeFavorite => '移除收藏';

  @override
  String get removeFromFavorites => '從收藏中移除';

  @override
  String get renameButton => '重新命名';

  @override
  String get renameDeviceDialogTitle => '重新命名設備';

  @override
  String get renameDeviceTitle => '重新命名設備';

  @override
  String get replaceCurrentSettingsConfirmation => '這將替換您目前的所有設定。您確定要繼續嗎？';

  @override
  String get requestAllPermissions => '請求所有權限';

  @override
  String get requestPermission => '請求權限';

  @override
  String requestPermissionFailed(Object error) {
    return '請求權限失敗：$error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 個標記';
  }

  @override
  String get reset => '重設';

  @override
  String get restore => '還原';

  @override
  String get restoreApplicationSettingsFromBackup => '從備份還原應用程式設定';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '從備份還原應用程式設定';

  @override
  String get restoreButton => '還原';

  @override
  String restoreFailedWithError(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloud => '從雲端還原';

  @override
  String get restoreFromCloudDescription => '從雲端儲存空間還原設定和規則';

  @override
  String restoreFromCloudFailed(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloudLabel => '從雲端還原';

  @override
  String get restoreFromCloudSuccess => '已成功從雲端還原';

  @override
  String get restoreFromCloudTitle => '從雲端還原';

  @override
  String get restoreFromLocal => '從本地還原';

  @override
  String get restorePurchases => '還原購買項目';

  @override
  String get restoreSectionTitle => '還原';

  @override
  String get restoreSettings => '還原設定';

  @override
  String get restoreSettingsConfirmation => '這將取代您目前的所有設定。您確定要繼續嗎？';

  @override
  String get restoreSettingsDialogTitle => '還原設定';

  @override
  String get restoreSettingsTitle => '還原設定';

  @override
  String get restoreSuccessFromLocal => '已成功從本地還原';

  @override
  String get restoreSuccessMessage => '已成功從雲端還原';

  @override
  String get retry => '重試';

  @override
  String get ridesharing => '共享乘車';

  @override
  String get risk => '風險';

  @override
  String get robocall => '自動電話';

  @override
  String get ruleAction => '規則動作';

  @override
  String get ruleAddButton => '新增規則';

  @override
  String get ruleAddedSuccess => '規則已成功新增';

  @override
  String ruleAddFailure(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String get ruleAddSuccess => '規則已成功新增';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '您確定要刪除此 $ruleType 嗎？';
  }

  @override
  String get ruleDeleteConfirmTitle => '刪除規則';

  @override
  String get ruleDeletedSuccess => '規則已成功刪除';

  @override
  String get ruleDeletedSuccessfully => '規則已成功刪除';

  @override
  String ruleDeleteFailed(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String get ruleDeleteSuccess => '規則已成功刪除';

  @override
  String get ruleDisabledSuccessfully => '規則已成功停用';

  @override
  String get ruleEnabledSuccessfully => '規則已成功啟用';

  @override
  String ruleLoadFailed(Object error) {
    return '載入規則失敗：$error';
  }

  @override
  String get ruleManagement => '規則管理';

  @override
  String get ruleManagementTitle => '規則管理';

  @override
  String get ruleName => '規則名稱';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => '規則名稱和內容正則表達式不能為空';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNameHint => '例如，家人、朋友等。';

  @override
  String get ruleNameLabel => '規則名稱';

  @override
  String get ruleNamePatternRequired => '請輸入規則名稱和模式';

  @override
  String get ruleNameRequired => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNotExist => '規則不存在或已被刪除';

  @override
  String ruleNotFound(Object error) {
    return '找不到規則：$error';
  }

  @override
  String get ruleSavedSuccessfully => '規則已成功儲存！';

  @override
  String get ruleSavedSuccessMessage => '規則已成功儲存！';

  @override
  String ruleSaveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get ruleSaveSuccess => '規則已成功儲存！';

  @override
  String get rulesExportedSuccessfully => '規則已成功匯出';

  @override
  String rulesExportedTo(Object path) {
    return '規則匯出到：$path';
  }

  @override
  String get rulesImported => '規則已成功匯入';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '已成功匯入 $count 條規則';
  }

  @override
  String rulesImportFailed(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String get ruleStatistics => '規則統計';

  @override
  String ruleStatusChanged(Object status) {
    return '規則已成功$status';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '規則已成功$status';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String get ruleUpdateSuccess => '規則已成功更新';

  @override
  String get ruleVerification => '規則驗證';

  @override
  String get save => '儲存';

  @override
  String get saveButton => '儲存';

  @override
  String get saveButtonLabel => '儲存';

  @override
  String get saveButtonText => '儲存';

  @override
  String saveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get saveFilter => '儲存篩選器';

  @override
  String get saveSettings => '儲存設定';

  @override
  String saveSettingsFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get scamsLikely => '可能係詐騙';

  @override
  String get search => '搜尋';

  @override
  String get searchContacts => '搜尋聯絡人';

  @override
  String searchError(Object error) {
    return '搜尋錯誤：$error';
  }

  @override
  String get searchFilters => '搜尋篩選器';

  @override
  String get searchForContacts => '搜尋聯絡人';

  @override
  String get searchHint => '搜尋...';

  @override
  String get searchSettingsSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get searchSettingsTitle => '搜尋設定';

  @override
  String get securityMessage => '唔好相信任何電話。務必獨立驗證客戶服務號碼。切勿分享密碼、驗證碼、卡號或個人資料。';

  @override
  String get selectActionToPerform => '選擇規則符合時要執行的操作';

  @override
  String get selectActionWhenBlockingCalls => '選擇封鎖來電時嘅操作';

  @override
  String get selectActionWhenRuleMatches => '選擇規則符合時嘅操作';

  @override
  String get selectAll => '全選';

  @override
  String get selectCountry => '選擇國家';

  @override
  String get selectDateRange => '選擇日期範圍';

  @override
  String get selectedDateRange => '已選日期範圍';

  @override
  String selectedItems(Object count) {
    return '已選 $count 個項目';
  }

  @override
  String get selectedLabel => '已選擇：';

  @override
  String get selectExportFormat => '選擇匯出格式';

  @override
  String get selectLabel => '選擇標籤';

  @override
  String get selectLabelAndEnterPhoneNumber => '請選擇標籤並輸入有效嘅電話號碼';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get selectMultiple => '選擇多個';

  @override
  String get selectPeriod => '選擇時段';

  @override
  String get selectSimCard => '選擇 SIM 卡';

  @override
  String get selectSimSlot => '選擇 SIM 卡槽';

  @override
  String get selectSpecificActionForBlockedCalls => '選擇封鎖來電時要執行的特定操作';

  @override
  String get selectTag => '選擇標籤';

  @override
  String get selectTags => '選擇標籤';

  @override
  String get selectTrustedDataSource => '請選擇信任的數據源';

  @override
  String get selectYourLanguage => '選擇您的語言';

  @override
  String get sender => '發件人';

  @override
  String get senderRegexOptional => '發件人正則表達式（可選）';

  @override
  String get serverAddressLabel => '伺服器地址';

  @override
  String get serviceTypeContact => '聯絡人訂閱';

  @override
  String get serviceTypeLabel => '服務類型';

  @override
  String get serviceTypePhone => '電話訂閱';

  @override
  String get serviceTypePlugin => '插件更新';

  @override
  String get serviceTypeSms => 'SMS 訂閱';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '設定';

  @override
  String get setEncryptionPassword => '設定加密密碼';

  @override
  String get setEncryptionPasswordDescription => '設定用於備份和還原的加密密碼';

  @override
  String get setEncryptionPasswordLabel => '設定加密密碼';

  @override
  String get setEncryptionPasswordTitle => '設定加密密碼';

  @override
  String get setPasswordButton => '設定';

  @override
  String get settings => '設定';

  @override
  String settingsBackedUpTo(Object path) {
    return '設定已備份到：$path';
  }

  @override
  String get settingsLoaded => '設定已載入';

  @override
  String settingsLoadFailed(Object error) {
    return '載入設定失敗：$error';
  }

  @override
  String get settingsRestoredSuccessfully => '設定已成功還原。請重新啟動應用程式以使變更生效。';

  @override
  String get settingsSaved => '設定已儲存';

  @override
  String settingsSaveFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get settingsTab => '設定';

  @override
  String get settingsTitle => '設定';

  @override
  String get setup => '設定';

  @override
  String get showContactEditDialogStaticMethod => '用於顯示聯絡人編輯對話框的靜態方法';

  @override
  String get showExplanation => '顯示說明';

  @override
  String get silence => '靜音';

  @override
  String get silenceAndNoAnswer => '靜音且不接聽';

  @override
  String get silenceNoAnswer => '靜音不接聽';

  @override
  String get silentCallVoiceClone => '靜音通話語音複製';

  @override
  String get silentRules => '靜音規則';

  @override
  String simCard(Object simNumber) {
    return 'SIM 卡 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 卡顏色';

  @override
  String get simCardConfigurationExplanation => '• SIM 卡配置：為每個 SIM 卡設置獨立的過濾規則';

  @override
  String get simCardFilterRules => 'SIM 卡過濾規則';

  @override
  String get simCardFilterRulesDescription => '根據 SIM 卡槽設置不同的過濾規則';

  @override
  String get simCardFontSize => 'SIM 卡字體大小';

  @override
  String get simCardPosition => 'SIM 卡位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return '載入 SIM 卡資訊失敗：$error';
  }

  @override
  String get simRuleInstructions => 'SIM 卡槽規則允許您為每個 SIM 卡槽配置獨立的過濾規則。';

  @override
  String get simRuleInstructionsTitle => 'SIM 卡槽規則';

  @override
  String get simRuleManagement => 'SIM 卡槽規則管理';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'SIM 卡數據加載失敗：$error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM 卡槽過濾配置';

  @override
  String get simSlotFilterConfigurationDescription => '允許按 SIM 卡槽設置過濾規則';

  @override
  String get simSlotFilterDescription => '為每張 SIM 卡配置獨立的過濾規則：';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber 過濾設定';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM 卡槽加載失敗：$error';
  }

  @override
  String get simSlotManagement => 'SIM 卡槽管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM 卡槽操作失敗：$error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM 卡槽位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM 卡槽規則：每個 SIM 卡獨立的過濾策略';

  @override
  String get simSlotRuleListTitle => 'SIM 卡槽規則列表';

  @override
  String get simSlotRuleManagement => 'SIM 卡槽規則';

  @override
  String get simSlotRuleManagementTitle => '規則管理';

  @override
  String get simSlotSettings => 'SIM 卡槽設定';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber';
  }

  @override
  String get skip => '跳過';

  @override
  String get smartCallerId => '智能來電顯示';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS 過濾可幫助您自動過濾垃圾訊息並保持您的訊息列表清潔。您可以設定過濾規則和通知方式。';

  @override
  String get smsFilterDisabled => 'SMS 過濾已停用';

  @override
  String get smsFilterEnabled => 'SMS 過濾已啟用';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMS 過濾規則已成功新增';

  @override
  String get smsFilterRules => 'SMS 過濾規則';

  @override
  String get smsFilterSettings => 'SMS 過濾設定';

  @override
  String get smsHistory => 'SMS 歷史記錄';

  @override
  String get smsManagement => 'SMS 管理';

  @override
  String get smsPermission => 'SMS 權限';

  @override
  String get smsPermissionDescription => '用於過濾垃圾訊息。';

  @override
  String get smsRuleAddedSuccessfully => 'SMS 規則已成功新增';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS 規則已成功刪除';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS 規則加載失敗：$error';
  }

  @override
  String get smsRuleManagement => 'SMS 規則管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS 規則已成功匯出到 $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS 規則已成功導入';

  @override
  String get smsRuleSubscription => 'SMS 規則訂閱';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS 規則已成功更新';

  @override
  String get smsSettingsSubtitle => 'SMS 過濾和關鍵字封鎖';

  @override
  String get smsSettingsTitle => 'SMS 設定';

  @override
  String get smsSubscription => 'SMS 訂閱';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS 訂閱已成功新增';

  @override
  String get smsSubscriptionRulesDescription =>
      '通過 URL 訂閱 SMS 規則列表，支持正則表達式匹配。您可以設定封鎖或允許操作。';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => '某些權限請求被拒絕';

  @override
  String get spamLikely => '可能是垃圾訊息';

  @override
  String get startColor => '開始顏色';

  @override
  String get startDate => '開始日期';

  @override
  String get startUsing => '開始使用';

  @override
  String get statAnswered => '已接聽';

  @override
  String get statBlocked => '已封鎖';

  @override
  String get staticMethodShowCallerIdDialog => '顯示來電顯示資訊對話框的靜態方法';

  @override
  String get staticMethodToDisplayCountrySelectionDialog => '顯示國家/地區選擇對話框的靜態方法';

  @override
  String get staticMethodToDisplayDialog => '顯示對話框的靜態方法';

  @override
  String get statistics => '統計';

  @override
  String get statisticsExportFeatureComingSoon => '統計資料匯出功能即將推出';

  @override
  String get statisticsGrid => '統計資料網格';

  @override
  String get statisticsPageTitle => '數據分析';

  @override
  String get stirColor => 'STIR 顏色';

  @override
  String get stirFontSize => 'STIR 字體大小';

  @override
  String get stirPosition => 'STIR 位置';

  @override
  String get storagePermission => '儲存權限';

  @override
  String get storagePermissionDescription => '用於保存設定和規則。';

  @override
  String get subscribe => '訂閱';

  @override
  String subscriptionAddSuccess(Object name) {
    return '已成功新增訂閱「$name」';
  }

  @override
  String get subscriptionDeleteConfirmContent => '確定要刪除此訂閱嗎？';

  @override
  String get subscriptionDeleteConfirmTitle => '刪除訂閱';

  @override
  String get subscriptionDeleted => '已刪除訂閱';

  @override
  String get subscriptionDeletedSuccessfully => '已成功刪除訂閱';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '刪除訂閱失敗：$error';
  }

  @override
  String get subscriptionDeleteSuccess => '已刪除訂閱';

  @override
  String get subscriptionEmptyState => '沒有可用的訂閱';

  @override
  String get subscriptionEmptyText => '尚無訂閱';

  @override
  String subscriptionLoadFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String get subscriptionManagementTitle => '訂閱管理';

  @override
  String get subscriptionName => '訂閱名稱';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '訂閱名稱和 URL 不能為空';

  @override
  String get subscriptionNameHint => '輸入訂閱名稱';

  @override
  String get subscriptionPageTitle => '訂閱管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '變更訂閱狀態失敗：$error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '切換訂閱狀態失敗：$error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '更新訂閱失敗：$error';
  }

  @override
  String get subscriptionUpdateSuccess => '已成功更新訂閱';

  @override
  String get subscriptionUrl => '訂閱網址';

  @override
  String get subscriptionUrlHint => '輸入訂閱網址';

  @override
  String successfullyImportedRules(Object count) {
    return '已成功匯入 $count 條規則';
  }

  @override
  String get supportSync => '支援同步';

  @override
  String get survey => '調查';

  @override
  String get syncDevicesButton => '同步裝置';

  @override
  String get syncFailed => '同步失敗';

  @override
  String get syncFailedMessage => '同步失敗';

  @override
  String get syncFolderNameHint => '請輸入同步資料夾名稱（預設：NotificationManager）';

  @override
  String get syncFolderNameLabel => '同步資料夾名稱';

  @override
  String get synchronized => '已同步';

  @override
  String get syncing => '正在同步...';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncStatusTitle => '同步狀態';

  @override
  String get syncStatusUpdatedMessage => '同步狀態已更新';

  @override
  String get syncSuccessful => '同步成功';

  @override
  String get syncSuccessMessage => '同步成功';

  @override
  String get syncWithCloudStorage => '與雲端儲存空間同步';

  @override
  String get syncWithCloudStorageSubtitle => '與雲端儲存空間同步';

  @override
  String get systemFeatures => '系統功能：';

  @override
  String get systemSettingsTitle => '系統設定';

  @override
  String get tabAll => '全部';

  @override
  String get tabAnswered => '已接聽';

  @override
  String get tabBlocked => '已封鎖';

  @override
  String get tabMissed => '未接聽';

  @override
  String get tabOutgoing => '已撥出';

  @override
  String tagLabel(String tag) {
    return '標籤：$tag';
  }

  @override
  String get tagsUpdated => '標籤已更新';

  @override
  String get takeaway => '外賣';

  @override
  String get telecommunication => '電訊';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => '電話推銷';

  @override
  String get testButton => '測試';

  @override
  String get testButtonLabel => '測試';

  @override
  String get testConnectionButton => '測試連線';

  @override
  String get textColorsSetting => '文字及標籤顏色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '此應用程式是一個強大的來電顯示工具，可讓您識別和封鎖不需要的來電。';

  @override
  String get thisWeek => '本週';

  @override
  String get timeInterceptor => '時間攔截器';

  @override
  String get timeInterceptorDescription => '根據通話頻率自動攔截/允許潛在通話';

  @override
  String get timeInterceptorExplanation => '• 時間攔截器：在短時間內攔截/允許重複通話';

  @override
  String get timeInterceptorExplanationContent =>
      '通話頻率攔截功能會分析通話頻率，以自動識別和攔截/允許頻繁的垃圾電話。';

  @override
  String get timeInterceptorExplanationTitle => '通話頻率攔截說明';

  @override
  String get timeInterceptorSettingsTitle => '通話頻率攔截設定';

  @override
  String get timeInterceptorSubtitle => '根據通話頻率自動攔截潛在的垃圾電話';

  @override
  String get timeInterceptorTitle => '啟用通話頻率攔截';

  @override
  String get timeWindowDescription => '設定允許重複通話的時間窗口大小。來自同一號碼在此窗口內的通話將被允許';

  @override
  String timeWindowLabel(int minutes) {
    return '攔截時間窗口（分鐘）：$minutes';
  }

  @override
  String get timeWindowSetting => '設定允許重複通話的時間窗口大小。來自同一號碼在此窗口內的通話將被允許';

  @override
  String get today => '今天';

  @override
  String get total => '總計';

  @override
  String get totalBlocked => '總封鎖';

  @override
  String get totalFiltered => '總過濾';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '在裝置或平台之間傳輸數據';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => '在裝置或平台之間傳輸數據';

  @override
  String get travelTicketing => '旅遊票務';

  @override
  String get trend => '趨勢';

  @override
  String get trendChart => '趨勢圖';

  @override
  String get tutorial => '教學';

  @override
  String get type => '類型';

  @override
  String get unassignedSIMCard => '未分配的 SIM 卡';

  @override
  String get unknown => '未知';

  @override
  String get unknownLabel => '不明標籤';

  @override
  String get unknownTag => '標籤：不明';

  @override
  String get unregisterButton => '取消註冊';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '你確定要取消註冊 $deviceName 嗎？';
  }

  @override
  String get unregisterDeviceTitle => '取消註冊裝置';

  @override
  String get unsupportedFileFormat => '不支援的檔案格式';

  @override
  String get update => '更新';

  @override
  String get updateAllNow => '立即全部更新';

  @override
  String get updateCallFilterConfig => '更新來電過濾配置';

  @override
  String updateContactFailed(Object error) {
    return '更新聯絡人失敗：$error';
  }

  @override
  String get updateFavoriteStatus => '更新喜好狀態';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '更新喜好狀態失敗：$error';
  }

  @override
  String get updateInterval => '更新間隔';

  @override
  String get updateLabelFailed => '更新標籤失敗';

  @override
  String get updateNow => '立即更新';

  @override
  String get updatePlugin => '更新插件';

  @override
  String updatePluginFailed(Object error) {
    return '更新插件失敗：$error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '更新訂閱失敗：$error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service 成功更新（$count 條規則）';
  }

  @override
  String get updateTags => '更新標籤';

  @override
  String get useCasesPoint1 => '• 識別自動重撥垃圾電話';

  @override
  String get useCasesPoint2 => '• 攔截在短時間內多次撥打的行銷電話';

  @override
  String get useCasesPoint3 => '• 預防電話轟炸和騷擾';

  @override
  String get useCasesTitle => '使用案例：';

  @override
  String get useGlobalSettings => '使用全域設定';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '使用者名稱';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '使用標準正則表達式語法來定義模式。例子：';

  @override
  String get validateRegex => '驗證正則表達式';

  @override
  String get verificationFailedText => '驗證失敗';

  @override
  String get verifiedText => '已驗證';

  @override
  String get verify => '驗證';

  @override
  String version(Object version) {
    return '版本：$version';
  }

  @override
  String get vipExchangeDescription => '用電話號碼標記次數兌換 VIP 會員資格';

  @override
  String get vipExchangeTitle => '標記兌換 VIP';

  @override
  String get watchAd => '觀看廣告';

  @override
  String get watchAdForTemp => '觀看廣告以獲得臨時權限';

  @override
  String get watchAdForTempDescription => '觀看短片廣告以暫時解鎖一些高級功能';

  @override
  String get webDAVConfigTitle => 'WebDAV 配置';

  @override
  String get webdavConfigurationTitle => 'WebDAV 配置';

  @override
  String get webdavPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get webdavServerAddressHint => '請輸入 WebDAV 伺服器地址';

  @override
  String get webdavUsernameHint => '請輸入 WebDAV 使用者名稱';

  @override
  String get week => '週';

  @override
  String get weekly => '每週';

  @override
  String get weeklyBlockedCallsSummary => '每週攔截電話摘要';

  @override
  String get weeklyChartTitle => '每週攔截電話';

  @override
  String get weeklyReport => '每週報告';

  @override
  String get weeklyReportDesc => '接收每週來電攔截活動摘要報告';

  @override
  String get welcome => '歡迎';

  @override
  String get whitelist => '白名單';

  @override
  String get whitelistLabel => '白名單';

  @override
  String get width => '寬度';

  @override
  String get wildcardMatchingDescription =>
      '使用 \'.\' 匹配任何字符 (例如 \'123.456\' 匹配 123-456)';

  @override
  String get wildcardMatchingTitle => '萬用字元匹配:';

  @override
  String get wildcardSupportForFlexibleFiltering => '萬用字元支援靈活過濾';

  @override
  String get windowSizeSetting => '視窗大小';

  @override
  String get year => '年';

  @override
  String get yearly => '每年';

  @override
  String get yearlyChartTitle => '每年封鎖的通話';

  @override
  String get noSimCardsDetected => '未偵測到 SIM 卡';

  @override
  String get filterManagementDescription => '設定通話過濾器';

  @override
  String get callerIdCustomizationSubtitle => '自訂來電顯示版面';

  @override
  String get fraudAlerSettingTitle => '詐騙警報設定';

  @override
  String get fraudAlerSettingSubtitle => '設定詐騙警報';

  @override
  String get enableFraudAlert => '啟用詐騙警報';

  @override
  String get enableFraudAlertDescription => '可疑詐騙電話警報';

  @override
  String get enableVibration => '啟用震動';

  @override
  String get enableVibrationDescription => '當通話被懷疑是詐騙電話時震動';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get useLocalNotification => '使用本地通知';

  @override
  String get useLocalNotificationDescription => '啟用來電的本地通知';

  @override
  String get cancelLocalNotification => '關閉本地通知';

  @override
  String get useStirNotification => '使用 STIR 通知';

  @override
  String get useStirNotificationDescription => '啟用來自 STIR 的通知';

  @override
  String get cancelLocalNotificationDescription => '自動關閉本地通知';

  @override
  String get callerIdSettingsTitle => '來電顯示設定';

  @override
  String get callerIdSettingsSubtitle => '設定來電通知和顯示模式';

  @override
  String get purchaseTitle => '購買';

  @override
  String get purchaseSubtitle => '購買服務';

  @override
  String get callerIdNotificationTitle => '來電資訊';

  @override
  String callerIdBody(String phoneNumber) {
    return '號碼: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '已封鎖的通話';

  @override
  String blockedCallBody(String phoneNumber) {
    return '已封鎖來自 $phoneNumber 的通話';
  }

  @override
  String get stirVerified => '已驗證';

  @override
  String get stirNotVerified => '未驗證';

  @override
  String get stirFailed => '驗證失敗';

  @override
  String get stirUnknown => '未知驗證狀態';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 驗證';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '號碼 $phoneNumber 的 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '滾動安全訊息設定';

  @override
  String get messageColor => '訊息顏色';

  @override
  String get messageFontSize => '訊息字體大小';

  @override
  String get messagePosition => '訊息位置';

  @override
  String get containerWidth => '容器寬度';

  @override
  String get scrollSpeed => '滾動速度';

  @override
  String get enableSecurityMessage => '啟用安全訊息';

  @override
  String get fraudAlertTitle => '詐騙警報';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '來自 $phoneNumber 的潛在詐騙電話';
  }

  @override
  String loadRulesFailed(Object error) {
    return '載入規則失敗：$error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '載入通話記錄失敗：$error';
  }

  @override
  String get noBlockedTypeData => '沒有可用的封鎖類型資料';

  @override
  String importEntity(Object entityTypeName) {
    return '匯入 $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName 匯入成功，總共匯入 $count 條記錄';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '匯入 $entityTypeName 失敗：$error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '匯出 $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName 匯出成功';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '匯出 $entityTypeName 失敗：$error';
  }

  @override
  String get cloudSyncService => '雲端同步服務';

  @override
  String get membershipCenter => '會員中心';

  @override
  String get redeemVipWithMarks => '使用積分兌換 VIP';

  @override
  String get currentMarkCount => '目前積分數量';

  @override
  String get markMoreNumbersForMore => '標記更多號碼以獲取更多積分';

  @override
  String get noAds => '無廣告';

  @override
  String get cloudBackup => '雲端備份';

  @override
  String get callerIdEnhancement => '來電顯示增強';

  @override
  String get voiceRecognition => '語音識別';

  @override
  String get feature => '功能';

  @override
  String get normalUser => '普通用戶';

  @override
  String get vipUser => 'VIP 用戶';

  @override
  String get temporaryVip => '臨時 VIP';

  @override
  String get removeAds => '移除廣告';

  @override
  String get unknownAction => '未知操作';

  @override
  String get settingsBackup => '設定備份';

  @override
  String get allServicesStatusTitle => '目前服務狀態';

  @override
  String get allServicesStatusSubtitle => '各雲端服務的目前狀態';

  @override
  String get redirect => '重定向';

  @override
  String get notify => '通知';

  @override
  String get log => '記錄';

  @override
  String get custom => '自訂';

  @override
  String get allowActionDescription => '即使號碼在封鎖清單上，通話也將被允許。';

  @override
  String get blockActionDescription => '通話將被封鎖並顯示在通話記錄中。';

  @override
  String get silenceActionDescription => '通話將被靜音但顯示在通話記錄中。';

  @override
  String get noneActionDescription => '不會對通話採取任何特殊操作。';

  @override
  String get redirectActionDescription => '將通話重定向到指定的號碼。';

  @override
  String get labelActionDescription => '為通話新增標籤以便於識別。';

  @override
  String get notifyActionDescription => '收到通話時發送通知。';

  @override
  String get logActionDescription => '記錄通話資訊而不採取任何其他操作。';

  @override
  String get customActionDescription => '執行自訂操作。';

  @override
  String get synced => '已同步';

  @override
  String get needVipAccess => '您需要 VIP 權限才能使用此功能';

  @override
  String importExportDescription(Object entityTypeName) {
    return '匯入或匯出 $entityTypeName 資料';
  }

  @override
  String get importExportTitle => '匯入/匯出';

  @override
  String get noPhoneRules => '找不到電話規則';

  @override
  String get noRegexRules => '找不到正則表達式規則';

  @override
  String get noAllowedBlockedRules => '找不到允許/封鎖規則';

  @override
  String get importExport => '匯入/匯出';

  @override
  String get filterByAction => '按操作篩選';

  @override
  String get upgradeToVip => '升級到 VIP';

  @override
  String get batteryOptimizationPermission => '電池優化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '允許應用程式在背景執行，以提供來電顯示等服務。';

  @override
  String get permissionTitle => '特殊權限';

  @override
  String get permissionSubtitle => '管理覆蓋層和電池優化權限';

  @override
  String get themeSettingsTitle => '主題設定';

  @override
  String get themeSettingsSubtitle => '選擇您喜歡的主題';

  @override
  String get databaseSyncTitle => '資料庫同步';

  @override
  String get countrySyncSettingsTitle => '基於國家/地區的資料庫同步設定';

  @override
  String get countrySyncSettingsSubtitle => '選擇用於資料同步的國家/地區';

  @override
  String get countryDataDisclaimer => '請注意：資料庫可能不包含所有特定國家/地區的數據。';

  @override
  String get editSubscription => '編輯訂閱';

  @override
  String get searchByNameOrPhoneNumber => '按姓名或電話號碼搜尋';

  @override
  String get allowedBlockedRulesInfo => '允許/封鎖規則用於匹配特定電話號碼的來電，具有最高優先級。';

  @override
  String get searchPhoneRulesHint => '搜尋電話規則';

  @override
  String get phoneRulesInfo => '電話規則用於匹配特定電話號碼的來電，優先級較低。部分來自 phoneRule 訂閱';

  @override
  String get searchSubscriptionsHint => '搜尋訂閱';

  @override
  String get searchPluginsHint => '搜尋插件';

  @override
  String get searchLabelsHint => '搜尋標籤';

  @override
  String get pluginDescription => '插件描述';

  @override
  String get enterPluginDescription => '輸入插件描述';

  @override
  String get searchRegexRulesHint => '搜尋正則表達式規則';

  @override
  String get regexRulesInfo => '正則表達式規則用於根據正則表達式模式過濾來電。';

  @override
  String get searchMarkedPhonesHint => '搜尋標記的電話';

  @override
  String get searchContactSubscriptionsHint => '搜尋聯絡人訂閱';

  @override
  String get showAllContacts => '顯示所有聯絡人';

  @override
  String get showFavorites => '顯示收藏';

  @override
  String get manualEntry => '手動輸入信息';

  @override
  String get scriptSaved => '腳本已儲存';

  @override
  String editScriptFor(String pluginName) {
    return '編輯 $pluginName 的腳本';
  }

  @override
  String get saveScript => '儲存腳本';

  @override
  String get testPlugin => '測試插件';

  @override
  String get description => '描述';

  @override
  String get accessTargetUrl => '存取目標 URL';

  @override
  String get result => '結果';

  @override
  String get editScript => '編輯腳本';

  @override
  String get numberFormat => '號碼格式';

  @override
  String get nationalNumber => '本地號碼';

  @override
  String get e164Number => 'E164 號碼';

  @override
  String get pluginRulesInfo => '為了安全起見，請僅使用來自可信任來源的插件。歡迎使用我們的模板創建您自己的自定義插件！';

  @override
  String get advancedMode => '高級模式';

  @override
  String get pleaseEnterAtLeastOneNumber => '請至少輸入一個號碼。';

  @override
  String get openInWebView => '在 WebView 中打開';

  @override
  String get pluginLabel => '插件標籤';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '訊息背景顏色';

  @override
  String get clearAllCallLogs => '清除所有通話記錄';

  @override
  String get clearAllCallLogsConfirmation => '確認清除所有通話記錄';

  @override
  String get allCallLogsCleared => '所有通話記錄已清除';

  @override
  String get unblocked => '已解除封鎖';

  @override
  String get blockNumber => '封鎖號碼';

  @override
  String get blockNumberSuccess => '封鎖號碼成功';

  @override
  String get blockNumberFailed => '封鎖號碼失敗';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '你確定要解除封鎖 $phoneNumber 嗎？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '正在撥打 $phoneNumber...';
  }

  @override
  String get viewDetails => '查看詳情';

  @override
  String get unblock => '解除封鎖';

  @override
  String get unblockNumber => '解除封鎖號碼';

  @override
  String get unblockNumberSuccess => '成功解除封鎖號碼';

  @override
  String get unblockNumberFailed => '解除封鎖號碼失敗';

  @override
  String get serviceNotAvailable => '服務不可用';

  @override
  String get callingNumberFailed => '撥打號碼失敗';

  @override
  String get listView => '列表視圖';

  @override
  String get timelineView => '時間軸視圖';

  @override
  String get nameCannotBeEmpty => '名稱不能為空';

  @override
  String get selectAction => '選擇操作';

  @override
  String get selectTargetService => '選擇目標服務';

  @override
  String get callDetails => '通話詳情';

  @override
  String get callType => '通話類型';

  @override
  String get callTime => '通話時間';

  @override
  String get numberInvalidFormat => '號碼格式無效';

  @override
  String get membershipFeature => '會員功能';

  @override
  String get medium => '媒介';

  @override
  String get verificationReport => '驗證報告';

  @override
  String get finalRisk => '最終風險';

  @override
  String get simState => 'SIM 卡狀態';

  @override
  String get ipCountry => 'IP 國家';

  @override
  String get simCountry => 'SIM 卡國家';

  @override
  String get isRoaming => '漫遊';

  @override
  String get isNumberMatch => '號碼匹配';

  @override
  String get support => '支援';

  @override
  String get rewardedAdService => '獎勵廣告服務';

  @override
  String get hasVipPrivilegeExceptAds => '你已擁有 VIP 權限（廣告除外）';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '你已擁有臨時權限，到期日：$expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '你還需要觀看 $count 個廣告才能獲得臨時 VIP 權限';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '你已獲得 $days 天的臨時購買權限。到期日：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '臨時購買權限已過期';

  @override
  String get loadingAd => '正在加載廣告...';

  @override
  String get earnedTempVip => '獲得臨時 VIP';

  @override
  String get vipExchangeService => 'VIP 兌換服務';

  @override
  String get marksInsufficient => '積分不足以兌換';

  @override
  String get invalidExchangeRule => '無效的兌換規則';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '成功兌換 $description，到期日：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '兌換失敗：$error';
  }

  @override
  String get vip3DaysWithAds => '3 天 VIP (含廣告，僅同步)';

  @override
  String get vip5DaysNoAds => '5 天全功能無廣告 VIP';

  @override
  String get vip7DaysNoAds => '7 天全功能無廣告 VIP';

  @override
  String get noNotifications => '沒有通知';

  @override
  String get clearAllNotifications => '清除所有通知';

  @override
  String get clearAllNotificationsConfirmation => '確定清除所有通知嗎？';

  @override
  String get allNotificationsCleared => '所有通知已清除';

  @override
  String get clearButton => '清除';

  @override
  String get justNow => '剛剛';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分鐘前',
      one: '1 分鐘前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小時前',
      one: '1 小時前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日前',
      one: '1 日前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨日';

  @override
  String get deletionProposal => '刪除建議';

  @override
  String get deletionProposals => '刪除建議';

  @override
  String get createProposal => '建立建議';

  @override
  String get createProposalTitle => '建立刪除建議';

  @override
  String get reason => '原因';

  @override
  String get reasonOutdated => '號碼已過時';

  @override
  String get reasonPrivacy => '私隱問題';

  @override
  String get reasonNotInService => '停止服務';

  @override
  String get reasonWronglyIdentified => '錯誤識別';

  @override
  String get reasonInaccurateInfo => '資料不準確';

  @override
  String get reasonWrongMarked => '錯誤標記';

  @override
  String get reasonOther => '其他';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get proposalStatus => '狀態';

  @override
  String get statusPending => '待定';

  @override
  String get statusActive => '進行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusExpired => '已過期';

  @override
  String get riskLevel => '風險級別';

  @override
  String get riskLevelVerified => '已驗證';

  @override
  String get riskLevelLow => '低';

  @override
  String get riskLevelHigh => '高';

  @override
  String get riskLevelUnknown => '未知';

  @override
  String get votingProgress => '投票進度';

  @override
  String agreeVotes(int count) {
    return '贊成: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反對: $count';
  }

  @override
  String totalVotes(int count) {
    return '總數: $count';
  }

  @override
  String get voteAgree => '贊成';

  @override
  String get voteDisagree => '反對';

  @override
  String createdAt(String date) {
    return '建立於: $date';
  }

  @override
  String get showReport => '顯示報告';

  @override
  String get hideReport => '隱藏報告';

  @override
  String get proposalStatistics => '建議統計';

  @override
  String get totalProposals => '建議總數';

  @override
  String get activeProposals => '進行中建議';

  @override
  String get completedProposals => '已完成建議';

  @override
  String get myVotes => '我的投票';

  @override
  String get proposalCreated => '建議建立成功';

  @override
  String get proposalCreateFailed => '建立建議失敗';

  @override
  String get voteSubmitted => '投票提交成功';

  @override
  String get voteSubmitFailed => '投票提交失敗';

  @override
  String get noProposalsFound => '找不到建議';

  @override
  String get loadingProposals => '載入提案中...';

  @override
  String get refreshProposals => '刷新提案';

  @override
  String get totalPendingProposals => '待處理提案總數';

  @override
  String get highRisk => '高風險';

  @override
  String get mediumRisk => '中風險';

  @override
  String get lowRisk => '低風險';

  @override
  String get communityImpact => '社區影響';

  @override
  String get criticalIssues => '嚴重問題';

  @override
  String get communityParticipation => '社區參與';

  @override
  String get noActivity => '無活動';

  @override
  String get low => '低';

  @override
  String get moderate => '中等';

  @override
  String get high => '高';

  @override
  String get veryHigh => '非常高';

  @override
  String get voted => '已投票';

  @override
  String get communityVotes => '社區投票';

  @override
  String get waitingForMoreVotes => '等待更多社區投票';

  @override
  String get proposalProcessed => '此提案已處理';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反對';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒絕';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待定';

  @override
  String get critical => '危急';

  @override
  String get oppose => '反對';

  @override
  String get veryLow => '非常低';

  @override
  String get deletionProposalNotificationDescription => '有關刪除提案投票結果和更新的通知。';

  @override
  String get deletionProposalCreated => '刪除提案已建立';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '您對 $phoneNumber 的刪除提案已提交供社區審查。';
  }

  @override
  String get proposalApproved => '提案已批准 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '社區已批准對 $phoneNumber 的刪除提案（$supportPercentage% 支持率，$totalVotes 票）。';
  }

  @override
  String get proposalRejected => '提案已拒絕 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '社區已拒絕對 $phoneNumber 的刪除提案（$supportPercentage% 支持率，$totalVotes 票）。';
  }

  @override
  String get communityVotingStarted => '社區投票已開始';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '現在開放社區投票，以刪除 $phoneNumber 的新提案。';
  }

  @override
  String get votingCompleted => '投票已完成';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '對 $phoneNumber 的社區投票已結束。結果：$result（$supportPercentage% 支持率）。';
  }

  @override
  String get newVoteReceived => '收到新投票';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '有人投票$voteType刪除 $phoneNumber。目前票數：$totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '載入投票數失敗';

  @override
  String get voteCount => '投票數';

  @override
  String get deletionProposalInfo => '刪除提案資訊';

  @override
  String get deletionProposalDescription => '提議刪除違反社區準則的號碼。您的參與有助於保持平台安全。';

  @override
  String get voteToEarnVip => '對提案進行投票以賺取 VIP 權限！';

  @override
  String get voteFailed => '投票失敗';

  @override
  String get searchProposals => '搜尋提案';

  @override
  String get defaultNotifications => '預設通知';

  @override
  String get defaultNotificationsDescription => '應用程式的預設通知頻道。';

  @override
  String get blockedCallNotifications => '封鎖來電通知';

  @override
  String get blockedCallNotificationsDescription => '顯示關於已封鎖來電的資訊。';

  @override
  String get stirVerification => 'STIR/SHAKEN 驗證';

  @override
  String get stirVerificationDescription => '顯示號碼的 STIR/SHAKEN 驗證結果。';

  @override
  String get fraudAlerts => '詐騙警報';

  @override
  String get fraudAlertsDescription => '顯示潛在詐騙來電的警告。';

  @override
  String get notificationFrequencyDescription =>
      '選擇您接收關於新刪除建議通知的頻率。您可以立即、分批或以自訂間隔接收。';

  @override
  String get immediateNotifications => '立即';

  @override
  String get immediateNotificationsDescription => '在建立建議後立即收到通知。';

  @override
  String get batchNotifications => '分批';

  @override
  String get batchNotificationsDescription => '定期接收通知摘要。';

  @override
  String get customNotifications => '自訂';

  @override
  String get customNotificationsDescription => '定義您自己的接收通知間隔。';

  @override
  String get customFrequency => '自訂頻率';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分鐘';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 小時';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 小時 $minutes 分鐘';
  }

  @override
  String get pendingProposals => '待處理的建議';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個待處理的建議',
      one: '1 個待處理的建議',
      zero: '沒有待處理的建議',
    );
    return '您有 $_temp0。';
  }

  @override
  String get guidelinesLabel => '指引';

  @override
  String get reportingGuidelines =>
      '• 只舉報真正有問題的號碼\n• 提供準確及詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelLabel => '風險級別';

  @override
  String get riskLevelDescription => '號碼的風險級別';

  @override
  String get phoneNumberMinDigits => '電話號碼必須至少有 7 位數字';

  @override
  String get provideDetailedExplanation => '提供詳細解釋（最少 10 個字元）';

  @override
  String get reasonMinCharacters => '原因必須至少有 10 個字元';

  @override
  String get countryCodeTwoLetters => '國家代碼 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '國家代碼 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '例如：US, CN, GB';

  @override
  String get countryCodeRequired => '必須填寫國家代碼';

  @override
  String get countryCodeLengthError => '國家代碼必須是 2 個字母';

  @override
  String get phoneNumberLengthError => '電話號碼必須至少有 7 位數字';

  @override
  String get reasonHint => '提供詳細解釋（最少 10 個字元）';

  @override
  String get reasonRequired => '必須填寫原因';

  @override
  String get reasonLengthError => '原因必須至少有 10 個字元';

  @override
  String get guidelinesTitle => '指引';

  @override
  String get guidelinesText =>
      '• 只舉報真正有問題的號碼\n• 提供準確及詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelCritical => '危急';

  @override
  String get riskLevelMedium => '中等';

  @override
  String get riskLevelVeryLow => '非常低';

  @override
  String get riskDescriptionVeryLow => '非常低 - 輕微滋擾，不頻繁的來電';

  @override
  String get riskDescriptionLow => '低 - 偶爾出現的垃圾或電話推銷來電';

  @override
  String get riskDescriptionMedium => '中等 - 定期的垃圾郵件或電話推銷';

  @override
  String get riskDescriptionHigh => '高 - 持續的騷擾或詐騙企圖';

  @override
  String get riskDescriptionCritical => '危急 - 危險的詐騙或威脅';

  @override
  String get notificationFrequencyTitle => '通知頻率';

  @override
  String get notificationFrequencyLabel => '通知頻率（小時）';

  @override
  String errorMessage(String error) {
    return '錯誤：$error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票：$totalVotes（$supportPercentage% 支持）';
  }

  @override
  String supportCount(int supportCount) {
    return '支持 ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反對 ($opposeCount)';
  }

  @override
  String get timeJustNow => '啱啱';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes 分鐘前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours 小時前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days 日前';
  }

  @override
  String get notificationFrequencyHours => '通知頻率 (小時)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票 ($supportPercentage% 支持)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個小時',
      one: '1 個小時',
      zero: '0 小時',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要通知';

  @override
  String get dataSourceDisclaimer =>
      '數字嚟自互聯網同埋用戶提交。我哋唔可以保證一個號碼一旦刪除，唔會被其他用戶或者來源重新提交。請積極搜索同驗證信息。';

  @override
  String get avatar => '頭像';

  @override
  String get location => '位置';

  @override
  String get simCardTitle => 'SIM 卡';

  @override
  String get liveActivitiesSettingsTitle => '即時動態設定';

  @override
  String get elementsSettingsTitle => '元素設定';

  @override
  String get liveActivityMode => '即時動態';

  @override
  String get liveActivityModeDescription => '喺鎖定螢幕同動態島 (iOS) 上，將通話資訊顯示為持續通知。';

  @override
  String get phoneNumberType => '電話號碼類型';

  @override
  String get liveActivitiesTestEndActivity => '結束活動';

  @override
  String get liveActivitiesTestSendNewActivity => '發送新活動';

  @override
  String get liveActivitiesTestUpdateActivity => '更新活動';

  @override
  String get liveActivityControlsTitle => '即時動態控制';

  @override
  String get liveActivitiesTestTitle => '即時動態測試';

  @override
  String get liveActivitiesTestSubtitle => '測試即時動態通知。';

  @override
  String get liveNotificationCustomizationTitle => '即時通知自訂';

  @override
  String get liveNotificationCustomizationSubtitle => '自訂即時通知嘅外觀。';

  @override
  String get notification_instructions =>
      '指示：\n1. 點擊「發送」以建立或更新通知。\n2. 去你嘅主畫面或者下拉通知欄睇吓結果。\n3. 點擊「結束」以關閉通知。';

  @override
  String get autoCancelNotification => '自動取消通知';

  @override
  String get autoCancelNotificationDescription => '如果選中，當用戶點擊通知時，通知將會自動關閉。';

  @override
  String get setDelayTime => '設定延遲時間';

  @override
  String get proposalDetails => '提案詳情';

  @override
  String get filterByStatus => '按狀態篩選';

  @override
  String get proposalNotFound => '搵唔到提案';

  @override
  String get processed => '已處理';

  @override
  String get showAll => '顯示全部';

  @override
  String get filterAndSortTitle => '篩選同排序';

  @override
  String get filterVerifiedOwner => '篩選已驗證嘅擁有者';

  @override
  String get filterBy => '篩選方式';

  @override
  String get sortOldest => '排序最舊';

  @override
  String get sortNewest => '排序最新';

  @override
  String get sortMostPopular => '排序最受歡迎';

  @override
  String get sortLeastPopular => '排序最唔受歡迎';

  @override
  String get sortBy => '排序方式';

  @override
  String get simRulesNotFound => '搵唔到 SIM 卡規則';

  @override
  String get simSlotRules => 'SIM 卡槽規則';

  @override
  String get noSimCardDetected => '偵測唔到 SIM 卡';

  @override
  String get invalidSimData => '無效 SIM 卡數據';

  @override
  String get simCardData => 'SIM 卡數據';

  @override
  String get simSlot => 'SIM 卡槽';

  @override
  String get enableFiltering => '啟用篩選';

  @override
  String get detailedSettingsTitle => '詳細設定';

  @override
  String get entryPointViewTitle => '入口點視圖';

  @override
  String get callTypeRejected => '已拒絕';

  @override
  String get callTypeSilenced => '已靜音';

  @override
  String get callTypeVoicemail => '語音信箱';

  @override
  String get callTypeUnknownIntercept => '未知攔截';

  @override
  String andMoreItems(int count) {
    return '以及 $count 個更多項目';
  }
}

/// The translations for Chinese, as used in Macao (`zh_MO`).
class AppLocalizationsZhMo extends AppLocalizationsZh {
  AppLocalizationsZhMo() : super('zh_MO');

  @override
  String get aboutContactSubscription => '關於聯絡人訂閱';

  @override
  String get aboutLabels => '關於標籤';

  @override
  String get aboutPhoneSubscriptionRules => '關於電話訂閱規則';

  @override
  String get aboutPhoneSubscriptions => '關於電話訂閱';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      '通過 URL 訂閱電話規則列表，自動更新規則。支持 JSON、CSV 格式規則文件。';

  @override
  String get aboutSmsFilter => '關於 SMS 過濾';

  @override
  String get aboutSmsSubscriptionRules => '關於 SMS 訂閱規則';

  @override
  String get aboutSubtitle => '應用程式版本和法律資訊';

  @override
  String get aboutTitle => '關於';

  @override
  String get action => '操作';

  @override
  String get actionAll => '全部';

  @override
  String get actionAllow => '允許';

  @override
  String get actionBlock => '封鎖';

  @override
  String get actionFilterAll => '全部過濾';

  @override
  String get actionFilterTitle => '按操作類型過濾';

  @override
  String get actionFilterTooltip => '操作過濾器';

  @override
  String get actionNone => '無操作';

  @override
  String get actionSilence => '靜音';

  @override
  String actionTag(Object actionType) {
    return '操作：$actionType';
  }

  @override
  String get actionType => '操作類型';

  @override
  String get actionUnknown => '未知';

  @override
  String get add => '新增';

  @override
  String get addAllowedBlockedRule => '新增允許/封鎖規則';

  @override
  String get addAllowSubscription => '新增允許訂閱';

  @override
  String get addBlockSubscription => '新增封鎖訂閱';

  @override
  String get addContactButton => '新增聯絡人';

  @override
  String addContactFailed(Object error) {
    return '新增聯絡人失敗：$error';
  }

  @override
  String get addedToAllowedRules => '已新增至允許規則';

  @override
  String get addedToBlacklist => '已新增至黑名單';

  @override
  String get addedToBlockedRules => '已新增至封鎖規則';

  @override
  String get addedToFavoriteContacts => '已新增至收藏聯絡人';

  @override
  String get addedToFavorites => '已新增至收藏聯絡人';

  @override
  String get addedToWhitelist => '已新增至白名單';

  @override
  String get addFavorite => '新增收藏';

  @override
  String get addFilter => '新增過濾器';

  @override
  String get addLabel => '新增標籤';

  @override
  String get addLabelButton => '新增標籤';

  @override
  String addLabelFailed(Object error) {
    return '新增標籤失敗：$error';
  }

  @override
  String get addLabelToCall => '新增標籤至通話記錄';

  @override
  String get addName => '新增名稱';

  @override
  String get addNoneSubscription => '新增無訂閱';

  @override
  String get addOrEditContactInfo => '用於新增或編輯聯絡人資訊';

  @override
  String get addPhoneMark => '新增電話標記';

  @override
  String get addPhoneNumberRule => '新增電話號碼規則';

  @override
  String get addPlugin => '新增插件';

  @override
  String get addPluginFailed => '新增插件失敗';

  @override
  String addPluginFailedWithError(Object error) {
    return '新增插件失敗：$error';
  }

  @override
  String get addPluginFromLocalFile => '從本地檔案新增插件';

  @override
  String get addPluginFromUrl => '從 URL 新增插件';

  @override
  String get addRegexRule => '新增正則表達式規則';

  @override
  String get addRule => '新增規則';

  @override
  String get addRuleButton => '新增規則';

  @override
  String addRuleFailed(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String get addRuleTooltip => '新增規則';

  @override
  String get addSilenceSubscription => '新增靜音訂閱';

  @override
  String get addSimRuleButton => '新增 SIM 卡規則';

  @override
  String get addSmsFilterRule => '新增 SMS 過濾規則';

  @override
  String get addSmsRule => '新增 SMS 規則';

  @override
  String get addSmsSubscription => '新增 SMS 訂閱';

  @override
  String get addSubscription => '新增訂閱';

  @override
  String get addSubscriptionButton => '新增訂閱';

  @override
  String addSubscriptionFailed(Object error) {
    return '新增訂閱失敗：$error';
  }

  @override
  String get addSubscriptionTooltip => '新增訂閱';

  @override
  String get addToAllowedRules => '新增至允許規則';

  @override
  String get addToBlacklist => '新增至黑名單';

  @override
  String get addToBlockedRules => '新增至封鎖規則';

  @override
  String get addToFavoriteContacts => '新增至常用聯絡人';

  @override
  String get addToFavorites => '新增至我的最愛';

  @override
  String get addToRules => '新增至規則';

  @override
  String get addToWhitelist => '新增至白名單';

  @override
  String get adPlaceholder => '廣告佔位符';

  @override
  String get agent => '代理';

  @override
  String get all => '全部';

  @override
  String get allCallsTab => '全部';

  @override
  String get allDataClearedSuccessfully => '已成功清除所有資料';

  @override
  String get allow => '允許';

  @override
  String get allowAllAllowRules => '允許所有允許規則';

  @override
  String get allowAllAllowRulesDesc => '允許來自允許規則的通話';

  @override
  String get allowAllBlacklistedNumbers => '允許所有黑名單號碼';

  @override
  String get allowAllBlacklistedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowAllBlockRules => '允許所有封鎖規則';

  @override
  String get allowAllBlockRulesDesc => '允許來自封鎖規則的通話';

  @override
  String get allowAllowedNumbers => '允許允許的號碼';

  @override
  String get allowAllowedNumbersDesc => '允許來自白名單的通話';

  @override
  String get allowBlock => '允許/封鎖';

  @override
  String get allowBlockedNumbers => '允許封鎖的號碼';

  @override
  String get allowBlockedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowedBlockedRule => '允許/封鎖規則';

  @override
  String get allowedBlockedRuleEditDialogTitle => '編輯允許/封鎖規則';

  @override
  String get allowedBlockedRuleManagement => '允許/封鎖規則管理';

  @override
  String get allowNonExceededNumbers => '允許未超出限制的號碼';

  @override
  String get allowNonExceededNumbersDescription => '自動允許未超出計數閾值的號碼';

  @override
  String get allowRegexAllowRules => '允許Regex允許規則';

  @override
  String get allowRegexAllowRulesDesc => '啟用允許規則的Regex模式匹配';

  @override
  String get allowRegexAllowRulesDescription => '啟用基於Regex的允許規則';

  @override
  String get allowRegexBlockRules => '允許Regex封鎖規則';

  @override
  String get allowRegexBlockRulesDesc => '啟用封鎖規則的Regex模式匹配';

  @override
  String get allowRegexBlockRulesDescription => '啟用基於Regex的封鎖規則';

  @override
  String get allowRule => '允許規則';

  @override
  String get allowRules => '允許規則';

  @override
  String get allowWhitelistedNumbers => '允許白名單號碼';

  @override
  String get allowWhitelistedNumbersDescription => '允許白名單中的所有號碼';

  @override
  String get allPermissionsGranted => '已授予所有權限';

  @override
  String get allSettingsCompleted => '所有設定已完成。';

  @override
  String allUpdateSuccess(Object count) {
    return '所有更新已完成（$count 條規則）';
  }

  @override
  String get answerThenHangup => '接聽後掛斷';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule。保留所有權利。';

  @override
  String get applicationSoftware => '應用程式軟件';

  @override
  String get apply => '應用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => '授權失敗：請檢查客戶端 ID 和金鑰';

  @override
  String get authorizationFailedMessage => '授權失敗';

  @override
  String get authorizationSuccessMessage => '授權成功';

  @override
  String get authorizeLoginButton => '授權登入';

  @override
  String get automotiveIndustry => '汽車工業';

  @override
  String get autoSyncLabel => '自動同步';

  @override
  String get autoUpdate => '自動更新';

  @override
  String get autoUpdateDescription => '設定訂閱的自動更新間隔或手動更新';

  @override
  String get autoUpdateSettings => '自動更新設定';

  @override
  String get autoUpdateSettingsSubtitle => '管理規則和插件的自動更新';

  @override
  String get autoUpdateSettingsTitle => '自動更新設定';

  @override
  String get autoUpdateSubtitle => '管理規則和插件的自動更新';

  @override
  String get autoUpdateTitle => '自動更新';

  @override
  String get avatarBorderColor => '頭像邊框顏色';

  @override
  String get avatarBorderSize => '頭像邊框大小';

  @override
  String get avatarIconSizesSetting => '頭像和圖標大小';

  @override
  String get avatarPosition => '頭像位置';

  @override
  String get avatarSize => '頭像大小';

  @override
  String axisPosition(Object axis) {
    return '$axis 位置';
  }

  @override
  String get backgroundGradientSetting => '背景漸變';

  @override
  String get backup => '備份';

  @override
  String get backupAndRestore => '備份和還原';

  @override
  String get backupAndRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupAndRestoreTitle => '備份和還原';

  @override
  String get backupFailed => '備份失敗';

  @override
  String get backupFailedMessage => '備份失敗';

  @override
  String backupFailedWithError(Object error) {
    return '備份失敗：$error';
  }

  @override
  String get backupRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupRestoreTitle => '備份和還原';

  @override
  String get backupSectionTitle => '備份';

  @override
  String get backupSettings => '備份設定';

  @override
  String get backupSettingsDialogTitle => '備份設定';

  @override
  String get backupSettingsTitle => '備份設定';

  @override
  String get backupSuccessMessage => '成功備份到雲端';

  @override
  String backupSuccessToLocal(Object path) {
    return '成功備份到：$path';
  }

  @override
  String get backupToCloud => '備份到雲端';

  @override
  String get backupToCloudDescription => '備份設定和規則到雲端儲存';

  @override
  String backupToCloudFailed(Object error) {
    return '備份到雲端失敗：$error';
  }

  @override
  String get backupToCloudLabel => '備份到雲端';

  @override
  String get backupToCloudSuccess => '成功備份到雲端';

  @override
  String get backupToCloudTitle => '備份到雲端';

  @override
  String get backupToLocalLabel => '備份到本地';

  @override
  String get bank => '銀行';

  @override
  String get basicInfo => '基本信息';

  @override
  String get basicRuleFilter => '基本規則過濾器';

  @override
  String get basicRuleFiltering => '基本規則過濾';

  @override
  String get basicRuleFilteringExplanation => '• 基本規則過濾：基於黑名單、白名單和正則表達式的過濾規則';

  @override
  String get basicRuleFilterSettings => '基本規則過濾器設置';

  @override
  String get basicRuleFilterSubtitle => '使用黑名單/白名單和正則表達式過濾通話';

  @override
  String get batchDeleteContacts => '批量刪除聯絡人';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '您確定要刪除 $count 個選定的聯絡人嗎？';
  }

  @override
  String get batchDeleteFailed => '批量刪除失敗';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '您確定要刪除 $count 個標籤嗎？';
  }

  @override
  String get blacklist => '黑名單';

  @override
  String get blacklistingAndWhitelisting => '黑名單和白名單';

  @override
  String get blacklistLabel => '黑名單';

  @override
  String get blackWhiteList => '黑/白名單';

  @override
  String get block => '封鎖';

  @override
  String get blockCalls => '封鎖通話';

  @override
  String get blocked => '已封鎖';

  @override
  String get blockedCallAction => '已封鎖通話操作';

  @override
  String get blockedCalls => '已封鎖通話';

  @override
  String get blockedCallsTitle => '已封鎖通話';

  @override
  String get blockedCommunications => '已封鎖通訊';

  @override
  String get blockedPhoneLabel => '已封鎖通話';

  @override
  String get blockedSpamCalls => '已封鎖垃圾電話';

  @override
  String get blockingTrend => '封鎖趨勢';

  @override
  String get blockInternationalCalls => '匹配不以 + 或 00 開頭的號碼';

  @override
  String get blockInternationalCallsTitle => '封鎖國際電話';

  @override
  String get blockLandlineNumbersTitle => '封鎖固網電話號碼';

  @override
  String get blockMobileNumbers => '匹配不以 13-19 開頭的號碼';

  @override
  String get blockMobileNumbersTitle => '封鎖手機號碼';

  @override
  String get blockPremiumRateNumbers => '匹配不以 118 或 120-190 開頭的號碼';

  @override
  String get blockPremiumRateNumbersTitle => '封鎖高收費電話號碼';

  @override
  String get blockRule => '封鎖規則';

  @override
  String get blockRules => '封鎖規則';

  @override
  String get blockSpecificAreaCodes => '匹配以 0 + 2-3 位數字開頭的號碼';

  @override
  String get blockSpecificAreaCodesTitle => '封鎖特定地區代碼：';

  @override
  String get blockTypeAnalysisTitle => '封鎖類型分析';

  @override
  String get both => '兩者';

  @override
  String get bulkDelete => '批量刪除聯絡人';

  @override
  String get bulkDeleteContacts => '批量刪除聯絡人';

  @override
  String get bulkDeleteLabels => '批量刪除標籤';

  @override
  String get call => '通話';

  @override
  String get callback => '回撥';

  @override
  String callbackTo(String number) {
    return '回撥至 $number';
  }

  @override
  String get callBlocking => '通話封鎖';

  @override
  String get callerIdApp => '來電顯示應用程式';

  @override
  String get callerIdCustomizationTitle => '自訂來電顯示';

  @override
  String get callerIdDialogTitle => '來電顯示信息';

  @override
  String get callerIdDisplayMode => '來電顯示模式';

  @override
  String callerIdMarkedByCount(Object count) {
    return '被標記 $count 次';
  }

  @override
  String get callerIdPreview => '來電顯示預覽';

  @override
  String get callFilter => '來電過濾';

  @override
  String get callFilterDescription =>
      '啟用後，來電會根據以下規則列表進行檢查。 預設情況下，來電過濾規則不會在裝置之間同步。';

  @override
  String get callFilterRules => '來電過濾規則';

  @override
  String get callFilterRulesDescription => '設定來電過濾的基本規則';

  @override
  String get callFilterSettings => '來電過濾設定';

  @override
  String get callFrequencyInterceptionSubtitle => '設定通話頻率限制和封鎖規則';

  @override
  String get callFrequencyInterceptionTitle => '通話頻率攔截';

  @override
  String get callHistory => '通話記錄';

  @override
  String get callHistoryInfoDesc => '此處顯示您的通話記錄，包括來電、去電和未接來電。';

  @override
  String get callHistoryInfoTitle => '通話記錄';

  @override
  String callHistoryInitFailed(Object error) {
    return '初始化通話記錄失敗：$error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '刷新通話記錄失敗：$error';
  }

  @override
  String get callHistoryTab => '通話記錄';

  @override
  String get callHistoryTimelineEarlier => '更早';

  @override
  String get callHistoryTimelineToday => '今天';

  @override
  String get callHistoryTimelineYesterday => '昨天';

  @override
  String get callScreeningPermission => '來電篩選權限';

  @override
  String get callScreeningPermissionDescription => '用於篩選和封鎖垃圾電話。';

  @override
  String get callScreeningPermissionNotGranted => '未授予來電篩選權限，可能會影響應用程式功能。';

  @override
  String get callSettingsSubtitle => '來電顯示、過濾和封鎖設定';

  @override
  String get callSettingsTitle => '通話設定';

  @override
  String get callStatistics => '通話統計';

  @override
  String get callTypeAnswered => '已接聽';

  @override
  String get callTypeBlocked => '已封鎖';

  @override
  String get callTypeIconColor => '通話類型圖示顏色';

  @override
  String get callTypeMissed => '未接來電';

  @override
  String get callTypeOutgoing => '去電';

  @override
  String get callTypePosition => '通話類型位置';

  @override
  String get callTypeUnknown => '未知';

  @override
  String get cancelButton => '取消';

  @override
  String get carRental => '汽車租賃';

  @override
  String get carrier => '運營商';

  @override
  String get carrierColor => '運營商顏色';

  @override
  String get carrierFontSize => '運營商字體大小';

  @override
  String get carrierPosition => '運營商位置';

  @override
  String get changeLabel => '更改標籤';

  @override
  String changePluginStatusFailed(Object error) {
    return '更改插件狀態失敗：$error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '更改訂閱狀態失敗：$error';
  }

  @override
  String get changeTag => '更改標籤';

  @override
  String get charity => '慈善機構';

  @override
  String chartMonthFormat(int month) {
    return '月份 $month';
  }

  @override
  String get chartOneDayAgo => '1 天前';

  @override
  String get chartOneMonthAgo => '1 個月前';

  @override
  String get chartOneWeekAgo => '1 週前';

  @override
  String get chartTenDaysAgo => '10 天前';

  @override
  String get chartThreeDaysAgo => '3 天前';

  @override
  String get chartToday => '今天';

  @override
  String get checkFileFormat => '請檢查檔案格式或權限';

  @override
  String checkPermissionFailed(Object error) {
    return '檢查權限失敗：$error';
  }

  @override
  String get chooseDefaultInterceptAction => '選擇預設攔截動作';

  @override
  String get clearAllData => '清除所有數據';

  @override
  String get clearAllDataConfirmation => '您確定要清除所有應用程式數據嗎？ 此操作無法撤銷。';

  @override
  String get clearAllDataDescription => '清除所有應用程式數據';

  @override
  String get clearAllDataLabel => '清除所有數據';

  @override
  String get clearFilter => '清除篩選器';

  @override
  String get clearLabelFilter => '清除標籤篩選器';

  @override
  String get clearLabelFilterButton => '清除標籤篩選器';

  @override
  String get closeButton => '關閉';

  @override
  String get cloudSync => '雲端同步';

  @override
  String get cloudSyncAndBackupTitle => '雲端同步與備份';

  @override
  String get cloudSyncSettingsSubtitle => '設定 WebDAV、OneDrive 和 Google Drive';

  @override
  String get cloudSyncSettingsTitle => '雲端同步設定';

  @override
  String get cloudSyncTitle => '雲端同步';

  @override
  String get collapseLabelSelector => '摺疊標籤選擇器';

  @override
  String get collection => '催收';

  @override
  String get colorPickerTitle => '選擇顏色';

  @override
  String get configManagement => '配置管理';

  @override
  String get configUpdated => '配置已更新';

  @override
  String get configurationAdvice => '透過正確的配置，您可以為工作和個人 SIM 卡設定不同的篩選策略。';

  @override
  String get configureBackupOptions => '設定備份選項';

  @override
  String get configureBackupOptionsSubtitle => '設定備份選項';

  @override
  String get configureCloudSyncService => '設定雲端同步服務';

  @override
  String get configureCloudSyncServiceHint => '請設定雲端同步服務以啟用多設備同步。';

  @override
  String get configureCloudSyncServiceMessage => '請設定雲端同步服務以啟用多設備同步。';

  @override
  String get configureSimCardFilterRules => '設定 SIM 卡篩選規則';

  @override
  String get configureSyncServiceHint => '請先在雲端同步設定中配置同步服務';

  @override
  String get confirm => '確認';

  @override
  String get confirmBatchDeleteContacts => '您確定要刪除所選的';

  @override
  String get confirmButton => '確認';

  @override
  String get confirmDelete => '確認刪除';

  @override
  String get confirmDeleteContact => '您確定要刪除';

  @override
  String get confirmDeleteContactName => '確認刪除？';

  @override
  String get confirmDeleteFilter => '您確定要刪除此篩選器嗎？';

  @override
  String confirmDeleteLabel(Object name) {
    return '您確定要刪除標籤 \"$name\" 嗎？';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '您確定要刪除插件 \"$name\" 嗎？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '您確定要刪除 $count 個插件嗎？';
  }

  @override
  String get confirmDeleteRuleMessage => '您確定要刪除此規則嗎？ 此操作無法撤銷。';

  @override
  String get confirmDeleteSelectedContacts => '您確定要刪除選定的聯絡人嗎？';

  @override
  String get confirmDeleteSmsFilterRule => '您確定要刪除此簡訊篩選規則嗎？';

  @override
  String get confirmDeleteSmsRule => '您確定要刪除此簡訊規則嗎？';

  @override
  String get confirmDeleteSubscription => '您確定要刪除此訂閱嗎？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '您確定要刪除 $name？';
  }

  @override
  String get confirmPassword => '確認密碼';

  @override
  String get confirmPasswordLabel => '確認密碼';

  @override
  String get connectedStatus => '已連接';

  @override
  String get connectionFailedCheckCredentialsMessage => '連接失敗：請檢查伺服器地址、用戶名和密碼';

  @override
  String get connectionFailedMessage => '連接失敗';

  @override
  String get connectionStatusLabel => '連線狀態';

  @override
  String get connectionSuccessMessage => '連線成功';

  @override
  String get contactAddSuccess => '成功新增聯絡人';

  @override
  String get contactDeleted => '已刪除聯絡人';

  @override
  String get contactEditDialog => '編輯聯絡人對話框';

  @override
  String get contactNameHint => '輸入聯絡人姓名（可選）';

  @override
  String get contactNameLabel => '姓名';

  @override
  String get contactNameOptional => '聯絡人姓名（可選）';

  @override
  String get contactNotFound => '找不到聯絡人';

  @override
  String get contacts => '聯絡人';

  @override
  String contactsDeleted(Object count) {
    return '已刪除 $count 個聯絡人';
  }

  @override
  String get contactSettingsSubtitle => '聯絡人管理和標籤設定';

  @override
  String get contactSettingsTitle => '聯絡人設定';

  @override
  String contactsLoadingFailed(Object error) {
    return '載入聯絡人失敗：$error';
  }

  @override
  String get contactsManagement => '聯絡人管理';

  @override
  String get contactsManagementPageTitle => '聯絡人管理頁面';

  @override
  String get contactsPageTitle => '聯絡人管理';

  @override
  String get contactsPermission => '聯絡人權限';

  @override
  String get contactsPermissionDescription => '用於識別聯絡人通話。';

  @override
  String get contactsTab => '聯絡人';

  @override
  String get contactSubscriptionDescription =>
      '通過 URL 訂閱聯絡人列表，自動更新聯絡人信息和標籤。支持 JSON 格式數據。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '載入聯絡人訂閱失敗：$error';
  }

  @override
  String get contactSubscriptionPageTitle => '聯絡人訂閱';

  @override
  String get contactUpdateSuccess => '成功更新聯絡人';

  @override
  String get contactUs => '聯絡我們';

  @override
  String get content => '內容';

  @override
  String get contentRegex => '內容正則表達式';

  @override
  String get countColor => '計數顏色';

  @override
  String get countFontSize => '計數字體大小';

  @override
  String get countPosition => '計數位置';

  @override
  String get country => '國家';

  @override
  String get countryNameColor => '國家名稱顏色';

  @override
  String get countryNameFontSize => '國家名稱字體大小';

  @override
  String get countryRegionNamePosition => '國家/地區名稱位置';

  @override
  String get countrySelectionDialog => '國家選擇對話框';

  @override
  String get countrySelectionDialogDescription => '用於選擇國家以查詢來電顯示信息';

  @override
  String get countThresholdDescription => '設置觸發過濾操作所需的最小計數閾值';

  @override
  String get countThresholdLabel => '計數閾值';

  @override
  String get countThresholdSettings => '計數閾值設定';

  @override
  String countThresholdValue(Object count) {
    return '計數閾值：$count';
  }

  @override
  String get createdRules => '已創建規則';

  @override
  String get csvFormat => 'CSV 格式';

  @override
  String get currentDeviceChip => '目前';

  @override
  String get currentDeviceLabel => '目前裝置標籤';

  @override
  String get currentDeviceTitle => '目前裝置';

  @override
  String get currentLabels => '目前標籤：';

  @override
  String get currentLanguage => '目前語言';

  @override
  String get currentPasswordLabel => '目前密碼';

  @override
  String get customerService => '客戶服務';

  @override
  String get customRange => '自定義範圍';

  @override
  String get dailyStatistics => '每日統計';

  @override
  String get dailyStatisticsDesc => '接收有關已封鎖的通話和訊息的每日統計資訊';

  @override
  String get dashboardTab => '儀表板';

  @override
  String get dataAnalysis => '數據分析';

  @override
  String get dataAnalysisDashboardPage => '數據分析儀表板頁面';

  @override
  String get dataExport => '數據匯出';

  @override
  String dataLoadFailure(Object error) {
    return '數據加載失敗：$error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '數據加載失敗：$error';
  }

  @override
  String get dataMigration => '數據遷移';

  @override
  String get dataMigrationDescription =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和還原功能手動遷移數據。';

  @override
  String get dataMigrationDialogContent =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和還原功能手動遷移數據。';

  @override
  String get dataMigrationDialogTitle => '數據遷移';

  @override
  String get dataMigrationSectionTitle => '數據遷移';

  @override
  String get dataSourceReminder => '數據源提示';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日',
      one: '1 日',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 天 VIP';
  }

  @override
  String get debtCollection => '債務催收';

  @override
  String get defaultPeriod => '週';

  @override
  String get delete => '刪除';

  @override
  String get deleteButton => '刪除';

  @override
  String get deleteContact => '刪除聯絡人';

  @override
  String deleteContactConfirm(Object name) {
    return '確定要刪除 $name 嗎？';
  }

  @override
  String get deleteContactConfirmation => '確定要刪除聯絡人嗎';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '確定要刪除 $deviceName 嗎？';
  }

  @override
  String get deleteDeviceDialogTitle => '刪除裝置';

  @override
  String deleteFailed(Object error) {
    return '刪除失敗：$error';
  }

  @override
  String get deleteFilter => '刪除篩選器';

  @override
  String get deleteLabel => '刪除標籤';

  @override
  String deleteLabelFailed(Object error) {
    return '刪除標籤失敗：$error';
  }

  @override
  String get deletePlugin => '刪除插件';

  @override
  String deletePluginFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deletePlugins => '刪除插件';

  @override
  String deletePluginsFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deleteRule => '刪除規則';

  @override
  String deleteRuleFailed(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String get deleteSelected => '刪除選定';

  @override
  String get deleteSmsRule => '刪除 SMS 規則';

  @override
  String get deleteSubscription => '刪除訂閱';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '確定要刪除訂閱 \"$name\" 嗎？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '刪除訂閱失敗：$error';
  }

  @override
  String get deleteSuccess => '刪除成功';

  @override
  String get delivery => '交付';

  @override
  String get deviceDeletedSuccessfully => '裝置已成功刪除';

  @override
  String get deviceDeletedSuccessfullyMessage => '裝置已成功刪除';

  @override
  String get deviceIdLabel => '裝置 ID';

  @override
  String get deviceIDLabel => '裝置 ID';

  @override
  String get deviceManagementSubtitle => '管理多裝置同步';

  @override
  String get deviceManagementTitle => '裝置管理';

  @override
  String get deviceModelLabel => '裝置型號';

  @override
  String get deviceName => '裝置名稱';

  @override
  String get deviceNameCannotBeEmpty => '設備名稱不能為空';

  @override
  String get deviceNameHint => '請輸入設備名稱';

  @override
  String get deviceNameLabel => '設備名稱';

  @override
  String get deviceRenamedSuccessfully => '設備已成功重新命名';

  @override
  String get deviceRenamedSuccessfullyMessage => '設備已成功重新命名';

  @override
  String get devicesSyncedSuccessfully => '設備已成功同步';

  @override
  String get devicesSyncedSuccessfullyMessage => '設備已成功同步';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '設備已成功同步';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '設備已成功取消註冊';

  @override
  String get dialogTitle => '正則表達式模式說明';

  @override
  String get differentFromLocalCounter =>
      '此功能與本地計數器過濾器不同，它側重於短時間內重複的通話模式，而不是長期標記計數。';

  @override
  String get disabled => '已停用';

  @override
  String get disabledStatus => '已停用';

  @override
  String get disableGlobalPlugins => '停用全域外掛程式';

  @override
  String get disableSubscriptionSuccessfully => '已成功停用訂閱';

  @override
  String get disconnectButton => '中斷連線';

  @override
  String get disconnectedMessage => '已中斷連線';

  @override
  String get disconnectedStatus => '已中斷連線';

  @override
  String get disconnectFailedMessage => '中斷連線失敗';

  @override
  String get done => '完成';

  @override
  String get dualSimAdvice => '此功能對於雙 SIM 卡手機特別有用，可以為工作和個人 SIM 卡設定不同的過濾策略。';

  @override
  String get earlier => '更早';

  @override
  String get ecommerce => '電子商務';

  @override
  String get edit => '編輯';

  @override
  String get editContact => '編輯聯絡人';

  @override
  String get editFilter => '編輯過濾器';

  @override
  String get editLabel => '編輯標籤';

  @override
  String get editPhoneRule => '編輯電話規則';

  @override
  String get editPhoneRules => '用於編輯電話規則';

  @override
  String get editPhoneRuleTitle => '編輯電話規則';

  @override
  String get editRule => '編輯規則';

  @override
  String get editSmsRule => '編輯 SMS 規則';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '元素位置';

  @override
  String get email => '電子郵件';

  @override
  String get emailOptional => '電子郵件 (可選)';

  @override
  String get enableCallFilter => '啟用通話過濾器';

  @override
  String get enableCallFilterDescription =>
      '啟用後，來電會根據下面的規則列表進行檢查。預設情況下，通話過濾規則不會在設備之間同步。';

  @override
  String get enabled => '已啟用';

  @override
  String get enabledStatus => '已啟用';

  @override
  String get enableEncryption => '啟用加密';

  @override
  String get enableEncryptionDescription => '加密備份檔案';

  @override
  String get enableEncryptionLabel => '啟用加密';

  @override
  String get enableEncryptionSubtitle => '備份檔案將被加密';

  @override
  String get enableEncryptionTitle => '啟用加密';

  @override
  String get enableGlobalPlugins => '啟用全域外掛程式';

  @override
  String get enableLocalCountFilter => '啟用本地計數過濾器';

  @override
  String get enableLocalCountFilterDescription => '根據通話標記計數自動過濾垃圾電話';

  @override
  String get enableLocalNotification => '使用本地通知';

  @override
  String get enableLocalNotificationDescription => '啟用後，將在設備上顯示已過濾訊息的通知';

  @override
  String get enableLocationSummary => '位置';

  @override
  String get enableMuteRules => '啟用靜音規則';

  @override
  String get enableMuteRulesDesc => '應用靜音攔截規則配置';

  @override
  String get enableNoneActionRules => '啟用無操作規則';

  @override
  String get enableNoneActionRulesDesc => '允許無攔截操作的規則配置';

  @override
  String get enableNotifications => '啟用通知';

  @override
  String get enableRemoteNumberFilter => '啟用遠端號碼過濾';

  @override
  String get enableRemoteNumberFilterDescription => '使用遠端資料庫過濾號碼';

  @override
  String get enableRule => '啟用規則';

  @override
  String get enableSmsFilter => '啟用短訊過濾';

  @override
  String get enableSmsFilterDescription => '啟用後，訊息將根據規則自動過濾';

  @override
  String get enableStatisticsNotifications => '啟用統計通知';

  @override
  String get enableSubscriptionSuccessfully => '成功啟用訂閱';

  @override
  String get enableTimeInterception => '啟用時間攔截';

  @override
  String get enableTimeInterceptionDescription => '短時間內攔截重複來電';

  @override
  String get enableTimeInterceptor => '啟用時間攔截器';

  @override
  String get endCallImmediately => '立即結束通話';

  @override
  String get endColor => '結束顏色';

  @override
  String get endDate => '結束日期';

  @override
  String get enhancedFilterInstructionsTitle => '增強型過濾系統';

  @override
  String get enhancedFilterSettings => '增強型過濾設定';

  @override
  String get enhancedFilterSettingsTitle => '增強型過濾設定';

  @override
  String get enhancedFilterSystemDescription => '增強型過濾系統支援全域規則和每張 SIM 卡的過濾配置。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '請同時輸入電話號碼和正則表達式';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => '請同時輸入電話號碼和正則表達式。';

  @override
  String get enterContactName => '請輸入聯絡人姓名';

  @override
  String get enterCurrentPasswordHint => '請輸入當前密碼';

  @override
  String get enterDeviceName => '輸入裝置名稱';

  @override
  String get enterDeviceNameHint => '請輸入裝置名稱';

  @override
  String get enterEmail => '請輸入電郵';

  @override
  String get enterEmailOptional => '請輸入電郵 (可選)';

  @override
  String get enterEncryptionPasswordHint => '輸入加密密碼';

  @override
  String get enterEncryptionPasswordTitle => '輸入加密密碼';

  @override
  String get enterFilterName => '請輸入過濾器名稱';

  @override
  String get enterFilterPattern => '請輸入過濾器模式';

  @override
  String get enterIconCode => '輸入圖標代碼';

  @override
  String get enterName => '輸入聯絡人姓名';

  @override
  String get enterNewDeviceNameHint => '輸入此裝置的新名稱';

  @override
  String get enterNewPasswordHint => '請輸入新密碼';

  @override
  String get enterPasswordAgain => '再次輸入密碼';

  @override
  String get enterPasswordHint => '請輸入密碼';

  @override
  String get enterPhoneNumber => '輸入電話號碼';

  @override
  String get enterPhoneNumberHint => '輸入要測試的電話號碼';

  @override
  String get enterPhoneNumberMultiple => '請輸入電話號碼，多個號碼用逗號分隔';

  @override
  String get enterPhoneNumberToStartSearch => '輸入電話號碼以開始搜尋';

  @override
  String get enterPhoneNumberToVerify => '輸入要驗證的電話號碼';

  @override
  String get enterPluginName => '輸入插件名稱';

  @override
  String get enterPluginUrl => '輸入插件 URL 地址';

  @override
  String get enterRegexHint => '輸入正則表達式';

  @override
  String get enterRuleNameAndPattern => '請輸入規則名稱和模式';

  @override
  String get enterRuleNameAndPatternMessage => '請輸入規則名稱和正則表達式。';

  @override
  String get enterRuleNameHint => '輸入規則名稱';

  @override
  String get enterSearchContent => '請輸入搜尋內容';

  @override
  String get enterSubscriptionName => '輸入訂閱名稱';

  @override
  String get enterSubscriptionUrl => '輸入訂閱 URL';

  @override
  String get enterSyncFolderNameHint => '請輸入同步資料夾名稱 (預設: NotificationManager)';

  @override
  String get entertainment => '娛樂';

  @override
  String get enterValidNameAndUrl => '請輸入有效的名稱和 URL';

  @override
  String get enterValidUrl => '請輸入有效的 URL';

  @override
  String get enterVersion => '輸入版本';

  @override
  String get enterWebDAVPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get enterWebDAVServerAddressHint => '請輸入 WebDAV 伺服器地址';

  @override
  String get enterWebDAVUsernameHint => '請輸入 WebDAV 用戶名';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '刪除設備時出錯: $error';
  }

  @override
  String get errorLoadingPlugin => '載入外掛程式時出錯';

  @override
  String errorOccurredMessage(Object error) {
    return '發生錯誤: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '重命名設備時出錯: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '同步設備時出錯: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '同步設備時出錯: $error';
  }

  @override
  String get errorText => '錯誤';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '取消註冊設備時出錯: $error';
  }

  @override
  String get exampleBlock400Prefix => '例如：攔截 400 字頭號碼';

  @override
  String get exampleBlockMarketingSms => '例如：攔截促銷短信';

  @override
  String get exampleContentRegex => '例如：.*offer.*';

  @override
  String get exampleContentRegexHint => '內容正則表達式範例';

  @override
  String get exampleCouponPromotionDiscount =>
      '例如：.*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => '例如：家人、朋友等';

  @override
  String get examplePhoneNumber => '例如：10086、12345 等';

  @override
  String get exampleRegex400Prefix => '400 字頭正則表達式範例';

  @override
  String get exampleRegexFormat => '範例：^10086\$ 格式';

  @override
  String get exampleSenderRegexHint => '範例';

  @override
  String get exchange => '兌換';

  @override
  String get exchangeNow => '立即兌換';

  @override
  String get exchangeVip => '兌換 VIP';

  @override
  String get expandLabelSelector => '展開標籤選擇器';

  @override
  String expiryTime(Object time) {
    return '到期時間: $time';
  }

  @override
  String get export => '匯出';

  @override
  String get exportAllApplicationSettings => '匯出所有應用程式設定';

  @override
  String get exportAllApplicationSettingsSubtitle => '匯出所有應用程式設定';

  @override
  String get exportAllRuleConfigurations => '匯出所有規則配置';

  @override
  String get exportAllRuleConfigurationsSubtitle => '匯出所有規則配置';

  @override
  String get exportComplete => '匯出完成';

  @override
  String get exportConfig => '匯出配置';

  @override
  String get exportContacts => '匯出聯絡人';

  @override
  String get exportData => '匯出資料';

  @override
  String get exportError => '匯出錯誤';

  @override
  String get exportFailed => '匯出失敗';

  @override
  String get exportFailure => '匯出配置失敗';

  @override
  String get exportFeatureComingSoon => '匯出功能即將推出';

  @override
  String get exporting => '匯出中...';

  @override
  String get exportLabels => '匯出標籤';

  @override
  String exportLabelsFailed(Object error) {
    return '匯出標籤失敗：$error';
  }

  @override
  String get exportPluginList => '匯出插件列表';

  @override
  String exportPluginListFailed(Object error) {
    return '匯出插件列表失敗：$error';
  }

  @override
  String get exportRules => '匯出規則';

  @override
  String get exportRulesDialogTitle => '匯出規則';

  @override
  String get exportRulesTitle => '匯出規則';

  @override
  String get exportSmsRules => '匯出 SMS 規則';

  @override
  String get exportStatisticsData => '匯出統計數據';

  @override
  String get exportSuccess => '匯出成功';

  @override
  String get exportSuccesslly => '配置匯出成功';

  @override
  String get failedToAddContact => '新增聯絡人失敗';

  @override
  String failedToAddRule(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return '新增 SMS 規則失敗：$error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return '新增 SMS 訂閱失敗：$error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '備份設定失敗：$error';
  }

  @override
  String get failedToDecryptBackupFile => '解密備份檔案失敗';

  @override
  String get failedToDeleteDevice => '刪除裝置失敗';

  @override
  String failedToDeleteSmsRule(Object error) {
    return '刪除 SMS 規則失敗：$error';
  }

  @override
  String failedToExportRules(Object error) {
    return '匯出規則失敗：$error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return '匯出 SMS 規則失敗：$error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '獲取來電顯示資訊失敗：$error';
  }

  @override
  String failedToImportRules(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return '匯入 SMS 規則失敗：$error';
  }

  @override
  String get failedToLoadContacts => '載入聯絡人失敗';

  @override
  String get failedToLoadPlugin => '載入插件失敗';

  @override
  String get failedToRenameDevice => '重新命名裝置失敗';

  @override
  String get failedToRestoreSettings => '還原設定失敗';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '還原設定失敗：$error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '設定密碼失敗：$error';
  }

  @override
  String get failedToSyncDevices => '同步裝置失敗';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '切換規則狀態失敗：$error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '切換訂閱狀態失敗';

  @override
  String get failedToUpdateContact => '更新聯絡人失敗';

  @override
  String failedToUpdateSmsRule(Object error) {
    return '更新 SMS 規則失敗：$error';
  }

  @override
  String get failure => '失敗';

  @override
  String get favoriteContacts => '我的最愛聯絡人';

  @override
  String get featureAddRules => '• 新增特定電話號碼規則';

  @override
  String get featureCenter => '功能中心';

  @override
  String get featureEnableDisable => '• 啟用/停用每個 SIM 卡的不同過濾器';

  @override
  String get featureListTitle => '功能：';

  @override
  String get featureManageRules => '• 管理每個 SIM 卡的規則列表';

  @override
  String get features => '功能';

  @override
  String get fetchingCallerIdInfo => '正在獲取來電顯示資訊...';

  @override
  String fileSavedTo(Object path) {
    return '檔案已儲存至：$path';
  }

  @override
  String get filter => '過濾器';

  @override
  String get filterByLabel => '按標籤過濾';

  @override
  String get filterClear => '清除過濾器';

  @override
  String get filterControlPanelTitle => '過濾器控制面板';

  @override
  String get filterControlSubtitle => '管理所有過濾器的開啟/關閉狀態';

  @override
  String get filterControlTitle => '篩選控制';

  @override
  String get filterDeleteFailed => '篩選刪除失敗';

  @override
  String get filterDeleteSuccess => '篩選刪除成功';

  @override
  String get filterDetails => '篩選詳細資料';

  @override
  String get filtered => '已篩選';

  @override
  String get filteredSms => '已篩選 SMS';

  @override
  String get filteredSmsLabel => '已篩選 SMS';

  @override
  String get filterExplanation => '篩選說明';

  @override
  String get filterManagement => '篩選管理';

  @override
  String get filterName => '篩選名稱';

  @override
  String get filterPattern => '篩選模式';

  @override
  String get filterPriorityNote => '注意：篩選器之間存在優先關係，詳情請參閱幫助文檔';

  @override
  String get filterSaveFailed => '篩選儲存失敗';

  @override
  String get filterSaveSuccess => '篩選儲存成功';

  @override
  String get filterSettings => '篩選設定';

  @override
  String get filterSettingsTitle => '篩選設定';

  @override
  String get filterSMS => '篩選 SMS';

  @override
  String get filterToggleInstructions => '啟用或停用此 SIM 卡槽的篩選器：';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status 篩選器：$filterName';
  }

  @override
  String get filterType => '篩選類型';

  @override
  String get financial => '財務';

  @override
  String get flexibleCombinationFeature => '• 靈活組合：啟用/停用每個 SIM 卡槽的篩選器';

  @override
  String get fontSizesSetting => '字體大小';

  @override
  String foundRules(Object count) {
    return '找到 $count 條規則';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '找到 $count 條規則。您想導入它們嗎？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '找到 $count 條規則。您想導入它們嗎？';
  }

  @override
  String get fraudAlert => '詐騙警報 - 掛斷電話';

  @override
  String get fraudScamLikely => '詐騙可能';

  @override
  String get free => '免費';

  @override
  String get functionSettingsTitle => '功能設定';

  @override
  String generalUpdateFailure(Object error) {
    return '更新失敗：$error';
  }

  @override
  String get getFree => '取得免費';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '配置所有 SIM 卡的全局篩選器：';

  @override
  String get globalFilterFeature => '• 全局篩選器：所有來電的基本規則';

  @override
  String get globalFilterSettings => '全局篩選設定';

  @override
  String get globalFilterToggleInstructions => '配置應用於所有 SIM 卡槽的全局篩選設定：';

  @override
  String get globalSearchSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get globalSearchTitle => '全局搜尋';

  @override
  String get globalSettings => '全局設定';

  @override
  String get googleAdDisplayPosition => 'Google 廣告顯示位置';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob 廣告可以在此處整合';

  @override
  String get googleDriveAuthDescription =>
      '使用系統配置的 Google Drive 客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveAuthorizationHint =>
      '使用系統配置的 Google Drive 客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveConfigTitle => 'Google Drive 配置';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive 配置';

  @override
  String get government => '政府';

  @override
  String get granted => '已授權';

  @override
  String get grantNecessaryPermissions => '授予必要的權限';

  @override
  String get grantPermissions => '授予權限';

  @override
  String get headhunter => '獵頭';

  @override
  String get height => '身高';

  @override
  String get homePageTitle => '主頁';

  @override
  String get homeTab => '首頁';

  @override
  String get howItWorksPoint1 => '• 系統將自動允許在設定的時間範圍內來自同一號碼的呼叫';

  @override
  String get howItWorksPoint2 => '• 較短的時間範圍會導致更嚴格的攔截；較長的時間範圍會導致較寬鬆的攔截';

  @override
  String get howItWorksPoint3 => '• 系統檢查通話記錄以確定是否為重複呼叫';

  @override
  String get howItWorksTitle => '運作方式：';

  @override
  String get iconCodeOptional => '圖示代碼（可選）';

  @override
  String get iconSize => '圖示大小';

  @override
  String get import => '導入';

  @override
  String get important => '重要';

  @override
  String get importButton => '導入';

  @override
  String get importConfig => '導入配置';

  @override
  String get importContacts => '導入聯絡人';

  @override
  String get importExportContacts => '導入/導出聯絡人';

  @override
  String get importExportContactsTooltip => '導入/導出聯絡人';

  @override
  String get importExportRules => '導入/導出規則';

  @override
  String importFailed(Object error) {
    return '導入失敗：$error';
  }

  @override
  String get importFailure => '導入配置失敗';

  @override
  String get importFeatureComingSoon => '導入功能即將推出';

  @override
  String get importLabels => '導入標籤';

  @override
  String importLabelsFailed(Object error) {
    return '導入標籤失敗：$error';
  }

  @override
  String get importPluginList => '導入插件列表';

  @override
  String importPluginListFailed(Object error) {
    return '導入插件列表失敗：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '成功導入 $count 個插件';
  }

  @override
  String get importRuleConfigurationsFromFile => '從檔案導入規則配置';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '從檔案導入規則配置';

  @override
  String get importRules => '導入規則';

  @override
  String get importRulesButton => '導入規則';

  @override
  String get importRulesDialogTitle => '導入規則';

  @override
  String importRulesError(Object error) {
    return '導入規則失敗：$error';
  }

  @override
  String get importRulesInstructions => '從 CSV 檔案導入規則';

  @override
  String get importRulesSuccess => '規則導入成功';

  @override
  String get importRulesTitle => '導入規則';

  @override
  String get importSuccess => '導入成功';

  @override
  String get incomingCallInterceptAction => '來電攔截操作';

  @override
  String get incomingCallNotification => '來電通知';

  @override
  String get incorrectPassword => '密碼錯誤';

  @override
  String get initializing => '正在初始化';

  @override
  String get installed => '已安裝';

  @override
  String get insufficientMarks => '分數不足';

  @override
  String get insurance => '保險';

  @override
  String get interceptAction => '攔截操作';

  @override
  String get interceptionActionSettingsSubtitle => '設定如何處理被封鎖的呼叫';

  @override
  String get interceptionActionSettingsTitle => '攔截操作設定';

  @override
  String get interceptionTimeInterval => '攔截時間間隔';

  @override
  String get internet => '網路';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 更新間隔設定為 $days 天';
  }

  @override
  String get invalidContentRegex => '無效的內容正則表達式';

  @override
  String get invalidLabel => '無效標籤';

  @override
  String get invalidRegexPattern => '無效的 Regex 模式';

  @override
  String get invalidSenderRegex => '無效的發送者 Regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '加入 Telegram 頻道和群組以獲取更多資訊';

  @override
  String get jsLogsTitle => 'JS 日誌';

  @override
  String get jsonFormat => 'JSON 格式';

  @override
  String get keepAllVersions => '保留所有版本';

  @override
  String get keepAllVersionsDescription => '保留每個備份的所有歷史版本';

  @override
  String get keepAllVersionsLabel => '保留所有版本';

  @override
  String get keepAllVersionsSubtitle => '保留每個備份的歷史版本';

  @override
  String get keepAllVersionsTitle => '保留所有版本';

  @override
  String get label => '標籤';

  @override
  String labelAddedSuccessfully(Object name) {
    return '成功新增標籤 \"$name\"';
  }

  @override
  String get labelCategories => '標籤分類';

  @override
  String get labelDeleted => '標籤已刪除';

  @override
  String get labelDescription => '標籤可幫助您更好地管理聯絡人，為電話號碼新增自訂標籤，以便輕鬆識別來電和訊息。';

  @override
  String get labelFilter => '標籤篩選器';

  @override
  String get labelFilterTooltip => '標籤篩選器';

  @override
  String get labelIconColor => '標籤圖示顏色';

  @override
  String get labelManagement => '標籤管理';

  @override
  String get labelNotFound => '找不到標籤';

  @override
  String get labelRemoved => '標籤已移除';

  @override
  String labelRemoveFailed(Object error) {
    return '移除標籤失敗：$error';
  }

  @override
  String get labels => '標籤';

  @override
  String get labelsColor => '標籤顏色';

  @override
  String labelsDeleted(Object count) {
    return '已刪除 $count 個標籤';
  }

  @override
  String get labelsExportedSuccessfully => '標籤匯出成功';

  @override
  String get labelsFontSize => '標籤字體大小';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '成功匯入 $count 個標籤';
  }

  @override
  String get labelsPosition => '標籤位置';

  @override
  String labelTag(Object labelId) {
    return '標籤：$labelId';
  }

  @override
  String get labelUpdated => '標籤已更新';

  @override
  String labelUpdateFailed(Object error) {
    return '更新標籤失敗：$error';
  }

  @override
  String get labelUpdateSuccess => '標籤 \"\$labelText\" 更新成功';

  @override
  String get languageSettings => '語言設定';

  @override
  String get languageSettingsSubtitle => '更改應用程式顯示語言';

  @override
  String get languageSettingsTitle => '語言設定';

  @override
  String get last30Days => '過去 30 天';

  @override
  String get last7Days => '過去 7 天';

  @override
  String get lastSyncLabel => '上次同步';

  @override
  String lastUpdated(Object date) {
    return '上次更新：$date';
  }

  @override
  String get lifetimeMembership => '終身會員';

  @override
  String get lifetimeMembershipDescription => '一次性購買，永久解鎖所有高級功能和未來更新';

  @override
  String loadContactsFailed(Object error) {
    return '載入聯絡人失敗：$error';
  }

  @override
  String get loadDataFailed => '載入資料失敗';

  @override
  String get loadFailed => '載入失敗';

  @override
  String get loading => '載入中...';

  @override
  String get loadingData => '載入資料中...';

  @override
  String get loadingTags => '載入標籤中...';

  @override
  String loadLabelFailed(Object error) {
    return '載入標籤失敗：$error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '載入標籤失敗：$error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '載入已標記電話號碼數量失敗：$error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '載入已標記電話失敗：$error';
  }

  @override
  String get loadMore => '載入更多';

  @override
  String get loadPluginButton => '載入插件';

  @override
  String loadPluginsFailed(Object error) {
    return '載入插件失敗：$error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '載入設定失敗：$error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return '載入 SMS 規則失敗：$error';
  }

  @override
  String get loadStatusFailedMessage => '載入狀態失敗';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String get loan => '貸款';

  @override
  String get localBackupTitle => '本地備份';

  @override
  String get localCounterFilter => '本地計數器過濾';

  @override
  String get localCounterFilterSubtitle => '根據通話頻率自動過濾垃圾電話';

  @override
  String get localCountFilter => '本地計數過濾';

  @override
  String get localCountFilterDescription => '根據本地號碼計數攔截頻繁通話';

  @override
  String get localCountFilterExplanationContent =>
      '本地計數過濾器分析通話記錄，以自動識別和阻止頻繁的垃圾電話。';

  @override
  String get localCountFilterExplanationTitle => '本地計數過濾器說明';

  @override
  String get localCountFilterHowItWorksPoint1 => '• 確定是否基於號碼的計數值進行阻止';

  @override
  String get localCountFilterHowItWorksPoint2 => '• 當號碼的計數超過設定的閾值時，您可以選擇自動阻止它';

  @override
  String get localCountFilterHowItWorksPoint3 => '• 您可以選擇性地允許不超過閾值的號碼';

  @override
  String get localCountFilterHowItWorksPoint4 => '• 您可以選擇是否記錄所有查詢日誌';

  @override
  String get localCountFiltering => '本地計數過濾';

  @override
  String get localCountFilteringExplanation => '• 本地計數過濾：基於本地標記計數的過濾規則';

  @override
  String get localCountFilterSettings => '本地計數過濾器設定';

  @override
  String get localCountFilterUseCases => '此過濾器特別適合於識別自動撥號的垃圾電話和營銷電話。';

  @override
  String get localFilterSettings => '本地過濾器設定';

  @override
  String get localNotificationDisabled => '本地通知已停用';

  @override
  String get localNotificationEnabled => '本地通知已啟用';

  @override
  String get localServices => '本地服務';

  @override
  String get locationColor => '位置顏色';

  @override
  String get locationFontSize => '位置字體大小';

  @override
  String get locationIconColor => '位置圖示顏色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => '記錄所有本地查詢';

  @override
  String get logAllLocalQueriesDescription => '記錄所有本地號碼查詢的日誌';

  @override
  String get logAllRemoteQueries => '記錄所有遠程查詢';

  @override
  String get logAllRemoteQueriesDescription => '記錄所有遠程號碼查詢操作';

  @override
  String get manage => '管理聯絡人';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => '管理我的最愛聯絡人';

  @override
  String get manageFilterRules => '管理過濾規則';

  @override
  String get manageFilterRulesDescription => '新增、編輯或刪除 SMS 過濾規則';

  @override
  String get manageFrequentContacts => '管理常用聯絡人';

  @override
  String get markCounts => '標記計數';

  @override
  String get markCount => '標記計數';

  @override
  String markedByCount(Object count) {
    return '被 $count 標記';
  }

  @override
  String get markedPhonesList => '已標記電話號碼';

  @override
  String get markExchange => '標記交換';

  @override
  String get markPhone => '標記電話號碼';

  @override
  String markPhoneFailed(Object error) {
    return '標記電話號碼失敗：$error';
  }

  @override
  String get markPhoneManagementSubtitle => '標記電話號碼';

  @override
  String get markPhoneManagementTitle => '標記電話管理';

  @override
  String get markPhoneSuccess => '電話號碼標記成功';

  @override
  String get matchFailed => '匹配失敗！';

  @override
  String get matchFailedMessage => '匹配失敗。';

  @override
  String get matchNumbersWithSpecialCharacters => '匹配特定號碼格式';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '匹配帶特殊字符的號碼：';

  @override
  String get matchSpecificDigitPatterns => '匹配 XXX-XXXX-XXXX 格式';

  @override
  String get matchSpecificDigitPatternsTitle => '匹配特定數字模式：';

  @override
  String get matchSuccessful => '匹配成功！';

  @override
  String get matchSuccessfulMessage => '匹配成功！';

  @override
  String get medical => '醫療';

  @override
  String get membershipPrivileges => '會員權益';

  @override
  String get migrationTool => '遷移工具';

  @override
  String get migrationToolTitle => '遷移工具';

  @override
  String get minutes => '分鐘';

  @override
  String get month => '月';

  @override
  String get monthly => '每月';

  @override
  String get monthlyCallCount => '每月通話次數';

  @override
  String get monthlyChartTitle => '每月攔截通話';

  @override
  String get monthlyMembership => '每月會員';

  @override
  String get monthlyMembershipDescription => '解鎖所有高級功能，每月自動續訂';

  @override
  String get monthlyTotal => '每月總計';

  @override
  String get monthlyTotalLabel => '每月總計';

  @override
  String get moreOptions => '更多選項';

  @override
  String get mute => '靜音';

  @override
  String get name => '名稱';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '名稱和電話號碼不能為空';

  @override
  String get nameAndPhoneNumberRequired => '名稱和電話號碼不能為空';

  @override
  String get nameColor => '名稱顏色';

  @override
  String get nameFontSize => '名稱字體大小';

  @override
  String nameLabel(Object name) {
    return '名稱：$name';
  }

  @override
  String get namePosition => '名稱位置';

  @override
  String get nameUnknown => '名稱：未知';

  @override
  String nameWithValue(String name) {
    return '名稱：$name';
  }

  @override
  String get newPasswordLabel => '新密碼';

  @override
  String get nextStep => '下一步';

  @override
  String get noAction => '無操作';

  @override
  String get noActionRules => '無操作規則';

  @override
  String get noActiveCloudSyncServiceMessage => '沒有啟用的雲同步服務';

  @override
  String get noCallLogs => '沒有通話記錄';

  @override
  String get noCallRecords => '沒有通話紀錄';

  @override
  String get noContacts => '還沒有聯絡人';

  @override
  String get noContactsYet => '還沒有聯絡人';

  @override
  String get noData => '沒有數據';

  @override
  String get noDevicesRegisteredMessage => '沒有註冊的設備';

  @override
  String get noDevicesRegisteredYet => '還沒有註冊的設備。';

  @override
  String get noFilters => '還沒有篩選器';

  @override
  String get noLabels => '還沒有標籤';

  @override
  String get noMarkedPhones => '沒有已標記的電話號碼';

  @override
  String get noMatchingContacts => '沒有匹配的聯絡人';

  @override
  String get noMatchingContactsFound => '找不到匹配的聯絡人';

  @override
  String get noMatchingNumbersFound => '找不到匹配的號碼';

  @override
  String get noMatchingRecords => '沒有匹配的通話記錄';

  @override
  String noMatchingRules(Object ruleType) {
    return '沒有匹配的 $ruleType';
  }

  @override
  String get none => '無';

  @override
  String get noneServiceType => '無';

  @override
  String get noPlugins => '暫時沒有插件';

  @override
  String get noRecords => '沒有通話記錄';

  @override
  String get noResultReturned => '沒有返回結果';

  @override
  String get noResultReturnedLog => '插件沒有返回結果';

  @override
  String noRules(Object ruleType) {
    return '暫時沒有 $ruleType';
  }

  @override
  String get noRulesPrompt => '沒有找到規則，請新增規則';

  @override
  String get noRulesToExport => '沒有要匯出的規則';

  @override
  String get noSmsFilterRulesYet => '暫時沒有簡訊過濾規則';

  @override
  String get noSmsRulesYet => '暫時沒有簡訊規則';

  @override
  String get noSubscriptions => '沒有訂閱';

  @override
  String get noSubscriptionsYet => '暫時沒有訂閱';

  @override
  String get notGranted => '未授權';

  @override
  String get notificationMode => '通知模式';

  @override
  String get notificationModeDescription => '在通知欄中顯示來電者資訊';

  @override
  String get notificationPermission => '通知權限';

  @override
  String get notificationPermissionDescription => '用於顯示來電和訊息通知。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知設定';

  @override
  String get notificationSettingsSaved => '通知設定已成功儲存';

  @override
  String get notSet => '未設定';

  @override
  String get notVerifiedText => '未驗證';

  @override
  String get noValidSmsRulesFoundInFile => '在檔案中找不到有效的簡訊規則';

  @override
  String get number => '號碼';

  @override
  String get numberColor => '號碼顏色';

  @override
  String get numberFontSize => '號碼字體大小';

  @override
  String get numberPosition => '號碼位置';

  @override
  String get numberSearch => '號碼搜尋';

  @override
  String get numberTypeColor => '號碼類型顏色';

  @override
  String get numberTypeFontSize => '號碼類型字體大小';

  @override
  String get numberTypePosition => '號碼類型位置';

  @override
  String get ok => '確定';

  @override
  String get okButton => '確定';

  @override
  String get onboardingCompleteDescription => '您的通話安全管理員已準備就緒，開始享受安全的通話體驗！';

  @override
  String get onboardingLanguageDescription => '選擇您偏好的語言以獲得最佳體驗。';

  @override
  String get onboardingPermissionsDescription => '為了提供完整的服務，我們需要以下權限：';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '一鍵封鎖垃圾電話和訊息，自訂封鎖規則，為您提供一個安靜的環境。';

  @override
  String get onboardingSmartCallerIdDescription => '自動識別未知來電，標記可疑號碼，保護您的通話安全。';

  @override
  String get onboardingWelcomeDescription => '您的通話管理專家，提供全面的來電識別和封鎖服務。';

  @override
  String get oneDriveAuthDescription => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveAuthorizationHint => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveConfigTitle => 'OneDrive 配置';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 配置';

  @override
  String get onlineCallerIdSubscription => '線上來電顯示訂閱';

  @override
  String get openAppSettings => '開啟應用程式設定';

  @override
  String openAppSettingsFailed(Object error) {
    return '無法開啟應用程式設定：$error';
  }

  @override
  String operationFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String get operationFailure => '操作失敗';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get other => '其他';

  @override
  String get ourOtherApps => '我們的其他應用程式';

  @override
  String get overlayMode => '浮動視窗';

  @override
  String get overlayModeDescription => '在浮動視窗中顯示來電者資訊';

  @override
  String get overlayPermission => '覆蓋層權限';

  @override
  String get overlayPermissionDescription => '用於顯示來電覆蓋層。';

  @override
  String get overview => '概覽';

  @override
  String get password => '密碼';

  @override
  String get passwordCannotBeEmpty => '密碼不能為空';

  @override
  String get passwordLabel => '密碼';

  @override
  String get passwordsDoNotMatch => '密碼不匹配';

  @override
  String get passwordSetSuccessfully => '密碼設定成功';

  @override
  String get pattern => '模式';

  @override
  String get pendingSync => '等待同步';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '週';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '權限請求被拒絕';

  @override
  String get permissionGranted => '權限已授予';

  @override
  String get permissionManagement => '權限管理';

  @override
  String get phoneCallsTab => '電話';

  @override
  String get phoneNumber => '電話號碼';

  @override
  String get phoneNumberCannotBeEmpty => '電話號碼不能為空';

  @override
  String get phoneNumberHint => '輸入電話號碼';

  @override
  String get phoneNumberHintText => '輸入電話號碼以新增規則';

  @override
  String get phoneNumberLabel => '電話號碼';

  @override
  String get phoneNumberRegexRequired => '請輸入電話號碼和正則表達式';

  @override
  String get phoneNumberRequired => '電話號碼是必需的';

  @override
  String get phoneNumberTypeFixedLine => '固定電話';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定電話或行動電話';

  @override
  String get phoneNumberTypeMobile => '行動電話';

  @override
  String get phoneNumberTypePager => '傳呼機';

  @override
  String get phoneNumberTypePersonalNumber => '個人號碼';

  @override
  String get phoneNumberTypePremiumRate => '高價電話';

  @override
  String get phoneNumberTypeSharedCost => '分攤費用';

  @override
  String get phoneNumberTypeTollFree => '免費電話';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '未知';

  @override
  String get phoneNumberTypeVoicemail => '語音信箱';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '電話權限';

  @override
  String get phonePermissionDescription => '用於識別和阻止來電。';

  @override
  String get phoneRule => '電話規則';

  @override
  String get phoneRuleEditDialog => '電話規則編輯對話框';

  @override
  String get phoneRuleManagement => '電話規則管理';

  @override
  String get phoneRuleSubscription => '電話規則訂閱';

  @override
  String get phoneSubscription => '電話訂閱';

  @override
  String get phoneSubscriptionRulesDescription =>
      '通過 URL 訂閱電話規則列表，以自動更新白名單和黑名單規則。支持 JSON 格式的規則文件。';

  @override
  String get phoneSubscriptionTitle => '電話規則訂閱';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => '請選擇一個標籤並輸入有效的電話號碼';

  @override
  String pluginAddedSuccess(Object name) {
    return '插件 \"$name\" 添加成功';
  }

  @override
  String get pluginDeleted => '插件已刪除';

  @override
  String get pluginLatestVersion => '插件已是最新版本';

  @override
  String get pluginListExportSuccess => '插件列表導出成功';

  @override
  String get pluginLoadedSuccessfully => '插件加載成功';

  @override
  String get pluginManagement => '插件管理';

  @override
  String get pluginManagementSubtitle => '管理和配置第三方插件';

  @override
  String get pluginManagementTitle => '插件管理';

  @override
  String get pluginName => '插件名稱';

  @override
  String get pluginNotLoaded => '插件尚未加載。請先加載插件。';

  @override
  String pluginsDeleted(Object count) {
    return '$count 個插件已成功刪除。';
  }

  @override
  String get pluginService => '插件服務';

  @override
  String get pluginTestPageTitle => '插件測試';

  @override
  String get pluginUpdateSuccess => '插件更新成功';

  @override
  String get pluginUrl => '插件 URL';

  @override
  String get pluginUrlCannotBeEmpty => '插件 URL 不能為空';

  @override
  String get pluginUrlHint => '輸入插件 URL';

  @override
  String get pluginUrlLabel => '插件 URL';

  @override
  String get pluginVersion => '插件版本';

  @override
  String get political => '政治';

  @override
  String get powerfulSpamBlocking => '強大的垃圾郵件攔截功能';

  @override
  String get previousStep => '上一步';

  @override
  String get prioritizeRemoteAction => '優先處理遠程操作設定';

  @override
  String get prioritizeRemoteActionDescription => '優先處理來自遠程資料庫的操作設定';

  @override
  String get processing => '處理中...';

  @override
  String get processingOperation => '處理中...';

  @override
  String get purchase => '購買';

  @override
  String get quarterlyMembership => '季度會員';

  @override
  String get quarterlyMembershipDescription => '解鎖所有高級功能，每季自動續訂';

  @override
  String get queryButton => '查詢';

  @override
  String get queryFailed => '查詢失敗';

  @override
  String get queryFailedLog => '查詢失敗';

  @override
  String get querying => '查詢中...';

  @override
  String get queryingPhoneNumber => '查詢電話號碼';

  @override
  String get queryResultTitle => '查詢結果';

  @override
  String get ready => '準備就緒！';

  @override
  String get receiveWeeklyStatistics => '接收每週統計數據';

  @override
  String get recruiter => '招聘人員';

  @override
  String get reEnterPasswordHint => '請重新輸入密碼';

  @override
  String get refresh => '刷新';

  @override
  String get refreshPermissionStatus => '刷新權限狀態';

  @override
  String get refreshTooltip => '刷新';

  @override
  String regexError(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String get regexPattern => '正則表達式模式';

  @override
  String get regexPatternExplanation => '正則表達式模式說明';

  @override
  String get regexPatternExplanationButton => '正則表達式模式說明';

  @override
  String get regexPatternLabel => '正則表達式模式';

  @override
  String get regexPatternsExamples => '使用標準正則表達式語法來定義模式。例如：';

  @override
  String get regexPatternsForPhoneNumberMatching => '用於電話號碼匹配的正則表達式模式';

  @override
  String get regexRule => '正則表達式規則';

  @override
  String regexRuleAddFailed(Object error) {
    return '添加正則表達式規則失敗：$error';
  }

  @override
  String get regexRuleAddSuccess => '正則表達式規則添加成功';

  @override
  String get regexRuleManagement => '正則表達式規則管理';

  @override
  String get regexRuleNamePatternRequired => '規則名稱和正則表達式模式不能為空';

  @override
  String get regexRules => '正則表達式規則';

  @override
  String get regexTesterTitle => '正則表達式測試器';

  @override
  String regexValidationFailed(Object error) {
    return '正則表達式驗證失敗：$error';
  }

  @override
  String get regexValidationSuccess => '正則表達式驗證成功';

  @override
  String get region => '地區';

  @override
  String get registeredDevicesTitle => '已註冊設備';

  @override
  String get rejectAllCalls => '拒絕所有來電';

  @override
  String get rejectAllCallsDescription => '啟用後，所有來電將以最高優先級被拒絕';

  @override
  String get rejectAllNumbers => '拒絕所有號碼';

  @override
  String get rejectAllNumbersDesc => '啟用後，拒絕所有來電';

  @override
  String get rejectExceededNumbers => '拒絕超出次數的號碼';

  @override
  String get rejectExceededNumbersDescription => '自動拒絕超出次數閾值的號碼';

  @override
  String get remoteFilterSettings => '遠程過濾器設定';

  @override
  String get remoteFilterSettingsPageTitle => '遠程號碼過濾器設定';

  @override
  String get remoteNumberFilter => '遠程號碼過濾器';

  @override
  String get remoteNumberFilterDatabaseInfo => '此過濾器使用獨立的遠程數據庫來獲取最新的號碼信息。';

  @override
  String get remoteNumberFilterDescription => '基於遠程數據庫信息攔截騷擾電話';

  @override
  String get remoteNumberFilterExplanationContent =>
      '遠程號碼過濾器通過查詢基於號碼次數的遠程數據庫來識別和阻止垃圾電話。';

  @override
  String get remoteNumberFilterExplanationTitle => '遠程號碼過濾器說明';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• 次數閾值：根據號碼出現頻率確定';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• 過濾操作：配置如何處理超過閾值的號碼';

  @override
  String get remoteNumberFilterFeaturePriority => '• 優先級設定：設置遠程操作的優先級';

  @override
  String get remoteNumberFilterFeatures => '功能：';

  @override
  String get remoteNumberFiltering => '遠程號碼過濾';

  @override
  String get remoteNumberFilteringExplanation => '• 遠程號碼過濾：基於遠程數據庫信息的過濾規則';

  @override
  String get remoteNumberFilterSubtitle => '使用雲數據庫和社區報告識別垃圾電話';

  @override
  String get removeAdsDescription => '永久移除應用程式中的所有廣告，以獲得更流暢的體驗';

  @override
  String get removeAdsTitle => '移除廣告';

  @override
  String get removedFromFavoriteContacts => '已從收藏聯絡人中移除';

  @override
  String get removedFromFavorites => '已從收藏聯絡人中移除';

  @override
  String get removeFavorite => '移除收藏';

  @override
  String get removeFromFavorites => '從收藏中移除';

  @override
  String get renameButton => '重新命名';

  @override
  String get renameDeviceDialogTitle => '重新命名設備';

  @override
  String get renameDeviceTitle => '重新命名設備';

  @override
  String get replaceCurrentSettingsConfirmation => '這將替換您目前的所有設定。您確定要繼續嗎？';

  @override
  String get requestAllPermissions => '請求所有權限';

  @override
  String get requestPermission => '請求權限';

  @override
  String requestPermissionFailed(Object error) {
    return '請求權限失敗：$error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 個標記';
  }

  @override
  String get reset => '重設';

  @override
  String get restore => '還原';

  @override
  String get restoreApplicationSettingsFromBackup => '從備份還原應用程式設定';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '從備份還原應用程式設定';

  @override
  String get restoreButton => '還原';

  @override
  String restoreFailedWithError(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloud => '從雲端還原';

  @override
  String get restoreFromCloudDescription => '從雲端儲存空間還原設定和規則';

  @override
  String restoreFromCloudFailed(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloudLabel => '從雲端還原';

  @override
  String get restoreFromCloudSuccess => '已成功從雲端還原';

  @override
  String get restoreFromCloudTitle => '從雲端還原';

  @override
  String get restoreFromLocal => '從本地還原';

  @override
  String get restorePurchases => '還原購買項目';

  @override
  String get restoreSectionTitle => '還原';

  @override
  String get restoreSettings => '還原設定';

  @override
  String get restoreSettingsConfirmation => '這將取代您目前的所有設定。您確定要繼續嗎？';

  @override
  String get restoreSettingsDialogTitle => '還原設定';

  @override
  String get restoreSettingsTitle => '還原設定';

  @override
  String get restoreSuccessFromLocal => '已成功從本地還原';

  @override
  String get restoreSuccessMessage => '已成功從雲端還原';

  @override
  String get retry => '重試';

  @override
  String get ridesharing => '共享乘車';

  @override
  String get risk => '風險';

  @override
  String get robocall => '自動電話';

  @override
  String get ruleAction => '規則動作';

  @override
  String get ruleAddButton => '新增規則';

  @override
  String get ruleAddedSuccess => '規則已成功新增';

  @override
  String ruleAddFailure(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String get ruleAddSuccess => '規則已成功新增';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '您確定要刪除此 $ruleType 嗎？';
  }

  @override
  String get ruleDeleteConfirmTitle => '刪除規則';

  @override
  String get ruleDeletedSuccess => '規則已成功刪除';

  @override
  String get ruleDeletedSuccessfully => '規則已成功刪除';

  @override
  String ruleDeleteFailed(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String get ruleDeleteSuccess => '規則已成功刪除';

  @override
  String get ruleDisabledSuccessfully => '規則已成功停用';

  @override
  String get ruleEnabledSuccessfully => '規則已成功啟用';

  @override
  String ruleLoadFailed(Object error) {
    return '載入規則失敗：$error';
  }

  @override
  String get ruleManagement => '規則管理';

  @override
  String get ruleManagementTitle => '規則管理';

  @override
  String get ruleName => '規則名稱';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => '規則名稱和內容正則表達式不能為空';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNameHint => '例如，家人、朋友等。';

  @override
  String get ruleNameLabel => '規則名稱';

  @override
  String get ruleNamePatternRequired => '請輸入規則名稱和模式';

  @override
  String get ruleNameRequired => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNotExist => '規則不存在或已被刪除';

  @override
  String ruleNotFound(Object error) {
    return '找不到規則：$error';
  }

  @override
  String get ruleSavedSuccessfully => '規則已成功儲存！';

  @override
  String get ruleSavedSuccessMessage => '規則已成功儲存！';

  @override
  String ruleSaveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get ruleSaveSuccess => '規則已成功儲存！';

  @override
  String get rulesExportedSuccessfully => '規則已成功匯出';

  @override
  String rulesExportedTo(Object path) {
    return '規則匯出到：$path';
  }

  @override
  String get rulesImported => '規則已成功匯入';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '已成功匯入 $count 條規則';
  }

  @override
  String rulesImportFailed(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String get ruleStatistics => '規則統計';

  @override
  String ruleStatusChanged(Object status) {
    return '規則已成功$status';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '規則已成功$status';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String get ruleUpdateSuccess => '規則已成功更新';

  @override
  String get ruleVerification => '規則驗證';

  @override
  String get save => '儲存';

  @override
  String get saveButton => '儲存';

  @override
  String get saveButtonLabel => '儲存';

  @override
  String get saveButtonText => '儲存';

  @override
  String saveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get saveFilter => '儲存篩選器';

  @override
  String get saveSettings => '儲存設定';

  @override
  String saveSettingsFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get scamsLikely => '可能係詐騙';

  @override
  String get search => '搜尋';

  @override
  String get searchContacts => '搜尋聯絡人';

  @override
  String searchError(Object error) {
    return '搜尋錯誤：$error';
  }

  @override
  String get searchFilters => '搜尋篩選器';

  @override
  String get searchForContacts => '搜尋聯絡人';

  @override
  String get searchHint => '搜尋...';

  @override
  String get searchSettingsSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get searchSettingsTitle => '搜尋設定';

  @override
  String get securityMessage => '唔好相信任何電話。務必獨立驗證客戶服務號碼。切勿分享密碼、驗證碼、卡號或個人資料。';

  @override
  String get selectActionToPerform => '選擇規則符合時要執行的操作';

  @override
  String get selectActionWhenBlockingCalls => '選擇封鎖來電時嘅操作';

  @override
  String get selectActionWhenRuleMatches => '選擇規則符合時嘅操作';

  @override
  String get selectAll => '全選';

  @override
  String get selectCountry => '選擇國家';

  @override
  String get selectDateRange => '選擇日期範圍';

  @override
  String get selectedDateRange => '已選日期範圍';

  @override
  String selectedItems(Object count) {
    return '已選 $count 個項目';
  }

  @override
  String get selectedLabel => '已選擇：';

  @override
  String get selectExportFormat => '選擇匯出格式';

  @override
  String get selectLabel => '選擇標籤';

  @override
  String get selectLabelAndEnterPhoneNumber => '請選擇標籤並輸入有效嘅電話號碼';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get selectMultiple => '選擇多個';

  @override
  String get selectPeriod => '選擇時段';

  @override
  String get selectSimCard => '選擇 SIM 卡';

  @override
  String get selectSimSlot => '選擇 SIM 卡槽';

  @override
  String get selectSpecificActionForBlockedCalls => '選擇封鎖來電時要執行的特定操作';

  @override
  String get selectTag => '選擇標籤';

  @override
  String get selectTags => '選擇標籤';

  @override
  String get selectTrustedDataSource => '請選擇信任的數據源';

  @override
  String get selectYourLanguage => '選擇您的語言';

  @override
  String get sender => '發件人';

  @override
  String get senderRegexOptional => '發件人正則表達式（可選）';

  @override
  String get serverAddressLabel => '伺服器地址';

  @override
  String get serviceTypeContact => '聯絡人訂閱';

  @override
  String get serviceTypeLabel => '服務類型';

  @override
  String get serviceTypePhone => '電話訂閱';

  @override
  String get serviceTypePlugin => '插件更新';

  @override
  String get serviceTypeSms => 'SMS 訂閱';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '設定';

  @override
  String get setEncryptionPassword => '設定加密密碼';

  @override
  String get setEncryptionPasswordDescription => '設定用於備份和還原的加密密碼';

  @override
  String get setEncryptionPasswordLabel => '設定加密密碼';

  @override
  String get setEncryptionPasswordTitle => '設定加密密碼';

  @override
  String get setPasswordButton => '設定';

  @override
  String get settings => '設定';

  @override
  String settingsBackedUpTo(Object path) {
    return '設定已備份到：$path';
  }

  @override
  String get settingsLoaded => '設定已載入';

  @override
  String settingsLoadFailed(Object error) {
    return '載入設定失敗：$error';
  }

  @override
  String get settingsRestoredSuccessfully => '設定已成功還原。請重新啟動應用程式以使變更生效。';

  @override
  String get settingsSaved => '設定已儲存';

  @override
  String settingsSaveFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get settingsTab => '設定';

  @override
  String get settingsTitle => '設定';

  @override
  String get setup => '設定';

  @override
  String get showContactEditDialogStaticMethod => '用於顯示聯絡人編輯對話框的靜態方法';

  @override
  String get showExplanation => '顯示說明';

  @override
  String get silence => '靜音';

  @override
  String get silenceAndNoAnswer => '靜音且不接聽';

  @override
  String get silenceNoAnswer => '靜音不接聽';

  @override
  String get silentCallVoiceClone => '靜音通話語音複製';

  @override
  String get silentRules => '靜音規則';

  @override
  String simCard(Object simNumber) {
    return 'SIM 卡 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 卡顏色';

  @override
  String get simCardConfigurationExplanation => '• SIM 卡配置：為每個 SIM 卡設置獨立的過濾規則';

  @override
  String get simCardFilterRules => 'SIM 卡過濾規則';

  @override
  String get simCardFilterRulesDescription => '根據 SIM 卡槽設置不同的過濾規則';

  @override
  String get simCardFontSize => 'SIM 卡字體大小';

  @override
  String get simCardPosition => 'SIM 卡位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return '載入 SIM 卡資訊失敗：$error';
  }

  @override
  String get simRuleInstructions => 'SIM 卡槽規則允許您為每個 SIM 卡槽配置獨立的過濾規則。';

  @override
  String get simRuleInstructionsTitle => 'SIM 卡槽規則';

  @override
  String get simRuleManagement => 'SIM 卡槽規則管理';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'SIM 卡數據加載失敗：$error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM 卡槽過濾配置';

  @override
  String get simSlotFilterConfigurationDescription => '允許按 SIM 卡槽設置過濾規則';

  @override
  String get simSlotFilterDescription => '為每張 SIM 卡配置獨立的過濾規則：';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber 過濾設定';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM 卡槽加載失敗：$error';
  }

  @override
  String get simSlotManagement => 'SIM 卡槽管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM 卡槽操作失敗：$error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM 卡槽位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM 卡槽規則：每個 SIM 卡獨立的過濾策略';

  @override
  String get simSlotRuleListTitle => 'SIM 卡槽規則列表';

  @override
  String get simSlotRuleManagement => 'SIM 卡槽規則';

  @override
  String get simSlotRuleManagementTitle => '規則管理';

  @override
  String get simSlotSettings => 'SIM 卡槽設定';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber';
  }

  @override
  String get skip => '跳過';

  @override
  String get smartCallerId => '智能來電顯示';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS 過濾可幫助您自動過濾垃圾訊息並保持您的訊息列表清潔。您可以設定過濾規則和通知方式。';

  @override
  String get smsFilterDisabled => 'SMS 過濾已停用';

  @override
  String get smsFilterEnabled => 'SMS 過濾已啟用';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMS 過濾規則已成功新增';

  @override
  String get smsFilterRules => 'SMS 過濾規則';

  @override
  String get smsFilterSettings => 'SMS 過濾設定';

  @override
  String get smsHistory => 'SMS 歷史記錄';

  @override
  String get smsManagement => 'SMS 管理';

  @override
  String get smsPermission => 'SMS 權限';

  @override
  String get smsPermissionDescription => '用於過濾垃圾訊息。';

  @override
  String get smsRuleAddedSuccessfully => 'SMS 規則已成功新增';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS 規則已成功刪除';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS 規則加載失敗：$error';
  }

  @override
  String get smsRuleManagement => 'SMS 規則管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS 規則已成功匯出到 $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS 規則已成功導入';

  @override
  String get smsRuleSubscription => 'SMS 規則訂閱';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS 規則已成功更新';

  @override
  String get smsSettingsSubtitle => 'SMS 過濾和關鍵字封鎖';

  @override
  String get smsSettingsTitle => 'SMS 設定';

  @override
  String get smsSubscription => 'SMS 訂閱';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS 訂閱已成功新增';

  @override
  String get smsSubscriptionRulesDescription =>
      '通過 URL 訂閱 SMS 規則列表，支持正則表達式匹配。您可以設定封鎖或允許操作。';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => '某些權限請求被拒絕';

  @override
  String get spamLikely => '可能是垃圾訊息';

  @override
  String get startColor => '開始顏色';

  @override
  String get startDate => '開始日期';

  @override
  String get startUsing => '開始使用';

  @override
  String get statAnswered => '已接聽';

  @override
  String get statBlocked => '已封鎖';

  @override
  String get staticMethodShowCallerIdDialog => '顯示來電顯示資訊對話框的靜態方法';

  @override
  String get staticMethodToDisplayCountrySelectionDialog => '顯示國家/地區選擇對話框的靜態方法';

  @override
  String get staticMethodToDisplayDialog => '顯示對話框的靜態方法';

  @override
  String get statistics => '統計';

  @override
  String get statisticsExportFeatureComingSoon => '統計資料匯出功能即將推出';

  @override
  String get statisticsGrid => '統計資料網格';

  @override
  String get statisticsPageTitle => '數據分析';

  @override
  String get stirColor => 'STIR 顏色';

  @override
  String get stirFontSize => 'STIR 字體大小';

  @override
  String get stirPosition => 'STIR 位置';

  @override
  String get storagePermission => '儲存權限';

  @override
  String get storagePermissionDescription => '用於保存設定和規則。';

  @override
  String get subscribe => '訂閱';

  @override
  String subscriptionAddSuccess(Object name) {
    return '已成功新增訂閱「$name」';
  }

  @override
  String get subscriptionDeleteConfirmContent => '確定要刪除此訂閱嗎？';

  @override
  String get subscriptionDeleteConfirmTitle => '刪除訂閱';

  @override
  String get subscriptionDeleted => '已刪除訂閱';

  @override
  String get subscriptionDeletedSuccessfully => '已成功刪除訂閱';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '刪除訂閱失敗：$error';
  }

  @override
  String get subscriptionDeleteSuccess => '已刪除訂閱';

  @override
  String get subscriptionEmptyState => '沒有可用的訂閱';

  @override
  String get subscriptionEmptyText => '尚無訂閱';

  @override
  String subscriptionLoadFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '載入訂閱失敗：$error';
  }

  @override
  String get subscriptionManagementTitle => '訂閱管理';

  @override
  String get subscriptionName => '訂閱名稱';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '訂閱名稱和 URL 不能為空';

  @override
  String get subscriptionNameHint => '輸入訂閱名稱';

  @override
  String get subscriptionPageTitle => '訂閱管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '變更訂閱狀態失敗：$error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '切換訂閱狀態失敗：$error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '更新訂閱失敗：$error';
  }

  @override
  String get subscriptionUpdateSuccess => '已成功更新訂閱';

  @override
  String get subscriptionUrl => '訂閱網址';

  @override
  String get subscriptionUrlHint => '輸入訂閱網址';

  @override
  String successfullyImportedRules(Object count) {
    return '已成功匯入 $count 條規則';
  }

  @override
  String get supportSync => '支援同步';

  @override
  String get survey => '調查';

  @override
  String get syncDevicesButton => '同步裝置';

  @override
  String get syncFailed => '同步失敗';

  @override
  String get syncFailedMessage => '同步失敗';

  @override
  String get syncFolderNameHint => '請輸入同步資料夾名稱（預設：NotificationManager）';

  @override
  String get syncFolderNameLabel => '同步資料夾名稱';

  @override
  String get synchronized => '已同步';

  @override
  String get syncing => '正在同步...';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncStatusTitle => '同步狀態';

  @override
  String get syncStatusUpdatedMessage => '同步狀態已更新';

  @override
  String get syncSuccessful => '同步成功';

  @override
  String get syncSuccessMessage => '同步成功';

  @override
  String get syncWithCloudStorage => '與雲端儲存空間同步';

  @override
  String get syncWithCloudStorageSubtitle => '與雲端儲存空間同步';

  @override
  String get systemFeatures => '系統功能：';

  @override
  String get systemSettingsTitle => '系統設定';

  @override
  String get tabAll => '全部';

  @override
  String get tabAnswered => '已接聽';

  @override
  String get tabBlocked => '已封鎖';

  @override
  String get tabMissed => '未接聽';

  @override
  String get tabOutgoing => '已撥出';

  @override
  String tagLabel(String tag) {
    return '標籤：$tag';
  }

  @override
  String get tagsUpdated => '標籤已更新';

  @override
  String get takeaway => '外賣';

  @override
  String get telecommunication => '電訊';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => '電話推銷';

  @override
  String get testButton => '測試';

  @override
  String get testButtonLabel => '測試';

  @override
  String get testConnectionButton => '測試連線';

  @override
  String get textColorsSetting => '文字及標籤顏色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '此應用程式是一個強大的來電顯示工具，可讓您識別和封鎖不需要的來電。';

  @override
  String get thisWeek => '本週';

  @override
  String get timeInterceptor => '時間攔截器';

  @override
  String get timeInterceptorDescription => '根據通話頻率自動攔截/允許潛在通話';

  @override
  String get timeInterceptorExplanation => '• 時間攔截器：在短時間內攔截/允許重複通話';

  @override
  String get timeInterceptorExplanationContent =>
      '通話頻率攔截功能會分析通話頻率，以自動識別和攔截/允許頻繁的垃圾電話。';

  @override
  String get timeInterceptorExplanationTitle => '通話頻率攔截說明';

  @override
  String get timeInterceptorSettingsTitle => '通話頻率攔截設定';

  @override
  String get timeInterceptorSubtitle => '根據通話頻率自動攔截潛在的垃圾電話';

  @override
  String get timeInterceptorTitle => '啟用通話頻率攔截';

  @override
  String get timeWindowDescription => '設定允許重複通話的時間窗口大小。來自同一號碼在此窗口內的通話將被允許';

  @override
  String timeWindowLabel(int minutes) {
    return '攔截時間窗口（分鐘）：$minutes';
  }

  @override
  String get timeWindowSetting => '設定允許重複通話的時間窗口大小。來自同一號碼在此窗口內的通話將被允許';

  @override
  String get today => '今天';

  @override
  String get total => '總計';

  @override
  String get totalBlocked => '總封鎖';

  @override
  String get totalFiltered => '總過濾';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '在裝置或平台之間傳輸數據';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => '在裝置或平台之間傳輸數據';

  @override
  String get travelTicketing => '旅遊票務';

  @override
  String get trend => '趨勢';

  @override
  String get trendChart => '趨勢圖';

  @override
  String get tutorial => '教學';

  @override
  String get type => '類型';

  @override
  String get unassignedSIMCard => '未分配的 SIM 卡';

  @override
  String get unknown => '未知';

  @override
  String get unknownLabel => '不明標籤';

  @override
  String get unknownTag => '標籤：不明';

  @override
  String get unregisterButton => '取消註冊';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '你確定要取消註冊 $deviceName 嗎？';
  }

  @override
  String get unregisterDeviceTitle => '取消註冊裝置';

  @override
  String get unsupportedFileFormat => '不支援的檔案格式';

  @override
  String get update => '更新';

  @override
  String get updateAllNow => '立即全部更新';

  @override
  String get updateCallFilterConfig => '更新來電過濾配置';

  @override
  String updateContactFailed(Object error) {
    return '更新聯絡人失敗：$error';
  }

  @override
  String get updateFavoriteStatus => '更新喜好狀態';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '更新喜好狀態失敗：$error';
  }

  @override
  String get updateInterval => '更新間隔';

  @override
  String get updateLabelFailed => '更新標籤失敗';

  @override
  String get updateNow => '立即更新';

  @override
  String get updatePlugin => '更新插件';

  @override
  String updatePluginFailed(Object error) {
    return '更新插件失敗：$error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '更新訂閱失敗：$error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service 成功更新（$count 條規則）';
  }

  @override
  String get updateTags => '更新標籤';

  @override
  String get useCasesPoint1 => '• 識別自動重撥垃圾電話';

  @override
  String get useCasesPoint2 => '• 攔截在短時間內多次撥打的行銷電話';

  @override
  String get useCasesPoint3 => '• 預防電話轟炸和騷擾';

  @override
  String get useCasesTitle => '使用案例：';

  @override
  String get useGlobalSettings => '使用全域設定';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '使用者名稱';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '使用標準正則表達式語法來定義模式。例子：';

  @override
  String get validateRegex => '驗證正則表達式';

  @override
  String get verificationFailedText => '驗證失敗';

  @override
  String get verifiedText => '已驗證';

  @override
  String get verify => '驗證';

  @override
  String version(Object version) {
    return '版本：$version';
  }

  @override
  String get vipExchangeDescription => '用電話號碼標記次數兌換 VIP 會員資格';

  @override
  String get vipExchangeTitle => '標記兌換 VIP';

  @override
  String get watchAd => '觀看廣告';

  @override
  String get watchAdForTemp => '觀看廣告以獲得臨時權限';

  @override
  String get watchAdForTempDescription => '觀看短片廣告以暫時解鎖一些高級功能';

  @override
  String get webDAVConfigTitle => 'WebDAV 配置';

  @override
  String get webdavConfigurationTitle => 'WebDAV 配置';

  @override
  String get webdavPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get webdavServerAddressHint => '請輸入 WebDAV 伺服器地址';

  @override
  String get webdavUsernameHint => '請輸入 WebDAV 使用者名稱';

  @override
  String get week => '週';

  @override
  String get weekly => '每週';

  @override
  String get weeklyBlockedCallsSummary => '每週攔截電話摘要';

  @override
  String get weeklyChartTitle => '每週攔截電話';

  @override
  String get weeklyReport => '每週報告';

  @override
  String get weeklyReportDesc => '接收每週來電攔截活動摘要報告';

  @override
  String get welcome => '歡迎';

  @override
  String get whitelist => '白名單';

  @override
  String get whitelistLabel => '白名單';

  @override
  String get width => '寬度';

  @override
  String get wildcardMatchingDescription =>
      '使用 \'.\' 匹配任何字符 (例如 \'123.456\' 匹配 123-456)';

  @override
  String get wildcardMatchingTitle => '萬用字元匹配:';

  @override
  String get wildcardSupportForFlexibleFiltering => '萬用字元支援靈活過濾';

  @override
  String get windowSizeSetting => '視窗大小';

  @override
  String get year => '年';

  @override
  String get yearly => '每年';

  @override
  String get yearlyChartTitle => '每年封鎖的通話';

  @override
  String get noSimCardsDetected => '未偵測到 SIM 卡';

  @override
  String get filterManagementDescription => '設定通話過濾器';

  @override
  String get callerIdCustomizationSubtitle => '自訂來電顯示版面';

  @override
  String get fraudAlerSettingTitle => '詐騙警報設定';

  @override
  String get fraudAlerSettingSubtitle => '設定詐騙警報';

  @override
  String get enableFraudAlert => '啟用詐騙警報';

  @override
  String get enableFraudAlertDescription => '可疑詐騙電話警報';

  @override
  String get enableVibration => '啟用震動';

  @override
  String get enableVibrationDescription => '當通話被懷疑是詐騙電話時震動';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get useLocalNotification => '使用本地通知';

  @override
  String get useLocalNotificationDescription => '啟用來電的本地通知';

  @override
  String get cancelLocalNotification => '關閉本地通知';

  @override
  String get useStirNotification => '使用 STIR 通知';

  @override
  String get useStirNotificationDescription => '啟用來自 STIR 的通知';

  @override
  String get cancelLocalNotificationDescription => '自動關閉本地通知';

  @override
  String get callerIdSettingsTitle => '來電顯示設定';

  @override
  String get callerIdSettingsSubtitle => '設定來電通知和顯示模式';

  @override
  String get purchaseTitle => '購買';

  @override
  String get purchaseSubtitle => '購買服務';

  @override
  String get callerIdNotificationTitle => '來電資訊';

  @override
  String callerIdBody(String phoneNumber) {
    return '號碼: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '已封鎖的通話';

  @override
  String blockedCallBody(String phoneNumber) {
    return '已封鎖來自 $phoneNumber 的通話';
  }

  @override
  String get stirVerified => '已驗證';

  @override
  String get stirNotVerified => '未驗證';

  @override
  String get stirFailed => '驗證失敗';

  @override
  String get stirUnknown => '未知驗證狀態';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 驗證';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '號碼 $phoneNumber 的 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '滾動安全訊息設定';

  @override
  String get messageColor => '訊息顏色';

  @override
  String get messageFontSize => '訊息字體大小';

  @override
  String get messagePosition => '訊息位置';

  @override
  String get containerWidth => '容器寬度';

  @override
  String get scrollSpeed => '滾動速度';

  @override
  String get enableSecurityMessage => '啟用安全訊息';

  @override
  String get fraudAlertTitle => '詐騙警報';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '來自 $phoneNumber 的潛在詐騙電話';
  }

  @override
  String loadRulesFailed(Object error) {
    return '載入規則失敗：$error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '載入通話記錄失敗：$error';
  }

  @override
  String get noBlockedTypeData => '沒有可用的封鎖類型資料';

  @override
  String importEntity(Object entityTypeName) {
    return '匯入 $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName 匯入成功，總共匯入 $count 條記錄';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '匯入 $entityTypeName 失敗：$error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '匯出 $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName 匯出成功';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '匯出 $entityTypeName 失敗：$error';
  }

  @override
  String get cloudSyncService => '雲端同步服務';

  @override
  String get membershipCenter => '會員中心';

  @override
  String get redeemVipWithMarks => '使用積分兌換 VIP';

  @override
  String get currentMarkCount => '目前積分數量';

  @override
  String get markMoreNumbersForMore => '標記更多號碼以獲取更多積分';

  @override
  String get noAds => '無廣告';

  @override
  String get cloudBackup => '雲端備份';

  @override
  String get callerIdEnhancement => '來電顯示增強';

  @override
  String get voiceRecognition => '語音識別';

  @override
  String get feature => '功能';

  @override
  String get normalUser => '普通用戶';

  @override
  String get vipUser => 'VIP 用戶';

  @override
  String get temporaryVip => '臨時 VIP';

  @override
  String get removeAds => '移除廣告';

  @override
  String get unknownAction => '未知操作';

  @override
  String get settingsBackup => '設定備份';

  @override
  String get allServicesStatusTitle => '目前服務狀態';

  @override
  String get allServicesStatusSubtitle => '各雲端服務的目前狀態';

  @override
  String get redirect => '重定向';

  @override
  String get notify => '通知';

  @override
  String get log => '記錄';

  @override
  String get custom => '自訂';

  @override
  String get allowActionDescription => '即使號碼在封鎖清單上，通話也將被允許。';

  @override
  String get blockActionDescription => '通話將被封鎖並顯示在通話記錄中。';

  @override
  String get silenceActionDescription => '通話將被靜音但顯示在通話記錄中。';

  @override
  String get noneActionDescription => '不會對通話採取任何特殊操作。';

  @override
  String get redirectActionDescription => '將通話重定向到指定的號碼。';

  @override
  String get labelActionDescription => '為通話新增標籤以便於識別。';

  @override
  String get notifyActionDescription => '收到通話時發送通知。';

  @override
  String get logActionDescription => '記錄通話資訊而不採取任何其他操作。';

  @override
  String get customActionDescription => '執行自訂操作。';

  @override
  String get synced => '已同步';

  @override
  String get needVipAccess => '您需要 VIP 權限才能使用此功能';

  @override
  String importExportDescription(Object entityTypeName) {
    return '匯入或匯出 $entityTypeName 資料';
  }

  @override
  String get importExportTitle => '匯入/匯出';

  @override
  String get noPhoneRules => '找不到電話規則';

  @override
  String get noRegexRules => '找不到正則表達式規則';

  @override
  String get noAllowedBlockedRules => '找不到允許/封鎖規則';

  @override
  String get importExport => '匯入/匯出';

  @override
  String get filterByAction => '按操作篩選';

  @override
  String get upgradeToVip => '升級到 VIP';

  @override
  String get batteryOptimizationPermission => '電池優化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '允許應用程式在背景執行，以提供來電顯示等服務。';

  @override
  String get permissionTitle => '特殊權限';

  @override
  String get permissionSubtitle => '管理覆蓋層和電池優化權限';

  @override
  String get themeSettingsTitle => '主題設定';

  @override
  String get themeSettingsSubtitle => '選擇您喜歡的主題';

  @override
  String get databaseSyncTitle => '資料庫同步';

  @override
  String get countrySyncSettingsTitle => '基於國家/地區的資料庫同步設定';

  @override
  String get countrySyncSettingsSubtitle => '選擇用於資料同步的國家/地區';

  @override
  String get countryDataDisclaimer => '請注意：資料庫可能不包含所有特定國家/地區的數據。';

  @override
  String get editSubscription => '編輯訂閱';

  @override
  String get searchByNameOrPhoneNumber => '按姓名或電話號碼搜尋';

  @override
  String get allowedBlockedRulesInfo => '允許/封鎖規則用於匹配特定電話號碼的來電，具有最高優先級。';

  @override
  String get searchPhoneRulesHint => '搜尋電話規則';

  @override
  String get phoneRulesInfo => '電話規則用於匹配特定電話號碼的來電，優先級較低。部分來自 phoneRule 訂閱';

  @override
  String get searchSubscriptionsHint => '搜尋訂閱';

  @override
  String get searchPluginsHint => '搜尋插件';

  @override
  String get searchLabelsHint => '搜尋標籤';

  @override
  String get pluginDescription => '插件描述';

  @override
  String get enterPluginDescription => '輸入插件描述';

  @override
  String get searchRegexRulesHint => '搜尋正則表達式規則';

  @override
  String get regexRulesInfo => '正則表達式規則用於根據正則表達式模式過濾來電。';

  @override
  String get searchMarkedPhonesHint => '搜尋標記的電話';

  @override
  String get searchContactSubscriptionsHint => '搜尋聯絡人訂閱';

  @override
  String get showAllContacts => '顯示所有聯絡人';

  @override
  String get showFavorites => '顯示收藏';

  @override
  String get manualEntry => '手動輸入信息';

  @override
  String get scriptSaved => '腳本已儲存';

  @override
  String editScriptFor(String pluginName) {
    return '編輯 $pluginName 的腳本';
  }

  @override
  String get saveScript => '儲存腳本';

  @override
  String get testPlugin => '測試插件';

  @override
  String get description => '描述';

  @override
  String get accessTargetUrl => '存取目標 URL';

  @override
  String get result => '結果';

  @override
  String get editScript => '編輯腳本';

  @override
  String get numberFormat => '號碼格式';

  @override
  String get nationalNumber => '本地號碼';

  @override
  String get e164Number => 'E164 號碼';

  @override
  String get pluginRulesInfo => '為了安全起見，請僅使用來自可信任來源的插件。歡迎使用我們的模板創建您自己的自定義插件！';

  @override
  String get advancedMode => '高級模式';

  @override
  String get pleaseEnterAtLeastOneNumber => '請至少輸入一個號碼。';

  @override
  String get openInWebView => '在 WebView 中打開';

  @override
  String get pluginLabel => '插件標籤';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '訊息背景顏色';

  @override
  String get clearAllCallLogs => '清除所有通話記錄';

  @override
  String get clearAllCallLogsConfirmation => '確認清除所有通話記錄';

  @override
  String get allCallLogsCleared => '所有通話記錄已清除';

  @override
  String get unblocked => '已解除封鎖';

  @override
  String get blockNumber => '封鎖號碼';

  @override
  String get blockNumberSuccess => '封鎖號碼成功';

  @override
  String get blockNumberFailed => '封鎖號碼失敗';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '你確定要解除封鎖 $phoneNumber 嗎？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '正在撥打 $phoneNumber...';
  }

  @override
  String get viewDetails => '查看詳情';

  @override
  String get unblock => '解除封鎖';

  @override
  String get unblockNumber => '解除封鎖號碼';

  @override
  String get unblockNumberSuccess => '成功解除封鎖號碼';

  @override
  String get unblockNumberFailed => '解除封鎖號碼失敗';

  @override
  String get serviceNotAvailable => '服務不可用';

  @override
  String get callingNumberFailed => '撥打號碼失敗';

  @override
  String get listView => '列表視圖';

  @override
  String get timelineView => '時間軸視圖';

  @override
  String get nameCannotBeEmpty => '名稱不能為空';

  @override
  String get selectAction => '選擇操作';

  @override
  String get selectTargetService => '選擇目標服務';

  @override
  String get callDetails => '通話詳情';

  @override
  String get callType => '通話類型';

  @override
  String get callTime => '通話時間';

  @override
  String get numberInvalidFormat => '號碼格式無效';

  @override
  String get membershipFeature => '會員功能';

  @override
  String get medium => '媒介';

  @override
  String get verificationReport => '驗證報告';

  @override
  String get finalRisk => '最終風險';

  @override
  String get simState => 'SIM 卡狀態';

  @override
  String get ipCountry => 'IP 國家';

  @override
  String get simCountry => 'SIM 卡國家';

  @override
  String get isRoaming => '漫遊';

  @override
  String get isNumberMatch => '號碼匹配';

  @override
  String get support => '支援';

  @override
  String get rewardedAdService => '獎勵廣告服務';

  @override
  String get hasVipPrivilegeExceptAds => '你已擁有 VIP 權限（廣告除外）';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '你已擁有臨時權限，到期日：$expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '你還需要觀看 $count 個廣告才能獲得臨時 VIP 權限';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '你已獲得 $days 天的臨時購買權限。到期日：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '臨時購買權限已過期';

  @override
  String get loadingAd => '正在加載廣告...';

  @override
  String get earnedTempVip => '獲得臨時 VIP';

  @override
  String get vipExchangeService => 'VIP 兌換服務';

  @override
  String get marksInsufficient => '積分不足以兌換';

  @override
  String get invalidExchangeRule => '無效的兌換規則';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '成功兌換 $description，到期日：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '兌換失敗：$error';
  }

  @override
  String get vip3DaysWithAds => '3 天 VIP (含廣告，僅同步)';

  @override
  String get vip5DaysNoAds => '5 天全功能無廣告 VIP';

  @override
  String get vip7DaysNoAds => '7 天全功能無廣告 VIP';

  @override
  String get noNotifications => '沒有通知';

  @override
  String get clearAllNotifications => '清除所有通知';

  @override
  String get clearAllNotificationsConfirmation => '確定清除所有通知嗎？';

  @override
  String get allNotificationsCleared => '所有通知已清除';

  @override
  String get clearButton => '清除';

  @override
  String get justNow => '剛剛';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分鐘前',
      one: '1 分鐘前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小時前',
      one: '1 小時前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 日前',
      one: '1 日前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨日';

  @override
  String get deletionProposal => '刪除建議';

  @override
  String get deletionProposals => '刪除建議';

  @override
  String get createProposal => '建立建議';

  @override
  String get createProposalTitle => '建立刪除建議';

  @override
  String get reason => '原因';

  @override
  String get reasonOutdated => '號碼已過時';

  @override
  String get reasonPrivacy => '私隱問題';

  @override
  String get reasonNotInService => '停止服務';

  @override
  String get reasonWronglyIdentified => '錯誤識別';

  @override
  String get reasonInaccurateInfo => '資料不準確';

  @override
  String get reasonWrongMarked => '錯誤標記';

  @override
  String get reasonOther => '其他';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get proposalStatus => '狀態';

  @override
  String get statusPending => '待定';

  @override
  String get statusActive => '進行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusExpired => '已過期';

  @override
  String get riskLevel => '風險級別';

  @override
  String get riskLevelVerified => '已驗證';

  @override
  String get riskLevelLow => '低';

  @override
  String get riskLevelHigh => '高';

  @override
  String get riskLevelUnknown => '未知';

  @override
  String get votingProgress => '投票進度';

  @override
  String agreeVotes(int count) {
    return '贊成: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反對: $count';
  }

  @override
  String totalVotes(int count) {
    return '總數: $count';
  }

  @override
  String get voteAgree => '贊成';

  @override
  String get voteDisagree => '反對';

  @override
  String createdAt(String date) {
    return '建立於: $date';
  }

  @override
  String get showReport => '顯示報告';

  @override
  String get hideReport => '隱藏報告';

  @override
  String get proposalStatistics => '建議統計';

  @override
  String get totalProposals => '建議總數';

  @override
  String get activeProposals => '進行中建議';

  @override
  String get completedProposals => '已完成建議';

  @override
  String get myVotes => '我的投票';

  @override
  String get proposalCreated => '建議建立成功';

  @override
  String get proposalCreateFailed => '建立建議失敗';

  @override
  String get voteSubmitted => '投票提交成功';

  @override
  String get voteSubmitFailed => '投票提交失敗';

  @override
  String get noProposalsFound => '找不到建議';

  @override
  String get loadingProposals => '載入提案中...';

  @override
  String get refreshProposals => '刷新提案';

  @override
  String get totalPendingProposals => '待處理提案總數';

  @override
  String get highRisk => '高風險';

  @override
  String get mediumRisk => '中風險';

  @override
  String get lowRisk => '低風險';

  @override
  String get communityImpact => '社區影響';

  @override
  String get criticalIssues => '嚴重問題';

  @override
  String get communityParticipation => '社區參與';

  @override
  String get noActivity => '無活動';

  @override
  String get low => '低';

  @override
  String get moderate => '中等';

  @override
  String get high => '高';

  @override
  String get veryHigh => '非常高';

  @override
  String get voted => '已投票';

  @override
  String get communityVotes => '社區投票';

  @override
  String get waitingForMoreVotes => '等待更多社區投票';

  @override
  String get proposalProcessed => '此提案已處理';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反對';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒絕';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待定';

  @override
  String get critical => '危急';

  @override
  String get oppose => '反對';

  @override
  String get veryLow => '非常低';

  @override
  String get deletionProposalNotificationDescription => '有關刪除提案投票結果和更新的通知。';

  @override
  String get deletionProposalCreated => '刪除提案已建立';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '您對 $phoneNumber 的刪除提案已提交供社區審查。';
  }

  @override
  String get proposalApproved => '提案已批准 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '社區已批准對 $phoneNumber 的刪除提案（$supportPercentage% 支持率，$totalVotes 票）。';
  }

  @override
  String get proposalRejected => '提案已拒絕 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '社區已拒絕對 $phoneNumber 的刪除提案（$supportPercentage% 支持率，$totalVotes 票）。';
  }

  @override
  String get communityVotingStarted => '社區投票已開始';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '現在開放社區投票，以刪除 $phoneNumber 的新提案。';
  }

  @override
  String get votingCompleted => '投票已完成';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '對 $phoneNumber 的社區投票已結束。結果：$result（$supportPercentage% 支持率）。';
  }

  @override
  String get newVoteReceived => '收到新投票';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '有人投票$voteType刪除 $phoneNumber。目前票數：$totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '載入投票數失敗';

  @override
  String get voteCount => '投票數';

  @override
  String get deletionProposalInfo => '刪除提案資訊';

  @override
  String get deletionProposalDescription => '提議刪除違反社區準則的號碼。您的參與有助於保持平台安全。';

  @override
  String get voteToEarnVip => '對提案進行投票以賺取 VIP 權限！';

  @override
  String get voteFailed => '投票失敗';

  @override
  String get searchProposals => '搜尋提案';

  @override
  String get defaultNotifications => '預設通知';

  @override
  String get defaultNotificationsDescription => '應用程式的預設通知頻道。';

  @override
  String get blockedCallNotifications => '封鎖來電通知';

  @override
  String get blockedCallNotificationsDescription => '顯示關於已封鎖來電的資訊。';

  @override
  String get stirVerification => 'STIR/SHAKEN 驗證';

  @override
  String get stirVerificationDescription => '顯示號碼的 STIR/SHAKEN 驗證結果。';

  @override
  String get fraudAlerts => '詐騙警報';

  @override
  String get fraudAlertsDescription => '顯示潛在詐騙來電的警告。';

  @override
  String get notificationFrequencyDescription =>
      '選擇您接收關於新刪除建議通知的頻率。您可以立即、分批或以自訂間隔接收。';

  @override
  String get immediateNotifications => '立即';

  @override
  String get immediateNotificationsDescription => '在建立建議後立即收到通知。';

  @override
  String get batchNotifications => '分批';

  @override
  String get batchNotificationsDescription => '定期接收通知摘要。';

  @override
  String get customNotifications => '自訂';

  @override
  String get customNotificationsDescription => '定義您自己的接收通知間隔。';

  @override
  String get customFrequency => '自訂頻率';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分鐘';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 小時';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 小時 $minutes 分鐘';
  }

  @override
  String get pendingProposals => '待處理的建議';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個待處理的建議',
      one: '1 個待處理的建議',
      zero: '沒有待處理的建議',
    );
    return '您有 $_temp0。';
  }

  @override
  String get guidelinesLabel => '指引';

  @override
  String get reportingGuidelines =>
      '• 只舉報真正有問題的號碼\n• 提供準確及詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelLabel => '風險級別';

  @override
  String get riskLevelDescription => '號碼的風險級別';

  @override
  String get phoneNumberMinDigits => '電話號碼必須至少有 7 位數字';

  @override
  String get provideDetailedExplanation => '提供詳細解釋（最少 10 個字元）';

  @override
  String get reasonMinCharacters => '原因必須至少有 10 個字元';

  @override
  String get countryCodeTwoLetters => '國家代碼 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '國家代碼 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '例如：US, CN, GB';

  @override
  String get countryCodeRequired => '必須填寫國家代碼';

  @override
  String get countryCodeLengthError => '國家代碼必須是 2 個字母';

  @override
  String get phoneNumberLengthError => '電話號碼必須至少有 7 位數字';

  @override
  String get reasonHint => '提供詳細解釋（最少 10 個字元）';

  @override
  String get reasonRequired => '必須填寫原因';

  @override
  String get reasonLengthError => '原因必須至少有 10 個字元';

  @override
  String get guidelinesTitle => '指引';

  @override
  String get guidelinesText =>
      '• 只舉報真正有問題的號碼\n• 提供準確及詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelCritical => '危急';

  @override
  String get riskLevelMedium => '中等';

  @override
  String get riskLevelVeryLow => '非常低';

  @override
  String get riskDescriptionVeryLow => '非常低 - 輕微滋擾，不頻繁的來電';

  @override
  String get riskDescriptionLow => '低 - 偶爾出現的垃圾或電話推銷來電';

  @override
  String get riskDescriptionMedium => '中等 - 定期的垃圾郵件或電話推銷';

  @override
  String get riskDescriptionHigh => '高 - 持續的騷擾或詐騙企圖';

  @override
  String get riskDescriptionCritical => '危急 - 危險的詐騙或威脅';

  @override
  String get notificationFrequencyTitle => '通知頻率';

  @override
  String get notificationFrequencyLabel => '通知頻率（小時）';

  @override
  String errorMessage(String error) {
    return '錯誤：$error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票：$totalVotes（$supportPercentage% 支持）';
  }

  @override
  String supportCount(int supportCount) {
    return '支持 ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反對 ($opposeCount)';
  }

  @override
  String get timeJustNow => '啱啱';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes 分鐘前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours 小時前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days 日前';
  }

  @override
  String get notificationFrequencyHours => '通知頻率 (小時)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票 ($supportPercentage% 支持)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個小時',
      one: '1 個小時',
      zero: '0 小時',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要通知';

  @override
  String get dataSourceDisclaimer =>
      '數字嚟自互聯網同埋用戶提交。我哋唔可以保證一個號碼一旦刪除，唔會被其他用戶或者來源重新提交。請積極搜索同驗證信息。';

  @override
  String get avatar => '頭像';

  @override
  String get location => '位置';

  @override
  String get simCardTitle => 'SIM 卡';

  @override
  String get liveActivitiesSettingsTitle => '即時動態設定';

  @override
  String get elementsSettingsTitle => '元素設定';

  @override
  String get liveActivityMode => '即時動態';

  @override
  String get liveActivityModeDescription => '喺鎖定螢幕同動態島 (iOS) 上，將通話資訊顯示為持續通知。';

  @override
  String get phoneNumberType => '電話號碼類型';

  @override
  String get liveActivitiesTestEndActivity => '結束活動';

  @override
  String get liveActivitiesTestSendNewActivity => '發送新活動';

  @override
  String get liveActivitiesTestUpdateActivity => '更新活動';

  @override
  String get liveActivityControlsTitle => '即時動態控制';

  @override
  String get liveActivitiesTestTitle => '即時動態測試';

  @override
  String get liveActivitiesTestSubtitle => '測試即時動態通知。';

  @override
  String get liveNotificationCustomizationTitle => '即時通知自訂';

  @override
  String get liveNotificationCustomizationSubtitle => '自訂即時通知嘅外觀。';

  @override
  String get notification_instructions =>
      '指示：\n1. 點擊「發送」以建立或更新通知。\n2. 去你嘅主畫面或者下拉通知欄睇吓結果。\n3. 點擊「結束」以關閉通知。';

  @override
  String get autoCancelNotification => '自動取消通知';

  @override
  String get autoCancelNotificationDescription => '如果選中，當用戶點擊通知時，通知將會自動關閉。';

  @override
  String get setDelayTime => '設定延遲時間';

  @override
  String get proposalDetails => '提案詳情';

  @override
  String get filterByStatus => '按狀態篩選';

  @override
  String get proposalNotFound => '搵唔到提案';

  @override
  String get processed => '已處理';

  @override
  String get showAll => '顯示全部';

  @override
  String get filterAndSortTitle => '篩選同排序';

  @override
  String get filterVerifiedOwner => '篩選已驗證嘅擁有者';

  @override
  String get filterBy => '篩選方式';

  @override
  String get sortOldest => '排序最舊';

  @override
  String get sortNewest => '排序最新';

  @override
  String get sortMostPopular => '排序最受歡迎';

  @override
  String get sortLeastPopular => '排序最唔受歡迎';

  @override
  String get sortBy => '排序方式';

  @override
  String get simRulesNotFound => '搵唔到 SIM 卡規則';

  @override
  String get simSlotRules => 'SIM 卡槽規則';

  @override
  String get noSimCardDetected => '偵測唔到 SIM 卡';

  @override
  String get invalidSimData => '無效 SIM 卡數據';

  @override
  String get simCardData => 'SIM 卡數據';

  @override
  String get simSlot => 'SIM 卡槽';

  @override
  String get enableFiltering => '啟用篩選';

  @override
  String get detailedSettingsTitle => '詳細設定';

  @override
  String get entryPointViewTitle => '入口點視圖';

  @override
  String get callTypeRejected => '已拒絕';

  @override
  String get callTypeSilenced => '已靜音';

  @override
  String get callTypeVoicemail => '語音信箱';

  @override
  String get callTypeUnknownIntercept => '未知攔截';

  @override
  String andMoreItems(int count) {
    return '以及 $count 個更多項目';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get aboutContactSubscription => '關於聯絡人訂閱';

  @override
  String get aboutLabels => '關於標籤';

  @override
  String get aboutPhoneSubscriptionRules => '關於電話訂閱規則';

  @override
  String get aboutPhoneSubscriptions => '關於電話訂閱';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      '透過 URL 訂閱電話規則列表，自動更新規則。支援 JSON、CSV 格式規則檔案。';

  @override
  String get aboutSmsFilter => '關於簡訊過濾';

  @override
  String get aboutSmsSubscriptionRules => '關於簡訊訂閱規則';

  @override
  String get aboutSubtitle => '應用程式版本和法律資訊';

  @override
  String get aboutTitle => '關於';

  @override
  String get action => '動作';

  @override
  String get actionAll => '全部';

  @override
  String get actionAllow => '允許';

  @override
  String get actionBlock => '封鎖';

  @override
  String get actionFilterAll => '全部過濾';

  @override
  String get actionFilterTitle => '依動作類型過濾';

  @override
  String get actionFilterTooltip => '動作過濾器';

  @override
  String get actionNone => '無動作';

  @override
  String get actionSilence => '靜音';

  @override
  String actionTag(Object actionType) {
    return '動作：$actionType';
  }

  @override
  String get actionType => '動作類型';

  @override
  String get actionUnknown => '未知';

  @override
  String get add => '新增';

  @override
  String get addAllowedBlockedRule => '新增允許/封鎖規則';

  @override
  String get addAllowSubscription => '新增允許訂閱';

  @override
  String get addBlockSubscription => '新增封鎖訂閱';

  @override
  String get addContactButton => '新增聯絡人';

  @override
  String addContactFailed(Object error) {
    return '新增聯絡人失敗：$error';
  }

  @override
  String get addedToAllowedRules => '已新增至允許規則';

  @override
  String get addedToBlacklist => '已新增至黑名單';

  @override
  String get addedToBlockedRules => '已新增至封鎖規則';

  @override
  String get addedToFavoriteContacts => '已新增至常用聯絡人';

  @override
  String get addedToFavorites => '已新增至常用聯絡人';

  @override
  String get addedToWhitelist => '已新增至白名單';

  @override
  String get addFavorite => '新增常用';

  @override
  String get addFilter => '新增過濾器';

  @override
  String get addLabel => '新增標籤';

  @override
  String get addLabelButton => '新增標籤';

  @override
  String addLabelFailed(Object error) {
    return '新增標籤失敗：$error';
  }

  @override
  String get addLabelToCall => '新增標籤到通話紀錄';

  @override
  String get addName => '新增名稱';

  @override
  String get addNoneSubscription => '新增無訂閱';

  @override
  String get addOrEditContactInfo => '用於新增或編輯聯絡人資訊';

  @override
  String get addPhoneMark => '新增電話標記';

  @override
  String get addPhoneNumberRule => '新增電話號碼規則';

  @override
  String get addPlugin => '新增外掛程式';

  @override
  String get addPluginFailed => '新增外掛程式失敗';

  @override
  String addPluginFailedWithError(Object error) {
    return '新增外掛程式失敗：$error';
  }

  @override
  String get addPluginFromLocalFile => '從本機檔案新增外掛程式';

  @override
  String get addPluginFromUrl => '從 URL 新增外掛程式';

  @override
  String get addRegexRule => '新增正則表達式規則';

  @override
  String get addRule => '新增規則';

  @override
  String get addRuleButton => '新增規則';

  @override
  String addRuleFailed(Object error) {
    return '新增規則失敗: $error';
  }

  @override
  String get addRuleTooltip => '新增規則';

  @override
  String get addSilenceSubscription => '新增靜音訂閱';

  @override
  String get addSimRuleButton => '新增 SIM 卡規則';

  @override
  String get addSmsFilterRule => '新增簡訊過濾規則';

  @override
  String get addSmsRule => '新增簡訊規則';

  @override
  String get addSmsSubscription => '新增簡訊訂閱';

  @override
  String get addSubscription => '新增訂閱';

  @override
  String get addSubscriptionButton => '新增訂閱';

  @override
  String addSubscriptionFailed(Object error) {
    return '新增訂閱失敗: $error';
  }

  @override
  String get addSubscriptionTooltip => '新增訂閱';

  @override
  String get addToAllowedRules => '新增至允許規則';

  @override
  String get addToBlacklist => '新增至黑名單';

  @override
  String get addToBlockedRules => '新增至封鎖規則';

  @override
  String get addToFavoriteContacts => '新增至我的最愛聯絡人';

  @override
  String get addToFavorites => '新增至我的最愛';

  @override
  String get addToRules => '新增至規則';

  @override
  String get addToWhitelist => '新增至白名單';

  @override
  String get adPlaceholder => '廣告佔位符';

  @override
  String get agent => '代理人';

  @override
  String get all => '全部';

  @override
  String get allCallsTab => '全部';

  @override
  String get allDataClearedSuccessfully => '所有資料已成功清除';

  @override
  String get allow => '允許';

  @override
  String get allowAllAllowRules => '允許所有允許規則';

  @override
  String get allowAllAllowRulesDesc => '允許來自允許規則的通話';

  @override
  String get allowAllBlacklistedNumbers => '允許所有黑名單號碼';

  @override
  String get allowAllBlacklistedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowAllBlockRules => '允許所有封鎖規則';

  @override
  String get allowAllBlockRulesDesc => '允許來自封鎖規則的通話';

  @override
  String get allowAllowedNumbers => '允許允許的號碼';

  @override
  String get allowAllowedNumbersDesc => '允許來自白名單的通話';

  @override
  String get allowBlock => '允許/封鎖';

  @override
  String get allowBlockedNumbers => '允許封鎖的號碼';

  @override
  String get allowBlockedNumbersDesc => '允許來自黑名單的通話';

  @override
  String get allowedBlockedRule => '允許/封鎖規則';

  @override
  String get allowedBlockedRuleEditDialogTitle => '編輯允許/封鎖規則';

  @override
  String get allowedBlockedRuleManagement => '允許/封鎖規則管理';

  @override
  String get allowNonExceededNumbers => '允許未超過次數的號碼';

  @override
  String get allowNonExceededNumbersDescription => '自動允許未超過次數限制的號碼';

  @override
  String get allowRegexAllowRules => '允許Regex允許規則';

  @override
  String get allowRegexAllowRulesDesc => '啟用允許規則的Regex模式匹配';

  @override
  String get allowRegexAllowRulesDescription => '啟用基於Regex的允許規則';

  @override
  String get allowRegexBlockRules => '允許Regex封鎖規則';

  @override
  String get allowRegexBlockRulesDesc => '啟用封鎖規則的Regex模式匹配';

  @override
  String get allowRegexBlockRulesDescription => '啟用基於Regex的封鎖規則';

  @override
  String get allowRule => '允許規則';

  @override
  String get allowRules => '允許規則';

  @override
  String get allowWhitelistedNumbers => '允許白名單號碼';

  @override
  String get allowWhitelistedNumbersDescription => '允許白名單中的所有號碼';

  @override
  String get allPermissionsGranted => '已授予所有權限';

  @override
  String get allSettingsCompleted => '所有設定已完成。';

  @override
  String allUpdateSuccess(Object count) {
    return '所有更新已完成（$count 條規則）';
  }

  @override
  String get answerThenHangup => '接聽後掛斷';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. 保留所有權利。';

  @override
  String get applicationSoftware => '應用程式軟體';

  @override
  String get apply => '套用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => '授權失敗：請檢查客戶端 ID 和金鑰';

  @override
  String get authorizationFailedMessage => '授權失敗';

  @override
  String get authorizationSuccessMessage => '授權成功';

  @override
  String get authorizeLoginButton => '授權登入';

  @override
  String get automotiveIndustry => '汽車工業';

  @override
  String get autoSyncLabel => '自動同步';

  @override
  String get autoUpdate => '自動更新';

  @override
  String get autoUpdateDescription => '設定訂閱的自動更新間隔或手動更新';

  @override
  String get autoUpdateSettings => '自動更新設定';

  @override
  String get autoUpdateSettingsSubtitle => '管理規則和外掛程式的自動更新';

  @override
  String get autoUpdateSettingsTitle => '自動更新設定';

  @override
  String get autoUpdateSubtitle => '管理規則和外掛程式的自動更新';

  @override
  String get autoUpdateTitle => '自動更新';

  @override
  String get avatarBorderColor => '頭像邊框顏色';

  @override
  String get avatarBorderSize => '頭像邊框大小';

  @override
  String get avatarIconSizesSetting => '頭像和圖示大小';

  @override
  String get avatarPosition => '頭像位置';

  @override
  String get avatarSize => '頭像大小';

  @override
  String axisPosition(Object axis) {
    return '$axis 位置';
  }

  @override
  String get backgroundGradientSetting => '背景漸層';

  @override
  String get backup => '備份';

  @override
  String get backupAndRestore => '備份和還原';

  @override
  String get backupAndRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupAndRestoreTitle => '備份與還原';

  @override
  String get backupFailed => '備份失敗';

  @override
  String get backupFailedMessage => '備份失敗';

  @override
  String backupFailedWithError(Object error) {
    return '備份失敗：$error';
  }

  @override
  String get backupRestoreSubtitle => '備份或還原應用程式數據';

  @override
  String get backupRestoreTitle => '備份與還原';

  @override
  String get backupSectionTitle => '備份';

  @override
  String get backupSettings => '備份設定';

  @override
  String get backupSettingsDialogTitle => '備份設定';

  @override
  String get backupSettingsTitle => '備份設定';

  @override
  String get backupSuccessMessage => '成功備份到雲端';

  @override
  String backupSuccessToLocal(Object path) {
    return '成功備份到：$path';
  }

  @override
  String get backupToCloud => '備份到雲端';

  @override
  String get backupToCloudDescription => '備份設定和規則到雲端儲存空間';

  @override
  String backupToCloudFailed(Object error) {
    return '備份到雲端失敗：$error';
  }

  @override
  String get backupToCloudLabel => '備份到雲端';

  @override
  String get backupToCloudSuccess => '成功備份到雲端';

  @override
  String get backupToCloudTitle => '備份到雲端';

  @override
  String get backupToLocalLabel => '備份到本地';

  @override
  String get bank => '銀行';

  @override
  String get basicInfo => '基本資訊';

  @override
  String get basicRuleFilter => '基本規則過濾器';

  @override
  String get basicRuleFiltering => '基本規則過濾';

  @override
  String get basicRuleFilteringExplanation => '• 基本規則過濾：基於黑名單、白名單和正則表達式的過濾規則';

  @override
  String get basicRuleFilterSettings => '基本規則過濾器設定';

  @override
  String get basicRuleFilterSubtitle => '使用黑名單/白名單和正則表達式過濾通話';

  @override
  String get batchDeleteContacts => '批量刪除聯絡人';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '您確定要刪除 $count 個選定的聯絡人嗎？';
  }

  @override
  String get batchDeleteFailed => '批量刪除失敗';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '您確定要刪除 $count 個標籤嗎？';
  }

  @override
  String get blacklist => '黑名單';

  @override
  String get blacklistingAndWhitelisting => '黑名單和白名單';

  @override
  String get blacklistLabel => '黑名單';

  @override
  String get blackWhiteList => '黑/白名單';

  @override
  String get block => '封鎖';

  @override
  String get blockCalls => '封鎖通話';

  @override
  String get blocked => '已封鎖';

  @override
  String get blockedCallAction => '封鎖通話動作';

  @override
  String get blockedCalls => '已封鎖的通話';

  @override
  String get blockedCallsTitle => '已封鎖的通話';

  @override
  String get blockedCommunications => '已封鎖的通訊';

  @override
  String get blockedPhoneLabel => '已封鎖的通話';

  @override
  String get blockedSpamCalls => '已封鎖的垃圾電話';

  @override
  String get blockingTrend => '封鎖趨勢';

  @override
  String get blockInternationalCalls => '匹配不以 + 或 00 開頭的號碼';

  @override
  String get blockInternationalCallsTitle => '封鎖國際電話';

  @override
  String get blockLandlineNumbersTitle => '封鎖固網電話號碼';

  @override
  String get blockMobileNumbers => '匹配不以 13-19 開頭的號碼';

  @override
  String get blockMobileNumbersTitle => '封鎖行動電話號碼';

  @override
  String get blockPremiumRateNumbers => '匹配不以 118 或 120-190 開頭的號碼';

  @override
  String get blockPremiumRateNumbersTitle => '封鎖高費率電話號碼';

  @override
  String get blockRule => '封鎖規則';

  @override
  String get blockRules => '封鎖規則';

  @override
  String get blockSpecificAreaCodes => '匹配以 0 + 2-3 位數字開頭的號碼';

  @override
  String get blockSpecificAreaCodesTitle => '封鎖特定區域碼：';

  @override
  String get blockTypeAnalysisTitle => '封鎖類型分析';

  @override
  String get both => '兩者';

  @override
  String get bulkDelete => '批量刪除聯絡人';

  @override
  String get bulkDeleteContacts => '批量刪除聯絡人';

  @override
  String get bulkDeleteLabels => '批量刪除標籤';

  @override
  String get call => '通話';

  @override
  String get callback => '回撥';

  @override
  String callbackTo(String number) {
    return '回撥至 $number';
  }

  @override
  String get callBlocking => '通話封鎖';

  @override
  String get callerIdApp => '來電顯示應用程式';

  @override
  String get callerIdCustomizationTitle => '自訂來電顯示';

  @override
  String get callerIdDialogTitle => '來電顯示資訊';

  @override
  String get callerIdDisplayMode => '來電顯示模式';

  @override
  String callerIdMarkedByCount(Object count) {
    return '被標記 $count 次';
  }

  @override
  String get callerIdPreview => '來電顯示預覽';

  @override
  String get callFilter => '來電過濾';

  @override
  String get callFilterDescription =>
      '啟用後，會根據以下規則列表檢查來電。預設情況下，來電過濾規則不會在裝置之間同步。';

  @override
  String get callFilterRules => '來電過濾規則';

  @override
  String get callFilterRulesDescription => '設定來電過濾的基本規則';

  @override
  String get callFilterSettings => '來電過濾設定';

  @override
  String get callFrequencyInterceptionSubtitle => '設定通話頻率限制和封鎖規則';

  @override
  String get callFrequencyInterceptionTitle => '通話頻率攔截';

  @override
  String get callHistory => '通話記錄';

  @override
  String get callHistoryInfoDesc => '此處顯示您的通話記錄，包括來電、去電和未接來電。';

  @override
  String get callHistoryInfoTitle => '通話記錄';

  @override
  String callHistoryInitFailed(Object error) {
    return '初始化通話記錄失敗：$error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '刷新通話記錄失敗：$error';
  }

  @override
  String get callHistoryTab => '通話記錄';

  @override
  String get callHistoryTimelineEarlier => '更早';

  @override
  String get callHistoryTimelineToday => '今天';

  @override
  String get callHistoryTimelineYesterday => '昨天';

  @override
  String get callScreeningPermission => '來電螢幕畫面權限';

  @override
  String get callScreeningPermissionDescription => '用於篩選和封鎖垃圾電話。';

  @override
  String get callScreeningPermissionNotGranted => '未授予來電螢幕畫面權限，可能會影響應用程式功能。';

  @override
  String get callSettingsSubtitle => '來電顯示、過濾和封鎖設定';

  @override
  String get callSettingsTitle => '通話設定';

  @override
  String get callStatistics => '通話統計';

  @override
  String get callTypeAnswered => '已接聽';

  @override
  String get callTypeBlocked => '已封鎖';

  @override
  String get callTypeIconColor => '通話類型圖示顏色';

  @override
  String get callTypeMissed => '未接來電';

  @override
  String get callTypeOutgoing => '去電';

  @override
  String get callTypePosition => '通話類型位置';

  @override
  String get callTypeUnknown => '未知';

  @override
  String get cancelButton => '取消';

  @override
  String get carRental => '租車';

  @override
  String get carrier => '電信業者';

  @override
  String get carrierColor => '電信業者顏色';

  @override
  String get carrierFontSize => '電信業者字體大小';

  @override
  String get carrierPosition => '電信業者位置';

  @override
  String get changeLabel => '變更標籤';

  @override
  String changePluginStatusFailed(Object error) {
    return '變更外掛程式狀態失敗：$error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '變更訂閱狀態失敗：$error';
  }

  @override
  String get changeTag => '變更標籤';

  @override
  String get charity => '慈善機構';

  @override
  String chartMonthFormat(int month) {
    return '$month 月';
  }

  @override
  String get chartOneDayAgo => '1 天前';

  @override
  String get chartOneMonthAgo => '1 個月前';

  @override
  String get chartOneWeekAgo => '1 週前';

  @override
  String get chartTenDaysAgo => '10 天前';

  @override
  String get chartThreeDaysAgo => '3 天前';

  @override
  String get chartToday => '今天';

  @override
  String get checkFileFormat => '請檢查檔案格式或權限';

  @override
  String checkPermissionFailed(Object error) {
    return '檢查權限失敗: $error';
  }

  @override
  String get chooseDefaultInterceptAction => '選擇預設攔截動作';

  @override
  String get clearAllData => '清除所有資料';

  @override
  String get clearAllDataConfirmation => '確定要清除所有應用程式資料嗎？此操作無法復原。';

  @override
  String get clearAllDataDescription => '清除所有應用程式資料';

  @override
  String get clearAllDataLabel => '清除所有資料';

  @override
  String get clearFilter => '清除篩選器';

  @override
  String get clearLabelFilter => '清除標籤篩選器';

  @override
  String get clearLabelFilterButton => '清除標籤篩選器';

  @override
  String get closeButton => '關閉';

  @override
  String get cloudSync => '雲端同步';

  @override
  String get cloudSyncAndBackupTitle => '雲端同步與備份';

  @override
  String get cloudSyncSettingsSubtitle => '設定 WebDAV、OneDrive 和 Google Drive';

  @override
  String get cloudSyncSettingsTitle => '雲端同步設定';

  @override
  String get cloudSyncTitle => '雲端同步';

  @override
  String get collapseLabelSelector => '摺疊標籤選擇器';

  @override
  String get collection => '催收';

  @override
  String get colorPickerTitle => '選擇顏色';

  @override
  String get configManagement => '配置管理';

  @override
  String get configUpdated => '配置已更新';

  @override
  String get configurationAdvice => '透過適當的配置，您可以為工作和個人 SIM 卡設定不同的過濾策略。';

  @override
  String get configureBackupOptions => '設定備份選項';

  @override
  String get configureBackupOptionsSubtitle => '設定備份選項';

  @override
  String get configureCloudSyncService => '設定雲端同步服務';

  @override
  String get configureCloudSyncServiceHint => '請設定雲端同步服務以啟用多裝置同步。';

  @override
  String get configureCloudSyncServiceMessage => '請設定雲端同步服務以啟用多裝置同步。';

  @override
  String get configureSimCardFilterRules => '設定 SIM 卡過濾規則';

  @override
  String get configureSyncServiceHint => '請先在雲端同步設定中設定同步服務';

  @override
  String get confirm => '確認';

  @override
  String get confirmBatchDeleteContacts => '確定要刪除選取的項目嗎';

  @override
  String get confirmButton => '確認';

  @override
  String get confirmDelete => '確認刪除';

  @override
  String get confirmDeleteContact => '確定要刪除嗎';

  @override
  String get confirmDeleteContactName => '確認刪除？';

  @override
  String get confirmDeleteFilter => '確定要刪除此篩選器嗎？';

  @override
  String confirmDeleteLabel(Object name) {
    return '確定要刪除標籤 \"$name\" 嗎';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '確定要刪除外掛程式 \"$name\" 嗎？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '確定要刪除 $count 個外掛程式嗎？';
  }

  @override
  String get confirmDeleteRuleMessage => '確定要刪除此規則嗎？此操作無法復原。';

  @override
  String get confirmDeleteSelectedContacts => '確定要刪除選取的聯絡人嗎？';

  @override
  String get confirmDeleteSmsFilterRule => '確定要刪除此簡訊過濾規則嗎？';

  @override
  String get confirmDeleteSmsRule => '確定要刪除此簡訊規則嗎？';

  @override
  String get confirmDeleteSubscription => '確定要刪除此訂閱嗎？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '確定要刪除 $name 嗎？';
  }

  @override
  String get confirmPassword => '確認密碼';

  @override
  String get confirmPasswordLabel => '確認密碼';

  @override
  String get connectedStatus => '已連線';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      '連線失敗：請檢查伺服器位址、使用者名稱和密碼';

  @override
  String get connectionFailedMessage => '連線失敗';

  @override
  String get connectionStatusLabel => '連線狀態';

  @override
  String get connectionSuccessMessage => '連線成功';

  @override
  String get contactAddSuccess => '聯絡人新增成功';

  @override
  String get contactDeleted => '聯絡人已刪除';

  @override
  String get contactEditDialog => '編輯聯絡人對話框';

  @override
  String get contactNameHint => '輸入聯絡人姓名 (選填)';

  @override
  String get contactNameLabel => '姓名';

  @override
  String get contactNameOptional => '聯絡人姓名 (選填)';

  @override
  String get contactNotFound => '找不到聯絡人';

  @override
  String get contacts => '聯絡人';

  @override
  String contactsDeleted(Object count) {
    return '已刪除 $count 個聯絡人';
  }

  @override
  String get contactSettingsSubtitle => '聯絡人管理和標籤設定';

  @override
  String get contactSettingsTitle => '聯絡人設定';

  @override
  String contactsLoadingFailed(Object error) {
    return '載入聯絡人失敗: $error';
  }

  @override
  String get contactsManagement => '聯絡人管理';

  @override
  String get contactsManagementPageTitle => '聯絡人管理頁面';

  @override
  String get contactsPageTitle => '聯絡人管理';

  @override
  String get contactsPermission => '聯絡人權限';

  @override
  String get contactsPermissionDescription => '用於識別聯絡人來電。';

  @override
  String get contactsTab => '聯絡人';

  @override
  String get contactSubscriptionDescription =>
      '通過 URL 訂閱聯絡人列表，自動更新聯絡人信息和標籤。支持 JSON 格式數據。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '載入聯絡人訂閱失敗: $error';
  }

  @override
  String get contactSubscriptionPageTitle => '聯絡人訂閱';

  @override
  String get contactUpdateSuccess => '聯絡人更新成功';

  @override
  String get contactUs => '聯絡我們';

  @override
  String get content => '內容';

  @override
  String get contentRegex => '內容正則表達式';

  @override
  String get countColor => '計數顏色';

  @override
  String get countFontSize => '計數字體大小';

  @override
  String get countPosition => '計數位置';

  @override
  String get country => '國家';

  @override
  String get countryNameColor => '國家名稱顏色';

  @override
  String get countryNameFontSize => '國家名稱字體大小';

  @override
  String get countryRegionNamePosition => '國家/地區名稱位置';

  @override
  String get countrySelectionDialog => '國家選擇對話框';

  @override
  String get countrySelectionDialogDescription => '用於選擇國家以查詢來電顯示信息';

  @override
  String get countThresholdDescription => '設置觸發過濾操作所需的最小計數閾值';

  @override
  String get countThresholdLabel => '計數閾值';

  @override
  String get countThresholdSettings => '計數閾值設置';

  @override
  String countThresholdValue(Object count) {
    return '計數閾值: $count';
  }

  @override
  String get createdRules => '已創建規則';

  @override
  String get csvFormat => 'CSV 格式';

  @override
  String get currentDeviceChip => '目前';

  @override
  String get currentDeviceLabel => '當前設備標籤';

  @override
  String get currentDeviceTitle => '當前設備';

  @override
  String get currentLabels => '目前標籤:';

  @override
  String get currentLanguage => '目前語言';

  @override
  String get currentPasswordLabel => '目前密碼';

  @override
  String get customerService => '客戶服務';

  @override
  String get customRange => '自定義範圍';

  @override
  String get dailyStatistics => '每日統計';

  @override
  String get dailyStatisticsDesc => '接收關於封鎖的電話和訊息的每日統計';

  @override
  String get dashboardTab => '儀表板';

  @override
  String get dataAnalysis => '數據分析';

  @override
  String get dataAnalysisDashboardPage => '數據分析儀表板頁面';

  @override
  String get dataExport => '數據匯出';

  @override
  String dataLoadFailure(Object error) {
    return '數據載入失敗：$error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '載入數據失敗：$error';
  }

  @override
  String get dataMigration => '數據遷移';

  @override
  String get dataMigrationDescription =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和恢復功能來手動遷移您的數據。';

  @override
  String get dataMigrationDialogContent =>
      '此功能允許您在設備之間傳輸所有數據。目前，您可以使用備份和恢復功能來手動遷移您的數據。';

  @override
  String get dataMigrationDialogTitle => '數據遷移';

  @override
  String get dataMigrationSectionTitle => '數據遷移';

  @override
  String get dataSourceReminder => '數據源提醒';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
      one: '1 天',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 天 VIP';
  }

  @override
  String get debtCollection => '債務催收';

  @override
  String get defaultPeriod => '週';

  @override
  String get delete => '刪除';

  @override
  String get deleteButton => '刪除';

  @override
  String get deleteContact => '刪除聯絡人';

  @override
  String deleteContactConfirm(Object name) {
    return '您確定要刪除 $name 嗎？';
  }

  @override
  String get deleteContactConfirmation => '您確定要刪除聯絡人';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '您確定要刪除 $deviceName 嗎？';
  }

  @override
  String get deleteDeviceDialogTitle => '刪除裝置';

  @override
  String deleteFailed(Object error) {
    return '刪除失敗：$error';
  }

  @override
  String get deleteFilter => '刪除篩選器';

  @override
  String get deleteLabel => '刪除標籤';

  @override
  String deleteLabelFailed(Object error) {
    return '刪除標籤失敗：$error';
  }

  @override
  String get deletePlugin => '刪除插件';

  @override
  String deletePluginFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deletePlugins => '刪除插件';

  @override
  String deletePluginsFailed(Object error) {
    return '刪除插件失敗：$error';
  }

  @override
  String get deleteRule => '刪除規則';

  @override
  String deleteRuleFailed(Object error) {
    return '刪除失敗：$error';
  }

  @override
  String get deleteSelected => '刪除已選取';

  @override
  String get deleteSmsRule => '刪除 SMS 規則';

  @override
  String get deleteSubscription => '刪除訂閱';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '您確定要刪除訂閱 \"$name\" 嗎？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '刪除訂閱失敗：$error';
  }

  @override
  String get deleteSuccess => '刪除成功';

  @override
  String get delivery => '傳送';

  @override
  String get deviceDeletedSuccessfully => '裝置已成功刪除';

  @override
  String get deviceDeletedSuccessfullyMessage => '裝置已成功刪除';

  @override
  String get deviceIdLabel => '裝置 ID';

  @override
  String get deviceIDLabel => '裝置 ID';

  @override
  String get deviceManagementSubtitle => '管理多裝置同步';

  @override
  String get deviceManagementTitle => '裝置管理';

  @override
  String get deviceModelLabel => '裝置型號';

  @override
  String get deviceName => '裝置名稱';

  @override
  String get deviceNameCannotBeEmpty => '裝置名稱不能為空';

  @override
  String get deviceNameHint => '請輸入裝置名稱';

  @override
  String get deviceNameLabel => '裝置名稱';

  @override
  String get deviceRenamedSuccessfully => '裝置已成功重新命名';

  @override
  String get deviceRenamedSuccessfullyMessage => '裝置已成功重新命名';

  @override
  String get devicesSyncedSuccessfully => '裝置已成功同步';

  @override
  String get devicesSyncedSuccessfullyMessage => '裝置已成功同步';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '裝置已成功同步';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '裝置已成功取消註冊';

  @override
  String get dialogTitle => '正則表達式模式說明';

  @override
  String get differentFromLocalCounter =>
      '此功能與本機計數器過濾器不同，它側重於短時間內重複的呼叫模式，而不是長期標記計數。';

  @override
  String get disabled => '已停用';

  @override
  String get disabledStatus => '已停用';

  @override
  String get disableGlobalPlugins => '停用全局插件';

  @override
  String get disableSubscriptionSuccessfully => '已成功停用訂閱';

  @override
  String get disconnectButton => '斷線';

  @override
  String get disconnectedMessage => '已斷線';

  @override
  String get disconnectedStatus => '已斷線';

  @override
  String get disconnectFailedMessage => '斷線失敗';

  @override
  String get done => '完成';

  @override
  String get dualSimAdvice => '此功能對於雙 SIM 卡手機特別有用，可以為工作和個人 SIM 卡設定不同的過濾策略。';

  @override
  String get earlier => '更早';

  @override
  String get ecommerce => '電子商務';

  @override
  String get edit => '編輯';

  @override
  String get editContact => '編輯聯絡人';

  @override
  String get editFilter => '編輯過濾器';

  @override
  String get editLabel => '編輯標籤';

  @override
  String get editPhoneRule => '編輯電話規則';

  @override
  String get editPhoneRules => '用於編輯電話規則';

  @override
  String get editPhoneRuleTitle => '編輯電話規則';

  @override
  String get editRule => '編輯規則';

  @override
  String get editSmsRule => '編輯簡訊規則';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '元素位置';

  @override
  String get email => '電子郵件';

  @override
  String get emailOptional => '電子郵件 (選填)';

  @override
  String get enableCallFilter => '啟用來電過濾';

  @override
  String get enableCallFilterDescription =>
      '啟用後，將根據下面的規則列表檢查來電。 預設情況下，呼叫過濾規則不會在裝置之間同步。';

  @override
  String get enabled => '已啟用';

  @override
  String get enabledStatus => '已啟用';

  @override
  String get enableEncryption => '啟用加密';

  @override
  String get enableEncryptionDescription => '加密備份檔案';

  @override
  String get enableEncryptionLabel => '啟用加密';

  @override
  String get enableEncryptionSubtitle => '備份檔案將被加密';

  @override
  String get enableEncryptionTitle => '啟用加密';

  @override
  String get enableGlobalPlugins => '啟用全局插件';

  @override
  String get enableLocalCountFilter => '啟用本機計數過濾器';

  @override
  String get enableLocalCountFilterDescription => '根據呼叫標記計數自動過濾垃圾電話';

  @override
  String get enableLocalNotification => '使用本機通知';

  @override
  String get enableLocalNotificationDescription => '啟用後，過濾訊息的通知將顯示在裝置上';

  @override
  String get enableLocationSummary => '位置';

  @override
  String get enableMuteRules => '啟用靜音規則';

  @override
  String get enableMuteRulesDesc => '套用靜音攔截規則配置';

  @override
  String get enableNoneActionRules => '啟用無動作規則';

  @override
  String get enableNoneActionRulesDesc => '允許無攔截動作的規則配置';

  @override
  String get enableNotifications => '啟用通知';

  @override
  String get enableRemoteNumberFilter => '啟用遠端號碼過濾器';

  @override
  String get enableRemoteNumberFilterDescription => '使用遠端資料庫來過濾號碼';

  @override
  String get enableRule => '啟用規則';

  @override
  String get enableSmsFilter => '啟用簡訊過濾';

  @override
  String get enableSmsFilterDescription => '啟用後，訊息將根據規則自動過濾';

  @override
  String get enableStatisticsNotifications => '啟用統計通知';

  @override
  String get enableSubscriptionSuccessfully => '啟用訂閱成功';

  @override
  String get enableTimeInterception => '啟用時間攔截';

  @override
  String get enableTimeInterceptionDescription => '攔截短時間內的重複通話';

  @override
  String get enableTimeInterceptor => '啟用時間攔截器';

  @override
  String get endCallImmediately => '立即結束通話';

  @override
  String get endColor => '結束顏色';

  @override
  String get endDate => '結束日期';

  @override
  String get enhancedFilterInstructionsTitle => '增強型過濾系統';

  @override
  String get enhancedFilterSettings => '增強型過濾設定';

  @override
  String get enhancedFilterSettingsTitle => '增強型過濾設定';

  @override
  String get enhancedFilterSystemDescription => '增強型過濾系統支援全域規則和每張 SIM 卡的過濾配置。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '請同時輸入電話號碼和正則表達式';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => '請同時輸入電話號碼和正則表達式。';

  @override
  String get enterContactName => '請輸入聯絡人姓名';

  @override
  String get enterCurrentPasswordHint => '請輸入當前密碼';

  @override
  String get enterDeviceName => '輸入裝置名稱';

  @override
  String get enterDeviceNameHint => '請輸入裝置名稱';

  @override
  String get enterEmail => '請輸入電子郵件';

  @override
  String get enterEmailOptional => '請輸入電子郵件 (選填)';

  @override
  String get enterEncryptionPasswordHint => '輸入加密密碼';

  @override
  String get enterEncryptionPasswordTitle => '輸入加密密碼';

  @override
  String get enterFilterName => '請輸入過濾器名稱';

  @override
  String get enterFilterPattern => '請輸入過濾模式';

  @override
  String get enterIconCode => '輸入圖示代碼';

  @override
  String get enterName => '輸入聯絡人姓名';

  @override
  String get enterNewDeviceNameHint => '為此裝置輸入一個新名稱';

  @override
  String get enterNewPasswordHint => '請輸入新密碼';

  @override
  String get enterPasswordAgain => '再次輸入密碼';

  @override
  String get enterPasswordHint => '請輸入密碼';

  @override
  String get enterPhoneNumber => '輸入電話號碼';

  @override
  String get enterPhoneNumberHint => '輸入電話號碼進行測試';

  @override
  String get enterPhoneNumberMultiple => '請輸入電話號碼，多個號碼以逗號分隔';

  @override
  String get enterPhoneNumberToStartSearch => '輸入電話號碼以開始搜尋';

  @override
  String get enterPhoneNumberToVerify => '輸入電話號碼以進行驗證';

  @override
  String get enterPluginName => '輸入插件名稱';

  @override
  String get enterPluginUrl => '輸入插件網址';

  @override
  String get enterRegexHint => '輸入正則表達式';

  @override
  String get enterRuleNameAndPattern => '請輸入規則名稱和模式';

  @override
  String get enterRuleNameAndPatternMessage => '請輸入規則名稱和正則表達式。';

  @override
  String get enterRuleNameHint => '輸入規則名稱';

  @override
  String get enterSearchContent => '請輸入搜尋內容';

  @override
  String get enterSubscriptionName => '輸入訂閱名稱';

  @override
  String get enterSubscriptionUrl => '輸入訂閱網址';

  @override
  String get enterSyncFolderNameHint => '請輸入同步資料夾名稱 (預設: NotificationManager)';

  @override
  String get entertainment => '娛樂';

  @override
  String get enterValidNameAndUrl => '請輸入有效的名稱和網址';

  @override
  String get enterValidUrl => '請輸入有效的網址';

  @override
  String get enterVersion => '輸入版本';

  @override
  String get enterWebDAVPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get enterWebDAVServerAddressHint => '請輸入 WebDAV 伺服器位址';

  @override
  String get enterWebDAVUsernameHint => '請輸入 WebDAV 使用者名稱';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '刪除裝置時發生錯誤: $error';
  }

  @override
  String get errorLoadingPlugin => '載入外掛程式時發生錯誤';

  @override
  String errorOccurredMessage(Object error) {
    return '發生錯誤: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '重新命名裝置時發生錯誤: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '同步裝置時發生錯誤: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '同步裝置時發生錯誤: $error';
  }

  @override
  String get errorText => '錯誤';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '取消註冊裝置時發生錯誤: $error';
  }

  @override
  String get exampleBlock400Prefix => '例如，封鎖 400 開頭的號碼';

  @override
  String get exampleBlockMarketingSms => '例如，封鎖行銷簡訊';

  @override
  String get exampleContentRegex => '例如，.*offer.*';

  @override
  String get exampleContentRegexHint => '內容正則表達式範例';

  @override
  String get exampleCouponPromotionDiscount =>
      '例如 .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => '例如，家人、朋友等。';

  @override
  String get examplePhoneNumber => '例如，10086、12345 等。';

  @override
  String get exampleRegex400Prefix => '400 開頭的正則表達式範例';

  @override
  String get exampleRegexFormat => '範例：^10086\$ 格式';

  @override
  String get exampleSenderRegexHint => '範例';

  @override
  String get exchange => '兌換';

  @override
  String get exchangeNow => '立即兌換';

  @override
  String get exchangeVip => '兌換 VIP';

  @override
  String get expandLabelSelector => '展開標籤選擇器';

  @override
  String expiryTime(Object time) {
    return '到期時間：$time';
  }

  @override
  String get export => '匯出';

  @override
  String get exportAllApplicationSettings => '匯出所有應用程式設定';

  @override
  String get exportAllApplicationSettingsSubtitle => '匯出所有應用程式設定';

  @override
  String get exportAllRuleConfigurations => '匯出所有規則設定';

  @override
  String get exportAllRuleConfigurationsSubtitle => '匯出所有規則設定';

  @override
  String get exportComplete => '匯出完成';

  @override
  String get exportConfig => '匯出配置';

  @override
  String get exportContacts => '匯出聯絡人';

  @override
  String get exportData => '匯出資料';

  @override
  String get exportError => '匯出錯誤';

  @override
  String get exportFailed => '匯出失敗';

  @override
  String get exportFailure => '匯出配置失敗';

  @override
  String get exportFeatureComingSoon => '匯出功能即將推出';

  @override
  String get exporting => '匯出中...';

  @override
  String get exportLabels => '匯出標籤';

  @override
  String exportLabelsFailed(Object error) {
    return '匯出標籤失敗：$error';
  }

  @override
  String get exportPluginList => '匯出外掛程式清單';

  @override
  String exportPluginListFailed(Object error) {
    return '匯出外掛程式清單失敗：$error';
  }

  @override
  String get exportRules => '匯出規則';

  @override
  String get exportRulesDialogTitle => '匯出規則';

  @override
  String get exportRulesTitle => '匯出規則';

  @override
  String get exportSmsRules => '匯出簡訊規則';

  @override
  String get exportStatisticsData => '匯出統計資料';

  @override
  String get exportSuccess => '匯出成功';

  @override
  String get exportSuccesslly => '設定檔匯出成功';

  @override
  String get failedToAddContact => '新增聯絡人失敗';

  @override
  String failedToAddRule(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return '新增簡訊規則失敗：$error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return '新增簡訊訂閱失敗：$error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '備份設定失敗：$error';
  }

  @override
  String get failedToDecryptBackupFile => '解密備份檔案失敗';

  @override
  String get failedToDeleteDevice => '刪除裝置失敗';

  @override
  String failedToDeleteSmsRule(Object error) {
    return '刪除簡訊規則失敗：$error';
  }

  @override
  String failedToExportRules(Object error) {
    return '匯出規則失敗：$error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return '匯出簡訊規則失敗：$error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '取得來電顯示資訊失敗：$error';
  }

  @override
  String failedToImportRules(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return '匯入簡訊規則失敗：$error';
  }

  @override
  String get failedToLoadContacts => '載入聯絡人失敗';

  @override
  String get failedToLoadPlugin => '載入外掛程式失敗';

  @override
  String get failedToRenameDevice => '重新命名裝置失敗';

  @override
  String get failedToRestoreSettings => '還原設定失敗';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '還原設定失敗：$error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '設定密碼失敗：$error';
  }

  @override
  String get failedToSyncDevices => '同步裝置失敗';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '切換規則狀態失敗：$error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '切換訂閱狀態失敗';

  @override
  String get failedToUpdateContact => '更新聯絡人失敗';

  @override
  String failedToUpdateSmsRule(Object error) {
    return '更新簡訊規則失敗：$error';
  }

  @override
  String get failure => '失敗';

  @override
  String get favoriteContacts => '我的最愛聯絡人';

  @override
  String get featureAddRules => '• 新增電話號碼特定規則';

  @override
  String get featureCenter => '功能中心';

  @override
  String get featureEnableDisable => '• 啟用/停用每個 SIM 卡的不同篩選器';

  @override
  String get featureListTitle => '功能：';

  @override
  String get featureManageRules => '• 管理每個 SIM 卡的規則清單';

  @override
  String get features => '功能';

  @override
  String get fetchingCallerIdInfo => '正在取得來電顯示資訊...';

  @override
  String fileSavedTo(Object path) {
    return '檔案已儲存至：$path';
  }

  @override
  String get filter => '篩選器';

  @override
  String get filterByLabel => '依標籤篩選';

  @override
  String get filterClear => '清除篩選器';

  @override
  String get filterControlPanelTitle => '篩選器控制面板';

  @override
  String get filterControlSubtitle => '管理所有篩選器的開啟/關閉狀態';

  @override
  String get filterControlTitle => '篩選控制';

  @override
  String get filterDeleteFailed => '篩選器刪除失敗';

  @override
  String get filterDeleteSuccess => '篩選器刪除成功';

  @override
  String get filterDetails => '篩選器詳細資訊';

  @override
  String get filtered => '已篩選';

  @override
  String get filteredSms => '已篩選簡訊';

  @override
  String get filteredSmsLabel => '已篩選簡訊';

  @override
  String get filterExplanation => '篩選器說明';

  @override
  String get filterManagement => '篩選器管理';

  @override
  String get filterName => '篩選器名稱';

  @override
  String get filterPattern => '篩選器模式';

  @override
  String get filterPriorityNote => '注意：篩選器之間存在優先順序關係，詳細資訊請參考說明文件';

  @override
  String get filterSaveFailed => '篩選器儲存失敗';

  @override
  String get filterSaveSuccess => '篩選器儲存成功';

  @override
  String get filterSettings => '篩選器設定';

  @override
  String get filterSettingsTitle => '篩選器設定';

  @override
  String get filterSMS => '篩選簡訊';

  @override
  String get filterToggleInstructions => '啟用或停用此 SIM 卡槽的篩選器：';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status 篩選器：$filterName';
  }

  @override
  String get filterType => '篩選器類型';

  @override
  String get financial => '金融';

  @override
  String get flexibleCombinationFeature => '• 彈性組合：每個 SIM 卡槽啟用/停用篩選器';

  @override
  String get fontSizesSetting => '字體大小';

  @override
  String foundRules(Object count) {
    return '找到 $count 條規則';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '找到 $count 條規則。您要匯入它們嗎？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '找到 $count 條規則。您要匯入它們嗎？';
  }

  @override
  String get fraudAlert => '詐騙警報 - 掛斷電話';

  @override
  String get fraudScamLikely => '詐騙可能性高';

  @override
  String get free => '免費';

  @override
  String get functionSettingsTitle => '功能設定';

  @override
  String generalUpdateFailure(Object error) {
    return '更新失敗：$error';
  }

  @override
  String get getFree => '取得免費';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '設定所有 SIM 卡的全局篩選器：';

  @override
  String get globalFilterFeature => '• 全局篩選器：所有來電的基本規則';

  @override
  String get globalFilterSettings => '全局篩選器設定';

  @override
  String get globalFilterToggleInstructions => '設定適用於所有 SIM 卡槽的全局篩選器設定：';

  @override
  String get globalSearchSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get globalSearchTitle => '全局搜尋';

  @override
  String get globalSettings => '全局設定';

  @override
  String get googleAdDisplayPosition => 'Google 廣告顯示位置';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob 廣告可以整合在此處';

  @override
  String get googleDriveAuthDescription => '使用系統配置的 Google 雲端硬碟客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveAuthorizationHint =>
      '使用系統配置的 Google 雲端硬碟客戶端 ID 和金鑰進行授權';

  @override
  String get googleDriveConfigTitle => 'Google 雲端硬碟配置';

  @override
  String get googleDriveConfigurationTitle => 'Google 雲端硬碟配置';

  @override
  String get government => '政府';

  @override
  String get granted => '已授權';

  @override
  String get grantNecessaryPermissions => '授予必要權限';

  @override
  String get grantPermissions => '授予權限';

  @override
  String get headhunter => '獵人頭';

  @override
  String get height => '身高';

  @override
  String get homePageTitle => '首頁';

  @override
  String get homeTab => '首頁';

  @override
  String get howItWorksPoint1 => '• 系統將自動允許在設定的時間範圍內來自相同號碼的來電';

  @override
  String get howItWorksPoint2 => '• 較短的時間範圍會導致更嚴格的攔截；較長的時間範圍會導致較寬鬆的攔截';

  @override
  String get howItWorksPoint3 => '• 系統會檢查通話記錄以確定是否為重複來電';

  @override
  String get howItWorksTitle => '運作方式：';

  @override
  String get iconCodeOptional => '圖示代碼（選填）';

  @override
  String get iconSize => '圖示大小';

  @override
  String get import => '匯入';

  @override
  String get important => '重要';

  @override
  String get importButton => '匯入';

  @override
  String get importConfig => '匯入設定';

  @override
  String get importContacts => '匯入聯絡人';

  @override
  String get importExportContacts => '匯入/匯出聯絡人';

  @override
  String get importExportContactsTooltip => '匯入/匯出聯絡人';

  @override
  String get importExportRules => '匯入/匯出規則';

  @override
  String importFailed(Object error) {
    return '匯入失敗：$error';
  }

  @override
  String get importFailure => '匯入設定失敗';

  @override
  String get importFeatureComingSoon => '匯入功能即將推出';

  @override
  String get importLabels => '匯入標籤';

  @override
  String importLabelsFailed(Object error) {
    return '匯入標籤失敗：$error';
  }

  @override
  String get importPluginList => '匯入插件列表';

  @override
  String importPluginListFailed(Object error) {
    return '匯入插件列表失敗：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '成功匯入 $count 個插件';
  }

  @override
  String get importRuleConfigurationsFromFile => '從檔案匯入規則設定';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '從檔案匯入規則設定';

  @override
  String get importRules => '匯入規則';

  @override
  String get importRulesButton => '匯入規則';

  @override
  String get importRulesDialogTitle => '匯入規則';

  @override
  String importRulesError(Object error) {
    return '匯入規則失敗：$error';
  }

  @override
  String get importRulesInstructions => '從 CSV 檔案匯入規則';

  @override
  String get importRulesSuccess => '規則匯入成功';

  @override
  String get importRulesTitle => '匯入規則';

  @override
  String get importSuccess => '匯入成功';

  @override
  String get incomingCallInterceptAction => '來電攔截動作';

  @override
  String get incomingCallNotification => '來電通知';

  @override
  String get incorrectPassword => '密碼錯誤';

  @override
  String get initializing => '正在初始化';

  @override
  String get installed => '已安裝';

  @override
  String get insufficientMarks => '分數不足';

  @override
  String get insurance => '保險';

  @override
  String get interceptAction => '攔截動作';

  @override
  String get interceptionActionSettingsSubtitle => '設定如何處理被封鎖的來電';

  @override
  String get interceptionActionSettingsTitle => '攔截動作設定';

  @override
  String get interceptionTimeInterval => '攔截時間間隔';

  @override
  String get internet => '網路';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 更新間隔設定為 $days 天';
  }

  @override
  String get invalidContentRegex => '無效的內容正則表達式';

  @override
  String get invalidLabel => '無效的標籤';

  @override
  String get invalidRegexPattern => '無效的 regex 模式';

  @override
  String get invalidSenderRegex => '無效的發送者 regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '加入 Telegram 頻道和群組以獲取更多資訊';

  @override
  String get jsLogsTitle => 'JS 日誌';

  @override
  String get jsonFormat => 'JSON 格式';

  @override
  String get keepAllVersions => '保留所有版本';

  @override
  String get keepAllVersionsDescription => '保留每個備份的所有歷史版本';

  @override
  String get keepAllVersionsLabel => '保留所有版本';

  @override
  String get keepAllVersionsSubtitle => '保留每個備份的歷史版本';

  @override
  String get keepAllVersionsTitle => '保留所有版本';

  @override
  String get label => '標籤';

  @override
  String labelAddedSuccessfully(Object name) {
    return '標籤 \"$name\" 新增成功';
  }

  @override
  String get labelCategories => '標籤分類';

  @override
  String get labelDeleted => '標籤已刪除';

  @override
  String get labelDescription => '標籤可協助您更好地管理聯絡人，將自訂標籤新增至電話號碼，以便輕鬆識別來電和訊息。';

  @override
  String get labelFilter => '標籤篩選器';

  @override
  String get labelFilterTooltip => '標籤篩選器';

  @override
  String get labelIconColor => '標籤圖示顏色';

  @override
  String get labelManagement => '標籤管理';

  @override
  String get labelNotFound => '找不到標籤';

  @override
  String get labelRemoved => '標籤已移除';

  @override
  String labelRemoveFailed(Object error) {
    return '移除標籤失敗：$error';
  }

  @override
  String get labels => '標籤';

  @override
  String get labelsColor => '標籤顏色';

  @override
  String labelsDeleted(Object count) {
    return '已刪除 $count 個標籤';
  }

  @override
  String get labelsExportedSuccessfully => '標籤匯出成功';

  @override
  String get labelsFontSize => '標籤字體大小';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '成功導入 $count 個標籤';
  }

  @override
  String get labelsPosition => '標籤位置';

  @override
  String labelTag(Object labelId) {
    return '標籤：$labelId';
  }

  @override
  String get labelUpdated => '標籤已更新';

  @override
  String labelUpdateFailed(Object error) {
    return '更新標籤失敗：$error';
  }

  @override
  String get labelUpdateSuccess => '標籤 \"\$labelText\" 更新成功';

  @override
  String get languageSettings => '語言設定';

  @override
  String get languageSettingsSubtitle => '變更應用程式顯示語言';

  @override
  String get languageSettingsTitle => '語言設定';

  @override
  String get last30Days => '最近 30 天';

  @override
  String get last7Days => '最近 7 天';

  @override
  String get lastSyncLabel => '上次同步';

  @override
  String lastUpdated(Object date) {
    return '上次更新時間：$date';
  }

  @override
  String get lifetimeMembership => '終身會員';

  @override
  String get lifetimeMembershipDescription => '一次性購買，永久解鎖所有高級功能和未來更新';

  @override
  String loadContactsFailed(Object error) {
    return '載入聯絡人失敗：$error';
  }

  @override
  String get loadDataFailed => '載入資料失敗';

  @override
  String get loadFailed => '載入失敗';

  @override
  String get loading => '載入中...';

  @override
  String get loadingData => '載入資料中...';

  @override
  String get loadingTags => '載入標籤中...';

  @override
  String loadLabelFailed(Object error) {
    return '載入標籤失敗：$error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '載入標籤失敗: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '載入標記的電話號碼失敗: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '載入標記的電話失敗: $error';
  }

  @override
  String get loadMore => '載入更多';

  @override
  String get loadPluginButton => '載入外掛程式';

  @override
  String loadPluginsFailed(Object error) {
    return '載入外掛程式失敗: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '載入設定失敗: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return '載入簡訊規則失敗: $error';
  }

  @override
  String get loadStatusFailedMessage => '載入狀態失敗';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '載入訂閱項目失敗: $error';
  }

  @override
  String get loan => '貸款';

  @override
  String get localBackupTitle => '本地備份';

  @override
  String get localCounterFilter => '本地計數器過濾器';

  @override
  String get localCounterFilterSubtitle => '根據通話頻率自動過濾垃圾電話';

  @override
  String get localCountFilter => '本地計數過濾器';

  @override
  String get localCountFilterDescription => '根據本地號碼計數攔截頻繁的電話';

  @override
  String get localCountFilterExplanationContent =>
      '本地計數過濾器會分析通話記錄，以自動識別和阻止頻繁的垃圾電話。';

  @override
  String get localCountFilterExplanationTitle => '本地計數過濾器說明';

  @override
  String get localCountFilterHowItWorksPoint1 => '• 確定是否根據號碼的計數值進行阻止';

  @override
  String get localCountFilterHowItWorksPoint2 => '• 當號碼的計數超過設定的閾值時，您可以選擇自動阻止它';

  @override
  String get localCountFilterHowItWorksPoint3 => '• 您可以選擇性地允許不超過閾值的號碼';

  @override
  String get localCountFilterHowItWorksPoint4 => '• 您可以選擇是否記錄所有查詢日誌';

  @override
  String get localCountFiltering => '本地計數過濾';

  @override
  String get localCountFilteringExplanation => '• 本地計數過濾：基於本地標記計數的過濾規則';

  @override
  String get localCountFilterSettings => '本地計數過濾器設定';

  @override
  String get localCountFilterUseCases => '此過濾器特別適合識別自動撥打的垃圾電話和行銷電話。';

  @override
  String get localFilterSettings => '本地過濾器設定';

  @override
  String get localNotificationDisabled => '已停用本地通知';

  @override
  String get localNotificationEnabled => '已啟用本地通知';

  @override
  String get localServices => '本地服務';

  @override
  String get locationColor => '位置顏色';

  @override
  String get locationFontSize => '位置字體大小';

  @override
  String get locationIconColor => '位置圖示顏色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => '記錄所有本地查詢';

  @override
  String get logAllLocalQueriesDescription => '記錄所有本地號碼查詢的日誌';

  @override
  String get logAllRemoteQueries => '記錄所有遠端查詢';

  @override
  String get logAllRemoteQueriesDescription => '記錄所有遠端號碼查詢操作';

  @override
  String get manage => '管理聯絡人';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => '管理我的最愛聯絡人';

  @override
  String get manageFilterRules => '管理過濾規則';

  @override
  String get manageFilterRulesDescription => '新增、編輯或刪除簡訊過濾規則';

  @override
  String get manageFrequentContacts => '管理常用聯絡人';

  @override
  String get markCounts => '標記計數';

  @override
  String get markCount => '標記計數';

  @override
  String markedByCount(Object count) {
    return '被標記 $count 次';
  }

  @override
  String get markedPhonesList => '標記的電話號碼';

  @override
  String get markExchange => '標記交換';

  @override
  String get markPhone => '標記電話號碼';

  @override
  String markPhoneFailed(Object error) {
    return '標記電話號碼失敗：$error';
  }

  @override
  String get markPhoneManagementSubtitle => '標記電話號碼';

  @override
  String get markPhoneManagementTitle => '標記電話管理';

  @override
  String get markPhoneSuccess => '電話號碼標記成功';

  @override
  String get matchFailed => '匹配失敗！';

  @override
  String get matchFailedMessage => '匹配失敗。';

  @override
  String get matchNumbersWithSpecialCharacters => '匹配特定號碼格式';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '匹配包含特殊字元的號碼：';

  @override
  String get matchSpecificDigitPatterns => '匹配 XXX-XXXX-XXXX 格式';

  @override
  String get matchSpecificDigitPatternsTitle => '匹配特定數字模式：';

  @override
  String get matchSuccessful => '匹配成功！';

  @override
  String get matchSuccessfulMessage => '匹配成功！';

  @override
  String get medical => '醫療';

  @override
  String get membershipPrivileges => '會員特權';

  @override
  String get migrationTool => '遷移工具';

  @override
  String get migrationToolTitle => '遷移工具';

  @override
  String get minutes => '分鐘';

  @override
  String get month => '月';

  @override
  String get monthly => '每月';

  @override
  String get monthlyCallCount => '每月通話次數';

  @override
  String get monthlyChartTitle => '每月封鎖的通話';

  @override
  String get monthlyMembership => '每月會員';

  @override
  String get monthlyMembershipDescription => '解鎖所有高級功能，每月自動續訂';

  @override
  String get monthlyTotal => '每月總計';

  @override
  String get monthlyTotalLabel => '每月總計';

  @override
  String get moreOptions => '更多選項';

  @override
  String get mute => '靜音';

  @override
  String get name => '姓名';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '姓名和電話號碼不能為空';

  @override
  String get nameAndPhoneNumberRequired => '姓名和電話號碼不能為空';

  @override
  String get nameColor => '姓名顏色';

  @override
  String get nameFontSize => '姓名字體大小';

  @override
  String nameLabel(Object name) {
    return '姓名：$name';
  }

  @override
  String get namePosition => '姓名位置';

  @override
  String get nameUnknown => '姓名：未知';

  @override
  String nameWithValue(String name) {
    return '姓名：$name';
  }

  @override
  String get newPasswordLabel => '新密碼';

  @override
  String get nextStep => '下一步';

  @override
  String get noAction => '無動作';

  @override
  String get noActionRules => '無動作規則';

  @override
  String get noActiveCloudSyncServiceMessage => '沒有啟用的雲端同步服務';

  @override
  String get noCallLogs => '沒有通話記錄';

  @override
  String get noCallRecords => '沒有通話紀錄';

  @override
  String get noContacts => '還沒有聯絡人';

  @override
  String get noContactsYet => '還沒有聯絡人';

  @override
  String get noData => '沒有資料';

  @override
  String get noDevicesRegisteredMessage => '沒有註冊的裝置';

  @override
  String get noDevicesRegisteredYet => '還沒有註冊的裝置。';

  @override
  String get noFilters => '還沒有篩選器';

  @override
  String get noLabels => '還沒有標籤';

  @override
  String get noMarkedPhones => '沒有標記的電話號碼';

  @override
  String get noMatchingContacts => '沒有符合的聯絡人';

  @override
  String get noMatchingContactsFound => '找不到符合的聯絡人';

  @override
  String get noMatchingNumbersFound => '找不到符合的號碼';

  @override
  String get noMatchingRecords => '沒有符合的通話紀錄';

  @override
  String noMatchingRules(Object ruleType) {
    return '沒有符合的 $ruleType';
  }

  @override
  String get none => '無';

  @override
  String get noneServiceType => '無';

  @override
  String get noPlugins => '尚無外掛程式';

  @override
  String get noRecords => '沒有通話紀錄';

  @override
  String get noResultReturned => '沒有傳回結果';

  @override
  String get noResultReturnedLog => '外掛程式沒有傳回結果';

  @override
  String noRules(Object ruleType) {
    return '尚無 $ruleType';
  }

  @override
  String get noRulesPrompt => '找不到規則，請新增規則';

  @override
  String get noRulesToExport => '沒有要匯出的規則';

  @override
  String get noSmsFilterRulesYet => '尚無簡訊過濾規則';

  @override
  String get noSmsRulesYet => '尚無簡訊規則';

  @override
  String get noSubscriptions => '沒有訂閱項目';

  @override
  String get noSubscriptionsYet => '尚無訂閱項目';

  @override
  String get notGranted => '未授權';

  @override
  String get notificationMode => '通知模式';

  @override
  String get notificationModeDescription => '在通知列中顯示來電者資訊';

  @override
  String get notificationPermission => '通知權限';

  @override
  String get notificationPermissionDescription => '用於顯示來電和訊息通知。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知設定';

  @override
  String get notificationSettingsSaved => '通知設定已成功儲存';

  @override
  String get notSet => '未設定';

  @override
  String get notVerifiedText => '未驗證';

  @override
  String get noValidSmsRulesFoundInFile => '在檔案中找不到有效的簡訊規則';

  @override
  String get number => '號碼';

  @override
  String get numberColor => '號碼顏色';

  @override
  String get numberFontSize => '號碼字體大小';

  @override
  String get numberPosition => '號碼位置';

  @override
  String get numberSearch => '號碼搜尋';

  @override
  String get numberTypeColor => '號碼類型顏色';

  @override
  String get numberTypeFontSize => '號碼類型字體大小';

  @override
  String get numberTypePosition => '號碼類型位置';

  @override
  String get ok => '確定';

  @override
  String get okButton => '確定';

  @override
  String get onboardingCompleteDescription => '您的通話安全管理員已準備就緒，開始享受安全的通話體驗！';

  @override
  String get onboardingLanguageDescription => '選擇您偏好的語言以獲得最佳體驗。';

  @override
  String get onboardingPermissionsDescription => '為了提供完整的服務，我們需要以下權限：';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '一鍵封鎖垃圾電話和訊息，自訂封鎖規則，並為您提供一個安靜的環境。';

  @override
  String get onboardingSmartCallerIdDescription => '自動識別未知來電，標記可疑號碼，並保護您的通話安全。';

  @override
  String get onboardingWelcomeDescription => '您的通話管理專家，提供全面的通話識別和封鎖服務。';

  @override
  String get oneDriveAuthDescription => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveAuthorizationHint => '使用系統配置的 OneDrive 客戶端 ID 和金鑰進行授權';

  @override
  String get oneDriveConfigTitle => 'OneDrive 配置';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 配置';

  @override
  String get onlineCallerIdSubscription => '線上來電顯示訂閱';

  @override
  String get openAppSettings => '開啟應用程式設定';

  @override
  String openAppSettingsFailed(Object error) {
    return '開啟應用程式設定失敗：$error';
  }

  @override
  String operationFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String get operationFailure => '操作失敗';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get other => '其他';

  @override
  String get ourOtherApps => '我們的其他應用程式';

  @override
  String get overlayMode => '懸浮視窗';

  @override
  String get overlayModeDescription => '在懸浮視窗中顯示來電者資訊';

  @override
  String get overlayPermission => '覆蓋權限';

  @override
  String get overlayPermissionDescription => '用於顯示來電覆蓋層。';

  @override
  String get overview => '總覽';

  @override
  String get password => '密碼';

  @override
  String get passwordCannotBeEmpty => '密碼不能為空';

  @override
  String get passwordLabel => '密碼';

  @override
  String get passwordsDoNotMatch => '密碼不符';

  @override
  String get passwordSetSuccessfully => '密碼設定成功';

  @override
  String get pattern => '模式';

  @override
  String get pendingSync => '等待同步';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '週';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '權限請求被拒絕';

  @override
  String get permissionGranted => '權限已授予';

  @override
  String get permissionManagement => '權限管理';

  @override
  String get phoneCallsTab => '電話';

  @override
  String get phoneNumber => '電話號碼';

  @override
  String get phoneNumberCannotBeEmpty => '電話號碼不能為空';

  @override
  String get phoneNumberHint => '輸入電話號碼';

  @override
  String get phoneNumberHintText => '輸入電話號碼以新增規則';

  @override
  String get phoneNumberLabel => '電話號碼';

  @override
  String get phoneNumberRegexRequired => '請輸入電話號碼和正則表達式模式';

  @override
  String get phoneNumberRequired => '電話號碼為必填項';

  @override
  String get phoneNumberTypeFixedLine => '固定電話';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定電話或行動電話';

  @override
  String get phoneNumberTypeMobile => '行動電話';

  @override
  String get phoneNumberTypePager => '呼叫器';

  @override
  String get phoneNumberTypePersonalNumber => '個人號碼';

  @override
  String get phoneNumberTypePremiumRate => '付費電話';

  @override
  String get phoneNumberTypeSharedCost => '分攤費用電話';

  @override
  String get phoneNumberTypeTollFree => '免付費電話';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '未知';

  @override
  String get phoneNumberTypeVoicemail => '語音信箱';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '電話權限';

  @override
  String get phonePermissionDescription => '用於識別和阻止來電。';

  @override
  String get phoneRule => '電話規則';

  @override
  String get phoneRuleEditDialog => '電話規則編輯對話方塊';

  @override
  String get phoneRuleManagement => '電話規則管理';

  @override
  String get phoneRuleSubscription => '電話規則訂閱';

  @override
  String get phoneSubscription => '電話訂閱';

  @override
  String get phoneSubscriptionRulesDescription =>
      '透過網址訂閱電話規則清單，以自動更新白名單和黑名單規則。支援 JSON 格式規則檔案。';

  @override
  String get phoneSubscriptionTitle => '電話規則訂閱';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => '請選擇標籤並輸入有效的電話號碼';

  @override
  String pluginAddedSuccess(Object name) {
    return '外掛程式 \"$name\" 新增成功';
  }

  @override
  String get pluginDeleted => '外掛程式已刪除';

  @override
  String get pluginLatestVersion => '外掛程式已是最新版本';

  @override
  String get pluginListExportSuccess => '外掛程式列表匯出成功';

  @override
  String get pluginLoadedSuccessfully => '外掛程式載入成功';

  @override
  String get pluginManagement => '外掛程式管理';

  @override
  String get pluginManagementSubtitle => '管理和配置第三方外掛程式';

  @override
  String get pluginManagementTitle => '外掛程式管理';

  @override
  String get pluginName => '外掛程式名稱';

  @override
  String get pluginNotLoaded => '外掛程式尚未載入。請先載入外掛程式。';

  @override
  String pluginsDeleted(Object count) {
    return '$count 個外掛程式已成功刪除。';
  }

  @override
  String get pluginService => '外掛程式服務';

  @override
  String get pluginTestPageTitle => '外掛程式測試';

  @override
  String get pluginUpdateSuccess => '外掛程式更新成功';

  @override
  String get pluginUrl => '外掛程式網址';

  @override
  String get pluginUrlCannotBeEmpty => '外掛程式網址不能為空';

  @override
  String get pluginUrlHint => '輸入外掛程式網址';

  @override
  String get pluginUrlLabel => '外掛程式網址';

  @override
  String get pluginVersion => '外掛程式版本';

  @override
  String get political => '政治';

  @override
  String get powerfulSpamBlocking => '強大的垃圾郵件攔截';

  @override
  String get previousStep => '上一步';

  @override
  String get prioritizeRemoteAction => '優先處理遠端操作設定';

  @override
  String get prioritizeRemoteActionDescription => '優先處理來自遠端資料庫的操作設定';

  @override
  String get processing => '處理中...';

  @override
  String get processingOperation => '處理中...';

  @override
  String get purchase => '購買';

  @override
  String get quarterlyMembership => '季度會員';

  @override
  String get quarterlyMembershipDescription => '解鎖所有高級功能，每季自動續訂';

  @override
  String get queryButton => '查詢';

  @override
  String get queryFailed => '查詢失敗';

  @override
  String get queryFailedLog => '查詢失敗';

  @override
  String get querying => '查詢中...';

  @override
  String get queryingPhoneNumber => '正在查詢電話號碼';

  @override
  String get queryResultTitle => '查詢結果';

  @override
  String get ready => '準備就緒！';

  @override
  String get receiveWeeklyStatistics => '接收每週統計資料';

  @override
  String get recruiter => '招聘人員';

  @override
  String get reEnterPasswordHint => '請重新輸入密碼';

  @override
  String get refresh => '重新整理';

  @override
  String get refreshPermissionStatus => '重新整理權限狀態';

  @override
  String get refreshTooltip => '重新整理';

  @override
  String regexError(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex 錯誤：$error';
  }

  @override
  String get regexPattern => '正規表示式';

  @override
  String get regexPatternExplanation => '正規表示式說明';

  @override
  String get regexPatternExplanationButton => '正規表示式說明';

  @override
  String get regexPatternLabel => '正規表示式';

  @override
  String get regexPatternsExamples => '使用標準正規表示式語法來定義模式。範例：';

  @override
  String get regexPatternsForPhoneNumberMatching => '用於電話號碼匹配的正規表示式';

  @override
  String get regexRule => '正規表示式規則';

  @override
  String regexRuleAddFailed(Object error) {
    return '新增正規表示式規則失敗：$error';
  }

  @override
  String get regexRuleAddSuccess => '正規表示式規則新增成功';

  @override
  String get regexRuleManagement => '正規表示式規則管理';

  @override
  String get regexRuleNamePatternRequired => '規則名稱和正規表示式不能為空';

  @override
  String get regexRules => '正規表示式規則';

  @override
  String get regexTesterTitle => '正規表示式測試器';

  @override
  String regexValidationFailed(Object error) {
    return '正規表示式驗證失敗：$error';
  }

  @override
  String get regexValidationSuccess => '正規表示式驗證成功';

  @override
  String get region => '區域';

  @override
  String get registeredDevicesTitle => '已註冊的裝置';

  @override
  String get rejectAllCalls => '拒絕所有來電';

  @override
  String get rejectAllCallsDescription => '啟用後，所有來電都將以最高優先級拒絕';

  @override
  String get rejectAllNumbers => '拒絕所有號碼';

  @override
  String get rejectAllNumbersDesc => '啟用後拒絕所有來電';

  @override
  String get rejectExceededNumbers => '拒絕超出次數的號碼';

  @override
  String get rejectExceededNumbersDescription => '自動拒絕超出次數門檻的號碼';

  @override
  String get remoteFilterSettings => '遠端過濾設定';

  @override
  String get remoteFilterSettingsPageTitle => '遠端號碼過濾設定';

  @override
  String get remoteNumberFilter => '遠端號碼過濾器';

  @override
  String get remoteNumberFilterDatabaseInfo => '此過濾器使用獨立的遠端資料庫來獲取最新的號碼資訊。';

  @override
  String get remoteNumberFilterDescription => '根據遠端資料庫資訊攔截騷擾電話';

  @override
  String get remoteNumberFilterExplanationContent =>
      '遠端號碼過濾器通過查詢基於號碼次數的遠端資料庫來識別和阻止垃圾電話。';

  @override
  String get remoteNumberFilterExplanationTitle => '遠端號碼過濾器說明';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• 次數門檻：根據號碼出現頻率確定';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• 過濾操作：配置如何處理超出門檻的號碼';

  @override
  String get remoteNumberFilterFeaturePriority => '• 優先級設定：設定遠端操作的優先級';

  @override
  String get remoteNumberFilterFeatures => '功能：';

  @override
  String get remoteNumberFiltering => '遠端號碼過濾';

  @override
  String get remoteNumberFilteringExplanation => '• 遠端號碼過濾：基於遠端資料庫資訊的過濾規則';

  @override
  String get remoteNumberFilterSubtitle => '使用雲端資料庫和社群報告識別垃圾電話';

  @override
  String get removeAdsDescription => '永久移除應用程式中的所有廣告，以獲得更流暢的體驗';

  @override
  String get removeAdsTitle => '移除廣告';

  @override
  String get removedFromFavoriteContacts => '已從最愛聯絡人中移除';

  @override
  String get removedFromFavorites => '已從最愛聯絡人中移除';

  @override
  String get removeFavorite => '移除最愛';

  @override
  String get removeFromFavorites => '從最愛中移除';

  @override
  String get renameButton => '重新命名';

  @override
  String get renameDeviceDialogTitle => '重新命名裝置';

  @override
  String get renameDeviceTitle => '重新命名裝置';

  @override
  String get replaceCurrentSettingsConfirmation => '這將取代您目前的所有設定。您確定要繼續嗎？';

  @override
  String get requestAllPermissions => '請求所有權限';

  @override
  String get requestPermission => '請求權限';

  @override
  String requestPermissionFailed(Object error) {
    return '請求權限失敗：$error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 分標記';
  }

  @override
  String get reset => '重設';

  @override
  String get restore => '還原';

  @override
  String get restoreApplicationSettingsFromBackup => '從備份還原應用程式設定';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '從備份還原應用程式設定';

  @override
  String get restoreButton => '還原';

  @override
  String restoreFailedWithError(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloud => '從雲端還原';

  @override
  String get restoreFromCloudDescription => '從雲端儲存空間還原設定和規則';

  @override
  String restoreFromCloudFailed(Object error) {
    return '從雲端還原失敗：$error';
  }

  @override
  String get restoreFromCloudLabel => '從雲端還原';

  @override
  String get restoreFromCloudSuccess => '已成功從雲端還原';

  @override
  String get restoreFromCloudTitle => '從雲端還原';

  @override
  String get restoreFromLocal => '從本機還原';

  @override
  String get restorePurchases => '還原購買';

  @override
  String get restoreSectionTitle => '還原';

  @override
  String get restoreSettings => '還原設定';

  @override
  String get restoreSettingsConfirmation => '這將取代您目前的所有設定。您確定要繼續嗎？';

  @override
  String get restoreSettingsDialogTitle => '還原設定';

  @override
  String get restoreSettingsTitle => '還原設定';

  @override
  String get restoreSuccessFromLocal => '已成功從本機還原';

  @override
  String get restoreSuccessMessage => '已成功從雲端還原';

  @override
  String get retry => '重試';

  @override
  String get ridesharing => '共享乘車';

  @override
  String get risk => '風險';

  @override
  String get robocall => '機器人電話';

  @override
  String get ruleAction => '規則動作';

  @override
  String get ruleAddButton => '新增規則';

  @override
  String get ruleAddedSuccess => '規則已成功新增';

  @override
  String ruleAddFailure(Object error) {
    return '新增規則失敗：$error';
  }

  @override
  String get ruleAddSuccess => '規則已成功新增';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '您確定要刪除此$ruleType嗎？';
  }

  @override
  String get ruleDeleteConfirmTitle => '刪除規則';

  @override
  String get ruleDeletedSuccess => '規則已成功刪除';

  @override
  String get ruleDeletedSuccessfully => '規則已成功刪除';

  @override
  String ruleDeleteFailed(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '刪除規則失敗：$error';
  }

  @override
  String get ruleDeleteSuccess => '規則已成功刪除';

  @override
  String get ruleDisabledSuccessfully => '規則已成功停用';

  @override
  String get ruleEnabledSuccessfully => '規則已成功啟用';

  @override
  String ruleLoadFailed(Object error) {
    return '載入規則失敗：$error';
  }

  @override
  String get ruleManagement => '規則管理';

  @override
  String get ruleManagementTitle => '規則管理';

  @override
  String get ruleName => '規則名稱';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => '規則名稱和內容正則表達式不能為空';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNameHint => '例如，家人、朋友等。';

  @override
  String get ruleNameLabel => '規則名稱';

  @override
  String get ruleNamePatternRequired => '請輸入規則名稱和模式';

  @override
  String get ruleNameRequired => '規則名稱和電話號碼不能為空';

  @override
  String get ruleNotExist => '規則不存在或已被刪除';

  @override
  String ruleNotFound(Object error) {
    return '找不到規則：$error';
  }

  @override
  String get ruleSavedSuccessfully => '規則儲存成功！';

  @override
  String get ruleSavedSuccessMessage => '規則儲存成功！';

  @override
  String ruleSaveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get ruleSaveSuccess => '規則儲存成功！';

  @override
  String get rulesExportedSuccessfully => '規則匯出成功';

  @override
  String rulesExportedTo(Object path) {
    return '規則匯出至：$path';
  }

  @override
  String get rulesImported => '規則匯入成功';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '成功匯入 $count 個規則';
  }

  @override
  String rulesImportFailed(Object error) {
    return '規則匯入失敗：$error';
  }

  @override
  String get ruleStatistics => '規則統計';

  @override
  String ruleStatusChanged(Object status) {
    return '規則 $status 成功';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作失敗：$error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '規則 $status 成功';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String get ruleUpdateSuccess => '規則更新成功';

  @override
  String get ruleVerification => '規則驗證';

  @override
  String get save => '儲存';

  @override
  String get saveButton => '儲存';

  @override
  String get saveButtonLabel => '儲存';

  @override
  String get saveButtonText => '儲存';

  @override
  String saveFailed(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get saveFilter => '儲存過濾器';

  @override
  String get saveSettings => '儲存設定';

  @override
  String saveSettingsFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get scamsLikely => '詐騙可能性高';

  @override
  String get search => '搜尋';

  @override
  String get searchContacts => '搜尋聯絡人';

  @override
  String searchError(Object error) {
    return '搜尋錯誤：$error';
  }

  @override
  String get searchFilters => '搜尋過濾器';

  @override
  String get searchForContacts => '搜尋聯絡人';

  @override
  String get searchHint => '搜尋...';

  @override
  String get searchSettingsSubtitle => '搜尋聯絡人、標籤、黑名單、白名單等';

  @override
  String get searchSettingsTitle => '搜尋設定';

  @override
  String get securityMessage => '不要信任任何電話。請務必獨立驗證客戶服務號碼。切勿分享密碼、驗證碼、卡號或個人資訊。';

  @override
  String get selectActionToPerform => '選擇規則匹配時要執行的操作';

  @override
  String get selectActionWhenBlockingCalls => '選擇封鎖電話時的操作';

  @override
  String get selectActionWhenRuleMatches => '選擇規則匹配時的操作';

  @override
  String get selectAll => '全選';

  @override
  String get selectCountry => '選擇國家';

  @override
  String get selectDateRange => '選擇日期範圍';

  @override
  String get selectedDateRange => '已選日期範圍';

  @override
  String selectedItems(Object count) {
    return '已選取 $count 個項目';
  }

  @override
  String get selectedLabel => '已選擇：';

  @override
  String get selectExportFormat => '選擇匯出格式';

  @override
  String get selectLabel => '選擇標籤';

  @override
  String get selectLabelAndEnterPhoneNumber => '請選擇標籤並輸入有效的電話號碼';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get selectMultiple => '選擇多個';

  @override
  String get selectPeriod => '選擇週期';

  @override
  String get selectSimCard => '選擇 SIM 卡';

  @override
  String get selectSimSlot => '選擇 SIM 卡槽';

  @override
  String get selectSpecificActionForBlockedCalls => '選擇封鎖來電時要執行的特定動作';

  @override
  String get selectTag => '選擇標籤';

  @override
  String get selectTags => '選擇標籤';

  @override
  String get selectTrustedDataSource => '請選擇信任的資料來源';

  @override
  String get selectYourLanguage => '選擇您的語言';

  @override
  String get sender => '寄件者';

  @override
  String get senderRegexOptional => '寄件者正則表達式 (選填)';

  @override
  String get serverAddressLabel => '伺服器位址';

  @override
  String get serviceTypeContact => '聯絡人訂閱';

  @override
  String get serviceTypeLabel => '服務類型';

  @override
  String get serviceTypePhone => '電話訂閱';

  @override
  String get serviceTypePlugin => '外掛程式更新';

  @override
  String get serviceTypeSms => '簡訊訂閱';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '設定';

  @override
  String get setEncryptionPassword => '設定加密密碼';

  @override
  String get setEncryptionPasswordDescription => '設定備份和還原的加密密碼';

  @override
  String get setEncryptionPasswordLabel => '設定加密密碼';

  @override
  String get setEncryptionPasswordTitle => '設定加密密碼';

  @override
  String get setPasswordButton => '設定';

  @override
  String get settings => '設定';

  @override
  String settingsBackedUpTo(Object path) {
    return '設定已備份至：$path';
  }

  @override
  String get settingsLoaded => '設定已載入';

  @override
  String settingsLoadFailed(Object error) {
    return '載入設定失敗：$error';
  }

  @override
  String get settingsRestoredSuccessfully => '設定已成功還原。請重新啟動應用程式以使變更生效。';

  @override
  String get settingsSaved => '設定已儲存';

  @override
  String settingsSaveFailed(Object error) {
    return '儲存設定失敗：$error';
  }

  @override
  String get settingsTab => '設定';

  @override
  String get settingsTitle => '設定';

  @override
  String get setup => '設定';

  @override
  String get showContactEditDialogStaticMethod => '用於顯示聯絡人編輯對話框的靜態方法';

  @override
  String get showExplanation => '顯示說明';

  @override
  String get silence => '靜音';

  @override
  String get silenceAndNoAnswer => '靜音且不接聽';

  @override
  String get silenceNoAnswer => '靜音不接聽';

  @override
  String get silentCallVoiceClone => '靜音通話語音複製';

  @override
  String get silentRules => '靜音規則';

  @override
  String simCard(Object simNumber) {
    return 'SIM 卡 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 卡顏色';

  @override
  String get simCardConfigurationExplanation => '• SIM 卡設定：為每張 SIM 卡設定獨立的過濾規則';

  @override
  String get simCardFilterRules => 'SIM 卡過濾規則';

  @override
  String get simCardFilterRulesDescription => '根據 SIM 卡槽設定不同的過濾規則';

  @override
  String get simCardFontSize => 'SIM 卡字體大小';

  @override
  String get simCardPosition => 'SIM 卡位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM 卡 $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return '載入 SIM 卡資訊失敗：$error';
  }

  @override
  String get simRuleInstructions => 'SIM 卡槽規則允許您為每個 SIM 卡槽配置獨立的過濾規則。';

  @override
  String get simRuleInstructionsTitle => 'SIM 卡槽規則';

  @override
  String get simRuleManagement => 'SIM 卡槽規則管理';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return '載入 SIM 卡資料失敗：$error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM 卡槽過濾器配置';

  @override
  String get simSlotFilterConfigurationDescription => '允許按 SIM 卡槽設定過濾規則';

  @override
  String get simSlotFilterDescription => '為每張 SIM 卡配置獨立的過濾規則：';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber 過濾器設定';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return '載入 SIM 卡槽失敗：$error';
  }

  @override
  String get simSlotManagement => 'SIM 卡槽管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM 卡槽操作失敗：$error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM 卡槽位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM 卡槽規則：每個 SIM 卡獨立的過濾策略';

  @override
  String get simSlotRuleListTitle => 'SIM 卡槽規則列表';

  @override
  String get simSlotRuleManagement => 'SIM 卡槽規則';

  @override
  String get simSlotRuleManagementTitle => '規則管理';

  @override
  String get simSlotSettings => 'SIM 卡槽設定';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM 卡槽 $slotNumber';
  }

  @override
  String get skip => '跳過';

  @override
  String get smartCallerId => '智慧來電顯示';

  @override
  String get sms => '簡訊';

  @override
  String get smsFilterDescription =>
      '簡訊過濾功能可協助您自動過濾垃圾訊息，並保持您的訊息列表乾淨。您可以設定過濾規則和通知方法。';

  @override
  String get smsFilterDisabled => '簡訊過濾已停用';

  @override
  String get smsFilterEnabled => '簡訊過濾已啟用';

  @override
  String get smsFilterRuleAddedSuccessfully => '簡訊過濾規則新增成功';

  @override
  String get smsFilterRules => '簡訊過濾規則';

  @override
  String get smsFilterSettings => '簡訊過濾設定';

  @override
  String get smsHistory => '簡訊歷史記錄';

  @override
  String get smsManagement => '簡訊管理';

  @override
  String get smsPermission => '簡訊權限';

  @override
  String get smsPermissionDescription => '用於過濾垃圾訊息。';

  @override
  String get smsRuleAddedSuccessfully => '簡訊規則新增成功';

  @override
  String get smsRuleDeletedSuccessfully => '簡訊規則刪除成功';

  @override
  String smsRuleLoadFailed(Object error) {
    return '載入簡訊規則失敗：$error';
  }

  @override
  String get smsRuleManagement => '簡訊規則管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return '簡訊規則已成功匯出至 $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => '簡訊規則已成功匯入';

  @override
  String get smsRuleSubscription => '簡訊規則訂閱';

  @override
  String get smsRuleUpdatedSuccessfully => '簡訊規則更新成功';

  @override
  String get smsSettingsSubtitle => '簡訊過濾和關鍵字封鎖';

  @override
  String get smsSettingsTitle => '簡訊設定';

  @override
  String get smsSubscription => '簡訊訂閱';

  @override
  String get smsSubscriptionAddedSuccessfully => '簡訊訂閱新增成功';

  @override
  String get smsSubscriptionRulesDescription =>
      '透過 URL 訂閱簡訊規則列表，支援正規表示式比對。您可以設定封鎖或允許動作。';

  @override
  String get smsTab => '簡訊';

  @override
  String get somePermissionsDenied => '某些權限請求被拒絕';

  @override
  String get spamLikely => '可能是垃圾訊息';

  @override
  String get startColor => '起始顏色';

  @override
  String get startDate => '開始日期';

  @override
  String get startUsing => '開始使用';

  @override
  String get statAnswered => '已接聽';

  @override
  String get statBlocked => '已封鎖';

  @override
  String get staticMethodShowCallerIdDialog => '顯示來電顯示資訊對話框的靜態方法';

  @override
  String get staticMethodToDisplayCountrySelectionDialog => '顯示國家/地區選擇對話框的靜態方法';

  @override
  String get staticMethodToDisplayDialog => '顯示對話框的靜態方法';

  @override
  String get statistics => '統計資料';

  @override
  String get statisticsExportFeatureComingSoon => '統計資料匯出功能即將推出';

  @override
  String get statisticsGrid => '統計資料網格';

  @override
  String get statisticsPageTitle => '資料分析';

  @override
  String get stirColor => 'STIR 顏色';

  @override
  String get stirFontSize => 'STIR 字體大小';

  @override
  String get stirPosition => 'STIR 位置';

  @override
  String get storagePermission => '儲存權限';

  @override
  String get storagePermissionDescription => '用於儲存設定和規則。';

  @override
  String get subscribe => '訂閱';

  @override
  String subscriptionAddSuccess(Object name) {
    return '成功新增訂閱 \"$name\"';
  }

  @override
  String get subscriptionDeleteConfirmContent => '確定要刪除此訂閱嗎？';

  @override
  String get subscriptionDeleteConfirmTitle => '刪除訂閱';

  @override
  String get subscriptionDeleted => '訂閱已刪除';

  @override
  String get subscriptionDeletedSuccessfully => '訂閱已成功刪除';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '刪除訂閱失敗: $error';
  }

  @override
  String get subscriptionDeleteSuccess => '訂閱已刪除';

  @override
  String get subscriptionEmptyState => '沒有可用的訂閱';

  @override
  String get subscriptionEmptyText => '尚無訂閱';

  @override
  String subscriptionLoadFailed(Object error) {
    return '載入訂閱失敗: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '載入訂閱失敗: $error';
  }

  @override
  String get subscriptionManagementTitle => '訂閱管理';

  @override
  String get subscriptionName => '訂閱名稱';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '訂閱名稱和 URL 不可為空';

  @override
  String get subscriptionNameHint => '輸入訂閱名稱';

  @override
  String get subscriptionPageTitle => '訂閱管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '變更訂閱狀態失敗: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '切換訂閱狀態失敗: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '更新訂閱失敗: $error';
  }

  @override
  String get subscriptionUpdateSuccess => '訂閱已成功更新';

  @override
  String get subscriptionUrl => '訂閱 URL';

  @override
  String get subscriptionUrlHint => '輸入訂閱 URL';

  @override
  String successfullyImportedRules(Object count) {
    return '成功匯入 $count 條規則';
  }

  @override
  String get supportSync => '支援同步';

  @override
  String get survey => '調查';

  @override
  String get syncDevicesButton => '同步裝置';

  @override
  String get syncFailed => '同步失敗';

  @override
  String get syncFailedMessage => '同步失敗';

  @override
  String get syncFolderNameHint => '請輸入同步資料夾名稱 (預設值：NotificationManager)';

  @override
  String get syncFolderNameLabel => '同步資料夾名稱';

  @override
  String get synchronized => '已同步';

  @override
  String get syncing => '同步中...';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncStatusTitle => '同步狀態';

  @override
  String get syncStatusUpdatedMessage => '同步狀態已更新';

  @override
  String get syncSuccessful => '同步成功';

  @override
  String get syncSuccessMessage => '同步成功';

  @override
  String get syncWithCloudStorage => '與雲端儲存空間同步';

  @override
  String get syncWithCloudStorageSubtitle => '與雲端儲存空間同步';

  @override
  String get systemFeatures => '系統功能：';

  @override
  String get systemSettingsTitle => '系統設定';

  @override
  String get tabAll => '全部';

  @override
  String get tabAnswered => '已接聽';

  @override
  String get tabBlocked => '已封鎖';

  @override
  String get tabMissed => '未接來電';

  @override
  String get tabOutgoing => '已撥出';

  @override
  String tagLabel(String tag) {
    return '標籤：$tag';
  }

  @override
  String get tagsUpdated => '標籤已更新';

  @override
  String get takeaway => '外賣';

  @override
  String get telecommunication => '電訊';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => '電話行銷';

  @override
  String get testButton => '測試';

  @override
  String get testButtonLabel => '測試';

  @override
  String get testConnectionButton => '測試連線';

  @override
  String get textColorsSetting => '文字和標籤顏色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '此應用程式是一個強大的來電顯示工具，可讓您識別和封鎖不需要的來電。';

  @override
  String get thisWeek => '本週';

  @override
  String get timeInterceptor => '時間攔截器';

  @override
  String get timeInterceptorDescription => '根據通話頻率自動攔截/允許潛在通話';

  @override
  String get timeInterceptorExplanation => '• 時間攔截器：在短時間內攔截/允許重複來電';

  @override
  String get timeInterceptorExplanationContent =>
      '通話頻率攔截功能分析通話頻率，以自動識別和攔截/允許頻繁的垃圾電話。';

  @override
  String get timeInterceptorExplanationTitle => '通話頻率攔截說明';

  @override
  String get timeInterceptorSettingsTitle => '通話頻率攔截設定';

  @override
  String get timeInterceptorSubtitle => '根據通話頻率自動攔截潛在的垃圾電話';

  @override
  String get timeInterceptorTitle => '啟用通話頻率攔截';

  @override
  String get timeWindowDescription => '設定允許重複來電的時間視窗大小。在此視窗內來自相同號碼的來電將被允許';

  @override
  String timeWindowLabel(int minutes) {
    return '攔截時間視窗（分鐘）：$minutes';
  }

  @override
  String get timeWindowSetting => '設定允許重複來電的時間視窗大小。在此視窗內來自相同號碼的來電將被允許';

  @override
  String get today => '今天';

  @override
  String get total => '總計';

  @override
  String get totalBlocked => '總共封鎖';

  @override
  String get totalFiltered => '總共過濾';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '在裝置或平台之間傳輸數據';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => '在裝置或平台之間傳輸數據';

  @override
  String get travelTicketing => '旅遊票務';

  @override
  String get trend => '趨勢';

  @override
  String get trendChart => '趨勢圖';

  @override
  String get tutorial => '教學';

  @override
  String get type => '類型';

  @override
  String get unassignedSIMCard => '未分配的 SIM 卡';

  @override
  String get unknown => '未知';

  @override
  String get unknownLabel => '不明標籤';

  @override
  String get unknownTag => '標籤：不明';

  @override
  String get unregisterButton => '取消註冊';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '您確定要取消註冊 $deviceName 嗎？';
  }

  @override
  String get unregisterDeviceTitle => '取消註冊裝置';

  @override
  String get unsupportedFileFormat => '不支援的檔案格式';

  @override
  String get update => '更新';

  @override
  String get updateAllNow => '立即全部更新';

  @override
  String get updateCallFilterConfig => '更新來電過濾器設定';

  @override
  String updateContactFailed(Object error) {
    return '更新聯絡人失敗：$error';
  }

  @override
  String get updateFavoriteStatus => '更新最愛狀態';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '更新最愛狀態失敗：$error';
  }

  @override
  String get updateInterval => '更新間隔';

  @override
  String get updateLabelFailed => '更新標籤失敗';

  @override
  String get updateNow => '立即更新';

  @override
  String get updatePlugin => '更新插件';

  @override
  String updatePluginFailed(Object error) {
    return '更新插件失敗：$error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '更新規則失敗：$error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '更新訂閱失敗：$error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service 成功更新（$count 條規則）';
  }

  @override
  String get updateTags => '更新標籤';

  @override
  String get useCasesPoint1 => '• 識別自動重撥垃圾電話';

  @override
  String get useCasesPoint2 => '• 攔截在短時間內多次撥打的行銷電話';

  @override
  String get useCasesPoint3 => '• 防止電話轟炸和騷擾';

  @override
  String get useCasesTitle => '使用案例：';

  @override
  String get useGlobalSettings => '使用全域設定';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '使用者名稱';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '使用標準正則表達式語法來定義模式。範例：';

  @override
  String get validateRegex => '驗證正則表達式';

  @override
  String get verificationFailedText => '失敗';

  @override
  String get verifiedText => '已驗證';

  @override
  String get verify => '驗證';

  @override
  String version(Object version) {
    return '版本：$version';
  }

  @override
  String get vipExchangeDescription => '用電話號碼標記數量交換 VIP 會員資格';

  @override
  String get vipExchangeTitle => '標記交換 VIP';

  @override
  String get watchAd => '觀看廣告';

  @override
  String get watchAdForTemp => '觀看廣告以獲得臨時權限';

  @override
  String get watchAdForTempDescription => '觀看短片廣告以暫時解鎖一些高級功能';

  @override
  String get webDAVConfigTitle => 'WebDAV 設定';

  @override
  String get webdavConfigurationTitle => 'WebDAV 設定';

  @override
  String get webdavPasswordHint => '請輸入 WebDAV 密碼';

  @override
  String get webdavServerAddressHint => '請輸入 WebDAV 伺服器位址';

  @override
  String get webdavUsernameHint => '請輸入 WebDAV 使用者名稱';

  @override
  String get week => '週';

  @override
  String get weekly => '每週';

  @override
  String get weeklyBlockedCallsSummary => '每週封鎖的電話摘要';

  @override
  String get weeklyChartTitle => '每週封鎖的電話';

  @override
  String get weeklyReport => '每週報告';

  @override
  String get weeklyReportDesc => '接收來電封鎖活動的每週摘要報告';

  @override
  String get welcome => '歡迎';

  @override
  String get whitelist => '白名單';

  @override
  String get whitelistLabel => '白名單';

  @override
  String get width => '寬度';

  @override
  String get wildcardMatchingDescription =>
      '使用 \'.\' 匹配任何字元 (例如 \'123.456\' 匹配 123-456)';

  @override
  String get wildcardMatchingTitle => '萬用字元匹配:';

  @override
  String get wildcardSupportForFlexibleFiltering => '萬用字元支援彈性過濾';

  @override
  String get windowSizeSetting => '視窗大小';

  @override
  String get year => '年';

  @override
  String get yearly => '每年';

  @override
  String get yearlyChartTitle => '年度封鎖來電';

  @override
  String get noSimCardsDetected => '未偵測到 SIM 卡';

  @override
  String get filterManagementDescription => '設定來電過濾器';

  @override
  String get callerIdCustomizationSubtitle => '自訂來電顯示版面';

  @override
  String get fraudAlerSettingTitle => '詐騙警報設定';

  @override
  String get fraudAlerSettingSubtitle => '設定詐騙警報';

  @override
  String get enableFraudAlert => '啟用詐騙警報';

  @override
  String get enableFraudAlertDescription => '可疑詐騙電話的警報';

  @override
  String get enableVibration => '啟用震動';

  @override
  String get enableVibrationDescription => '當來電疑似詐騙電話時震動';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get useLocalNotification => '使用本地通知';

  @override
  String get useLocalNotificationDescription => '啟用來電的本地通知';

  @override
  String get cancelLocalNotification => '關閉本地通知';

  @override
  String get useStirNotification => '使用來自 STIR 的通知';

  @override
  String get useStirNotificationDescription => '啟用 STIR 通知來電';

  @override
  String get cancelLocalNotificationDescription => '自動關閉本地通知';

  @override
  String get callerIdSettingsTitle => '來電顯示設定';

  @override
  String get callerIdSettingsSubtitle => '設定來電通知與顯示模式';

  @override
  String get purchaseTitle => '購買';

  @override
  String get purchaseSubtitle => '購買服務';

  @override
  String get callerIdNotificationTitle => '來電資訊';

  @override
  String callerIdBody(String phoneNumber) {
    return '號碼: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '已封鎖來電';

  @override
  String blockedCallBody(String phoneNumber) {
    return '已封鎖來自 $phoneNumber 的來電';
  }

  @override
  String get stirVerified => '已驗證';

  @override
  String get stirNotVerified => '未驗證';

  @override
  String get stirFailed => '驗證失敗';

  @override
  String get stirUnknown => '未知驗證狀態';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 驗證';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '號碼 $phoneNumber 的 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '滾動安全訊息設定';

  @override
  String get messageColor => '訊息顏色';

  @override
  String get messageFontSize => '訊息字體大小';

  @override
  String get messagePosition => '訊息位置';

  @override
  String get containerWidth => '容器寬度';

  @override
  String get scrollSpeed => '滾動速度';

  @override
  String get enableSecurityMessage => '啟用安全訊息';

  @override
  String get fraudAlertTitle => '詐騙警報';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '來自 $phoneNumber 的潛在詐騙電話';
  }

  @override
  String loadRulesFailed(Object error) {
    return '載入規則失敗: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '載入通話記錄失敗: $error';
  }

  @override
  String get noBlockedTypeData => '沒有可用的封鎖類型資料';

  @override
  String importEntity(Object entityTypeName) {
    return '匯入 $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName 匯入成功，總共匯入 $count 筆記錄';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '匯入 $entityTypeName 失敗: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '匯出 $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName 匯出成功';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '匯出 $entityTypeName 失敗: $error';
  }

  @override
  String get cloudSyncService => '雲端同步服務';

  @override
  String get membershipCenter => '會員中心';

  @override
  String get redeemVipWithMarks => '使用 Marks 兌換 VIP';

  @override
  String get currentMarkCount => '目前 Mark 數量';

  @override
  String get markMoreNumbersForMore => '標記更多號碼以獲得更多 marks';

  @override
  String get noAds => '無廣告';

  @override
  String get cloudBackup => '雲端備份';

  @override
  String get callerIdEnhancement => '來電顯示增強';

  @override
  String get voiceRecognition => '語音辨識';

  @override
  String get feature => '功能';

  @override
  String get normalUser => '一般使用者';

  @override
  String get vipUser => 'VIP 使用者';

  @override
  String get temporaryVip => '臨時 VIP';

  @override
  String get removeAds => '移除廣告';

  @override
  String get unknownAction => '不明動作';

  @override
  String get settingsBackup => '設定備份';

  @override
  String get allServicesStatusTitle => '目前服務狀態';

  @override
  String get allServicesStatusSubtitle => '各雲端服務的目前狀態';

  @override
  String get redirect => '重新導向';

  @override
  String get notify => '通知';

  @override
  String get log => '日誌';

  @override
  String get custom => '自訂';

  @override
  String get allowActionDescription => '即使號碼在封鎖清單上，也允許通話。';

  @override
  String get blockActionDescription => '通話將被封鎖並顯示在通話記錄中。';

  @override
  String get silenceActionDescription => '通話將被靜音，但顯示在通話記錄中。';

  @override
  String get noneActionDescription => '不會對通話採取任何特殊動作。';

  @override
  String get redirectActionDescription => '將通話重新導向到指定的號碼。';

  @override
  String get labelActionDescription => '為通話新增標籤，以便輕鬆識別。';

  @override
  String get notifyActionDescription => '收到通話時傳送通知。';

  @override
  String get logActionDescription => '記錄通話資訊，不採取任何其他動作。';

  @override
  String get customActionDescription => '執行自訂動作。';

  @override
  String get synced => '已同步';

  @override
  String get needVipAccess => '您需要 VIP 權限才能使用此功能';

  @override
  String importExportDescription(Object entityTypeName) {
    return '匯入或匯出 $entityTypeName 資料';
  }

  @override
  String get importExportTitle => '匯入/匯出';

  @override
  String get noPhoneRules => '找不到電話規則';

  @override
  String get noRegexRules => '找不到正則表達式規則';

  @override
  String get noAllowedBlockedRules => '找不到允許/封鎖規則';

  @override
  String get importExport => '匯入/匯出';

  @override
  String get filterByAction => '依動作篩選';

  @override
  String get upgradeToVip => '升級到 VIP';

  @override
  String get batteryOptimizationPermission => '電池優化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '允許應用程式在背景執行，以提供來電顯示等服務。';

  @override
  String get permissionTitle => '特殊權限';

  @override
  String get permissionSubtitle => '管理覆蓋層和電池優化權限';

  @override
  String get themeSettingsTitle => '主題設定';

  @override
  String get themeSettingsSubtitle => '選擇您喜歡的主題';

  @override
  String get databaseSyncTitle => '資料庫同步';

  @override
  String get countrySyncSettingsTitle => '基於國家/地區的資料庫同步設定';

  @override
  String get countrySyncSettingsSubtitle => '選擇用於資料同步的國家/地區';

  @override
  String get countryDataDisclaimer => '請注意：資料庫可能不包含所有特定國家或地區的資料。';

  @override
  String get editSubscription => '編輯訂閱';

  @override
  String get searchByNameOrPhoneNumber => '依姓名或電話號碼搜尋';

  @override
  String get allowedBlockedRulesInfo => '允許/封鎖規則用於將來電與特定電話號碼匹配，具有最高優先級。';

  @override
  String get searchPhoneRulesHint => '搜尋電話規則';

  @override
  String get phoneRulesInfo => '電話規則用於將來電與特定電話號碼匹配，具有較低的優先級。有些來自 phoneRule 訂閱';

  @override
  String get searchSubscriptionsHint => '搜尋訂閱';

  @override
  String get searchPluginsHint => '搜尋外掛程式';

  @override
  String get searchLabelsHint => '搜尋標籤';

  @override
  String get pluginDescription => '外掛程式描述';

  @override
  String get enterPluginDescription => '輸入外掛程式描述';

  @override
  String get searchRegexRulesHint => '搜尋正則表達式規則';

  @override
  String get regexRulesInfo => '正則表達式規則用於基於正則表達式模式過濾來電。';

  @override
  String get searchMarkedPhonesHint => '搜尋已標記的電話';

  @override
  String get searchContactSubscriptionsHint => '搜尋聯絡人訂閱';

  @override
  String get showAllContacts => '顯示所有聯絡人';

  @override
  String get showFavorites => '顯示我的最愛';

  @override
  String get manualEntry => '手動輸入資訊';

  @override
  String get scriptSaved => '腳本已儲存';

  @override
  String editScriptFor(String pluginName) {
    return '編輯 $pluginName 的腳本';
  }

  @override
  String get saveScript => '儲存腳本';

  @override
  String get testPlugin => '測試外掛程式';

  @override
  String get description => '描述';

  @override
  String get accessTargetUrl => '存取目標 URL';

  @override
  String get result => '結果';

  @override
  String get editScript => '編輯腳本';

  @override
  String get numberFormat => '號碼格式';

  @override
  String get nationalNumber => '國內號碼';

  @override
  String get e164Number => 'E164 號碼';

  @override
  String get pluginRulesInfo =>
      '為了安全起見，請僅使用來自受信任來源的外掛程式。 隨時使用我們的範本來創建您自己的自定義外掛程式！';

  @override
  String get advancedMode => '進階模式';

  @override
  String get pleaseEnterAtLeastOneNumber => '請至少輸入一個號碼。';

  @override
  String get openInWebView => '在 WebView 中開啟';

  @override
  String get pluginLabel => '外掛程式標籤';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '訊息背景顏色';

  @override
  String get clearAllCallLogs => '清除所有通話記錄';

  @override
  String get clearAllCallLogsConfirmation => '確認清除所有通話記錄';

  @override
  String get allCallLogsCleared => '所有通話記錄已清除';

  @override
  String get unblocked => '已解除封鎖';

  @override
  String get blockNumber => '封鎖號碼';

  @override
  String get blockNumberSuccess => '封鎖號碼成功';

  @override
  String get blockNumberFailed => '封鎖號碼失敗';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '您確定要解除封鎖 $phoneNumber 嗎？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '正在撥打 $phoneNumber...';
  }

  @override
  String get viewDetails => '查看詳情';

  @override
  String get unblock => '解除封鎖';

  @override
  String get unblockNumber => '解除封鎖號碼';

  @override
  String get unblockNumberSuccess => '號碼已成功解除封鎖';

  @override
  String get unblockNumberFailed => '解除封鎖號碼失敗';

  @override
  String get serviceNotAvailable => '服務不可用';

  @override
  String get callingNumberFailed => '撥打號碼失敗';

  @override
  String get listView => '列表檢視';

  @override
  String get timelineView => '時間軸檢視';

  @override
  String get nameCannotBeEmpty => '名稱不能為空';

  @override
  String get selectAction => '選擇操作';

  @override
  String get selectTargetService => '選擇目標服務';

  @override
  String get callDetails => '通話詳情';

  @override
  String get callType => '通話類型';

  @override
  String get callTime => '通話時間';

  @override
  String get numberInvalidFormat => '號碼格式無效';

  @override
  String get membershipFeature => '會員功能';

  @override
  String get medium => '媒介';

  @override
  String get verificationReport => '驗證報告';

  @override
  String get finalRisk => '最終風險';

  @override
  String get simState => 'SIM 卡狀態';

  @override
  String get ipCountry => 'IP 國家';

  @override
  String get simCountry => 'SIM 卡國家';

  @override
  String get isRoaming => '漫遊';

  @override
  String get isNumberMatch => '號碼匹配';

  @override
  String get support => '支援';

  @override
  String get rewardedAdService => '獎勵廣告服務';

  @override
  String get hasVipPrivilegeExceptAds => '您已經擁有 VIP 權限（廣告除外）';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '您已經擁有臨時權限，到期日：$expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '您需要觀看多 $count 個廣告才能獲得臨時 VIP 權限';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '您已被授予 $days 天的臨時購買權限。到期日：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '臨時購買權限已過期';

  @override
  String get loadingAd => '正在載入廣告...';

  @override
  String get earnedTempVip => '獲得臨時 VIP';

  @override
  String get vipExchangeService => 'VIP 兌換服務';

  @override
  String get marksInsufficient => '兌換分數不足';

  @override
  String get invalidExchangeRule => '無效的兌換規則';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '成功兌換 $description，到期日：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '兌換失敗：$error';
  }

  @override
  String get vip3DaysWithAds => '3 天 VIP（含廣告，僅同步）';

  @override
  String get vip5DaysNoAds => '5 天完整功能無廣告 VIP';

  @override
  String get vip7DaysNoAds => '7 天完整功能無廣告 VIP';

  @override
  String get noNotifications => '沒有通知';

  @override
  String get clearAllNotifications => '清除所有通知';

  @override
  String get clearAllNotificationsConfirmation => '確認清除所有通知';

  @override
  String get allNotificationsCleared => '所有通知已清除';

  @override
  String get clearButton => '清除';

  @override
  String get justNow => '剛剛';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分鐘前',
      one: '1 分鐘前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小時前',
      one: '1 小時前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天前',
      one: '1 天前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨天';

  @override
  String get deletionProposal => '刪除提案';

  @override
  String get deletionProposals => '刪除提案';

  @override
  String get createProposal => '建立提案';

  @override
  String get createProposalTitle => '建立刪除提案';

  @override
  String get reason => '原因';

  @override
  String get reasonOutdated => '過時的號碼';

  @override
  String get reasonPrivacy => '隱私問題';

  @override
  String get reasonNotInService => '停止服務';

  @override
  String get reasonWronglyIdentified => '錯誤識別';

  @override
  String get reasonInaccurateInfo => '資訊不正確';

  @override
  String get reasonWrongMarked => '錯誤標記';

  @override
  String get reasonOther => '其他';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get proposalStatus => '狀態';

  @override
  String get statusPending => '待定';

  @override
  String get statusActive => '啟用';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusExpired => '已過期';

  @override
  String get riskLevel => '風險等級';

  @override
  String get riskLevelVerified => '已驗證';

  @override
  String get riskLevelLow => '低';

  @override
  String get riskLevelHigh => '高';

  @override
  String get riskLevelUnknown => '未知';

  @override
  String get votingProgress => '投票進度';

  @override
  String agreeVotes(int count) {
    return '贊成: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反對: $count';
  }

  @override
  String totalVotes(int count) {
    return '總計: $count';
  }

  @override
  String get voteAgree => '贊成';

  @override
  String get voteDisagree => '反對';

  @override
  String createdAt(String date) {
    return '建立於: $date';
  }

  @override
  String get showReport => '顯示報告';

  @override
  String get hideReport => '隱藏報告';

  @override
  String get proposalStatistics => '提案統計';

  @override
  String get totalProposals => '提案總數';

  @override
  String get activeProposals => '啟用提案';

  @override
  String get completedProposals => '已完成提案';

  @override
  String get myVotes => '我的投票';

  @override
  String get proposalCreated => '提案建立成功';

  @override
  String get proposalCreateFailed => '提案建立失敗';

  @override
  String get voteSubmitted => '投票提交成功';

  @override
  String get voteSubmitFailed => '投票提交失敗';

  @override
  String get noProposalsFound => '找不到提案';

  @override
  String get loadingProposals => '載入提案中...';

  @override
  String get refreshProposals => '重新整理提案';

  @override
  String get totalPendingProposals => '待處理提案總數';

  @override
  String get highRisk => '高風險';

  @override
  String get mediumRisk => '中風險';

  @override
  String get lowRisk => '低風險';

  @override
  String get communityImpact => '社群影響力';

  @override
  String get criticalIssues => '重大問題';

  @override
  String get communityParticipation => '社群參與度';

  @override
  String get noActivity => '無活動';

  @override
  String get low => '低';

  @override
  String get moderate => '中等';

  @override
  String get high => '高';

  @override
  String get veryHigh => '非常高';

  @override
  String get voted => '已投票';

  @override
  String get communityVotes => '社群投票';

  @override
  String get waitingForMoreVotes => '等待更多社群投票';

  @override
  String get proposalProcessed => '此提案已處理';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反對';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒絕';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待定';

  @override
  String get critical => ' критический';

  @override
  String get oppose => '反對';

  @override
  String get veryLow => '非常低';

  @override
  String get deletionProposalNotificationDescription => '關於刪除提案投票結果和更新的通知。';

  @override
  String get deletionProposalCreated => '已建立刪除提案';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '您針對 $phoneNumber 提出的刪除提案已提交供社群審核。';
  }

  @override
  String get proposalApproved => '提案已批准 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '針對 $phoneNumber 的刪除提案已獲得社群批准（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get proposalRejected => '提案已拒絕 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '針對 $phoneNumber 的刪除提案已被社群拒絕（$supportPercentage% 支持，$totalVotes 票）。';
  }

  @override
  String get communityVotingStarted => '社群投票已開始';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '針對 $phoneNumber 的新刪除提案現已開放社群投票。';
  }

  @override
  String get votingCompleted => '投票已完成';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '針對 $phoneNumber 的社群投票已結束。結果：$result（$supportPercentage% 支持）。';
  }

  @override
  String get newVoteReceived => '收到新投票';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '有人投票$voteType刪除 $phoneNumber。目前投票數：$totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '載入投票數失敗';

  @override
  String get voteCount => '投票數';

  @override
  String get deletionProposalInfo => '刪除提案資訊';

  @override
  String get deletionProposalDescription => '提議刪除違反社群規範的號碼。您的參與有助於確保平台安全。';

  @override
  String get voteToEarnVip => '對提案進行投票以賺取 VIP 權限！';

  @override
  String get voteFailed => '投票失敗';

  @override
  String get searchProposals => '搜尋提案';

  @override
  String get defaultNotifications => '預設通知';

  @override
  String get defaultNotificationsDescription => '應用程式的預設通知頻道。';

  @override
  String get blockedCallNotifications => '封鎖的來電通知';

  @override
  String get blockedCallNotificationsDescription => '顯示關於封鎖來電的資訊。';

  @override
  String get stirVerification => 'STIR/SHAKEN 驗證';

  @override
  String get stirVerificationDescription => '顯示號碼的 STIR/SHAKEN 驗證結果。';

  @override
  String get fraudAlerts => '詐騙警報';

  @override
  String get fraudAlertsDescription => '顯示潛在詐騙電話的警告。';

  @override
  String get notificationFrequencyDescription =>
      '選擇您接收關於新刪除建議的通知頻率。您可以立即、批量或自訂間隔接收它們。';

  @override
  String get immediateNotifications => '立即';

  @override
  String get immediateNotificationsDescription => '在建立提案後立即收到通知。';

  @override
  String get batchNotifications => '分批';

  @override
  String get batchNotificationsDescription => '定期收到通知摘要。';

  @override
  String get customNotifications => '自訂';

  @override
  String get customNotificationsDescription => '定義您自己的間隔以接收通知。';

  @override
  String get customFrequency => '自訂頻率';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分鐘';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 小時';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 小時 $minutes 分鐘';
  }

  @override
  String get pendingProposals => '待處理的提案';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個待處理的提案',
      one: '1 個待處理的提案',
      zero: '沒有待處理的提案',
    );
    return '您有 $_temp0。';
  }

  @override
  String get guidelinesLabel => '指南';

  @override
  String get reportingGuidelines =>
      '• 僅舉報真正有問題的號碼\n• 提供準確且詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelLabel => '風險級別';

  @override
  String get riskLevelDescription => '號碼的風險級別';

  @override
  String get phoneNumberMinDigits => '電話號碼必須至少包含 7 位數字';

  @override
  String get provideDetailedExplanation => '提供詳細的解釋（至少 10 個字元）';

  @override
  String get reasonMinCharacters => '原因必須至少包含 10 個字元';

  @override
  String get countryCodeTwoLetters => '國家代碼（ISO 3166-1 alpha-2）*';

  @override
  String get countryCodeLabel => '國家代碼（ISO 3166-1 alpha-2）*';

  @override
  String get countryCodeHint => '例如：US, CN, GB';

  @override
  String get countryCodeRequired => '需要國家代碼';

  @override
  String get countryCodeLengthError => '國家代碼必須為 2 個字母';

  @override
  String get phoneNumberLengthError => '電話號碼必須至少包含 7 位數字';

  @override
  String get reasonHint => '提供詳細的解釋（至少 10 個字元）';

  @override
  String get reasonRequired => '需要原因';

  @override
  String get reasonLengthError => '原因必須至少包含 10 個字元';

  @override
  String get guidelinesTitle => '指南';

  @override
  String get guidelinesText =>
      '• 僅舉報真正有問題的號碼\n• 提供準確且詳細的原因\n• 根據嚴重程度選擇適當的風險級別\n• 虛假舉報可能會導致帳戶限制';

  @override
  String get riskLevelCritical => '危急';

  @override
  String get riskLevelMedium => '中等';

  @override
  String get riskLevelVeryLow => '非常低';

  @override
  String get riskDescriptionVeryLow => '非常低 - 輕微煩擾，不頻繁的電話';

  @override
  String get riskDescriptionLow => '低 - 偶爾不需要的電話';

  @override
  String get riskDescriptionMedium => '中等 - 定期的垃圾郵件或電話行銷';

  @override
  String get riskDescriptionHigh => '高 - 持續的騷擾或詐騙企圖';

  @override
  String get riskDescriptionCritical => '危急 - 危險的詐騙或威脅';

  @override
  String get notificationFrequencyTitle => '通知頻率';

  @override
  String get notificationFrequencyLabel => '通知頻率（小時）';

  @override
  String errorMessage(String error) {
    return '錯誤：$error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票：$totalVotes（$supportPercentage% 支持）';
  }

  @override
  String supportCount(int supportCount) {
    return '支持（$supportCount）';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反對（$opposeCount）';
  }

  @override
  String get timeJustNow => '剛剛';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes 分鐘前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours 小時前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days 天前';
  }

  @override
  String get notificationFrequencyHours => '通知頻率（小時）';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票 ($supportPercentage% 支持)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小時',
      one: '1 小時',
      zero: '0 小時',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要通知';

  @override
  String get dataSourceDisclaimer =>
      '數字來自網路和用戶提交。 我們無法保證刪除的號碼不會被其他用戶或來源重新提交。 請主動搜索和驗證信息。';

  @override
  String get avatar => '頭像';

  @override
  String get location => '位置';

  @override
  String get simCardTitle => 'SIM 卡';

  @override
  String get liveActivitiesSettingsTitle => '即時活動設定';

  @override
  String get elementsSettingsTitle => '元素設定';

  @override
  String get liveActivityMode => '即時活動';

  @override
  String get liveActivityModeDescription => '在鎖定螢幕和動態島（iOS）上將通話資訊顯示為持續性通知。';

  @override
  String get phoneNumberType => '電話號碼類型';

  @override
  String get liveActivitiesTestEndActivity => '結束活動';

  @override
  String get liveActivitiesTestSendNewActivity => '發送新活動';

  @override
  String get liveActivitiesTestUpdateActivity => '更新活動';

  @override
  String get liveActivityControlsTitle => '即時活動控制';

  @override
  String get liveActivitiesTestTitle => '即時活動測試';

  @override
  String get liveActivitiesTestSubtitle => '測試即時活動通知。';

  @override
  String get liveNotificationCustomizationTitle => '即時通知自訂';

  @override
  String get liveNotificationCustomizationSubtitle => '自訂即時通知的外觀。';

  @override
  String get notification_instructions =>
      '操作說明：\n1. 點擊“發送”以建立或更新通知。\n2. 前往您的主畫面或下拉通知欄以查看結果。\n3. 點擊“結束”以關閉通知。';

  @override
  String get autoCancelNotification => '自動取消通知';

  @override
  String get autoCancelNotificationDescription => '如果選中，當用戶點擊通知時，通知將自動關閉。';

  @override
  String get setDelayTime => '設定延遲時間';

  @override
  String get proposalDetails => '提案詳情';

  @override
  String get filterByStatus => '按狀態篩選';

  @override
  String get proposalNotFound => '找不到提案';

  @override
  String get processed => '已處理';

  @override
  String get showAll => '顯示全部';

  @override
  String get filterAndSortTitle => '篩選和排序';

  @override
  String get filterVerifiedOwner => '篩選已驗證的所有者';

  @override
  String get filterBy => '篩選條件';

  @override
  String get sortOldest => '最早排序';

  @override
  String get sortNewest => '最新排序';

  @override
  String get sortMostPopular => '按最受歡迎程度排序';

  @override
  String get sortLeastPopular => '按最不受歡迎程度排序';

  @override
  String get sortBy => '排序方式';

  @override
  String get simRulesNotFound => '找不到 SIM 卡規則';

  @override
  String get simSlotRules => 'SIM 卡插槽規則';

  @override
  String get noSimCardDetected => '未檢測到 SIM 卡';

  @override
  String get invalidSimData => 'SIM 卡資料無效';

  @override
  String get simCardData => 'SIM 卡資料';

  @override
  String get simSlot => 'SIM 卡插槽';

  @override
  String get enableFiltering => '啟用篩選';

  @override
  String get detailedSettingsTitle => '詳細設定';

  @override
  String get entryPointViewTitle => '進入點視窗';

  @override
  String get callTypeRejected => '已拒絕';

  @override
  String get callTypeSilenced => '已靜音';

  @override
  String get callTypeVoicemail => '語音信箱';

  @override
  String get callTypeUnknownIntercept => '不明攔截';

  @override
  String andMoreItems(int count) {
    return '以及其他 $count 個項目';
  }
}
