// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja_JP locale. All the
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
  String get localeName => 'ja_JP';

  static String m0(permissionName) => "${permissionName}権限が付与されませんでした。";

  static String m1(listType) => "${listType}に追加";

  static String m2(listType) => "${listType}に追加";

  static String m3(permissionName) =>
      "アプリの設定で${permissionName}権限を手動で無効にする必要があります。";

  static String m4(listType) => "${listType}を削除";

  static String m5(listType) => "${listType}を削除";

  static String m6(permissionName) =>
      "アプリの設定で${permissionName}権限を手動で無効にする必要があります。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("バージョン情報"),
        "accept": MessageLookupByLibrary.simpleMessage("承諾"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("広告が有効になっています："),
        "add": MessageLookupByLibrary.simpleMessage("追加"),
        "addAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("許可されたエントリページを追加"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("ブラックリストページを追加"),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage("ブロックされたページを追加"),
        "addContact": MessageLookupByLibrary.simpleMessage("連絡先を追加"),
        "addContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("連絡先購読ページを追加"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage("ラベルページを追加"),
        "addPluginPage": MessageLookupByLibrary.simpleMessage("プラグインページを追加"),
        "addRegexPage": MessageLookupByLibrary.simpleMessage("正規表現ページを追加"),
        "addSmsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMSブラックリストページを追加"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS購読ページを追加"),
        "addSmsTextBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMSテキストブラックリストページを追加"),
        "addSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("SMSテキストホワイトリストページを追加"),
        "addSmsWhitelistPage":
            MessageLookupByLibrary.simpleMessage("SMSホワイトリストページを追加"),
        "addSubscriptionPage": MessageLookupByLibrary.simpleMessage("購読ページを追加"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage("許可に追加"),
        "addToAllowedtype": m1,
        "addToBlocked": MessageLookupByLibrary.simpleMessage("ブロックに追加"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("ラベルに追加"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("ホワイトリストページを追加"),
        "addedSuccessfully": MessageLookupByLibrary.simpleMessage("正常に追加されました"),
        "all": MessageLookupByLibrary.simpleMessage("すべて"),
        "allowAllAllowedNumbers":
            MessageLookupByLibrary.simpleMessage("許可されているすべての番号を許可する"),
        "allowAllBlacklistedNumbers":
            MessageLookupByLibrary.simpleMessage("ブラックリストに登録されているすべての番号を許可する"),
        "allowAllWhitelistedNumbers":
            MessageLookupByLibrary.simpleMessage("ホワイトリストに登録されているすべての番号を許可する"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("ブロックされている番号を許可する"),
        "allowRegexBlacklistedPatterns":
            MessageLookupByLibrary.simpleMessage("正規表現ブラックリストパターンを許可する"),
        "allowRegexWhitelistedPatterns":
            MessageLookupByLibrary.simpleMessage("正規表現ホワイトリストパターンを許可する"),
        "allowRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("繰り返しの着信を許可する"),
        "allowThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("このアプリに発信者番号の表示を許可する"),
        "allowed": MessageLookupByLibrary.simpleMessage("許可"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("許可されたエントリページ"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage("許可されたページビュー"),
        "answerthenhangup": MessageLookupByLibrary.simpleMessage("応答して切断"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage("本当にこの項目を削除しますか？"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage("本当にこの連絡先を削除しますか？"),
        "autoCloseLocalNotification":
            MessageLookupByLibrary.simpleMessage("ローカル通知を自動的に閉じる"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("自動更新が無効になっています"),
        "autoUpdateEnabled":
            MessageLookupByLibrary.simpleMessage("自動更新が有効になっています"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("アバターとアイコンのサイズ"),
        "avatarBorderColor": MessageLookupByLibrary.simpleMessage("アバターの境界線の色"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("アバターの境界線のサイズ"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("アバターの位置"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("アバターサイズ"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("アバターのURLまたはパス"),
        "backgroundGradient": MessageLookupByLibrary.simpleMessage("背景グラデーション"),
        "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
        "bank": MessageLookupByLibrary.simpleMessage("銀行"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("バッテリーの最適化"),
        "blacklist": MessageLookupByLibrary.simpleMessage("ブラックリスト"),
        "blacklistPage": MessageLookupByLibrary.simpleMessage("ブラックリストページ"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("ブラックリストとホワイトリスト"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("ブラックリストページビュー"),
        "blockCallsFromSpecificAreaCodes":
            MessageLookupByLibrary.simpleMessage("特定の市外局番からの通話をブロックする："),
        "blockInternationalCalls":
            MessageLookupByLibrary.simpleMessage("国際電話をブロックする："),
        "blocked": MessageLookupByLibrary.simpleMessage("ブロック"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("ブロックされた通話の操作"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("ブロックされた通話の通知"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("ブロックされた通話の統計"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("ブロックされたページ"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("ブロックされたページビュー"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage("元の通話アプリとローカル通知の両方"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("元のSMSとローカル通知の両方"),
        "call": MessageLookupByLibrary.simpleMessage("通話"),
        "callHistory": MessageLookupByLibrary.simpleMessage("通話履歴"),
        "callLog": MessageLookupByLibrary.simpleMessage("通話履歴"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("通話履歴の権限が拒否されました"),
        "callScreeningRoleRequestFailed":
            MessageLookupByLibrary.simpleMessage("通話スクリーニングの役割要求に失敗しました！"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage("通話スクリーニングの役割要求に成功しました！"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("発信者番号アプリ"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle": MessageLookupByLibrary.simpleMessage("発信者番号のスタイル"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("発信者番号のスタイルの内容"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("通話タイプアイコンの色"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("キャリア："),
        "carrierColor": MessageLookupByLibrary.simpleMessage("キャリアの色"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage("キャリアのフォントサイズ"),
        "carrierPosition": MessageLookupByLibrary.simpleMessage("キャリアの位置"),
        "charity": MessageLookupByLibrary.simpleMessage("慈善団体"),
        "chooseAvatarLocalOrNetwork":
            MessageLookupByLibrary.simpleMessage("アバターを選択（ローカルまたはネットワーク）："),
        "chooseFromGallery": MessageLookupByLibrary.simpleMessage("ギャラリーから選択"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("リンクまたはファイルのみを選択"),
        "chooseTheDefaultInterceptAction":
            MessageLookupByLibrary.simpleMessage("デフォルトのインターセプトアクションを選択する"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("言語を選択してください"),
        "clientId": MessageLookupByLibrary.simpleMessage("クライアントID"),
        "close": MessageLookupByLibrary.simpleMessage("閉じる"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("クラウドバックアップディレクトリ名"),
        "cloudBackupRequiresAutoBackup":
            MessageLookupByLibrary.simpleMessage("クラウドバックアップには自動バックアップが必要です"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("クラウドサービス"),
        "collection": MessageLookupByLibrary.simpleMessage("集金"),
        "configurationExportedToFile":
            MessageLookupByLibrary.simpleMessage("設定をファイルにエクスポートしました！"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("設定がインポートされました"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("設定のインポートに成功しました"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("設定が保存されました！"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("削除の確認"),
        "contactFile": MessageLookupByLibrary.simpleMessage("連絡先ファイル"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("連絡先購読ページ"),
        "contactUs": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
        "contacts": MessageLookupByLibrary.simpleMessage("連絡先"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("連絡先が正常にエクスポートされました"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("連絡先が正常にインポートされました"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("連絡先ページ"),
        "contactsWithNumber": MessageLookupByLibrary.simpleMessage("番号付きの連絡先"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("ContactSubscriptionListView"),
        "countColor": MessageLookupByLibrary.simpleMessage("カウントの色"),
        "countFontSize": MessageLookupByLibrary.simpleMessage("カウントのフォントサイズ"),
        "countPosition": MessageLookupByLibrary.simpleMessage("カウントの位置"),
        "country": MessageLookupByLibrary.simpleMessage("国："),
        "countryNameColor": MessageLookupByLibrary.simpleMessage("国/地域名のカラー"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("国/地域名のフォントサイズ"),
        "countryNamePosition": MessageLookupByLibrary.simpleMessage("国/地域名の位置"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("アバターをトリミング"),
        "customerService": MessageLookupByLibrary.simpleMessage("カスタマーサービス"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("発信者番号のカスタマイズ"),
        "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
        "darkMode": MessageLookupByLibrary.simpleMessage("ダークモード"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("連絡先を削除"),
        "deleted": MessageLookupByLibrary.simpleMessage("削除済み"),
        "delivery": MessageLookupByLibrary.simpleMessage("配達"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage("権限を拒否しました。設定で手動で権限を有効にできます。"),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("ブロックされた通話の通知を無効にする"),
        "disablePermission": MessageLookupByLibrary.simpleMessage("権限を無効にする"),
        "disableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMSローカル通知を無効にする"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("このアプリに発信者番号の表示を許可しない"),
        "disabled": MessageLookupByLibrary.simpleMessage("無効"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("Eコマース"),
        "edit": MessageLookupByLibrary.simpleMessage("編集"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("アバターを編集"),
        "editCode": MessageLookupByLibrary.simpleMessage("コードを編集"),
        "editContact": MessageLookupByLibrary.simpleMessage("連絡先を編集"),
        "editPluginCode": MessageLookupByLibrary.simpleMessage("プラグインコードを編集"),
        "education": MessageLookupByLibrary.simpleMessage("教育"),
        "elementPositions": MessageLookupByLibrary.simpleMessage("要素の位置"),
        "email": MessageLookupByLibrary.simpleMessage("メール"),
        "enableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("ブロックされた通話の通知を有効にする"),
        "enableDarkModeBasedOnTime":
            MessageLookupByLibrary.simpleMessage("時間に基づいてダークモードを有効にする"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("オーバーレイ権限を有効にする"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMSローカル通知を有効にする"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("広告を削除するには有効にします"),
        "enabled": MessageLookupByLibrary.simpleMessage("有効"),
        "endColor": MessageLookupByLibrary.simpleMessage("終了色"),
        "endcall": MessageLookupByLibrary.simpleMessage("通話を終了"),
        "enterImageUrl": MessageLookupByLibrary.simpleMessage("画像のURLを入力"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("ここにプラグインコードを入力してください"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("URLを入力"),
        "entry": MessageLookupByLibrary.simpleMessage("エントリ"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("エントリが正常に追加されました"),
        "error": MessageLookupByLibrary.simpleMessage("エラー"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("連絡先のエクスポートエラー："),
        "errorGettingPermissionStatus":
            MessageLookupByLibrary.simpleMessage("権限ステータスの取得エラー"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("インポートエラー"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage("通話スクリーニングの役割の要求エラー："),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("エクスポート"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("許可されたエントリページをエクスポート"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("CSVとしてエクスポート"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("JSONとしてエクスポート"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("VCFとしてエクスポート"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("YAMLとしてエクスポート"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("ブラックリストページをエクスポート"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("ブロックされたページをエクスポート"),
        "exportContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("連絡先購読ページをエクスポート"),
        "exportContacts": MessageLookupByLibrary.simpleMessage("連絡先をエクスポート"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("エクスポートに失敗しました"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("エクスポート形式："),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("ラベルページをエクスポート"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("プラグインページをエクスポート"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("正規表現ページをエクスポート"),
        "exportSmsBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("SMSブラックリストページをエクスポート"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("購読ページをエクスポート"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("エクスポートに成功しました"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("ホワイトリストページをエクスポート"),
        "failed": MessageLookupByLibrary.simpleMessage("失敗"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("追加に失敗しました："),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("エントリの追加に失敗しました："),
        "feature": MessageLookupByLibrary.simpleMessage("特徴"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription": MessageLookupByLibrary.simpleMessage("機能の説明"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("着信SMSメッセージをフィルタリングする"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("繰り返しの着信をフィルタリングする"),
        "financial": MessageLookupByLibrary.simpleMessage("金融"),
        "firstName": MessageLookupByLibrary.simpleMessage("名"),
        "fraudScamLikely": MessageLookupByLibrary.simpleMessage("詐欺の可能性が高い"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("開始する"),
        "googleDriveLoginFailed":
            MessageLookupByLibrary.simpleMessage("Googleドライブへのログインに失敗しました"),
        "googleDriveLoginSuccessfully":
            MessageLookupByLibrary.simpleMessage("Googleドライブにログインしました"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Googleドライブ設定"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("権限を付与"),
        "group": MessageLookupByLibrary.simpleMessage("グループ"),
        "height": MessageLookupByLibrary.simpleMessage("高さ"),
        "history": MessageLookupByLibrary.simpleMessage("履歴"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("アイコンサイズ"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("インポート"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("許可されたエントリページをインポート"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("ブラックリストページをインポート"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("ブロックされたエントリページをインポート"),
        "importConfiguration": MessageLookupByLibrary.simpleMessage("インポート設定"),
        "importContacts": MessageLookupByLibrary.simpleMessage("連絡先をインポート"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("CSVからインポート"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
        "importFromJson": MessageLookupByLibrary.simpleMessage("JSONからインポート"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("VCFからインポート"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage("YAMLからインポート"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage("ラベルページをインポート"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("プラグインページをインポート"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("正規表現ページをインポート"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("購読ページをインポート"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("URLから正常にインポートされました"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("アプリ内購入が有効になっています"),
        "incomingCallInterceptAction":
            MessageLookupByLibrary.simpleMessage("着信インターセプトアクション"),
        "initializing": MessageLookupByLibrary.simpleMessage("初期化中..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("データベースを初期化しています..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials":
            MessageLookupByLibrary.simpleMessage("OneDriveの資格情報を入力してください"),
        "insurance": MessageLookupByLibrary.simpleMessage("保険"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage("時間範囲内で繰り返しの着信をインターセプトする"),
        "invalidJsonFormat": MessageLookupByLibrary.simpleMessage("無効なJSON形式"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("購読していません"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("購読済み"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "詳細については、Telegramチャンネルとグループに参加してください"),
        "keepOnlyLatestBackup":
            MessageLookupByLibrary.simpleMessage("最新のバックアップのみを保持"),
        "keyword": MessageLookupByLibrary.simpleMessage("キーワード"),
        "label": MessageLookupByLibrary.simpleMessage("ラベル"),
        "labelIconColor": MessageLookupByLibrary.simpleMessage("ラベルアイコンの色"),
        "labelPage": MessageLookupByLibrary.simpleMessage("ラベルページ"),
        "labelpageview": MessageLookupByLibrary.simpleMessage("ラベルページビュー"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("ラベルの色"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage("ラベルのフォントサイズ"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("ラベルの位置"),
        "lastName": MessageLookupByLibrary.simpleMessage("姓"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("ライト"),
        "link": MessageLookupByLibrary.simpleMessage("リンク"),
        "loading": MessageLookupByLibrary.simpleMessage("読み込み中..."),
        "loan": MessageLookupByLibrary.simpleMessage("ローン"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "ローカルバックアップディレクトリはダウンロードフォルダの下のみ"),
        "localCard1": MessageLookupByLibrary.simpleMessage("ローカルカード1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("ローカルカード1の内容"),
        "locationColor": MessageLookupByLibrary.simpleMessage("位置の色"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage("位置のフォントサイズ"),
        "locationIconColor": MessageLookupByLibrary.simpleMessage("位置アイコンの色"),
        "locationPosition": MessageLookupByLibrary.simpleMessage("位置の位置"),
        "login": MessageLookupByLibrary.simpleMessage("ログイン"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("ログインに失敗しました"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Googleドライブにログイン"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Googleドライブにログイン/ログアウト"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Googleドライブからログアウト"),
        "manageRules": MessageLookupByLibrary.simpleMessage("ルールの管理"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("手動バックアップ"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("次のようにマークされています"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("任意の文字に一致させる："),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage("特定の数字を含む電話番号を照合する："),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage("途中に特定の文字を含む電話番号を照合する："),
        "medical": MessageLookupByLibrary.simpleMessage("医療"),
        "merge": MessageLookupByLibrary.simpleMessage("マージ"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("連絡先をマージ"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("選択したものをマージ"),
        "message": MessageLookupByLibrary.simpleMessage("メッセージ"),
        "mins": MessageLookupByLibrary.simpleMessage("分"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("名前"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage("名前は空にできません"),
        "nameColor": MessageLookupByLibrary.simpleMessage("名前の色"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage("名前のフォントサイズ"),
        "namePosition": MessageLookupByLibrary.simpleMessage("名前の位置"),
        "next": MessageLookupByLibrary.simpleMessage("次へ"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected": MessageLookupByLibrary.simpleMessage("画像が選択されていません"),
        "noIncomingSmsMessagesFilter":
            MessageLookupByLibrary.simpleMessage("着信SMSメッセージをフィルタリングしない"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("未確認"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "numberColor": MessageLookupByLibrary.simpleMessage("番号の色"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage("番号のフォントサイズ"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("番号の位置"),
        "numberType": MessageLookupByLibrary.simpleMessage("番号タイプ"),
        "numberTypeColor": MessageLookupByLibrary.simpleMessage("番号タイプのカラー"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("番号タイプのフォントサイズ"),
        "numberTypePosition": MessageLookupByLibrary.simpleMessage("番号タイプの位置"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting": MessageLookupByLibrary.simpleMessage("OneDrive設定"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("オンライン発信者番号購読"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification":
            MessageLookupByLibrary.simpleMessage("元の通話アプリの通知のみ"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("ローカル通知のみを鳴らす"),
        "onlyUseOriginalSmsNotification":
            MessageLookupByLibrary.simpleMessage("元のSMS通知のみを使用する"),
        "openLocalFolder": MessageLookupByLibrary.simpleMessage("ローカルフォルダを開く"),
        "other": MessageLookupByLibrary.simpleMessage("その他"),
        "overlay": MessageLookupByLibrary.simpleMessage("オーバーレイ"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "オーバーレイ権限が付与されていません。これは、発信者番号の機能に影響を与える可能性があります。アプリの設定でこの権限を有効にできます。"),
        "page": MessageLookupByLibrary.simpleMessage("ページ"),
        "password": MessageLookupByLibrary.simpleMessage("パスワード"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("JSONを貼り付ける"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("JSON設定を貼り付ける"),
        "pasteJsonHere": MessageLookupByLibrary.simpleMessage("ここにJSONを貼り付ける"),
        "pattern": MessageLookupByLibrary.simpleMessage("パターン"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied": MessageLookupByLibrary.simpleMessage("権限が拒否されました"),
        "permissionGranted": MessageLookupByLibrary.simpleMessage("権限が付与されました"),
        "permissionInAppSetting":
            MessageLookupByLibrary.simpleMessage("：アプリの設定で権限を手動で無効にする必要があります。"),
        "permissionInTheAppSettings":
            MessageLookupByLibrary.simpleMessage("アプリの設定の権限。"),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("権限が付与されませんでした。"),
        "permissions": MessageLookupByLibrary.simpleMessage("権限"),
        "permissionsRequired": MessageLookupByLibrary.simpleMessage("必要な権限"),
        "phone": MessageLookupByLibrary.simpleMessage("電話"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("固定電話"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("固定電話,携帯電話"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("携帯電話"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("ポケベル"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("個人番号"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("プレミアムレート"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("共有コスト"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("フリーダイヤル"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown": MessageLookupByLibrary.simpleMessage("不明"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("ボイスメール"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("電話番号"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("入力してください"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("電話番号を入力してください"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("パターンを入力してください"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("URLを入力してください"),
        "pleaseSelectAFileOrInputAUrl":
            MessageLookupByLibrary.simpleMessage("ファイルを選択するか、URLを入力してください"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("ラベルを選択してください"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("エクスポートフォルダを選択してください"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("出力ファイルを選択してください："),
        "pleaseSelectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("エクスポートするエントリを選択してください"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "「権限を付与」をタップし、次の画面で権限を許可してください。"),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "「デフォルトに設定」をタップし、次の画面で権限を許可してください。"),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage("データベースの初期化が完了するまでお待ちください。"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("プラグインページ"),
        "plugins": MessageLookupByLibrary.simpleMessage("プラグイン"),
        "pluginspageview": MessageLookupByLibrary.simpleMessage("プラグインページビュー"),
        "political": MessageLookupByLibrary.simpleMessage("政治"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "regex": MessageLookupByLibrary.simpleMessage("正規表現"),
        "regexPage": MessageLookupByLibrary.simpleMessage("正規表現ページ"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("正規表現パターンの説明"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "正規表現パターンは、電話番号の照合に使用される正規表現です。"),
        "regexpageview": MessageLookupByLibrary.simpleMessage("正規表現ページビュー"),
        "region": MessageLookupByLibrary.simpleMessage("地域："),
        "reject": MessageLookupByLibrary.simpleMessage("拒否"),
        "rejectAllNumbers": MessageLookupByLibrary.simpleMessage("すべての番号を拒否する"),
        "remove": MessageLookupByLibrary.simpleMessage("削除"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup":
            MessageLookupByLibrary.simpleMessage("広告を削除してオンラインバックアップを有効にする"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage("許可から削除"),
        "removeAllowedtype": m4,
        "removeBlocked": MessageLookupByLibrary.simpleMessage("ブロックから削除"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("繰り返しブロックされた通話（分）"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("繰り返しの通話"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Googleドライブから復元"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage("ローカルから復元"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("OneDriveから復元"),
        "restoreFromWebdav": MessageLookupByLibrary.simpleMessage("WebDAVから復元"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("ライドシェア"),
        "risk": MessageLookupByLibrary.simpleMessage("リスク"),
        "robocall": MessageLookupByLibrary.simpleMessage("ロボコール"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts": MessageLookupByLibrary.simpleMessage("連絡先を検索"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("エントリを検索"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("ラベルを選択："),
        "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
        "selectColor": MessageLookupByLibrary.simpleMessage("色を選択"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("国コードを選択（オプション）"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("エントリを選択"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("エクスポートするエントリを選択"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage("選択した連絡先が正常にマージされました"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("選択されたラベル"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("エクスポートフォルダを選択しています"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays":
            MessageLookupByLibrary.simpleMessage("サービス更新間隔（日）"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "settingsSaved": MessageLookupByLibrary.simpleMessage("設定が保存されました"),
        "setupDefault": MessageLookupByLibrary.simpleMessage("デフォルトに設定"),
        "setupDefaultCallerIdApp":
            MessageLookupByLibrary.simpleMessage("デフォルトの発信者番号アプリに設定"),
        "sharing": MessageLookupByLibrary.simpleMessage("共有"),
        "showContactButton": MessageLookupByLibrary.simpleMessage("連絡先ボタンを表示"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("連絡先アイコンボタンを表示"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("Telegramを表示"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("WhatsAppを表示"),
        "showingResultsFor": MessageLookupByLibrary.simpleMessage("結果を表示"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer": MessageLookupByLibrary.simpleMessage("サイレント、応答なし"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("SIMカードの色"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("SIMカードのフォントサイズ"),
        "simCardPosition": MessageLookupByLibrary.simpleMessage("SIMカードの位置"),
        "skip": MessageLookupByLibrary.simpleMessage("スキップ"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMSブラックリストページ"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("SMSフィルタリング"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "SMSフィルタリングには、SMS、通知、および電話の権限が必要です。この機能を有効にするには、これらの権限を付与してください。"),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMSローカル通知"),
        "smsNotification": MessageLookupByLibrary.simpleMessage("SMS通知"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage": MessageLookupByLibrary.simpleMessage("SMS購読ページ"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage":
            MessageLookupByLibrary.simpleMessage("SMSテキストホワイトリストページ"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview":
            MessageLookupByLibrary.simpleMessage("SmsBlacklistPageView"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("SmsSubscriptionListView"),
        "smstextblacklistpageview":
            MessageLookupByLibrary.simpleMessage("SmsTextBlacklistPageView"),
        "smstextwhitelistpageview":
            MessageLookupByLibrary.simpleMessage("SmsTextWhitelistPageView"),
        "smswhitelistpageview":
            MessageLookupByLibrary.simpleMessage("SmsWhitelistPageView"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("スパムの可能性が高い"),
        "startColor": MessageLookupByLibrary.simpleMessage("開始色"),
        "statisticsTimeRangeMinutes":
            MessageLookupByLibrary.simpleMessage("統計の時間範囲（分）："),
        "stirColor": MessageLookupByLibrary.simpleMessage("STIRカラー"),
        "stirFontSize": MessageLookupByLibrary.simpleMessage("STIRのフォントサイズ"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("STIRの位置"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("ストレージ"),
        "subscribe": MessageLookupByLibrary.simpleMessage("購読"),
        "subscribed": MessageLookupByLibrary.simpleMessage("購読済み"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("購読済みリンク"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("購読リストページ"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("購読リストビュー"),
        "successfully": MessageLookupByLibrary.simpleMessage("成功しました"),
        "survey": MessageLookupByLibrary.simpleMessage("調査"),
        "sync": MessageLookupByLibrary.simpleMessage("同期"),
        "system": MessageLookupByLibrary.simpleMessage("システム"),
        "takeaway": MessageLookupByLibrary.simpleMessage("テイクアウト"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("テレマーケティング"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("テスト"),
        "textLabelColors": MessageLookupByLibrary.simpleMessage("テキストとラベルの色"),
        "textType": MessageLookupByLibrary.simpleMessage("テキストタイプ"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "このアプリは、未知の発信者を識別し、不要な電話をブロックできる強力な発信者番号ツールです。その機能は次のとおりです。"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "このアプリが正常に機能するには、通話履歴情報へのアクセスが必要です。権限を付与してください。"),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "この権限は、アプリをデフォルトの発信者番号アプリにするために必要です。"),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "この権限は、アプリが他のアプリの上に重要な情報を表示するために必要です。"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("チュートリアル"),
        "unknown": MessageLookupByLibrary.simpleMessage("不明"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("購読解除済み"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("URL形式が正しくありません"),
        "useNetworkImage": MessageLookupByLibrary.simpleMessage("ネットワーク画像を使用"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "「.」文字を使用して、任意の1文字に一致させます。たとえば、「123.456」パターンは、「123-456」、「123.456」、「123a456」などに一致します。"),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "「\'^0[0-9]{2,3}\'」パターンを使用して、「0」で始まり、その後に2桁または3桁の数字が続く電話番号に一致させます。これは通常、市外局番を表します。\n「^010」パターンを使用して、北京の市外局番（010）からの通話をブロックします。\n「^202」パターンを使用して、ワシントンの市外局番（202）からの通話をブロックします。\n「\'^0[0-9]{2,3}\'」市外局番を、ブロックする特定の市外局番に置き換えます。"),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "「\'[0-9]{3}-[0-9]{4}-[0-9]{4}\'」パターンを使用して、「XXX-XXXX-XXXX」形式の電話番号に一致させます。「X」を、照合する特定の数字に置き換えます。"),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "「^\\+」パターンを使用して、プラス記号で始まるすべての電話番号に一致させます。プラス記号は通常、国際番号を示します。"),
        "userName": MessageLookupByLibrary.simpleMessage("ユーザー名"),
        "verified": MessageLookupByLibrary.simpleMessage("確認済み"),
        "video": MessageLookupByLibrary.simpleMessage("ビデオ"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("WebDAV設定"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
        "website": MessageLookupByLibrary.simpleMessage("ウェブサイト"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("ホワイトリスト"),
        "whitelistPage": MessageLookupByLibrary.simpleMessage("ホワイトリストページ"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("ホワイトリストページビュー"),
        "width": MessageLookupByLibrary.simpleMessage("幅"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage("柔軟なフィルタリングのためのワイルドカードサポート"),
        "windowSize": MessageLookupByLibrary.simpleMessage("ウィンドウサイズ"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "標準の正規表現構文を使用してパターンを定義するか、AIにFlutterのパターンを生成させることができます。"),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage("権限を拒否しました。設定で手動で権限を有効にできます。"),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("権限を有効にしました。"),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("手動で無効にする必要があります"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
