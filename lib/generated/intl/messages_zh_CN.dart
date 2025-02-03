// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(permissionName) => "${permissionName} 权限未被允许。";

  static String m1(listType) => "添加到${listType}";

  static String m2(listType) => "添加到${listType}";

  static String m3(permissionName) => "您需要在应用设置中手动禁用${permissionName} 权限。";

  static String m4(listType) => "移除${listType}";

  static String m5(listType) => "移除${listType}";

  static String m6(permissionName) => "您需要在应用设置中手动禁用 ${permissionName} 权限。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "accept": MessageLookupByLibrary.simpleMessage("接受"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("已启用广告："),
        "add": MessageLookupByLibrary.simpleMessage("添加"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage("添加允许条目页"),
        "addBlacklistPage": MessageLookupByLibrary.simpleMessage("添加黑名单页"),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage("添加已阻止页"),
        "addContact": MessageLookupByLibrary.simpleMessage("添加联系人"),
        "addContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("添加联系人订阅页面"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage("添加标签页"),
        "addPluginPage": MessageLookupByLibrary.simpleMessage("添加插件页"),
        "addRegexPage": MessageLookupByLibrary.simpleMessage("添加正则表达式页"),
        "addSmsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("添加短信黑名单页面"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("添加短信订阅页面"),
        "addSmsTextBlacklistPage":
            MessageLookupByLibrary.simpleMessage("添加短信文本黑名单页面"),
        "addSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("添加短信文本白名单页面"),
        "addSmsWhitelistPage":
            MessageLookupByLibrary.simpleMessage("添加短信白名单页面"),
        "addSubscriptionPage": MessageLookupByLibrary.simpleMessage("添加订阅页"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage("添加到已允许"),
        "addToAllowedtype": m1,
        "addToBlocked": MessageLookupByLibrary.simpleMessage("添加到已阻止"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("添加到标签"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage("添加白名单页"),
        "addedSuccessfully": MessageLookupByLibrary.simpleMessage("已成功添加"),
        "agent": MessageLookupByLibrary.simpleMessage("中介"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "allowAllAllowedNumbers":
            MessageLookupByLibrary.simpleMessage("允许所有已允许的号码"),
        "allowAllBlacklistedNumbers":
            MessageLookupByLibrary.simpleMessage("允许所有已列入黑名单的号码"),
        "allowAllWhitelistedNumbers":
            MessageLookupByLibrary.simpleMessage("允许所有已列入白名单的号码"),
        "allowBlockedNumbers": MessageLookupByLibrary.simpleMessage("允许已阻止的号码"),
        "allowOtherNumbers": MessageLookupByLibrary.simpleMessage("允许其他号码"),
        "allowRegexBlacklistedPatterns":
            MessageLookupByLibrary.simpleMessage("允许正则表达式黑名单模式"),
        "allowRegexWhitelistedPatterns":
            MessageLookupByLibrary.simpleMessage("允许正则表达式白名单模式"),
        "allowRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("允许重复来电"),
        "allowThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("允许此应用显示来电显示"),
        "allowed": MessageLookupByLibrary.simpleMessage("允许"),
        "allowedEntryPage": MessageLookupByLibrary.simpleMessage("允许的条目页"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage("允许的页面视图"),
        "answerthenhangup": MessageLookupByLibrary.simpleMessage("接听然后挂断"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage("您确定要删除该项目吗？"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage("您确定要删除此联系人吗？"),
        "autoCloseLocalNotification":
            MessageLookupByLibrary.simpleMessage("自动关闭本地通知"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage("已禁用自动更新"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage("已启用自动更新"),
        "autobackup": MessageLookupByLibrary.simpleMessage("自动备份"),
        "avatar": MessageLookupByLibrary.simpleMessage("头像"),
        "avatarAndIconSizes": MessageLookupByLibrary.simpleMessage("头像和图标大小"),
        "avatarBorderColor": MessageLookupByLibrary.simpleMessage("头像边框颜色"),
        "avatarBorderSize": MessageLookupByLibrary.simpleMessage("头像边框大小"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("头像位置"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("头像大小"),
        "avatarUrlOrPath": MessageLookupByLibrary.simpleMessage("头像 URL 或路径"),
        "backgroundGradient": MessageLookupByLibrary.simpleMessage("背景渐变"),
        "backup": MessageLookupByLibrary.simpleMessage("备份"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage("备份和恢复"),
        "bank": MessageLookupByLibrary.simpleMessage("银行"),
        "batteryOptimization": MessageLookupByLibrary.simpleMessage("电池优化"),
        "blacklist": MessageLookupByLibrary.simpleMessage("黑名单"),
        "blacklistPage": MessageLookupByLibrary.simpleMessage("黑名单页"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("黑名单和白名单"),
        "blacklistpageview": MessageLookupByLibrary.simpleMessage("黑名单页视图"),
        "blockCallsFromSpecificAreaCodes":
            MessageLookupByLibrary.simpleMessage("阻止来自特定区号的电话："),
        "blockInternationalCalls":
            MessageLookupByLibrary.simpleMessage("阻止国际电话："),
        "blocked": MessageLookupByLibrary.simpleMessage("阻止"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage("来电阻止操作"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("来电阻止通知"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("阻止的电话"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("已阻止的通话统计信息"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("已阻止页面"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage("已阻止页视图"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage("原始呼叫应用和本地通知"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("原始短信和本地通知"),
        "call": MessageLookupByLibrary.simpleMessage("呼叫"),
        "callHistory": MessageLookupByLibrary.simpleMessage("通话记录"),
        "callLog": MessageLookupByLibrary.simpleMessage("通话记录"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("已拒绝通话记录权限"),
        "callScreeningRoleRequestFailed":
            MessageLookupByLibrary.simpleMessage("呼叫筛选角色要求失败！"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage("呼叫筛选角色要求成功！"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("来电显示应用"),
        "callerIdData": MessageLookupByLibrary.simpleMessage("来电信息："),
        "callerIdDataIsNotAvailable":
            MessageLookupByLibrary.simpleMessage("来电信息不可用"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("来电显示 SIM 卡来源"),
        "callerIdStyle": MessageLookupByLibrary.simpleMessage("来电显示样式"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("来电显示样式内容"),
        "calltypeIconColor": MessageLookupByLibrary.simpleMessage("通话类型图标颜色"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "cannotFindItem": MessageLookupByLibrary.simpleMessage("找不到商品"),
        "carrier": MessageLookupByLibrary.simpleMessage("运营商："),
        "carrierColor": MessageLookupByLibrary.simpleMessage("运营商颜色"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage("运营商字体大小"),
        "carrierPosition": MessageLookupByLibrary.simpleMessage("运营商位置"),
        "charity": MessageLookupByLibrary.simpleMessage("慈善机构"),
        "chooseAvatarLocalOrNetwork":
            MessageLookupByLibrary.simpleMessage("选择头像（本地或网络）："),
        "chooseFromGallery": MessageLookupByLibrary.simpleMessage("从图库选择"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("仅选择链接或文件"),
        "chooseTheDefaultInterceptAction":
            MessageLookupByLibrary.simpleMessage("选择默认拦截操作"),
        "chooseYourLanguage": MessageLookupByLibrary.simpleMessage("选择您的语言"),
        "clientId": MessageLookupByLibrary.simpleMessage("客户端 ID"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("云备份"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("云备份目录名称"),
        "cloudBackupRequiresAutoBackup":
            MessageLookupByLibrary.simpleMessage("云备份需要自动备份"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("云服务"),
        "collection": MessageLookupByLibrary.simpleMessage("债务收款"),
        "configurationExportedToFile":
            MessageLookupByLibrary.simpleMessage("配置已导出到文件！"),
        "configurationImported": MessageLookupByLibrary.simpleMessage("配置已导入"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("配置导入成功"),
        "configurationSaved": MessageLookupByLibrary.simpleMessage("配置已保存！"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("确认删除"),
        "contactFile": MessageLookupByLibrary.simpleMessage("联系人文件"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("联系人订阅页面"),
        "contactUs": MessageLookupByLibrary.simpleMessage("联系我们"),
        "contacts": MessageLookupByLibrary.simpleMessage("联系人"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("已成功导出联系人"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("已成功导入联系人"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("联系人页面"),
        "contactsWithNumber": MessageLookupByLibrary.simpleMessage("具有号码的联系人"),
        "contactsubscription": MessageLookupByLibrary.simpleMessage("联系订阅"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("通讯录订阅页面"),
        "count": MessageLookupByLibrary.simpleMessage("数量"),
        "countColor": MessageLookupByLibrary.simpleMessage("计数颜色"),
        "countFontSize": MessageLookupByLibrary.simpleMessage("计数字体大小"),
        "countPosition": MessageLookupByLibrary.simpleMessage("计数位置"),
        "country": MessageLookupByLibrary.simpleMessage("国家/地区："),
        "countryCode": MessageLookupByLibrary.simpleMessage("国家代码"),
        "countryName": MessageLookupByLibrary.simpleMessage("国家名称"),
        "countryNameColor": MessageLookupByLibrary.simpleMessage("国家/地区名称颜色"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("国家/地区名称字体大小"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("国家/地区名称位置"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("裁剪头像"),
        "customerService": MessageLookupByLibrary.simpleMessage("客户服务"),
        "customizeCallerId": MessageLookupByLibrary.simpleMessage("自定义来电显示"),
        "dark": MessageLookupByLibrary.simpleMessage("深色"),
        "darkMode": MessageLookupByLibrary.simpleMessage("黑夜模式"),
        "days": MessageLookupByLibrary.simpleMessage("天"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("删除联系人"),
        "deleted": MessageLookupByLibrary.simpleMessage("已删除"),
        "delivery": MessageLookupByLibrary.simpleMessage("送货"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage("您已拒绝权限。您可以手动在设置中启用权限。"),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "应用支持从在线链接和插件订阅。您可以自定义自己的 API 或将任何网站转换为插件，以帮助您查找来电显示信息。"),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "应用支持正则表达式 (Regex)，允许您自定义模式来阻止呼叫。"),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "在本地或通过 WebDAV、Google Drive 或 OneDrive 在线导入或导出您的数据库。"),
        "disableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("禁用来电阻止通知"),
        "disablePermission": MessageLookupByLibrary.simpleMessage("禁用权限"),
        "disableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("禁用短信本地通知"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("禁用 STIR 通知"),
        "disableThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("禁用此应用显示来电显示"),
        "disabled": MessageLookupByLibrary.simpleMessage("已禁用"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("电子商务"),
        "edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("编辑头像"),
        "editCode": MessageLookupByLibrary.simpleMessage("编辑代码"),
        "editContact": MessageLookupByLibrary.simpleMessage("编辑联系人"),
        "editPluginCode": MessageLookupByLibrary.simpleMessage("编辑插件代码"),
        "education": MessageLookupByLibrary.simpleMessage("教育"),
        "elementPositions": MessageLookupByLibrary.simpleMessage("元素位置"),
        "email": MessageLookupByLibrary.simpleMessage("电子邮件"),
        "enableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("启用来电阻止通知"),
        "enableDarkModeBasedOnTime":
            MessageLookupByLibrary.simpleMessage("基于时间启用深色模式"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("启用覆盖权限"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("启用短信本地通知"),
        "enableSorting": MessageLookupByLibrary.simpleMessage("启用排序："),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("启用 STIR 通知"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage("启用以移除广告"),
        "enabled": MessageLookupByLibrary.simpleMessage("已启用"),
        "endColor": MessageLookupByLibrary.simpleMessage("结束颜色"),
        "endcall": MessageLookupByLibrary.simpleMessage("结束通话"),
        "enterCountryCode":
            MessageLookupByLibrary.simpleMessage("输入国家代码（例如：CN、US）"),
        "enterImageUrl": MessageLookupByLibrary.simpleMessage("输入图像 URL"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("在此处输入插件代码"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("输入网址"),
        "entry": MessageLookupByLibrary.simpleMessage("条目"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("已成功添加条目"),
        "error": MessageLookupByLibrary.simpleMessage("错误"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("导出联系人出错："),
        "errorGettingPermissionStatus":
            MessageLookupByLibrary.simpleMessage("获取权限状态错误"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("导入出错"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage("请求呼叫筛选角色错误："),
        "expirationDate": MessageLookupByLibrary.simpleMessage("到期日期"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("到期日期"),
        "export": MessageLookupByLibrary.simpleMessage("导出"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("导出允许的条目页"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("导出为 CSV"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("导出为 JSON"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("导出为 VCF"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("导出为 YAML"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage("导出黑名单页"),
        "exportBlockedPage": MessageLookupByLibrary.simpleMessage("导出已阻止页面"),
        "exportContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("导出联系人订阅页面"),
        "exportContacts": MessageLookupByLibrary.simpleMessage("导出联系人"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("导出失败"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("导出格式："),
        "exportLabelPage": MessageLookupByLibrary.simpleMessage("导出标签页面"),
        "exportPluginPage": MessageLookupByLibrary.simpleMessage("导出插件页面"),
        "exportRegexPage": MessageLookupByLibrary.simpleMessage("导出正则表达式页面"),
        "exportSmsBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("导出短信黑名单页面"),
        "exportSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("导出短信订阅页面"),
        "exportSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("导出短信文本黑名单页面"),
        "exportSmsWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("导出短信白名单"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("导出订阅页面"),
        "exportSuccessful": MessageLookupByLibrary.simpleMessage("导出成功"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage("导出白名单页面"),
        "failed": MessageLookupByLibrary.simpleMessage("失败"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("未能添加："),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage("未能添加条目："),
        "feature": MessageLookupByLibrary.simpleMessage("功能"),
        "feature1": MessageLookupByLibrary.simpleMessage("支持订阅"),
        "feature2": MessageLookupByLibrary.simpleMessage("支持正规则"),
        "feature3": MessageLookupByLibrary.simpleMessage("隐私保护"),
        "featureDescription": MessageLookupByLibrary.simpleMessage("功能说明"),
        "featureIntroduction": MessageLookupByLibrary.simpleMessage("功能介绍"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("过滤来短信"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("过滤重复来电"),
        "financial": MessageLookupByLibrary.simpleMessage("财经"),
        "firstName": MessageLookupByLibrary.simpleMessage("名字"),
        "fraudScamLikely": MessageLookupByLibrary.simpleMessage("可能为欺诈诈骗"),
        "function": MessageLookupByLibrary.simpleMessage("功能"),
        "getStarted": MessageLookupByLibrary.simpleMessage("开始"),
        "googleDriveLoginFailed":
            MessageLookupByLibrary.simpleMessage("Google 云端硬盘登录失败"),
        "googleDriveLoginSuccessfully":
            MessageLookupByLibrary.simpleMessage("谷歌云端硬盘登录成功"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Google 云端硬盘设置"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("授予权限"),
        "group": MessageLookupByLibrary.simpleMessage("组"),
        "headhunter": MessageLookupByLibrary.simpleMessage("猎头"),
        "height": MessageLookupByLibrary.simpleMessage("高度"),
        "history": MessageLookupByLibrary.simpleMessage("历史记录"),
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "iconSize": MessageLookupByLibrary.simpleMessage("图标大小"),
        "ifThereIsAnErrorSelectACountry":
            MessageLookupByLibrary.simpleMessage("如果有错误请选择一个国家"),
        "import": MessageLookupByLibrary.simpleMessage("导入"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("导入允许的条目页"),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage("导入黑名单页"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("导入阻止条目页面"),
        "importConfiguration": MessageLookupByLibrary.simpleMessage("导入配置"),
        "importContacts": MessageLookupByLibrary.simpleMessage("导入联系人"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("从 CSV 导入"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("从文件导入"),
        "importFromJson": MessageLookupByLibrary.simpleMessage("从 JSON 导入"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("从 URL 导入"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("从 VCF 导入"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage("从 YAML 导入"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage("导入标签页面"),
        "importPluginPage": MessageLookupByLibrary.simpleMessage("导入插件页面"),
        "importRegexPage": MessageLookupByLibrary.simpleMessage("导入正则表达式页面"),
        "importSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("导入短信订阅页面"),
        "importSmsTextBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("导入短信文本黑名单页面"),
        "importSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("导入短信文本白名单"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("导入订阅页面"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage("导入白名单页面"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("已成功从网址导入"),
        "inappPurchase": MessageLookupByLibrary.simpleMessage("应用内购买"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("应用内购买已启用"),
        "incomingCallInterceptAction":
            MessageLookupByLibrary.simpleMessage("来电拦截操作"),
        "initializing": MessageLookupByLibrary.simpleMessage("初始化中..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("初始化数据库中..."),
        "inputOnedriveCredentials":
            MessageLookupByLibrary.simpleMessage("输入 OneDrive 凭据"),
        "insurance": MessageLookupByLibrary.simpleMessage("保险"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage("在时间范围内拦截重复来电"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("无效的 JSON 格式"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("未订阅"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("已订阅"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage("加入电报频道和群组，了解详情"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage("仅保留最新备份"),
        "keyword": MessageLookupByLibrary.simpleMessage("关键字"),
        "label": MessageLookupByLibrary.simpleMessage("标签"),
        "labelIconColor": MessageLookupByLibrary.simpleMessage("标签图标颜色"),
        "labelPage": MessageLookupByLibrary.simpleMessage("标签页面"),
        "labelpageview": MessageLookupByLibrary.simpleMessage("标签页视图"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("标签颜色"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage("标签字体大小"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("标签位置"),
        "lastName": MessageLookupByLibrary.simpleMessage("姓氏"),
        "lifetimePurchase": MessageLookupByLibrary.simpleMessage("终身购买"),
        "light": MessageLookupByLibrary.simpleMessage("浅色"),
        "link": MessageLookupByLibrary.simpleMessage("链接"),
        "loading": MessageLookupByLibrary.simpleMessage("加载中..."),
        "loan": MessageLookupByLibrary.simpleMessage("贷款"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage("本地备份目录仅位于下载文件夹下"),
        "localCard1": MessageLookupByLibrary.simpleMessage("注意"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("为保证你的安全，请仅使用你信任的订阅来源"),
        "locationColor": MessageLookupByLibrary.simpleMessage("位置颜色"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage("位置字体大小"),
        "locationIconColor": MessageLookupByLibrary.simpleMessage("位置图标颜色"),
        "locationPosition": MessageLookupByLibrary.simpleMessage("位置位置"),
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("登录失败"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("登录 Google 云端硬盘"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("登录/退出 Google 云端硬盘"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("退出 Google 云端硬盘"),
        "manageRules": MessageLookupByLibrary.simpleMessage("管理规则"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("手动备份"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("标记为"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage("匹配任何字符："),
        "matchFailed": MessageLookupByLibrary.simpleMessage("匹配失败!"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage("匹配包含特定数字的电话号码："),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage("匹配中间包含特定字符的电话号码："),
        "matchSuccessful": MessageLookupByLibrary.simpleMessage("匹配成功!"),
        "medical": MessageLookupByLibrary.simpleMessage("医疗"),
        "merge": MessageLookupByLibrary.simpleMessage("合并"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("合并联系人"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("合并所选"),
        "message": MessageLookupByLibrary.simpleMessage("信息"),
        "mins": MessageLookupByLibrary.simpleMessage("分钟"),
        "monthlySubscription": MessageLookupByLibrary.simpleMessage("月度订阅"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage("更多广告以获取临时 VIP 特权。"),
        "name": MessageLookupByLibrary.simpleMessage("姓名"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage("名称不得为空"),
        "nameColor": MessageLookupByLibrary.simpleMessage("姓名颜色"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage("姓名字体大小"),
        "namePosition": MessageLookupByLibrary.simpleMessage("姓名位置"),
        "next": MessageLookupByLibrary.simpleMessage("下一步"),
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("暂时没有数据"),
        "noImageSelected": MessageLookupByLibrary.simpleMessage("尚未选择图像"),
        "noIncomingSmsMessagesFilter":
            MessageLookupByLibrary.simpleMessage("不过滤来短信"),
        "normalUser": MessageLookupByLibrary.simpleMessage("普通用户"),
        "notVerified": MessageLookupByLibrary.simpleMessage("STIR 未验证"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "numberColor": MessageLookupByLibrary.simpleMessage("号码颜色"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage("号码字体大小"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("号码位置"),
        "numberType": MessageLookupByLibrary.simpleMessage("号码类型"),
        "numberTypeColor": MessageLookupByLibrary.simpleMessage("号码类型颜色"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage("号码类型字体大小"),
        "numberTypePosition": MessageLookupByLibrary.simpleMessage("号码类型位置"),
        "ok": MessageLookupByLibrary.simpleMessage("确定"),
        "onedriveSetting": MessageLookupByLibrary.simpleMessage("OneDrive 设置"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage("一次性购买永久解锁所有高级功能和未来更新。"),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("在线来电显示订阅"),
        "onlyForSupportedArea": MessageLookupByLibrary.simpleMessage("仅限支持地区"),
        "onlyOriginalCallAppNotification":
            MessageLookupByLibrary.simpleMessage("仅原始呼叫应用通知"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("仅响铃本地通知"),
        "onlyUseOriginalSmsNotification":
            MessageLookupByLibrary.simpleMessage("仅使用原始短信通知"),
        "openLocalFolder": MessageLookupByLibrary.simpleMessage("打开本地文件夹"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "overlay": MessageLookupByLibrary.simpleMessage("浮动窗口"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "未授予浮动窗口权限，这可能会影响来电显示功能。您可以在应用设置中启用此权限。"),
        "page": MessageLookupByLibrary.simpleMessage("页"),
        "password": MessageLookupByLibrary.simpleMessage("密码"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("粘贴 JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("粘贴 JSON 配置"),
        "pasteJsonHere": MessageLookupByLibrary.simpleMessage("在此处粘贴 JSON"),
        "pattern": MessageLookupByLibrary.simpleMessage("模式"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage("永久移除应用内所有广告，享受纯净的用户体验。"),
        "permissionDenied": MessageLookupByLibrary.simpleMessage("权限被拒绝"),
        "permissionGranted": MessageLookupByLibrary.simpleMessage("已授予权限"),
        "permissionInAppSetting":
            MessageLookupByLibrary.simpleMessage(":您需要在应用设置中手动禁用权限。"),
        "permissionInTheAppSettings":
            MessageLookupByLibrary.simpleMessage("应用设置中的权限。"),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("权限未被允许。"),
        "permissions": MessageLookupByLibrary.simpleMessage("权限"),
        "permissionsRequired": MessageLookupByLibrary.simpleMessage("所需权限"),
        "phone": MessageLookupByLibrary.simpleMessage("电话"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("固定电话"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("固定电话或移动电话"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("手机"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("传呼机"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("个人号码"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("高级费率"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("共享成本"),
        "phoneNumberTypeTollFree": MessageLookupByLibrary.simpleMessage("免费电话"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("统一接入号码"),
        "phoneNumberTypeUnknown": MessageLookupByLibrary.simpleMessage("未知"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("语音邮件"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("电话号码"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("请输入"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("请输入电话号码"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage("请输入电话号码和正则表达式"),
        "pleaseEnterARegexPattern":
            MessageLookupByLibrary.simpleMessage("请输入正规则表达式"),
        "pleaseEnterAnPattern": MessageLookupByLibrary.simpleMessage("请输入一个模式"),
        "pleaseEnterAnUrl": MessageLookupByLibrary.simpleMessage("请输入一个 URL"),
        "pleaseSelectAFileOrInputAUrl":
            MessageLookupByLibrary.simpleMessage("请选择一个文件或输入一个 URL"),
        "pleaseSelectALabel": MessageLookupByLibrary.simpleMessage("请选择一个标签"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("请选择一个导出文件夹"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("请选择输出文件："),
        "pleaseSelectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("请选择要导出的条目"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage("请点击“授予权限”，并在下一个屏幕中允许该权限。"),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage("请点击“设为默认”，并在下一个屏幕允许权限。"),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage("请等待数据库初始化完成。"),
        "pluginData": MessageLookupByLibrary.simpleMessage("插件数据："),
        "pluginPage": MessageLookupByLibrary.simpleMessage("插件页面"),
        "plugins": MessageLookupByLibrary.simpleMessage("插件"),
        "pluginspageview": MessageLookupByLibrary.simpleMessage("插件页视图"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("插件更新"),
        "political": MessageLookupByLibrary.simpleMessage("政治"),
        "purchase": MessageLookupByLibrary.simpleMessage("购买"),
        "purchaseFailed": MessageLookupByLibrary.simpleMessage("购买失败："),
        "purchaseIsBeingProcessed":
            MessageLookupByLibrary.simpleMessage("正在处理购买..."),
        "purchaseSuccessful": MessageLookupByLibrary.simpleMessage("购买成功！"),
        "quarterlySubscription": MessageLookupByLibrary.simpleMessage("季度订阅"),
        "recordbackup": MessageLookupByLibrary.simpleMessage("录音备份"),
        "recruiter": MessageLookupByLibrary.simpleMessage("招聘"),
        "regex": MessageLookupByLibrary.simpleMessage("正则表达式"),
        "regexPage": MessageLookupByLibrary.simpleMessage("正则页面"),
        "regexPattern": MessageLookupByLibrary.simpleMessage("正规则"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("正则表达式模式说明"),
        "regexPatternTest": MessageLookupByLibrary.simpleMessage("正则表达式测试"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage("正则表达式模式是用于匹配电话号码的正则表达式。"),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("正则表达式测试号码"),
        "regexpageview": MessageLookupByLibrary.simpleMessage("正则表达式页视图"),
        "region": MessageLookupByLibrary.simpleMessage("地区："),
        "reject": MessageLookupByLibrary.simpleMessage("拒绝"),
        "rejectAllNumbers": MessageLookupByLibrary.simpleMessage("拒绝所有号码"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "removeAds": MessageLookupByLibrary.simpleMessage("移除广告"),
        "removeAdsAndEnableOnlineBackup":
            MessageLookupByLibrary.simpleMessage("移除广告并启用在线备份"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage("删除已允许"),
        "removeAllowedtype": m4,
        "removeBlocked": MessageLookupByLibrary.simpleMessage("删除已阻止"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("在内重复阻止通话"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("重复呼叫"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("从 Google 云端硬盘恢复"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage("从本地恢复"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("从 OneDrive 恢复"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("从 WebDAV 恢复"),
        "restorePurchase": MessageLookupByLibrary.simpleMessage("恢复购买"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("拼车"),
        "risk": MessageLookupByLibrary.simpleMessage("风险"),
        "robocall": MessageLookupByLibrary.simpleMessage("机器人电话"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "searchContacts": MessageLookupByLibrary.simpleMessage("搜索联系人"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("搜索条目"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("选择一个标签："),
        "selectAll": MessageLookupByLibrary.simpleMessage("全选"),
        "selectColor": MessageLookupByLibrary.simpleMessage("选择颜色"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("选择国家/地区代码（可选）"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("选择条目"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("选择要导出的条目"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage("已成功合并所选联系人"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("所选的标签"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("正在选择导出文件夹"),
        "service": MessageLookupByLibrary.simpleMessage("服务"),
        "serviceUpdateIntervalsDays":
            MessageLookupByLibrary.simpleMessage("服务更新间隔（天）"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "settingsSaved": MessageLookupByLibrary.simpleMessage("设置已保存"),
        "setupDefault": MessageLookupByLibrary.simpleMessage("设为默认"),
        "setupDefaultCallerIdApp":
            MessageLookupByLibrary.simpleMessage("设为默认来电显示应用"),
        "sharing": MessageLookupByLibrary.simpleMessage("共享"),
        "showContactButton": MessageLookupByLibrary.simpleMessage("显示联系人按钮"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("显示联系人图标按钮"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("显示 Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("显示 WhatsApp"),
        "showingResultsFor": MessageLookupByLibrary.simpleMessage("显示结果"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("显示搜索结果"),
        "silencenoanswer": MessageLookupByLibrary.simpleMessage("无声无应答"),
        "silentCallvoiceClone":
            MessageLookupByLibrary.simpleMessage("无声通话(语音克隆？"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("SIM 卡颜色"),
        "simCardFontSize": MessageLookupByLibrary.simpleMessage("SIM 卡字体大小"),
        "simCardPosition": MessageLookupByLibrary.simpleMessage("SIM 卡位置"),
        "skip": MessageLookupByLibrary.simpleMessage("跳过"),
        "sms": MessageLookupByLibrary.simpleMessage("短信"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS黑名单"),
        "smsBlacklistPage": MessageLookupByLibrary.simpleMessage("短信黑名单页面"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("短信过滤"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "短信过滤需要短信、通知和电话权限。请授予这些权限以启用此功能。"),
        "smsLocalNotification": MessageLookupByLibrary.simpleMessage("短信本地通知"),
        "smsNotification": MessageLookupByLibrary.simpleMessage("短信通知"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS订阅"),
        "smsSubscriptionPage": MessageLookupByLibrary.simpleMessage("短信订阅页面"),
        "smsTextBlacklist": MessageLookupByLibrary.simpleMessage("SMS文本黑名单"),
        "smsTextWhitelistPage":
            MessageLookupByLibrary.simpleMessage("短信文本白名单页面"),
        "smsTextwhitelist": MessageLookupByLibrary.simpleMessage("SMS文本白名单"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS白名单"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage("短信黑名单页面"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("短信订阅页面"),
        "smstextblacklistpageview":
            MessageLookupByLibrary.simpleMessage("短信文本黑名单页面"),
        "smstextwhitelistpageview":
            MessageLookupByLibrary.simpleMessage("短信文本白名单页面"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage("短信白名单页面"),
        "sortBy": MessageLookupByLibrary.simpleMessage("排序方式："),
        "spamLikely": MessageLookupByLibrary.simpleMessage("可能为垃圾邮件"),
        "startColor": MessageLookupByLibrary.simpleMessage("起始颜色"),
        "statisticsTimeRangeMinutes":
            MessageLookupByLibrary.simpleMessage("统计时间范围（分钟）："),
        "stirColor": MessageLookupByLibrary.simpleMessage("STIR 颜色"),
        "stirFontSize": MessageLookupByLibrary.simpleMessage("STIR 字体大小"),
        "stirNotification": MessageLookupByLibrary.simpleMessage("STIR 通知"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("STIR 位置"),
        "stirRecognition": MessageLookupByLibrary.simpleMessage("STIR 识别"),
        "storage": MessageLookupByLibrary.simpleMessage("储存空间"),
        "subscribe": MessageLookupByLibrary.simpleMessage("订阅"),
        "subscribed": MessageLookupByLibrary.simpleMessage("已订阅"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("已订阅链接"),
        "subscriptionListPage": MessageLookupByLibrary.simpleMessage("订阅列表页面"),
        "subscriptionValid": MessageLookupByLibrary.simpleMessage("订阅有效"),
        "subscriptionlistview": MessageLookupByLibrary.simpleMessage("订阅列表视图"),
        "subscriptionmodel": MessageLookupByLibrary.simpleMessage("在线数据订阅更新"),
        "successful": MessageLookupByLibrary.simpleMessage("成功"),
        "successfully": MessageLookupByLibrary.simpleMessage("成功"),
        "survey": MessageLookupByLibrary.simpleMessage("调查"),
        "sync": MessageLookupByLibrary.simpleMessage("同步"),
        "system": MessageLookupByLibrary.simpleMessage("系统"),
        "takeaway": MessageLookupByLibrary.simpleMessage("外卖"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("电话营销"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage("临时购买特权已过期"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("已获得临时 VIP"),
        "temporaryVipUser": MessageLookupByLibrary.simpleMessage("临时 VIP 用户"),
        "test": MessageLookupByLibrary.simpleMessage("测试"),
        "testCallerIdOverlay": MessageLookupByLibrary.simpleMessage("测试来电信息弹窗"),
        "textLabelColors": MessageLookupByLibrary.simpleMessage("文本和标签颜色"),
        "textType": MessageLookupByLibrary.simpleMessage("文本类型"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "翻译并不完整，现在的翻译全部由AI完成. 如果你发现任何翻译问题或者缺失请点击此处到GIthub修改翻译."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "此应用是一款功能强大的来电显示工具，可让您识别未知来电者并阻止不需要的电话。其特点包括："),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "此应用需要访问您的通话记录信息才能正常运行。请授予权限。"),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage("此权限是我们应用成为默认来电显示应用所必需的。"),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "此权限对于我们的应用程序在其他应用程序之上显示重要信息是必需的。"),
        "toTestRules": MessageLookupByLibrary.simpleMessage("验证规则"),
        "today": MessageLookupByLibrary.simpleMessage("今天"),
        "translation": MessageLookupByLibrary.simpleMessage("翻译"),
        "tutorial": MessageLookupByLibrary.simpleMessage("教程"),
        "unknown": MessageLookupByLibrary.simpleMessage("未知"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage("每月解锁高级功能，包括独家内容和移除广告。"),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage("每季度解锁高级功能并享受更优惠的价格。"),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("未订阅"),
        "url": MessageLookupByLibrary.simpleMessage("网址"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("URL 格式不正确"),
        "useNetworkImage": MessageLookupByLibrary.simpleMessage("使用网络图像"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "使用“.”字符匹配任何单个字符。例如，模式“123.456”匹配“123-456”、“123.456”、“123a456”等。"),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "使用模式 \'^0[0-9]{2,3}\' 来匹配以 \'0\' 开头，后跟 2 或 3 位数字的电话号码，这通常代表区号。\n使用模式 \'^010\' 阻止来自北京区号 (010) 的电话。\n使用模式 \'^202\' 阻止来自华盛顿区号 (202) 的电话。\n将 \'^0[0-9]{2,3}\' 区号替换为您要阻止的特定区号。"),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "使用模式 \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' 来匹配格式为 \'XXX-XXXX-XXXX\' 的电话号码。将 \'X\' 替换为您要匹配的特定数字。"),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "使用规则 \'^170 [0-9]{3} 656 [0-9]{2}\$\'匹配号码。 ^: 匹配字符串开头。505: 匹配字符串 \'505\'。 \'\' 匹配一个空格. \'[0-9]{3}\': 匹配三个数字 (0-9)。\'\' 匹配一个空格.656: 匹配字符串 \'656\'。\'[0-9]{1}\': 匹配一个数字 (0-9)。\'\$\' (可选): 匹配字符串结尾 (仅当您需要完全匹配字符串时)。"),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "使用模式 \'^\\+\' 来匹配所有以加号开头的电话号码，加号通常表示国际号码。"),
        "userName": MessageLookupByLibrary.simpleMessage("用户名"),
        "verificationPageRules": MessageLookupByLibrary.simpleMessage("验证规则页面"),
        "verificationResultsRules":
            MessageLookupByLibrary.simpleMessage("验证结果（接听规则）："),
        "verified": MessageLookupByLibrary.simpleMessage("STIR 已验证"),
        "verify": MessageLookupByLibrary.simpleMessage("验证"),
        "verifyPhoneNumber": MessageLookupByLibrary.simpleMessage("验证电话号码"),
        "video": MessageLookupByLibrary.simpleMessage("视频"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP 用户"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage("观看一段短广告以临时解锁一些高级功能。"),
        "watchAd": MessageLookupByLibrary.simpleMessage("观看广告"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage("观看广告以获取临时特权"),
        "webdav": MessageLookupByLibrary.simpleMessage("WebDAV 设置"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
        "website": MessageLookupByLibrary.simpleMessage("网站"),
        "weeklyBlockedCallsSummary":
            MessageLookupByLibrary.simpleMessage("每周阻止电话统计"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("白名单"),
        "whitelistPage": MessageLookupByLibrary.simpleMessage("白名单页面"),
        "whitelistpageview": MessageLookupByLibrary.simpleMessage("白名单页视图"),
        "width": MessageLookupByLibrary.simpleMessage("宽度"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage("对灵活过滤的支持"),
        "windowSize": MessageLookupByLibrary.simpleMessage("窗口大小"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage("您已拥有临时特权。到期日期"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "您可以使用标准正则表达式语法来定义模式，或者让 AI 为 Flutter 生成模式。"),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage("您已拒绝权限。您可以手动在设置中启用权限。"),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("您已启用该权限。"),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage("您已获得临时购买特权"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage("您拥有 VIP 特权，除了关闭广告。"),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("您需要手动禁用"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch": MessageLookupByLibrary.simpleMessage("您需要观看")
      };
}
