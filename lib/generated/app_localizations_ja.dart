// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get aboutContactSubscription => '連絡先サブスクリプションについて';

  @override
  String get aboutLabels => 'ラベルについて';

  @override
  String get aboutPhoneSubscriptionRules => '電話サブスクリプションルールについて';

  @override
  String get aboutPhoneSubscriptions => '電話サブスクリプションについて';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'URL経由で電話ルールリストをサブスクライブし、ルールを自動的に更新します。JSON、CSV形式のルールファイルをサポートしています。';

  @override
  String get aboutSmsFilter => 'SMSフィルタリングについて';

  @override
  String get aboutSmsSubscriptionRules => 'SMSサブスクリプションルールについて';

  @override
  String get aboutSubtitle => 'アプリケーションのバージョンと法的情報';

  @override
  String get aboutTitle => '概要';

  @override
  String get action => 'アクション';

  @override
  String get actionAll => 'すべて';

  @override
  String get actionAllow => '許可';

  @override
  String get actionBlock => 'ブロック';

  @override
  String get actionFilterAll => 'すべてのフィルター';

  @override
  String get actionFilterTitle => 'アクションタイプでフィルタリング';

  @override
  String get actionFilterTooltip => 'アクションフィルター';

  @override
  String get actionNone => 'アクションなし';

  @override
  String get actionSilence => 'サイレント';

  @override
  String actionTag(Object actionType) {
    return 'アクション: $actionType';
  }

  @override
  String get actionType => 'アクションタイプ';

  @override
  String get actionUnknown => '不明';

  @override
  String get add => '追加';

  @override
  String get addAllowedBlockedRule => '許可/ブロックルールを追加';

  @override
  String get addAllowSubscription => '許可サブスクリプションを追加';

  @override
  String get addBlockSubscription => 'ブロックサブスクリプションを追加';

  @override
  String get addContactButton => '連絡先を追加';

  @override
  String addContactFailed(Object error) {
    return '連絡先の追加に失敗しました: $error';
  }

  @override
  String get addedToAllowedRules => '許可ルールに追加されました';

  @override
  String get addedToBlacklist => 'ブラックリストに追加されました';

  @override
  String get addedToBlockedRules => 'ブロックルールに追加されました';

  @override
  String get addedToFavoriteContacts => 'お気に入りの連絡先に追加されました';

  @override
  String get addedToFavorites => 'お気に入りの連絡先に追加されました';

  @override
  String get addedToWhitelist => 'ホワイトリストに追加されました';

  @override
  String get addFavorite => 'お気に入りに追加';

  @override
  String get addFilter => 'フィルターを追加';

  @override
  String get addLabel => 'ラベルを追加';

  @override
  String get addLabelButton => 'ラベルを追加';

  @override
  String addLabelFailed(Object error) {
    return 'ラベルの追加に失敗しました: $error';
  }

  @override
  String get addLabelToCall => '通話記録にラベルを追加';

  @override
  String get addName => '名前を追加';

  @override
  String get addNoneSubscription => 'なしサブスクリプションを追加';

  @override
  String get addOrEditContactInfo => '連絡先情報を追加または編集するために使用';

  @override
  String get addPhoneMark => '電話マークを追加';

  @override
  String get addPhoneNumberRule => '電話番号ルールを追加';

  @override
  String get addPlugin => 'プラグインを追加';

  @override
  String get addPluginFailed => 'プラグインの追加に失敗しました';

  @override
  String addPluginFailedWithError(Object error) {
    return 'プラグインの追加に失敗しました: $error';
  }

  @override
  String get addPluginFromLocalFile => 'ローカルファイルからプラグインを追加';

  @override
  String get addPluginFromUrl => 'URLからプラグインを追加';

  @override
  String get addRegexRule => '正規表現ルールを追加';

  @override
  String get addRule => 'ルールを追加';

  @override
  String get addRuleButton => 'ルールを追加';

  @override
  String addRuleFailed(Object error) {
    return 'ルールの追加に失敗しました: $error';
  }

  @override
  String get addRuleTooltip => 'ルールを追加';

  @override
  String get addSilenceSubscription => 'サイレンスサブスクリプションを追加';

  @override
  String get addSimRuleButton => 'SIMルールを追加';

  @override
  String get addSmsFilterRule => 'SMSフィルタールールを追加';

  @override
  String get addSmsRule => 'SMSルールを追加';

  @override
  String get addSmsSubscription => 'SMSサブスクリプションを追加';

  @override
  String get addSubscription => 'サブスクリプションを追加';

  @override
  String get addSubscriptionButton => 'サブスクリプションを追加';

  @override
  String addSubscriptionFailed(Object error) {
    return 'サブスクリプションの追加に失敗しました: $error';
  }

  @override
  String get addSubscriptionTooltip => 'サブスクリプションを追加';

  @override
  String get addToAllowedRules => '許可ルールに追加';

  @override
  String get addToBlacklist => 'ブラックリストに追加';

  @override
  String get addToBlockedRules => 'ブロックされたルールに追加';

  @override
  String get addToFavoriteContacts => 'お気に入りの連絡先に追加';

  @override
  String get addToFavorites => 'お気に入りに追加';

  @override
  String get addToRules => 'ルールに追加';

  @override
  String get addToWhitelist => 'ホワイトリストに追加';

  @override
  String get adPlaceholder => '広告プレースホルダー';

  @override
  String get agent => 'エージェント';

  @override
  String get all => 'すべて';

  @override
  String get allCallsTab => 'すべて';

  @override
  String get allDataClearedSuccessfully => 'すべてのデータが正常にクリアされました';

  @override
  String get allow => '許可';

  @override
  String get allowAllAllowRules => 'すべての許可ルールを許可する';

  @override
  String get allowAllAllowRulesDesc => '許可ルールからの通話を許可する';

  @override
  String get allowAllBlacklistedNumbers => 'すべてのブラックリストに登録された番号を許可する';

  @override
  String get allowAllBlacklistedNumbersDesc => 'ブラックリストからの通話を許可する';

  @override
  String get allowAllBlockRules => 'すべてのブロックルールを許可する';

  @override
  String get allowAllBlockRulesDesc => 'ブロックルールからの通話を許可する';

  @override
  String get allowAllowedNumbers => '許可された番号を許可する';

  @override
  String get allowAllowedNumbersDesc => '許可リストからの通話を許可する';

  @override
  String get allowBlock => '許可/ブロック';

  @override
  String get allowBlockedNumbers => 'ブロックされた番号を許可する';

  @override
  String get allowBlockedNumbersDesc => 'ブロックリストからの通話を許可する';

  @override
  String get allowedBlockedRule => '許可/ブロックルール';

  @override
  String get allowedBlockedRuleEditDialogTitle => '許可/ブロックルールの編集';

  @override
  String get allowedBlockedRuleManagement => '許可/ブロックルールの管理';

  @override
  String get allowNonExceededNumbers => '制限を超えない番号を許可する';

  @override
  String get allowNonExceededNumbersDescription => 'カウントのしきい値を超えない番号を自動的に許可する';

  @override
  String get allowRegexAllowRules => 'Regex許可ルールを許可する';

  @override
  String get allowRegexAllowRulesDesc => '許可ルールの正規表現パターンマッチングを有効にする';

  @override
  String get allowRegexAllowRulesDescription => '正規表現ベースの許可ルールを有効にする';

  @override
  String get allowRegexBlockRules => 'Regexブロックルールを許可する';

  @override
  String get allowRegexBlockRulesDesc => 'ブロックルールの正規表現パターンマッチングを有効にする';

  @override
  String get allowRegexBlockRulesDescription => '正規表現ベースのブロックルールを有効にする';

  @override
  String get allowRule => '許可ルール';

  @override
  String get allowRules => '許可ルール';

  @override
  String get allowWhitelistedNumbers => 'ホワイトリストに登録された番号を許可する';

  @override
  String get allowWhitelistedNumbersDescription => 'ホワイトリストのすべての番号を許可する';

  @override
  String get allPermissionsGranted => 'すべての権限が付与されました';

  @override
  String get allSettingsCompleted => 'すべての設定が完了しました。';

  @override
  String allUpdateSuccess(Object count) {
    return 'すべての更新が完了しました ($count 件のルール)';
  }

  @override
  String get answerThenHangup => '応答してから電話を切る';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule。All rights reserved.';

  @override
  String get applicationSoftware => 'アプリケーションソフトウェア';

  @override
  String get apply => '適用';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      '認証に失敗しました: クライアントIDとキーを確認してください';

  @override
  String get authorizationFailedMessage => '認証に失敗しました';

  @override
  String get authorizationSuccessMessage => '認証に成功しました';

  @override
  String get authorizeLoginButton => 'ログインを認証';

  @override
  String get automotiveIndustry => '自動車産業';

  @override
  String get autoSyncLabel => '自動同期';

  @override
  String get autoUpdate => '自動更新';

  @override
  String get autoUpdateDescription => 'サブスクリプションの自動更新間隔を設定するか、手動で更新します';

  @override
  String get autoUpdateSettings => '自動更新設定';

  @override
  String get autoUpdateSettingsSubtitle => 'ルールとプラグインの自動更新を管理する';

  @override
  String get autoUpdateSettingsTitle => '自動更新設定';

  @override
  String get autoUpdateSubtitle => 'ルールとプラグインの自動更新を管理する';

  @override
  String get autoUpdateTitle => '自動更新';

  @override
  String get avatarBorderColor => 'アバターの境界線の色';

  @override
  String get avatarBorderSize => 'アバターの境界線のサイズ';

  @override
  String get avatarIconSizesSetting => 'アバターとアイコンのサイズ';

  @override
  String get avatarPosition => 'アバターの位置';

  @override
  String get avatarSize => 'アバターのサイズ';

  @override
  String axisPosition(Object axis) {
    return '$axis の位置';
  }

  @override
  String get backgroundGradientSetting => '背景のグラデーション';

  @override
  String get backup => 'バックアップ';

  @override
  String get backupAndRestore => 'バックアップと復元';

  @override
  String get backupAndRestoreSubtitle => 'アプリケーションデータをバックアップまたは復元します';

  @override
  String get backupAndRestoreTitle => 'バックアップと復元';

  @override
  String get backupFailed => 'バックアップに失敗しました';

  @override
  String get backupFailedMessage => 'バックアップに失敗しました';

  @override
  String backupFailedWithError(Object error) {
    return 'バックアップに失敗しました: $error';
  }

  @override
  String get backupRestoreSubtitle => 'アプリケーションデータをバックアップまたは復元します';

  @override
  String get backupRestoreTitle => 'バックアップと復元';

  @override
  String get backupSectionTitle => 'バックアップ';

  @override
  String get backupSettings => 'バックアップ設定';

  @override
  String get backupSettingsDialogTitle => 'バックアップ設定';

  @override
  String get backupSettingsTitle => 'バックアップ設定';

  @override
  String get backupSuccessMessage => 'クラウドへのバックアップに成功しました';

  @override
  String backupSuccessToLocal(Object path) {
    return 'ローカルへのバックアップに成功しました: $path';
  }

  @override
  String get backupToCloud => 'クラウドにバックアップ';

  @override
  String get backupToCloudDescription => '設定とルールをクラウドストレージにバックアップします';

  @override
  String backupToCloudFailed(Object error) {
    return 'クラウドへのバックアップに失敗しました: $error';
  }

  @override
  String get backupToCloudLabel => 'クラウドにバックアップ';

  @override
  String get backupToCloudSuccess => 'クラウドへのバックアップに成功しました';

  @override
  String get backupToCloudTitle => 'クラウドにバックアップ';

  @override
  String get backupToLocalLabel => 'ローカルにバックアップ';

  @override
  String get bank => '銀行';

  @override
  String get basicInfo => '基本情報';

  @override
  String get basicRuleFilter => '基本ルールフィルタ';

  @override
  String get basicRuleFiltering => '基本ルールフィルタリング';

  @override
  String get basicRuleFilteringExplanation =>
      '• 基本ルールフィルタリング：ブラックリスト、ホワイトリスト、および正規表現に基づくフィルタリングルール';

  @override
  String get basicRuleFilterSettings => '基本ルールフィルタ設定';

  @override
  String get basicRuleFilterSubtitle =>
      'ブラックリスト/ホワイトリストと正規表現を使用して通話をフィルタリングします';

  @override
  String get batchDeleteContacts => '連絡先を一括削除';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '$count 件の選択した連絡先を削除してもよろしいですか？';
  }

  @override
  String get batchDeleteFailed => '一括削除に失敗しました';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '$count 個のラベルを削除してもよろしいですか？';
  }

  @override
  String get blacklist => 'ブラックリスト';

  @override
  String get blacklistingAndWhitelisting => 'ブラックリストとホワイトリスト';

  @override
  String get blacklistLabel => 'ブラックリスト';

  @override
  String get blackWhiteList => 'ブラック/ホワイトリスト';

  @override
  String get block => 'ブロック';

  @override
  String get blockCalls => '通話をブロック';

  @override
  String get blocked => 'ブロック済み';

  @override
  String get blockedCallAction => 'ブロックされた通話の処理';

  @override
  String get blockedCalls => 'ブロックされた通話';

  @override
  String get blockedCallsTitle => 'ブロックされた通話';

  @override
  String get blockedCommunications => 'ブロックされた通信';

  @override
  String get blockedPhoneLabel => 'ブロックされた通話';

  @override
  String get blockedSpamCalls => 'ブロックされた迷惑電話';

  @override
  String get blockingTrend => 'ブロックの傾向';

  @override
  String get blockInternationalCalls => '+ または 00 で始まらない番号に一致します';

  @override
  String get blockInternationalCallsTitle => '国際電話をブロック';

  @override
  String get blockLandlineNumbersTitle => '固定電話番号をブロック';

  @override
  String get blockMobileNumbers => '13～19 で始まらない番号に一致します';

  @override
  String get blockMobileNumbersTitle => '携帯電話番号をブロック';

  @override
  String get blockPremiumRateNumbers => '118 または 120～190 で始まらない番号に一致します';

  @override
  String get blockPremiumRateNumbersTitle => 'プレミアムレート番号をブロック';

  @override
  String get blockRule => 'ブロックルール';

  @override
  String get blockRules => 'ブロックルール';

  @override
  String get blockSpecificAreaCodes => '0 + 2～3 桁で始まる番号に一致します';

  @override
  String get blockSpecificAreaCodesTitle => '特定の市外局番をブロック：';

  @override
  String get blockTypeAnalysisTitle => 'ブロックタイプの分析';

  @override
  String get both => '両方';

  @override
  String get bulkDelete => '連絡先を一括削除';

  @override
  String get bulkDeleteContacts => '連絡先を一括削除';

  @override
  String get bulkDeleteLabels => 'ラベルを一括削除';

  @override
  String get call => '電話';

  @override
  String get callback => 'コールバック';

  @override
  String callbackTo(String number) {
    return '$number にコールバックする';
  }

  @override
  String get callBlocking => '通話ブロック';

  @override
  String get callerIdApp => '発信者番号アプリ';

  @override
  String get callerIdCustomizationTitle => '発信者番号をカスタマイズ';

  @override
  String get callerIdDialogTitle => '発信者番号情報';

  @override
  String get callerIdDisplayMode => '発信者ID表示モード';

  @override
  String callerIdMarkedByCount(Object count) {
    return '$count によってマークされました';
  }

  @override
  String get callerIdPreview => '発信者IDプレビュー';

  @override
  String get callFilter => '通話フィルター';

  @override
  String get callFilterDescription =>
      '有効にすると、着信は以下のルールリストと照合されます。通話フィルタリングルールは、デフォルトではデバイス間で同期されません。';

  @override
  String get callFilterRules => '通話フィルタールール';

  @override
  String get callFilterRulesDescription => '通話フィルタリングの基本的なルールを設定する';

  @override
  String get callFilterSettings => '通話フィルター設定';

  @override
  String get callFrequencyInterceptionSubtitle => '通話頻度の制限とブロックルールを設定する';

  @override
  String get callFrequencyInterceptionTitle => '通話頻度インターセプション';

  @override
  String get callHistory => '通話履歴';

  @override
  String get callHistoryInfoDesc => '着信、発信、不在着信を含む、あなたの通話履歴を表示します。';

  @override
  String get callHistoryInfoTitle => '通話履歴';

  @override
  String callHistoryInitFailed(Object error) {
    return '通話履歴の初期化に失敗しました: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '通話履歴の更新に失敗しました: $error';
  }

  @override
  String get callHistoryTab => '通話履歴';

  @override
  String get callHistoryTimelineEarlier => 'それ以前';

  @override
  String get callHistoryTimelineToday => '今日';

  @override
  String get callHistoryTimelineYesterday => '昨日';

  @override
  String get callScreeningPermission => '通話スクリーニング権限';

  @override
  String get callScreeningPermissionDescription => 'スパム通話のスクリーニングとブロックに使用されます。';

  @override
  String get callScreeningPermissionNotGranted =>
      '通話スクリーニング権限が付与されていません。アプリの機能に影響する可能性があります。';

  @override
  String get callSettingsSubtitle => '発信者ID、フィルタリング、ブロック設定';

  @override
  String get callSettingsTitle => '通話設定';

  @override
  String get callStatistics => '通話統計';

  @override
  String get callTypeAnswered => '応答済み';

  @override
  String get callTypeBlocked => 'ブロック';

  @override
  String get callTypeIconColor => '通話タイプのアイコンの色';

  @override
  String get callTypeMissed => '不在着信';

  @override
  String get callTypeOutgoing => '発信';

  @override
  String get callTypePosition => '通話タイプの位置';

  @override
  String get callTypeUnknown => '不明';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get carRental => 'レンタカー';

  @override
  String get carrier => 'キャリア';

  @override
  String get carrierColor => 'キャリアの色';

  @override
  String get carrierFontSize => 'キャリアのフォントサイズ';

  @override
  String get carrierPosition => 'キャリアの位置';

  @override
  String get changeLabel => 'ラベルを変更';

  @override
  String changePluginStatusFailed(Object error) {
    return 'プラグインステータスの変更に失敗しました: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'サブスクリプションステータスの変更に失敗しました: $error';
  }

  @override
  String get changeTag => 'タグを変更';

  @override
  String get charity => '慈善団体';

  @override
  String chartMonthFormat(int month) {
    return '$month 月';
  }

  @override
  String get chartOneDayAgo => '1 日前';

  @override
  String get chartOneMonthAgo => '1 か月前';

  @override
  String get chartOneWeekAgo => '1 週間前';

  @override
  String get chartTenDaysAgo => '10 日前';

  @override
  String get chartThreeDaysAgo => '3 日前';

  @override
  String get chartToday => '今日';

  @override
  String get checkFileFormat => 'ファイル形式または権限を確認してください';

  @override
  String checkPermissionFailed(Object error) {
    return '権限の確認に失敗しました: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'デフォルトのインターセプトアクションを選択';

  @override
  String get clearAllData => 'すべてのデータを消去';

  @override
  String get clearAllDataConfirmation =>
      '本当にすべてのアプリケーションデータを消去しますか？この操作は元に戻せません。';

  @override
  String get clearAllDataDescription => 'すべてのアプリケーションデータを消去';

  @override
  String get clearAllDataLabel => 'すべてのデータを消去';

  @override
  String get clearFilter => 'フィルターをクリア';

  @override
  String get clearLabelFilter => 'ラベルフィルターをクリア';

  @override
  String get clearLabelFilterButton => 'ラベルフィルターをクリア';

  @override
  String get closeButton => '閉じる';

  @override
  String get cloudSync => 'クラウド同期';

  @override
  String get cloudSyncAndBackupTitle => 'クラウド同期とバックアップ';

  @override
  String get cloudSyncSettingsSubtitle => 'WebDAV、OneDrive、Google Driveを設定する';

  @override
  String get cloudSyncSettingsTitle => 'クラウド同期設定';

  @override
  String get cloudSyncTitle => 'クラウド同期';

  @override
  String get collapseLabelSelector => 'ラベルセレクターを折りたたむ';

  @override
  String get collection => '債権回収';

  @override
  String get colorPickerTitle => '色を選択';

  @override
  String get configManagement => '構成管理';

  @override
  String get configUpdated => '構成を更新しました';

  @override
  String get configurationAdvice =>
      '適切な構成を通じて、仕事用と個人用のSIMカードに異なるフィルタリング戦略を設定できます。';

  @override
  String get configureBackupOptions => 'バックアップオプションを設定';

  @override
  String get configureBackupOptionsSubtitle => 'バックアップオプションを設定';

  @override
  String get configureCloudSyncService => 'クラウド同期サービスを設定';

  @override
  String get configureCloudSyncServiceHint =>
      'マルチデバイス同期を有効にするには、クラウド同期サービスを設定してください。';

  @override
  String get configureCloudSyncServiceMessage =>
      'マルチデバイス同期を有効にするには、クラウド同期サービスを設定してください。';

  @override
  String get configureSimCardFilterRules => 'SIMカードフィルタールールを設定';

  @override
  String get configureSyncServiceHint => 'まずクラウド同期設定で同期サービスを設定してください';

  @override
  String get confirm => '確認';

  @override
  String get confirmBatchDeleteContacts => '選択したものを削除してもよろしいですか';

  @override
  String get confirmButton => '確認';

  @override
  String get confirmDelete => '削除の確認';

  @override
  String get confirmDeleteContact => '本当に削除しますか';

  @override
  String get confirmDeleteContactName => '削除の確認？';

  @override
  String get confirmDeleteFilter => '本当にこのフィルターを削除しますか？';

  @override
  String confirmDeleteLabel(Object name) {
    return 'ラベル \"$name\" を削除してもよろしいですか';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'プラグイン \"$name\" を削除してもよろしいですか？';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '$count個のプラグインを削除してもよろしいですか？';
  }

  @override
  String get confirmDeleteRuleMessage => '本当にこのルールを削除しますか？この操作は元に戻せません。';

  @override
  String get confirmDeleteSelectedContacts => '選択した連絡先を削除してもよろしいですか？';

  @override
  String get confirmDeleteSmsFilterRule => '本当にこのSMSフィルタールールを削除しますか？';

  @override
  String get confirmDeleteSmsRule => '本当にこのSMSルールを削除しますか？';

  @override
  String get confirmDeleteSubscription => 'このサブスクリプションを削除してもよろしいですか？';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '$nameを削除してもよろしいですか？';
  }

  @override
  String get confirmPassword => 'パスワードの確認';

  @override
  String get confirmPasswordLabel => 'パスワードの確認';

  @override
  String get connectedStatus => '接続済み';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      '接続に失敗しました: サーバーアドレス、ユーザー名、パスワードを確認してください';

  @override
  String get connectionFailedMessage => '接続に失敗しました';

  @override
  String get connectionStatusLabel => '接続ステータス';

  @override
  String get connectionSuccessMessage => '接続に成功しました';

  @override
  String get contactAddSuccess => '連絡先が正常に追加されました';

  @override
  String get contactDeleted => '連絡先を削除しました';

  @override
  String get contactEditDialog => '連絡先編集ダイアログ';

  @override
  String get contactNameHint => '連絡先名を入力してください (任意)';

  @override
  String get contactNameLabel => '名前';

  @override
  String get contactNameOptional => '連絡先名 (任意)';

  @override
  String get contactNotFound => '連絡先が見つかりません';

  @override
  String get contacts => '連絡先';

  @override
  String contactsDeleted(Object count) {
    return '$count 件の連絡先を削除しました';
  }

  @override
  String get contactSettingsSubtitle => '連絡先の管理とラベル設定';

  @override
  String get contactSettingsTitle => '連絡先設定';

  @override
  String contactsLoadingFailed(Object error) {
    return '連絡先の読み込みに失敗しました: $error';
  }

  @override
  String get contactsManagement => '連絡先管理';

  @override
  String get contactsManagementPageTitle => '連絡先管理ページ';

  @override
  String get contactsPageTitle => '連絡先';

  @override
  String get contactsPermission => '連絡先権限';

  @override
  String get contactsPermissionDescription => '連絡先通話を識別するために使用します。';

  @override
  String get contactsTab => '連絡先';

  @override
  String get contactSubscriptionDescription =>
      'URL経由で連絡先リストを購読し、連絡先情報とラベルを自動的に更新します。JSON形式のデータをサポートします。';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '連絡先サブスクリプションの読み込みに失敗しました: $error';
  }

  @override
  String get contactSubscriptionPageTitle => '連絡先サブスクリプション';

  @override
  String get contactUpdateSuccess => '連絡先が正常に更新されました';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get content => 'コンテンツ';

  @override
  String get contentRegex => 'コンテンツ正規表現';

  @override
  String get countColor => 'カウントの色';

  @override
  String get countFontSize => 'カウントのフォントサイズ';

  @override
  String get countPosition => 'カウントの位置';

  @override
  String get country => '国';

  @override
  String get countryNameColor => '国名の色';

  @override
  String get countryNameFontSize => '国名のフォントサイズ';

  @override
  String get countryRegionNamePosition => '国/地域名の位置';

  @override
  String get countrySelectionDialog => '国選択ダイアログ';

  @override
  String get countrySelectionDialogDescription => '発信者番号情報を照会する国を選択するために使用します';

  @override
  String get countThresholdDescription =>
      'フィルタリングアクションをトリガーするために必要な最小カウントのしきい値を設定します';

  @override
  String get countThresholdLabel => 'カウントのしきい値';

  @override
  String get countThresholdSettings => 'カウントのしきい値設定';

  @override
  String countThresholdValue(Object count) {
    return 'カウントのしきい値: $count';
  }

  @override
  String get createdRules => '作成されたルール';

  @override
  String get csvFormat => 'CSV形式';

  @override
  String get currentDeviceChip => '現在';

  @override
  String get currentDeviceLabel => '現在のデバイスラベル';

  @override
  String get currentDeviceTitle => '現在のデバイス';

  @override
  String get currentLabels => '現在のラベル:';

  @override
  String get currentLanguage => '現在の言語';

  @override
  String get currentPasswordLabel => '現在のパスワード';

  @override
  String get customerService => 'カスタマーサービス';

  @override
  String get customRange => 'カスタム範囲';

  @override
  String get dailyStatistics => '毎日の統計';

  @override
  String get dailyStatisticsDesc => 'ブロックされた通話とメッセージに関する毎日の統計を受け取ります';

  @override
  String get dashboardTab => 'ダッシュボード';

  @override
  String get dataAnalysis => 'データ分析';

  @override
  String get dataAnalysisDashboardPage => 'データ分析ダッシュボードページ';

  @override
  String get dataExport => 'データエクスポート';

  @override
  String dataLoadFailure(Object error) {
    return 'データの読み込みに失敗しました: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'データの読み込みに失敗しました: $error';
  }

  @override
  String get dataMigration => 'データ移行';

  @override
  String get dataMigrationDescription =>
      'この機能により、デバイス間でデータをすべて転送できます。現在、バックアップと復元機能を使用して、手動でデータを移行できます。';

  @override
  String get dataMigrationDialogContent =>
      'この機能により、デバイス間でデータをすべて転送できます。現在、バックアップと復元機能を使用して、手動でデータを移行できます。';

  @override
  String get dataMigrationDialogTitle => 'データ移行';

  @override
  String get dataMigrationSectionTitle => 'データ移行';

  @override
  String get dataSourceReminder => 'データソースのリマインダー';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日',
      one: '1日',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days 日間VIP';
  }

  @override
  String get debtCollection => '債権回収';

  @override
  String get defaultPeriod => '週';

  @override
  String get delete => '削除';

  @override
  String get deleteButton => '削除';

  @override
  String get deleteContact => '連絡先を削除';

  @override
  String deleteContactConfirm(Object name) {
    return '$nameを削除してもよろしいですか？';
  }

  @override
  String get deleteContactConfirmation => '連絡先を削除してもよろしいですか？';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '$deviceNameを削除してもよろしいですか？';
  }

  @override
  String get deleteDeviceDialogTitle => 'デバイスを削除';

  @override
  String deleteFailed(Object error) {
    return '削除に失敗しました: $error';
  }

  @override
  String get deleteFilter => 'フィルターを削除';

  @override
  String get deleteLabel => 'ラベルを削除';

  @override
  String deleteLabelFailed(Object error) {
    return 'ラベルの削除に失敗しました: $error';
  }

  @override
  String get deletePlugin => 'プラグインを削除';

  @override
  String deletePluginFailed(Object error) {
    return 'プラグインの削除に失敗しました: $error';
  }

  @override
  String get deletePlugins => 'プラグインを削除';

  @override
  String deletePluginsFailed(Object error) {
    return 'プラグインの削除に失敗しました: $error';
  }

  @override
  String get deleteRule => 'ルールを削除';

  @override
  String deleteRuleFailed(Object error) {
    return '削除に失敗しました: $error';
  }

  @override
  String get deleteSelected => '選択したものを削除';

  @override
  String get deleteSmsRule => 'SMSルールを削除';

  @override
  String get deleteSubscription => 'サブスクリプションを削除';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'サブスクリプション \"$name\" を削除してもよろしいですか？';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'サブスクリプションの削除に失敗しました: $error';
  }

  @override
  String get deleteSuccess => '削除に成功しました';

  @override
  String get delivery => '配信';

  @override
  String get deviceDeletedSuccessfully => 'デバイスは正常に削除されました';

  @override
  String get deviceDeletedSuccessfullyMessage => 'デバイスは正常に削除されました';

  @override
  String get deviceIdLabel => 'デバイスID';

  @override
  String get deviceIDLabel => 'デバイスID';

  @override
  String get deviceManagementSubtitle => 'マルチデバイス同期を管理する';

  @override
  String get deviceManagementTitle => 'デバイス管理';

  @override
  String get deviceModelLabel => 'デバイスモデル';

  @override
  String get deviceName => 'デバイス名';

  @override
  String get deviceNameCannotBeEmpty => 'デバイス名は空にできません';

  @override
  String get deviceNameHint => 'デバイス名を入力してください';

  @override
  String get deviceNameLabel => 'デバイス名';

  @override
  String get deviceRenamedSuccessfully => 'デバイス名を変更しました';

  @override
  String get deviceRenamedSuccessfullyMessage => 'デバイス名を正常に変更しました';

  @override
  String get devicesSyncedSuccessfully => 'デバイスを同期しました';

  @override
  String get devicesSyncedSuccessfullyMessage => 'デバイスを正常に同期しました';

  @override
  String get devicesSynchronizedSuccessfullyMessage => 'デバイスを正常に同期しました';

  @override
  String get deviceUnregisteredSuccessfullyMessage => 'デバイスの登録を解除しました';

  @override
  String get dialogTitle => '正規表現パターンの説明';

  @override
  String get differentFromLocalCounter =>
      'この機能は、長期間のマークカウントではなく、短期間での繰り返し呼び出しパターンに焦点を当てているため、ローカルカウンターフィルターとは異なります。';

  @override
  String get disabled => '無効';

  @override
  String get disabledStatus => '無効';

  @override
  String get disableGlobalPlugins => 'グローバルプラグインを無効にする';

  @override
  String get disableSubscriptionSuccessfully => 'サブスクリプションを無効にしました';

  @override
  String get disconnectButton => '切断';

  @override
  String get disconnectedMessage => '切断されました';

  @override
  String get disconnectedStatus => '切断';

  @override
  String get disconnectFailedMessage => '切断に失敗しました';

  @override
  String get done => '完了';

  @override
  String get dualSimAdvice =>
      'この機能は、仕事用と個人用のSIMカードで異なるフィルタリング戦略を設定するために、デュアルSIMの携帯電話で特に役立ちます。';

  @override
  String get earlier => '前へ';

  @override
  String get ecommerce => 'Eコマース';

  @override
  String get edit => '編集';

  @override
  String get editContact => '連絡先を編集';

  @override
  String get editFilter => 'フィルターを編集';

  @override
  String get editLabel => 'ラベルを編集';

  @override
  String get editPhoneRule => '電話ルールを編集';

  @override
  String get editPhoneRules => '電話ルールを編集するために使用します';

  @override
  String get editPhoneRuleTitle => '電話ルールを編集';

  @override
  String get editRule => 'ルールを編集';

  @override
  String get editSmsRule => 'SMSルールを編集';

  @override
  String get education => '教育';

  @override
  String get elementPositionsSetting => '要素の位置';

  @override
  String get email => 'メール';

  @override
  String get emailOptional => 'メール（オプション）';

  @override
  String get enableCallFilter => 'コールフィルターを有効にする';

  @override
  String get enableCallFilterDescription =>
      '有効にすると、着信は以下のルールリストと照合されます。通話フィルタリングルールは、デフォルトではデバイス間で同期されません。';

  @override
  String get enabled => '有効';

  @override
  String get enabledStatus => '有効';

  @override
  String get enableEncryption => '暗号化を有効にする';

  @override
  String get enableEncryptionDescription => 'バックアップファイルを暗号化する';

  @override
  String get enableEncryptionLabel => '暗号化を有効にする';

  @override
  String get enableEncryptionSubtitle => 'バックアップファイルは暗号化されます';

  @override
  String get enableEncryptionTitle => '暗号化を有効にする';

  @override
  String get enableGlobalPlugins => 'グローバルプラグインを有効にする';

  @override
  String get enableLocalCountFilter => 'ローカルカウントフィルターを有効にする';

  @override
  String get enableLocalCountFilterDescription =>
      'コールマークカウントに基づいてスパム通話を自動的にフィルタリングします';

  @override
  String get enableLocalNotification => 'ローカル通知を使用する';

  @override
  String get enableLocalNotificationDescription =>
      '有効にすると、フィルタリングされたメッセージの通知がデバイスに表示されます';

  @override
  String get enableLocationSummary => '場所';

  @override
  String get enableMuteRules => 'ミュートルールを有効にする';

  @override
  String get enableMuteRulesDesc => 'ミュートインターセプションルールの設定を適用する';

  @override
  String get enableNoneActionRules => 'アクションなしルールを有効にする';

  @override
  String get enableNoneActionRulesDesc => 'インターセプションアクションなしでルール設定を許可する';

  @override
  String get enableNotifications => '通知を有効にする';

  @override
  String get enableRemoteNumberFilter => 'リモート番号フィルターを有効にする';

  @override
  String get enableRemoteNumberFilterDescription =>
      'リモートデータベースを使用して番号をフィルタリングする';

  @override
  String get enableRule => 'ルールを有効にする';

  @override
  String get enableSmsFilter => 'SMSフィルタリングを有効にする';

  @override
  String get enableSmsFilterDescription =>
      '有効にすると、メッセージはルールに従って自動的にフィルタリングされます';

  @override
  String get enableStatisticsNotifications => '統計通知を有効にする';

  @override
  String get enableSubscriptionSuccessfully => 'サブスクリプションを正常に有効にしました';

  @override
  String get enableTimeInterception => '時間インターセプションを有効にする';

  @override
  String get enableTimeInterceptionDescription => '短時間内での繰り返し呼び出しをインターセプトする';

  @override
  String get enableTimeInterceptor => '時間インターセプターを有効にする';

  @override
  String get endCallImmediately => 'すぐに通話を終了する';

  @override
  String get endColor => '終了色';

  @override
  String get endDate => '終了日';

  @override
  String get enhancedFilterInstructionsTitle => '拡張フィルターシステム';

  @override
  String get enhancedFilterSettings => '拡張フィルター設定';

  @override
  String get enhancedFilterSettingsTitle => '拡張フィルター設定';

  @override
  String get enhancedFilterSystemDescription =>
      '拡張フィルターシステムは、グローバルルールとSIMカードごとのフィルタリング設定の両方をサポートしています。';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '電話番号と正規表現パターンの両方入力してください';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      '電話番号と正規表現パターンの両方入力してください。';

  @override
  String get enterContactName => '連絡先名を入力してください';

  @override
  String get enterCurrentPasswordHint => '現在のパスワードを入力してください';

  @override
  String get enterDeviceName => 'デバイス名を入力してください';

  @override
  String get enterDeviceNameHint => 'デバイス名を入力してください';

  @override
  String get enterEmail => 'メールアドレスを入力してください';

  @override
  String get enterEmailOptional => 'メールアドレスを入力してください（オプション）';

  @override
  String get enterEncryptionPasswordHint => '暗号化パスワードを入力してください';

  @override
  String get enterEncryptionPasswordTitle => '暗号化パスワードを入力';

  @override
  String get enterFilterName => 'フィルター名を入力してください';

  @override
  String get enterFilterPattern => 'フィルターパターンを入力してください';

  @override
  String get enterIconCode => 'アイコンコードを入力してください';

  @override
  String get enterName => '連絡先名を入力してください';

  @override
  String get enterNewDeviceNameHint => 'このデバイスの新しい名前を入力してください';

  @override
  String get enterNewPasswordHint => '新しいパスワードを入力してください';

  @override
  String get enterPasswordAgain => 'パスワードを再入力してください';

  @override
  String get enterPasswordHint => 'パスワードを入力してください';

  @override
  String get enterPhoneNumber => '電話番号を入力してください';

  @override
  String get enterPhoneNumberHint => 'テストする電話番号を入力してください';

  @override
  String get enterPhoneNumberMultiple => '電話番号を入力してください。複数の番号はカンマで区切ってください';

  @override
  String get enterPhoneNumberToStartSearch => '検索を開始する電話番号を入力してください';

  @override
  String get enterPhoneNumberToVerify => '確認する電話番号を入力してください';

  @override
  String get enterPluginName => 'プラグイン名を入力してください';

  @override
  String get enterPluginUrl => 'プラグインURLアドレスを入力してください';

  @override
  String get enterRegexHint => '正規表現パターンを入力してください';

  @override
  String get enterRuleNameAndPattern => 'ルール名とパターンを入力してください';

  @override
  String get enterRuleNameAndPatternMessage => 'ルール名と正規表現パターンの両方を入力してください。';

  @override
  String get enterRuleNameHint => 'ルール名を入力してください';

  @override
  String get enterSearchContent => '検索内容を入力してください';

  @override
  String get enterSubscriptionName => 'サブスクリプション名を入力してください';

  @override
  String get enterSubscriptionUrl => 'サブスクリプションURLを入力してください';

  @override
  String get enterSyncFolderNameHint =>
      '同期フォルダー名を入力してください（デフォルト：NotificationManager）';

  @override
  String get entertainment => 'エンターテイメント';

  @override
  String get enterValidNameAndUrl => '有効な名前とURLを入力してください';

  @override
  String get enterValidUrl => '有効なURLを入力してください';

  @override
  String get enterVersion => 'バージョンを入力してください';

  @override
  String get enterWebDAVPasswordHint => 'WebDAVパスワードを入力してください';

  @override
  String get enterWebDAVServerAddressHint => 'WebDAVサーバーアドレスを入力してください';

  @override
  String get enterWebDAVUsernameHint => 'WebDAVユーザー名を入力してください';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'デバイスの削除エラー：$error';
  }

  @override
  String get errorLoadingPlugin => 'プラグインの読み込みエラー';

  @override
  String errorOccurredMessage(Object error) {
    return 'エラーが発生しました：$error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'デバイスの名前変更エラー：$error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'デバイスの同期エラー：$error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'デバイスの同期エラー：$error';
  }

  @override
  String get errorText => 'エラー';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'デバイスの登録解除エラー：$error';
  }

  @override
  String get exampleBlock400Prefix => '例：400プレフィックス番号をブロック';

  @override
  String get exampleBlockMarketingSms => '例：マーケティングSMSをブロック';

  @override
  String get exampleContentRegex => '例：.*offer.*';

  @override
  String get exampleContentRegexHint => 'コンテンツ正規表現の例';

  @override
  String get exampleCouponPromotionDiscount =>
      '例：.*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => '例：家族、友人など';

  @override
  String get examplePhoneNumber => '例：10086、12345など';

  @override
  String get exampleRegex400Prefix => '400プレフィックスの正規表現の例';

  @override
  String get exampleRegexFormat => '例：^10086\$形式';

  @override
  String get exampleSenderRegexHint => '例';

  @override
  String get exchange => '交換';

  @override
  String get exchangeNow => '今すぐ交換';

  @override
  String get exchangeVip => 'VIPを交換';

  @override
  String get expandLabelSelector => 'ラベルセレクターを展開';

  @override
  String expiryTime(Object time) {
    return '有効期限：$time';
  }

  @override
  String get export => 'エクスポート';

  @override
  String get exportAllApplicationSettings => 'すべてのアプリケーション設定をエクスポート';

  @override
  String get exportAllApplicationSettingsSubtitle => 'すべてのアプリケーション設定をエクスポートする';

  @override
  String get exportAllRuleConfigurations => 'すべてのルール設定をエクスポート';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'すべてのルール設定をエクスポートする';

  @override
  String get exportComplete => 'エクスポート完了';

  @override
  String get exportConfig => '設定をエクスポート';

  @override
  String get exportContacts => '連絡先をエクスポート';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get exportError => 'エクスポートエラー';

  @override
  String get exportFailed => 'エクスポートに失敗しました';

  @override
  String get exportFailure => '設定のエクスポートに失敗しました';

  @override
  String get exportFeatureComingSoon => 'エクスポート機能は間もなく利用可能になります';

  @override
  String get exporting => 'エクスポート中...';

  @override
  String get exportLabels => 'ラベルのエクスポート';

  @override
  String exportLabelsFailed(Object error) {
    return 'ラベルのエクスポートに失敗しました: $error';
  }

  @override
  String get exportPluginList => 'プラグインリストのエクスポート';

  @override
  String exportPluginListFailed(Object error) {
    return 'プラグインリストのエクスポートに失敗しました: $error';
  }

  @override
  String get exportRules => 'ルールのエクスポート';

  @override
  String get exportRulesDialogTitle => 'ルールのエクスポート';

  @override
  String get exportRulesTitle => 'ルールのエクスポート';

  @override
  String get exportSmsRules => 'SMSルールのエクスポート';

  @override
  String get exportStatisticsData => '統計データのエクスポート';

  @override
  String get exportSuccess => 'エクスポート成功';

  @override
  String get exportSuccesslly => '設定のエクスポートに成功しました';

  @override
  String get failedToAddContact => '連絡先の追加に失敗しました';

  @override
  String failedToAddRule(Object error) {
    return 'ルールの追加に失敗しました: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMSルールの追加に失敗しました: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMSサブスクリプションの追加に失敗しました: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '設定のバックアップに失敗しました: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'バックアップファイルの復号に失敗しました';

  @override
  String get failedToDeleteDevice => 'デバイスの削除に失敗しました';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMSルールの削除に失敗しました: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'ルールのエクスポートに失敗しました: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMSルールのエクスポートに失敗しました: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '発信者ID情報の取得に失敗しました: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'ルールのインポートに失敗しました: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMSルールのインポートに失敗しました: $error';
  }

  @override
  String get failedToLoadContacts => '連絡先の読み込みに失敗しました';

  @override
  String get failedToLoadPlugin => 'プラグインの読み込みに失敗しました';

  @override
  String get failedToRenameDevice => 'デバイスの名前変更に失敗しました';

  @override
  String get failedToRestoreSettings => '設定の復元に失敗しました';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '設定の復元に失敗しました: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'パスワードの設定に失敗しました: $error';
  }

  @override
  String get failedToSyncDevices => 'デバイスの同期に失敗しました';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'ルールのステータスの切り替えに失敗しました: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'サブスクリプションのステータスの切り替えに失敗しました';

  @override
  String get failedToUpdateContact => '連絡先の更新に失敗しました';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMSルールの更新に失敗しました: $error';
  }

  @override
  String get failure => '失敗';

  @override
  String get favoriteContacts => 'お気に入りの連絡先';

  @override
  String get featureAddRules => '• 電話番号固有のルールを追加';

  @override
  String get featureCenter => '機能センター';

  @override
  String get featureEnableDisable => '• SIMごとに異なるフィルターを有効/無効にする';

  @override
  String get featureListTitle => '機能:';

  @override
  String get featureManageRules => '• SIMごとにルールリストを管理';

  @override
  String get features => '機能';

  @override
  String get fetchingCallerIdInfo => '発信者ID情報を取得中...';

  @override
  String fileSavedTo(Object path) {
    return 'ファイルは以下に保存されました: $path';
  }

  @override
  String get filter => 'フィルター';

  @override
  String get filterByLabel => 'ラベルでフィルタリング';

  @override
  String get filterClear => 'フィルターをクリア';

  @override
  String get filterControlPanelTitle => 'フィルターコントロールパネル';

  @override
  String get filterControlSubtitle => 'すべてのフィルターのオン/オフステータスを管理';

  @override
  String get filterControlTitle => 'フィルターコントロール';

  @override
  String get filterDeleteFailed => 'フィルターの削除に失敗しました';

  @override
  String get filterDeleteSuccess => 'フィルターを正常に削除しました';

  @override
  String get filterDetails => 'フィルターの詳細';

  @override
  String get filtered => 'フィルタリング済み';

  @override
  String get filteredSms => 'フィルタリングされたSMS';

  @override
  String get filteredSmsLabel => 'フィルタリングされたSMS';

  @override
  String get filterExplanation => 'フィルターの説明';

  @override
  String get filterManagement => 'フィルター管理';

  @override
  String get filterName => 'フィルター名';

  @override
  String get filterPattern => 'フィルターパターン';

  @override
  String get filterPriorityNote =>
      '注意：フィルター間には優先順位の関係があります。詳細については、ヘルプドキュメントを参照してください。';

  @override
  String get filterSaveFailed => 'フィルターの保存に失敗しました';

  @override
  String get filterSaveSuccess => 'フィルターを正常に保存しました';

  @override
  String get filterSettings => 'フィルター設定';

  @override
  String get filterSettingsTitle => 'フィルター設定';

  @override
  String get filterSMS => 'SMSのフィルター';

  @override
  String get filterToggleInstructions => 'このSIMスロットのフィルターを有効または無効にします:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status フィルター: $filterName';
  }

  @override
  String get filterType => 'フィルタータイプ';

  @override
  String get financial => '金融';

  @override
  String get flexibleCombinationFeature =>
      '• 柔軟な組み合わせ: SIMスロットごとにフィルターを有効/無効にする';

  @override
  String get fontSizesSetting => 'フォントサイズ';

  @override
  String foundRules(Object count) {
    return '$count個のルールが見つかりました';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count個のルールが見つかりました。インポートしますか？';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count個のルールが見つかりました。インポートしますか？';
  }

  @override
  String get fraudAlert => '詐欺アラート - 通話を切断してください';

  @override
  String get fraudScamLikely => '詐欺の可能性あり';

  @override
  String get free => '無料';

  @override
  String get functionSettingsTitle => '機能設定';

  @override
  String generalUpdateFailure(Object error) {
    return '更新に失敗しました: $error';
  }

  @override
  String get getFree => '無料で入手';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => 'すべてのSIMカードのグローバルフィルターを設定します:';

  @override
  String get globalFilterFeature => '• グローバルフィルター: すべての着信通話の基本ルール';

  @override
  String get globalFilterSettings => 'グローバルフィルター設定';

  @override
  String get globalFilterToggleInstructions =>
      'すべてのSIMスロットに適用されるグローバルフィルター設定を構成します:';

  @override
  String get globalSearchSubtitle => '連絡先、ラベル、ブラックリスト、ホワイトリストなどを検索します。';

  @override
  String get globalSearchTitle => 'グローバル検索';

  @override
  String get globalSettings => 'グローバル設定';

  @override
  String get googleAdDisplayPosition => 'Google広告の表示位置';

  @override
  String get googleAdMobIntegrationText => 'ここにGoogle AdMob広告を統合できます';

  @override
  String get googleDriveAuthDescription =>
      'システム設定されたGoogle DriveクライアントIDとキーを使用して認証します';

  @override
  String get googleDriveAuthorizationHint =>
      'システム設定されたGoogle DriveクライアントIDとキーを使用して認証します';

  @override
  String get googleDriveConfigTitle => 'Googleドライブ設定';

  @override
  String get googleDriveConfigurationTitle => 'Googleドライブ設定';

  @override
  String get government => '政府';

  @override
  String get granted => '許可済み';

  @override
  String get grantNecessaryPermissions => '必要な権限を付与する';

  @override
  String get grantPermissions => '権限を付与する';

  @override
  String get headhunter => 'ヘッドハンター';

  @override
  String get height => '高さ';

  @override
  String get homePageTitle => 'ホームページ';

  @override
  String get homeTab => 'ホーム';

  @override
  String get howItWorksPoint1 => '• システムは、設定された時間枠内で同じ番号からの通話を自動的に許可します';

  @override
  String get howItWorksPoint2 =>
      '• 時間枠が短いほど、インターセプトは厳しくなります。時間枠が長いほど、インターセプトは緩くなります';

  @override
  String get howItWorksPoint3 => '• システムは、コールログをチェックして、繰り返しコールかどうかを判断します';

  @override
  String get howItWorksTitle => '仕組み:';

  @override
  String get iconCodeOptional => 'アイコンコード（オプション）';

  @override
  String get iconSize => 'アイコンサイズ';

  @override
  String get import => 'インポート';

  @override
  String get important => '重要';

  @override
  String get importButton => 'インポート';

  @override
  String get importConfig => '設定をインポート';

  @override
  String get importContacts => '連絡先をインポート';

  @override
  String get importExportContacts => '連絡先のインポート/エクスポート';

  @override
  String get importExportContactsTooltip => '連絡先のインポート/エクスポート';

  @override
  String get importExportRules => 'ルールのインポート/エクスポート';

  @override
  String importFailed(Object error) {
    return 'インポートに失敗しました：$error';
  }

  @override
  String get importFailure => '設定のインポートに失敗しました';

  @override
  String get importFeatureComingSoon => 'インポート機能は近日公開予定です';

  @override
  String get importLabels => 'ラベルのインポート';

  @override
  String importLabelsFailed(Object error) {
    return 'ラベルのインポートに失敗しました：$error';
  }

  @override
  String get importPluginList => 'プラグインリストをインポート';

  @override
  String importPluginListFailed(Object error) {
    return 'プラグインリストのインポートに失敗しました：$error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '$count個のプラグインを正常にインポートしました';
  }

  @override
  String get importRuleConfigurationsFromFile => 'ファイルからルール設定をインポート';

  @override
  String get importRuleConfigurationsFromFileSubtitle => 'ファイルからルール設定をインポート';

  @override
  String get importRules => 'ルールのインポート';

  @override
  String get importRulesButton => 'ルールをインポート';

  @override
  String get importRulesDialogTitle => 'ルールのインポート';

  @override
  String importRulesError(Object error) {
    return 'ルールのインポートに失敗しました：$error';
  }

  @override
  String get importRulesInstructions => 'CSVファイルからルールをインポートします';

  @override
  String get importRulesSuccess => 'ルールが正常にインポートされました';

  @override
  String get importRulesTitle => 'ルールのインポート';

  @override
  String get importSuccess => 'インポートに成功しました';

  @override
  String get incomingCallInterceptAction => '着信時のインターセプトアクション';

  @override
  String get incomingCallNotification => '着信通知';

  @override
  String get incorrectPassword => 'パスワードが正しくありません';

  @override
  String get initializing => '初期化中';

  @override
  String get installed => 'インストール済み';

  @override
  String get insufficientMarks => '十分なマークがありません';

  @override
  String get insurance => '保険';

  @override
  String get interceptAction => 'インターセプトアクション';

  @override
  String get interceptionActionSettingsSubtitle => 'ブロックされた通話の処理方法を設定します';

  @override
  String get interceptionActionSettingsTitle => 'インターセプトアクション設定';

  @override
  String get interceptionTimeInterval => 'インターセプト間隔';

  @override
  String get internet => 'インターネット';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service の更新間隔が$days日に設定されました';
  }

  @override
  String get invalidContentRegex => '無効なコンテンツ正規表現';

  @override
  String get invalidLabel => '無効なラベル';

  @override
  String get invalidRegexPattern => '無効な正規表現パターン';

  @override
  String get invalidSenderRegex => '無効な送信者正規表現';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '詳細については、Telegramチャンネルとグループに参加してください';

  @override
  String get jsLogsTitle => 'JS ログ';

  @override
  String get jsonFormat => 'JSON形式';

  @override
  String get keepAllVersions => 'すべてのバージョンを保持';

  @override
  String get keepAllVersionsDescription => '各バックアップのすべての履歴バージョンを保持します';

  @override
  String get keepAllVersionsLabel => 'すべてのバージョンを保持';

  @override
  String get keepAllVersionsSubtitle => '各バックアップの履歴バージョンを保持';

  @override
  String get keepAllVersionsTitle => 'すべてのバージョンを保持';

  @override
  String get label => 'ラベル';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'ラベル \"$name\" が正常に追加されました';
  }

  @override
  String get labelCategories => 'ラベルカテゴリ';

  @override
  String get labelDeleted => 'ラベルが削除されました';

  @override
  String get labelDescription =>
      'ラベルは、連絡先の管理を改善し、電話番号にカスタムラベルを追加して、通話とメッセージを簡単に識別するのに役立ちます。';

  @override
  String get labelFilter => 'ラベルフィルター';

  @override
  String get labelFilterTooltip => 'ラベルフィルター';

  @override
  String get labelIconColor => 'ラベルアイコンの色';

  @override
  String get labelManagement => 'ラベル管理';

  @override
  String get labelNotFound => 'ラベルが見つかりません';

  @override
  String get labelRemoved => 'ラベルが削除されました';

  @override
  String labelRemoveFailed(Object error) {
    return 'ラベルの削除に失敗しました: $error';
  }

  @override
  String get labels => 'ラベル';

  @override
  String get labelsColor => 'ラベルの色';

  @override
  String labelsDeleted(Object count) {
    return '$count 個のラベルが削除されました';
  }

  @override
  String get labelsExportedSuccessfully => 'ラベルが正常にエクスポートされました';

  @override
  String get labelsFontSize => 'ラベルのフォントサイズ';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count 個のラベルが正常にインポートされました';
  }

  @override
  String get labelsPosition => 'ラベルの位置';

  @override
  String labelTag(Object labelId) {
    return 'ラベル: $labelId';
  }

  @override
  String get labelUpdated => 'ラベルが更新されました';

  @override
  String labelUpdateFailed(Object error) {
    return 'ラベルの更新に失敗しました: $error';
  }

  @override
  String get labelUpdateSuccess => 'ラベル \"\$labelText\" が正常に更新されました';

  @override
  String get languageSettings => '言語設定';

  @override
  String get languageSettingsSubtitle => 'アプリケーションの表示言語を変更します';

  @override
  String get languageSettingsTitle => '言語設定';

  @override
  String get last30Days => '過去30日間';

  @override
  String get last7Days => '過去7日間';

  @override
  String get lastSyncLabel => '最終同期';

  @override
  String lastUpdated(Object date) {
    return '最終更新: $date';
  }

  @override
  String get lifetimeMembership => '生涯メンバーシップ';

  @override
  String get lifetimeMembershipDescription =>
      '1回限りの購入で、すべてのプレミアム機能と今後のアップデートを永久にアンロックします';

  @override
  String loadContactsFailed(Object error) {
    return '連絡先の読み込みに失敗しました: $error';
  }

  @override
  String get loadDataFailed => 'データの読み込みに失敗しました';

  @override
  String get loadFailed => '読み込みに失敗しました';

  @override
  String get loading => '読み込み中...';

  @override
  String get loadingData => 'データを読み込み中...';

  @override
  String get loadingTags => 'タグを読み込み中...';

  @override
  String loadLabelFailed(Object error) {
    return 'ラベルの読み込みに失敗しました: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'ラベルの読み込みに失敗しました: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'マークされた電話番号の読み込みに失敗しました: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'マークされた電話番号の読み込みに失敗しました: $error';
  }

  @override
  String get loadMore => 'もっと読み込む';

  @override
  String get loadPluginButton => 'プラグインを読み込む';

  @override
  String loadPluginsFailed(Object error) {
    return 'プラグインの読み込みに失敗しました: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '設定の読み込みに失敗しました: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'SMSルールの読み込みに失敗しました: $error';
  }

  @override
  String get loadStatusFailedMessage => 'ステータスの読み込みに失敗しました';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'サブスクリプションの読み込みに失敗しました: $error';
  }

  @override
  String get loan => 'ローン';

  @override
  String get localBackupTitle => 'ローカルバックアップ';

  @override
  String get localCounterFilter => 'ローカルカウンターフィルター';

  @override
  String get localCounterFilterSubtitle => '通話頻度に基づいて迷惑電話を自動的にフィルタリングします';

  @override
  String get localCountFilter => 'ローカルカウントフィルター';

  @override
  String get localCountFilterDescription => 'ローカル番号のカウントに基づいて、頻繁な通話を遮断します';

  @override
  String get localCountFilterExplanationContent =>
      'ローカルカウントフィルターは、通話履歴を分析して、頻繁な迷惑電話を自動的に識別してブロックします。';

  @override
  String get localCountFilterExplanationTitle => 'ローカルカウントフィルターの説明';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• 番号のカウント値に基づいてブロックするかどうかを決定する';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• 番号のカウントが設定されたしきい値を超えた場合、自動的にブロックすることを選択できます';

  @override
  String get localCountFilterHowItWorksPoint3 => '• しきい値を超えない番号を個別に許可することができます';

  @override
  String get localCountFilterHowItWorksPoint4 => '• すべてのクエリログを記録するかどうかを選択できます';

  @override
  String get localCountFiltering => 'ローカルカウントフィルタリング';

  @override
  String get localCountFilteringExplanation =>
      '• ローカルカウントフィルタリング: ローカルマーキングカウントに基づくフィルタリングルール';

  @override
  String get localCountFilterSettings => 'ローカルカウントフィルター設定';

  @override
  String get localCountFilterUseCases =>
      'このフィルターは、自動ダイヤルによる迷惑電話やマーケティングコールを特定するのに特に適しています。';

  @override
  String get localFilterSettings => 'ローカルフィルター設定';

  @override
  String get localNotificationDisabled => 'ローカル通知は無効になっています';

  @override
  String get localNotificationEnabled => 'ローカル通知は有効になっています';

  @override
  String get localServices => 'ローカルサービス';

  @override
  String get locationColor => '位置の色';

  @override
  String get locationFontSize => '位置のフォントサイズ';

  @override
  String get locationIconColor => '位置のアイコンの色';

  @override
  String get locationPosition => '位置';

  @override
  String get logAllLocalQueries => 'すべてのローカルクエリをログに記録する';

  @override
  String get logAllLocalQueriesDescription => 'すべてのローカル番号クエリのログを記録する';

  @override
  String get logAllRemoteQueries => 'すべてのリモートクエリをログに記録する';

  @override
  String get logAllRemoteQueriesDescription => 'すべてのリモート番号クエリ操作を記録する';

  @override
  String get manage => '連絡先の管理';

  @override
  String get manageContacts => '管理';

  @override
  String get manageFavoriteContacts => 'お気に入りの連絡先を管理';

  @override
  String get manageFilterRules => 'フィルタールールの管理';

  @override
  String get manageFilterRulesDescription => 'SMSフィルタールールの追加、編集、または削除';

  @override
  String get manageFrequentContacts => '頻繁な連絡先の管理';

  @override
  String get markCounts => 'マーク数';

  @override
  String get markCount => 'マーク数';

  @override
  String markedByCount(Object count) {
    return '$count によってマークされました';
  }

  @override
  String get markedPhonesList => 'マークされた電話番号';

  @override
  String get markExchange => 'マーク交換';

  @override
  String get markPhone => '電話番号をマーク';

  @override
  String markPhoneFailed(Object error) {
    return '電話番号のマーキングに失敗しました: $error';
  }

  @override
  String get markPhoneManagementSubtitle => '電話番号をマークするには';

  @override
  String get markPhoneManagementTitle => '電話マーク管理';

  @override
  String get markPhoneSuccess => '電話番号が正常にマークされました';

  @override
  String get matchFailed => 'マッチングに失敗しました！';

  @override
  String get matchFailedMessage => 'マッチングに失敗しました。';

  @override
  String get matchNumbersWithSpecialCharacters => '特定の番号形式に一致します';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '特殊文字を含む番号に一致させる:';

  @override
  String get matchSpecificDigitPatterns => 'XXX-XXXX-XXXX形式に一致します';

  @override
  String get matchSpecificDigitPatternsTitle => '特定の数字パターンに一致させる:';

  @override
  String get matchSuccessful => 'マッチングに成功しました！';

  @override
  String get matchSuccessfulMessage => 'マッチングに成功しました！';

  @override
  String get medical => '医療';

  @override
  String get membershipPrivileges => 'メンバーシップ特典';

  @override
  String get migrationTool => '移行ツール';

  @override
  String get migrationToolTitle => '移行ツール';

  @override
  String get minutes => '分';

  @override
  String get month => '月';

  @override
  String get monthly => '毎月';

  @override
  String get monthlyCallCount => '月間通話数';

  @override
  String get monthlyChartTitle => '月間ブロックされた通話数';

  @override
  String get monthlyMembership => '月額メンバーシップ';

  @override
  String get monthlyMembershipDescription => 'すべてのプレミアム機能をアンロックし、毎月自動更新されます';

  @override
  String get monthlyTotal => '月間合計';

  @override
  String get monthlyTotalLabel => '月間合計';

  @override
  String get moreOptions => 'その他のオプション';

  @override
  String get mute => 'ミュート';

  @override
  String get name => '名前';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '名前と電話番号は空にできません';

  @override
  String get nameAndPhoneNumberRequired => '名前と電話番号は必須です';

  @override
  String get nameColor => '名前の色';

  @override
  String get nameFontSize => '名前のフォントサイズ';

  @override
  String nameLabel(Object name) {
    return '名前：$name';
  }

  @override
  String get namePosition => '名前の位置';

  @override
  String get nameUnknown => '名前：不明';

  @override
  String nameWithValue(String name) {
    return '名前：$name';
  }

  @override
  String get newPasswordLabel => '新しいパスワード';

  @override
  String get nextStep => '次へ';

  @override
  String get noAction => 'アクションなし';

  @override
  String get noActionRules => 'アクションルールなし';

  @override
  String get noActiveCloudSyncServiceMessage => 'アクティブなクラウド同期サービスがありません';

  @override
  String get noCallLogs => '通話ログなし';

  @override
  String get noCallRecords => '通話記録なし';

  @override
  String get noContacts => 'まだ連絡先がありません';

  @override
  String get noContactsYet => 'まだ連絡先がありません';

  @override
  String get noData => 'データなし';

  @override
  String get noDevicesRegisteredMessage => '登録されているデバイスがありません';

  @override
  String get noDevicesRegisteredYet => 'まだ登録されているデバイスがありません。';

  @override
  String get noFilters => 'まだフィルタがありません';

  @override
  String get noLabels => 'まだラベルがありません';

  @override
  String get noMarkedPhones => 'マークされた電話番号はありません';

  @override
  String get noMatchingContacts => '一致する連絡先がありません';

  @override
  String get noMatchingContactsFound => '一致する連絡先が見つかりませんでした';

  @override
  String get noMatchingNumbersFound => '一致する番号が見つかりませんでした';

  @override
  String get noMatchingRecords => '一致する通話記録がありません';

  @override
  String noMatchingRules(Object ruleType) {
    return '一致する$ruleTypeがありません';
  }

  @override
  String get none => 'なし';

  @override
  String get noneServiceType => 'なし';

  @override
  String get noPlugins => 'まだプラグインはありません';

  @override
  String get noRecords => '通話記録がありません';

  @override
  String get noResultReturned => '結果が返されませんでした';

  @override
  String get noResultReturnedLog => 'プラグインから結果が返されませんでした';

  @override
  String noRules(Object ruleType) {
    return 'まだ$ruleTypeがありません';
  }

  @override
  String get noRulesPrompt => 'ルールが見つかりませんでした。ルールを追加してください';

  @override
  String get noRulesToExport => 'エクスポートするルールがありません';

  @override
  String get noSmsFilterRulesYet => 'まだSMSフィルタールールはありません';

  @override
  String get noSmsRulesYet => 'まだSMSルールはありません';

  @override
  String get noSubscriptions => 'サブスクリプションがありません';

  @override
  String get noSubscriptionsYet => 'まだサブスクリプションはありません';

  @override
  String get notGranted => '許可されていません';

  @override
  String get notificationMode => '通知モード';

  @override
  String get notificationModeDescription => '通知バーに発信者情報を表示します';

  @override
  String get notificationPermission => '通知許可';

  @override
  String get notificationPermissionDescription =>
      '着信通話とメッセージの通知を表示するために使用されます。';

  @override
  String get notifications => '通知';

  @override
  String get notificationSettings => '通知設定';

  @override
  String get notificationSettingsSaved => '通知設定が正常に保存されました';

  @override
  String get notSet => '未設定';

  @override
  String get notVerifiedText => '未確認';

  @override
  String get noValidSmsRulesFoundInFile => 'ファイルに有効なSMSルールが見つかりませんでした';

  @override
  String get number => '番号';

  @override
  String get numberColor => '番号の色';

  @override
  String get numberFontSize => '番号のフォントサイズ';

  @override
  String get numberPosition => '番号の位置';

  @override
  String get numberSearch => '番号検索';

  @override
  String get numberTypeColor => '番号タイプの色';

  @override
  String get numberTypeFontSize => '番号タイプのフォントサイズ';

  @override
  String get numberTypePosition => '番号タイプの位置';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'あなたの通話セキュリティマネージャーは準備ができました。安全な通話体験をお楽しみください！';

  @override
  String get onboardingLanguageDescription => '最高の体験のために、ご希望の言語を選択してください。';

  @override
  String get onboardingPermissionsDescription => '完全なサービスを提供するために、次の権限が必要です。';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'ワンクリックでスパム通話とメッセージをブロックし、ブロックルールをカスタマイズして、静かな環境を提供します。';

  @override
  String get onboardingSmartCallerIdDescription =>
      '不明な通話を自動的に識別し、不審な番号をマークし、通話の安全性を保護します。';

  @override
  String get onboardingWelcomeDescription =>
      'あなたの通話管理のエキスパート。包括的な通話識別とブロックサービスを提供します。';

  @override
  String get oneDriveAuthDescription =>
      'システムで設定されたOneDriveクライアントIDとキーを使用して承認します';

  @override
  String get oneDriveAuthorizationHint =>
      'システムで設定されたOneDriveクライアントIDとキーを使用して承認します';

  @override
  String get oneDriveConfigTitle => 'OneDrive設定';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive設定';

  @override
  String get onlineCallerIdSubscription => 'オンライン発信者 ID サブスクリプション';

  @override
  String get openAppSettings => 'アプリ設定を開く';

  @override
  String openAppSettingsFailed(Object error) {
    return 'アプリ設定を開けませんでした: $error';
  }

  @override
  String operationFailed(Object error) {
    return '操作に失敗しました: $error';
  }

  @override
  String get operationFailure => '操作に失敗しました';

  @override
  String get operationSuccess => '操作は成功しました';

  @override
  String get other => 'その他';

  @override
  String get ourOtherApps => 'その他のアプリ';

  @override
  String get overlayMode => 'フローティングウィンドウ';

  @override
  String get overlayModeDescription => 'フローティングウィンドウで発信者情報を表示します';

  @override
  String get overlayPermission => 'オーバーレイ許可';

  @override
  String get overlayPermissionDescription => '着信コールのオーバーレイを表示するために使用されます。';

  @override
  String get overview => '概要';

  @override
  String get password => 'パスワード';

  @override
  String get passwordCannotBeEmpty => 'パスワードは空にできません';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get passwordSetSuccessfully => 'パスワードが正常に設定されました';

  @override
  String get pattern => 'パターン';

  @override
  String get pendingSync => '同期保留中';

  @override
  String get periodMonth => '月';

  @override
  String get periodWeek => '週';

  @override
  String get periodYear => '年';

  @override
  String get permissionDenied => '許可要求が拒否されました';

  @override
  String get permissionGranted => '許可されました';

  @override
  String get permissionManagement => '許可管理';

  @override
  String get phoneCallsTab => '電話';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get phoneNumberCannotBeEmpty => '電話番号は空にできません';

  @override
  String get phoneNumberHint => '電話番号を入力してください';

  @override
  String get phoneNumberHintText => 'ルールを追加するには電話番号を入力してください';

  @override
  String get phoneNumberLabel => '電話番号';

  @override
  String get phoneNumberRegexRequired => '電話番号と正規表現パターンの両方を入力してください';

  @override
  String get phoneNumberRequired => '電話番号は必須です';

  @override
  String get phoneNumberTypeFixedLine => '固定回線';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '固定回線または携帯電話';

  @override
  String get phoneNumberTypeMobile => '携帯電話';

  @override
  String get phoneNumberTypePager => 'ポケットベル';

  @override
  String get phoneNumberTypePersonalNumber => 'パーソナルナンバー';

  @override
  String get phoneNumberTypePremiumRate => 'プレミアム料金';

  @override
  String get phoneNumberTypeSharedCost => '共有コスト';

  @override
  String get phoneNumberTypeTollFree => 'フリーダイヤル';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '不明';

  @override
  String get phoneNumberTypeVoicemail => 'ボイスメール';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '電話許可';

  @override
  String get phonePermissionDescription => '着信を識別してブロックするために使用されます。';

  @override
  String get phoneRule => '電話ルール';

  @override
  String get phoneRuleEditDialog => '電話ルールの編集ダイアログ';

  @override
  String get phoneRuleManagement => '電話ルール管理';

  @override
  String get phoneRuleSubscription => '電話ルールサブスクリプション';

  @override
  String get phoneSubscription => '電話サブスクリプション';

  @override
  String get phoneSubscriptionRulesDescription =>
      'URL経由で電話ルールリストをサブスクライブして、ホワイトリストとブラックリストのルールを自動的に更新します。JSON形式のルールファイルをサポートしています。';

  @override
  String get phoneSubscriptionTitle => '電話ルールサブスクリプション';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => 'ラベルを選択し、有効な電話番号を入力してください';

  @override
  String pluginAddedSuccess(Object name) {
    return 'プラグイン \"$name\" が正常に追加されました';
  }

  @override
  String get pluginDeleted => 'プラグインを削除しました';

  @override
  String get pluginLatestVersion => 'プラグインはすでに最新バージョンです';

  @override
  String get pluginListExportSuccess => 'プラグインリストが正常にエクスポートされました';

  @override
  String get pluginLoadedSuccessfully => 'プラグインが正常に読み込まれました';

  @override
  String get pluginManagement => 'プラグイン管理';

  @override
  String get pluginManagementSubtitle => 'サードパーティプラグインを管理および設定する';

  @override
  String get pluginManagementTitle => 'プラグイン管理';

  @override
  String get pluginName => 'プラグイン名';

  @override
  String get pluginNotLoaded => 'プラグインはまだ読み込まれていません。最初にプラグインを読み込んでください。';

  @override
  String pluginsDeleted(Object count) {
    return '$count 個のプラグインが正常に削除されました。';
  }

  @override
  String get pluginService => 'プラグインサービス';

  @override
  String get pluginTestPageTitle => 'プラグインテスト';

  @override
  String get pluginUpdateSuccess => 'プラグインが正常に更新されました';

  @override
  String get pluginUrl => 'プラグインURL';

  @override
  String get pluginUrlCannotBeEmpty => 'プラグインURLは空にできません';

  @override
  String get pluginUrlHint => 'プラグインURLを入力してください';

  @override
  String get pluginUrlLabel => 'プラグインURL';

  @override
  String get pluginVersion => 'プラグインバージョン';

  @override
  String get political => '政治的';

  @override
  String get powerfulSpamBlocking => '強力なスパムブロック';

  @override
  String get previousStep => '前へ';

  @override
  String get prioritizeRemoteAction => 'リモートアクション設定を優先する';

  @override
  String get prioritizeRemoteActionDescription => 'リモートデータベースからのアクション設定を優先する';

  @override
  String get processing => '処理中...';

  @override
  String get processingOperation => '処理中...';

  @override
  String get purchase => '購入';

  @override
  String get quarterlyMembership => '四半期メンバーシップ';

  @override
  String get quarterlyMembershipDescription => 'すべてのプレミアム機能をアンロックし、四半期ごとに自動更新';

  @override
  String get queryButton => '照会';

  @override
  String get queryFailed => '照会に失敗しました';

  @override
  String get queryFailedLog => '照会に失敗しました';

  @override
  String get querying => '照会中...';

  @override
  String get queryingPhoneNumber => '電話番号を照会中';

  @override
  String get queryResultTitle => '照会結果';

  @override
  String get ready => '準備完了！';

  @override
  String get receiveWeeklyStatistics => '毎週の統計を受け取る';

  @override
  String get recruiter => '採用担当者';

  @override
  String get reEnterPasswordHint => 'パスワードを再入力してください';

  @override
  String get refresh => '更新';

  @override
  String get refreshPermissionStatus => '許可ステータスを更新';

  @override
  String get refreshTooltip => '更新';

  @override
  String regexError(Object error) {
    return '正規表現エラー: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return '正規表現エラー: $error';
  }

  @override
  String get regexPattern => '正規表現パターン';

  @override
  String get regexPatternExplanation => '正規表現パターンの説明';

  @override
  String get regexPatternExplanationButton => '正規表現パターンの説明';

  @override
  String get regexPatternLabel => '正規表現パターン';

  @override
  String get regexPatternsExamples => '標準の正規表現構文を使用してパターンを定義します。例：';

  @override
  String get regexPatternsForPhoneNumberMatching => '電話番号の一致のための正規表現パターン';

  @override
  String get regexRule => '正規表現ルール';

  @override
  String regexRuleAddFailed(Object error) {
    return '正規表現ルールの追加に失敗しました: $error';
  }

  @override
  String get regexRuleAddSuccess => '正規表現ルールが正常に追加されました';

  @override
  String get regexRuleManagement => '正規表現ルール管理';

  @override
  String get regexRuleNamePatternRequired => 'ルール名と正規表現パターンは空にできません';

  @override
  String get regexRules => '正規表現ルール';

  @override
  String get regexTesterTitle => '正規表現テスター';

  @override
  String regexValidationFailed(Object error) {
    return '正規表現の検証に失敗しました: $error';
  }

  @override
  String get regexValidationSuccess => '正規表現の検証に成功しました';

  @override
  String get region => '地域';

  @override
  String get registeredDevicesTitle => '登録済みデバイス';

  @override
  String get rejectAllCalls => 'すべての通話を拒否';

  @override
  String get rejectAllCallsDescription => '有効にすると、すべての通話が最高の優先度で拒否されます';

  @override
  String get rejectAllNumbers => 'すべての番号を拒否';

  @override
  String get rejectAllNumbersDesc => '有効にすると、すべての着信通話を拒否します';

  @override
  String get rejectExceededNumbers => '超過した番号を拒否';

  @override
  String get rejectExceededNumbersDescription => 'カウントのしきい値を超える番号を自動的に拒否します';

  @override
  String get remoteFilterSettings => 'リモートフィルター設定';

  @override
  String get remoteFilterSettingsPageTitle => 'リモート番号フィルター設定';

  @override
  String get remoteNumberFilter => 'リモート番号フィルター';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'このフィルターは、最新の番号情報を取得するために、独立したリモートデータベースを使用します。';

  @override
  String get remoteNumberFilterDescription => 'リモートデータベース情報に基づいて、嫌がらせ電話を阻止します';

  @override
  String get remoteNumberFilterExplanationContent =>
      'リモート番号フィルターは、番号カウントに基づいてリモートデータベースに問い合わせることにより、迷惑電話を特定しブロックします。';

  @override
  String get remoteNumberFilterExplanationTitle => 'リモート番号フィルターの説明';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• カウントしきい値: 番号の出現頻度に基づいて決定';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• フィルターアクション: しきい値を超える番号の処理方法を設定';

  @override
  String get remoteNumberFilterFeaturePriority => '• 優先度設定: リモートアクションの優先度を設定';

  @override
  String get remoteNumberFilterFeatures => '特徴:';

  @override
  String get remoteNumberFiltering => 'リモート番号フィルタリング';

  @override
  String get remoteNumberFilteringExplanation =>
      '• リモート番号フィルタリング: リモートデータベース情報に基づくフィルタリングルール';

  @override
  String get remoteNumberFilterSubtitle =>
      'クラウドデータベースとコミュニティレポートを使用して、迷惑電話を特定します';

  @override
  String get removeAdsDescription => 'よりスムーズな体験のために、アプリ内のすべての広告を完全に削除します';

  @override
  String get removeAdsTitle => '広告を削除';

  @override
  String get removedFromFavoriteContacts => 'お気に入りの連絡先から削除しました';

  @override
  String get removedFromFavorites => 'お気に入りから削除しました';

  @override
  String get removeFavorite => 'お気に入りから削除';

  @override
  String get removeFromFavorites => 'お気に入りから削除';

  @override
  String get renameButton => '名前を変更';

  @override
  String get renameDeviceDialogTitle => 'デバイスの名前を変更';

  @override
  String get renameDeviceTitle => 'デバイスの名前を変更';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'これにより、現在のすべての設定が置き換えられます。続行してもよろしいですか？';

  @override
  String get requestAllPermissions => 'すべての権限を要求';

  @override
  String get requestPermission => '権限を要求';

  @override
  String requestPermissionFailed(Object error) {
    return '権限の要求に失敗しました: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count マーク';
  }

  @override
  String get reset => 'リセット';

  @override
  String get restore => '復元';

  @override
  String get restoreApplicationSettingsFromBackup => 'バックアップからアプリケーション設定を復元';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'バックアップからアプリケーション設定を復元します';

  @override
  String get restoreButton => '復元';

  @override
  String restoreFailedWithError(Object error) {
    return 'クラウドからの復元に失敗しました: $error';
  }

  @override
  String get restoreFromCloud => 'クラウドから復元';

  @override
  String get restoreFromCloudDescription => 'クラウドストレージから設定とルールを復元します';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'クラウドからの復元に失敗しました: $error';
  }

  @override
  String get restoreFromCloudLabel => 'クラウドから復元';

  @override
  String get restoreFromCloudSuccess => 'クラウドから正常に復元されました';

  @override
  String get restoreFromCloudTitle => 'クラウドから復元';

  @override
  String get restoreFromLocal => 'ローカルから復元';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get restoreSectionTitle => '復元';

  @override
  String get restoreSettings => '設定を復元';

  @override
  String get restoreSettingsConfirmation =>
      'これにより、現在のすべての設定が置き換えられます。続行してもよろしいですか？';

  @override
  String get restoreSettingsDialogTitle => '設定を復元';

  @override
  String get restoreSettingsTitle => '設定を復元';

  @override
  String get restoreSuccessFromLocal => 'ローカルから正常に復元されました';

  @override
  String get restoreSuccessMessage => 'クラウドから正常に復元されました';

  @override
  String get retry => '再試行';

  @override
  String get ridesharing => 'ライドシェア';

  @override
  String get risk => 'リスク';

  @override
  String get robocall => 'ロボコール';

  @override
  String get ruleAction => 'ルールの操作';

  @override
  String get ruleAddButton => 'ルールを追加';

  @override
  String get ruleAddedSuccess => 'ルールが正常に追加されました';

  @override
  String ruleAddFailure(Object error) {
    return 'ルールの追加に失敗しました: $error';
  }

  @override
  String get ruleAddSuccess => 'ルールが正常に追加されました';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'この$ruleTypeを削除してもよろしいですか？';
  }

  @override
  String get ruleDeleteConfirmTitle => 'ルールを削除';

  @override
  String get ruleDeletedSuccess => 'ルールが正常に削除されました';

  @override
  String get ruleDeletedSuccessfully => 'ルールが正常に削除されました';

  @override
  String ruleDeleteFailed(Object error) {
    return 'ルールの削除に失敗しました: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'ルールの削除に失敗しました: $error';
  }

  @override
  String get ruleDeleteSuccess => 'ルールが正常に削除されました';

  @override
  String get ruleDisabledSuccessfully => 'ルールは正常に無効化されました';

  @override
  String get ruleEnabledSuccessfully => 'ルールは正常に有効化されました';

  @override
  String ruleLoadFailed(Object error) {
    return 'ルールの読み込みに失敗しました: $error';
  }

  @override
  String get ruleManagement => 'ルール管理';

  @override
  String get ruleManagementTitle => 'ルール管理';

  @override
  String get ruleName => 'ルール名';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => 'ルール名とコンテンツの正規表現は空にできません';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => 'ルール名と電話番号は空にできません';

  @override
  String get ruleNameHint => '例：家族、友人など';

  @override
  String get ruleNameLabel => 'ルール名';

  @override
  String get ruleNamePatternRequired => 'ルール名とパターンを入力してください';

  @override
  String get ruleNameRequired => 'ルール名と電話番号は空にできません';

  @override
  String get ruleNotExist => 'ルールが存在しないか、削除されました';

  @override
  String ruleNotFound(Object error) {
    return 'ルールが見つかりません: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'ルールは正常に保存されました！';

  @override
  String get ruleSavedSuccessMessage => 'ルールは正常に保存されました！';

  @override
  String ruleSaveFailed(Object error) {
    return '保存に失敗しました: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '保存に失敗しました: $error';
  }

  @override
  String get ruleSaveSuccess => 'ルールは正常に保存されました！';

  @override
  String get rulesExportedSuccessfully => 'ルールは正常にエクスポートされました';

  @override
  String rulesExportedTo(Object path) {
    return 'ルールがエクスポートされました: $path';
  }

  @override
  String get rulesImported => 'ルールは正常にインポートされました';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count 件のルールが正常にインポートされました';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'ルールのインポートに失敗しました: $error';
  }

  @override
  String get ruleStatistics => 'ルールの統計';

  @override
  String ruleStatusChanged(Object status) {
    return 'ルール $status は正常に変更されました';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '操作に失敗しました: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'ルール $status は正常に変更されました';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'ルールの更新に失敗しました: $error';
  }

  @override
  String get ruleUpdateSuccess => 'ルールは正常に更新されました';

  @override
  String get ruleVerification => 'ルール検証';

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
    return '保存に失敗しました: $error';
  }

  @override
  String get saveFilter => 'フィルターを保存';

  @override
  String get saveSettings => '設定を保存';

  @override
  String saveSettingsFailed(Object error) {
    return '設定の保存に失敗しました: $error';
  }

  @override
  String get scamsLikely => '詐欺の可能性';

  @override
  String get search => '検索';

  @override
  String get searchContacts => '連絡先を検索';

  @override
  String searchError(Object error) {
    return '検索エラー: $error';
  }

  @override
  String get searchFilters => 'フィルターを検索';

  @override
  String get searchForContacts => '連絡先を検索';

  @override
  String get searchHint => '検索...';

  @override
  String get searchSettingsSubtitle => '連絡先、ラベル、ブラックリスト、ホワイトリストなどを検索します。';

  @override
  String get searchSettingsTitle => '検索設定';

  @override
  String get securityMessage =>
      '電話を信頼しないでください。常にカスタマーサービス番号を個別に確認してください。パスワード、確認コード、カード番号、個人情報を決して共有しないでください。';

  @override
  String get selectActionToPerform => 'ルールが一致した場合に実行するアクションを選択してください';

  @override
  String get selectActionWhenBlockingCalls => '通話をブロックする場合のアクションを選択';

  @override
  String get selectActionWhenRuleMatches => 'ルールが一致した場合のアクションを選択';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get selectCountry => '国を選択';

  @override
  String get selectDateRange => '日付範囲を選択';

  @override
  String get selectedDateRange => '選択された日付範囲';

  @override
  String selectedItems(Object count) {
    return '$count 個のアイテムが選択されました';
  }

  @override
  String get selectedLabel => '選択済み:';

  @override
  String get selectExportFormat => 'エクスポート形式を選択';

  @override
  String get selectLabel => 'ラベルを選択';

  @override
  String get selectLabelAndEnterPhoneNumber => 'ラベルを選択して、有効な電話番号を入力してください';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get selectMultiple => '複数選択';

  @override
  String get selectPeriod => '期間を選択';

  @override
  String get selectSimCard => 'SIMカードを選択';

  @override
  String get selectSimSlot => 'SIMスロットを選択';

  @override
  String get selectSpecificActionForBlockedCalls => '通話拒否時の特定のアクションを選択';

  @override
  String get selectTag => 'タグを選択';

  @override
  String get selectTags => 'タグを選択';

  @override
  String get selectTrustedDataSource => '信頼できるデータソースを選択してください';

  @override
  String get selectYourLanguage => '言語を選択';

  @override
  String get sender => '送信者';

  @override
  String get senderRegexOptional => '送信者Regex (オプション)';

  @override
  String get serverAddressLabel => 'サーバーアドレス';

  @override
  String get serviceTypeContact => '連絡先サブスクリプション';

  @override
  String get serviceTypeLabel => 'サービスタイプ';

  @override
  String get serviceTypePhone => '電話サブスクリプション';

  @override
  String get serviceTypePlugin => 'プラグインアップデート';

  @override
  String get serviceTypeSms => 'SMSサブスクリプション';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '設定';

  @override
  String get setEncryptionPassword => '暗号化パスワードを設定';

  @override
  String get setEncryptionPasswordDescription => 'バックアップと復元のために暗号化パスワードを設定します';

  @override
  String get setEncryptionPasswordLabel => '暗号化パスワードを設定';

  @override
  String get setEncryptionPasswordTitle => '暗号化パスワードを設定';

  @override
  String get setPasswordButton => '設定';

  @override
  String get settings => '設定';

  @override
  String settingsBackedUpTo(Object path) {
    return '設定のバックアップ先: $path';
  }

  @override
  String get settingsLoaded => '設定を読み込みました';

  @override
  String settingsLoadFailed(Object error) {
    return '設定の読み込みに失敗しました: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      '設定が正常に復元されました。変更を有効にするには、アプリを再起動してください。';

  @override
  String get settingsSaved => '設定を保存しました';

  @override
  String settingsSaveFailed(Object error) {
    return '設定の保存に失敗しました: $error';
  }

  @override
  String get settingsTab => '設定';

  @override
  String get settingsTitle => '設定';

  @override
  String get setup => 'セットアップ';

  @override
  String get showContactEditDialogStaticMethod => '連絡先編集ダイアログを表示するための静的メソッド';

  @override
  String get showExplanation => '説明を表示';

  @override
  String get silence => 'サイレンス';

  @override
  String get silenceAndNoAnswer => 'サイレンスと応答なし';

  @override
  String get silenceNoAnswer => 'サイレンス、応答なし';

  @override
  String get silentCallVoiceClone => 'サイレントコール音声クローン';

  @override
  String get silentRules => 'サイレントルール';

  @override
  String simCard(Object simNumber) {
    return 'SIMカード $simNumber';
  }

  @override
  String get simCardColor => 'SIMカードの色';

  @override
  String get simCardConfigurationExplanation =>
      '• SIMカード構成: 各SIMカードに独立したフィルタリングルールを設定します';

  @override
  String get simCardFilterRules => 'SIMカードのフィルタリングルール';

  @override
  String get simCardFilterRulesDescription =>
      'SIMカードスロットに基づいて異なるフィルタリングルールを設定します';

  @override
  String get simCardFontSize => 'SIMカードのフォントサイズ';

  @override
  String get simCardPosition => 'SIMカードの位置';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'SIMカード情報の読み込みに失敗しました: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIMスロットルールを使用すると、各SIMスロットに対して独立したフィルタリングルールを設定できます。';

  @override
  String get simRuleInstructionsTitle => 'SIMスロットルール';

  @override
  String get simRuleManagement => 'SIMスロットルール管理';

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
    return 'SIMデータの読み込みに失敗しました: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIMスロットフィルタ設定';

  @override
  String get simSlotFilterConfigurationDescription =>
      'SIMスロットごとにフィルタールールを設定できます。';

  @override
  String get simSlotFilterDescription => '各SIMカードに対して独立したフィルタリングルールを設定します:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIMスロット $slotNumber フィルタ設定';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIMスロットの読み込みに失敗しました: $error';
  }

  @override
  String get simSlotManagement => 'SIMスロット管理';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIMスロット操作に失敗しました: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIMスロット位置 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIMスロットルール: SIMごとに独立したフィルタリング戦略';

  @override
  String get simSlotRuleListTitle => 'SIMスロットルールリスト';

  @override
  String get simSlotRuleManagement => 'SIMスロットルール';

  @override
  String get simSlotRuleManagementTitle => 'ルール管理';

  @override
  String get simSlotSettings => 'SIMスロット設定';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIMスロット $slotNumber';
  }

  @override
  String get skip => 'スキップ';

  @override
  String get smartCallerId => 'スマートコールID';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMSフィルタリングは、迷惑メッセージを自動的にフィルタリングし、メッセージリストをクリーンに保つのに役立ちます。フィルタールールと通知方法を設定できます。';

  @override
  String get smsFilterDisabled => 'SMSフィルタリング無効';

  @override
  String get smsFilterEnabled => 'SMSフィルタリング有効';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMSフィルタールールが正常に追加されました';

  @override
  String get smsFilterRules => 'SMSフィルタールール';

  @override
  String get smsFilterSettings => 'SMSフィルタ設定';

  @override
  String get smsHistory => 'SMS履歴';

  @override
  String get smsManagement => 'SMS管理';

  @override
  String get smsPermission => 'SMS許可';

  @override
  String get smsPermissionDescription => '迷惑メッセージをフィルタリングするために使用されます。';

  @override
  String get smsRuleAddedSuccessfully => 'SMSルールが正常に追加されました';

  @override
  String get smsRuleDeletedSuccessfully => 'SMSルールが正常に削除されました';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMSルールの読み込みに失敗しました: $error';
  }

  @override
  String get smsRuleManagement => 'SMSルール管理';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMSルールが $filePath に正常にエクスポートされました';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMSルールが正常にインポートされました';

  @override
  String get smsRuleSubscription => 'SMSルールサブスクリプション';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMSルールが正常に更新されました';

  @override
  String get smsSettingsSubtitle => 'SMSフィルタリングとキーワードブロック';

  @override
  String get smsSettingsTitle => 'SMS設定';

  @override
  String get smsSubscription => 'SMSサブスクリプション';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMSサブスクリプションが正常に追加されました';

  @override
  String get smsSubscriptionRulesDescription =>
      'URL経由でSMSルールリストを購読し、正規表現のマッチングをサポートします。ブロックまたは許可のアクションを設定できます。';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => '一部の権限要求が拒否されました';

  @override
  String get spamLikely => 'スパムの可能性あり';

  @override
  String get startColor => '開始色';

  @override
  String get startDate => '開始日';

  @override
  String get startUsing => '始める';

  @override
  String get statAnswered => '回答済み';

  @override
  String get statBlocked => 'ブロック済み';

  @override
  String get staticMethodShowCallerIdDialog => '発信者ID情報ダイアログを表示するための静的メソッド';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      '国選択ダイアログを表示するための静的メソッド';

  @override
  String get staticMethodToDisplayDialog => 'ダイアログを表示するための静的メソッド';

  @override
  String get statistics => '統計';

  @override
  String get statisticsExportFeatureComingSoon => '統計エクスポート機能は近日公開予定です';

  @override
  String get statisticsGrid => '統計グリッド';

  @override
  String get statisticsPageTitle => 'データ分析';

  @override
  String get stirColor => 'STIRの色';

  @override
  String get stirFontSize => 'STIRのフォントサイズ';

  @override
  String get stirPosition => 'STIRの位置';

  @override
  String get storagePermission => 'ストレージの許可';

  @override
  String get storagePermissionDescription => '設定とルールを保存するために使用します。';

  @override
  String get subscribe => '購読する';

  @override
  String subscriptionAddSuccess(Object name) {
    return '購読 \"$name\" が正常に追加されました';
  }

  @override
  String get subscriptionDeleteConfirmContent => 'この購読を削除してもよろしいですか？';

  @override
  String get subscriptionDeleteConfirmTitle => '購読の削除';

  @override
  String get subscriptionDeleted => '購読を削除しました';

  @override
  String get subscriptionDeletedSuccessfully => '購読が正常に削除されました';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '購読の削除に失敗しました: $error';
  }

  @override
  String get subscriptionDeleteSuccess => '購読を削除しました';

  @override
  String get subscriptionEmptyState => '利用可能な購読はありません';

  @override
  String get subscriptionEmptyText => 'まだ購読はありません';

  @override
  String subscriptionLoadFailed(Object error) {
    return '購読の読み込みに失敗しました: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '購読の読み込みに失敗しました: $error';
  }

  @override
  String get subscriptionManagementTitle => '購読管理';

  @override
  String get subscriptionName => '購読名';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '購読名とURLは空にできません';

  @override
  String get subscriptionNameHint => '購読名を入力してください';

  @override
  String get subscriptionPageTitle => '購読管理';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '購読ステータスの変更に失敗しました: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '購読ステータスの切り替えに失敗しました: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '購読の更新に失敗しました: $error';
  }

  @override
  String get subscriptionUpdateSuccess => '購読が正常に更新されました';

  @override
  String get subscriptionUrl => '購読URL';

  @override
  String get subscriptionUrlHint => '購読URLを入力してください';

  @override
  String successfullyImportedRules(Object count) {
    return '$count 件のルールを正常にインポートしました';
  }

  @override
  String get supportSync => '同期のサポート';

  @override
  String get survey => 'アンケート';

  @override
  String get syncDevicesButton => 'デバイスの同期';

  @override
  String get syncFailed => '同期に失敗しました';

  @override
  String get syncFailedMessage => '同期に失敗しました';

  @override
  String get syncFolderNameHint =>
      '同期フォルダー名を入力してください (デフォルト: NotificationManager)';

  @override
  String get syncFolderNameLabel => '同期フォルダー名';

  @override
  String get synchronized => '同期済み';

  @override
  String get syncing => '同期中...';

  @override
  String get syncNow => '今すぐ同期';

  @override
  String get syncNowButton => '今すぐ同期';

  @override
  String get syncStatusTitle => '同期ステータス';

  @override
  String get syncStatusUpdatedMessage => '同期ステータスが更新されました';

  @override
  String get syncSuccessful => '同期に成功しました';

  @override
  String get syncSuccessMessage => '同期に成功しました';

  @override
  String get syncWithCloudStorage => 'クラウドストレージと同期';

  @override
  String get syncWithCloudStorageSubtitle => 'クラウドストレージと同期';

  @override
  String get systemFeatures => 'システム機能：';

  @override
  String get systemSettingsTitle => 'システム設定';

  @override
  String get tabAll => 'すべて';

  @override
  String get tabAnswered => '応答済み';

  @override
  String get tabBlocked => 'ブロック済み';

  @override
  String get tabMissed => '不在着信';

  @override
  String get tabOutgoing => '発信';

  @override
  String tagLabel(String tag) {
    return 'タグ：$tag';
  }

  @override
  String get tagsUpdated => 'タグを更新しました';

  @override
  String get takeaway => '持ち帰り';

  @override
  String get telecommunication => '電気通信';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'テレマーケティング';

  @override
  String get testButton => 'テスト';

  @override
  String get testButtonLabel => 'テスト';

  @override
  String get testConnectionButton => '接続をテスト';

  @override
  String get textColorsSetting => 'テキストとラベルの色';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'このアプリは、不要な電話を識別してブロックできる強力な発信者番号ツールです。';

  @override
  String get thisWeek => '今週';

  @override
  String get timeInterceptor => '時間インターセプター';

  @override
  String get timeInterceptorDescription => '通話頻度に基づいて、潜在的な通話を自動的に傍受/許可します';

  @override
  String get timeInterceptorExplanation => '• 時間インターセプター：短時間内での繰り返し通話を傍受/許可します';

  @override
  String get timeInterceptorExplanationContent =>
      '通話頻度傍受機能は、通話頻度を分析して、頻繁な迷惑電話を自動的に識別して傍受/許可します。';

  @override
  String get timeInterceptorExplanationTitle => '通話頻度傍受の説明';

  @override
  String get timeInterceptorSettingsTitle => '通話頻度傍受設定';

  @override
  String get timeInterceptorSubtitle => '通話頻度に基づいて、潜在的な迷惑電話を自動的に傍受します';

  @override
  String get timeInterceptorTitle => '通話頻度傍受を有効にする';

  @override
  String get timeWindowDescription =>
      '繰り返し通話を許可する時間枠を設定します。このウィンドウ内の同じ番号からの通話は許可されます';

  @override
  String timeWindowLabel(int minutes) {
    return '傍受時間枠（分）：$minutes';
  }

  @override
  String get timeWindowSetting =>
      '繰り返し通話を許可する時間枠を設定します。このウィンドウ内の同じ番号からの通話は許可されます';

  @override
  String get today => '今日';

  @override
  String get total => '合計';

  @override
  String get totalBlocked => '合計ブロック';

  @override
  String get totalFiltered => '合計フィルタリング';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'デバイスまたはプラットフォーム間でデータを転送する';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'デバイスまたはプラットフォーム間でデータを転送する';

  @override
  String get travelTicketing => '旅行のチケット';

  @override
  String get trend => 'トレンド';

  @override
  String get trendChart => 'トレンドチャート';

  @override
  String get tutorial => 'チュートリアル';

  @override
  String get type => 'タイプ';

  @override
  String get unassignedSIMCard => '未割り当てのSIMカード';

  @override
  String get unknown => '不明';

  @override
  String get unknownLabel => '不明なラベル';

  @override
  String get unknownTag => 'タグ: 不明';

  @override
  String get unregisterButton => '登録解除';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '$deviceNameの登録を解除してもよろしいですか？';
  }

  @override
  String get unregisterDeviceTitle => 'デバイスの登録解除';

  @override
  String get unsupportedFileFormat => 'サポートされていないファイル形式';

  @override
  String get update => 'アップデート';

  @override
  String get updateAllNow => 'すべて今すぐ更新';

  @override
  String get updateCallFilterConfig => '通話フィルタ設定を更新';

  @override
  String updateContactFailed(Object error) {
    return '連絡先の更新に失敗しました: $error';
  }

  @override
  String get updateFavoriteStatus => 'お気に入りステータスを更新';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'お気に入りステータスの更新に失敗しました: $error';
  }

  @override
  String get updateInterval => '更新間隔';

  @override
  String get updateLabelFailed => 'ラベルの更新に失敗しました';

  @override
  String get updateNow => '今すぐ更新';

  @override
  String get updatePlugin => 'プラグインを更新';

  @override
  String updatePluginFailed(Object error) {
    return 'プラグインの更新に失敗しました: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'ルールの更新に失敗しました: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'サブスクリプションの更新に失敗しました: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$serviceが正常に更新されました（$countルール）';
  }

  @override
  String get updateTags => 'タグを更新';

  @override
  String get useCasesPoint1 => '• 自動リダイヤルスパム通話を識別する';

  @override
  String get useCasesPoint2 => '• 短期間に複数回発信するマーケティング通話を阻止する';

  @override
  String get useCasesPoint3 => '• 電話爆弾と嫌がらせを防止する';

  @override
  String get useCasesTitle => 'ユースケース:';

  @override
  String get useGlobalSettings => 'グローバル設定を使用';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'ユーザー名';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'パターンを定義するには、標準の正規表現構文を使用します。例：';

  @override
  String get validateRegex => '正規表現を検証';

  @override
  String get verificationFailedText => '失敗';

  @override
  String get verifiedText => '確認済み';

  @override
  String get verify => '確認';

  @override
  String version(Object version) {
    return 'バージョン: $version';
  }

  @override
  String get vipExchangeDescription => '電話番号マーキングカウントでVIPメンバーシップを交換する';

  @override
  String get vipExchangeTitle => 'マーク交換VIP';

  @override
  String get watchAd => '広告を見る';

  @override
  String get watchAdForTemp => '一時的に広告を見る';

  @override
  String get watchAdForTempDescription =>
      'いくつかのプレミアム機能を一時的にアンロックするために、短い広告をご覧ください';

  @override
  String get webDAVConfigTitle => 'WebDAV設定';

  @override
  String get webdavConfigurationTitle => 'WebDAV設定';

  @override
  String get webdavPasswordHint => 'WebDAVパスワードを入力してください';

  @override
  String get webdavServerAddressHint => 'WebDAVサーバーアドレスを入力してください';

  @override
  String get webdavUsernameHint => 'WebDAVユーザー名を入力してください';

  @override
  String get week => '週';

  @override
  String get weekly => '毎週';

  @override
  String get weeklyBlockedCallsSummary => '週ごとのブロックされた通話の概要';

  @override
  String get weeklyChartTitle => '週ごとのブロックされた通話';

  @override
  String get weeklyReport => '週次レポート';

  @override
  String get weeklyReportDesc => '通話ブロックアクティビティの週次サマリーレポートを受け取ります';

  @override
  String get welcome => 'ようこそ';

  @override
  String get whitelist => 'ホワイトリスト';

  @override
  String get whitelistLabel => 'ホワイトリスト';

  @override
  String get width => '幅';

  @override
  String get wildcardMatchingDescription =>
      '「.」を使用して任意の文字に一致させます（例：「123.456」は123-456に一致します）';

  @override
  String get wildcardMatchingTitle => 'ワイルドカードマッチング:';

  @override
  String get wildcardSupportForFlexibleFiltering => '柔軟なフィルタリングのためのワイルドカードサポート';

  @override
  String get windowSizeSetting => 'ウィンドウサイズ';

  @override
  String get year => '年';

  @override
  String get yearly => '年間';

  @override
  String get yearlyChartTitle => '年間のブロックされた通話';

  @override
  String get noSimCardsDetected => 'SIMカードが検出されませんでした';

  @override
  String get filterManagementDescription => '通話フィルターを設定する';

  @override
  String get callerIdCustomizationSubtitle => '発信者IDレイアウトをカスタマイズする';

  @override
  String get fraudAlerSettingTitle => '詐欺アラート設定';

  @override
  String get fraudAlerSettingSubtitle => '詐欺アラートを設定する';

  @override
  String get enableFraudAlert => '詐欺アラートを有効にする';

  @override
  String get enableFraudAlertDescription => '詐欺の疑いのある通話に対するアラート';

  @override
  String get enableVibration => 'バイブレーションを有効にする';

  @override
  String get enableVibrationDescription => '詐欺の疑いのある通話の場合にバイブレーションする';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get useLocalNotification => 'ローカル通知を使用する';

  @override
  String get useLocalNotificationDescription => '着信に対してローカル通知を有効にする';

  @override
  String get cancelLocalNotification => 'ローカル通知を閉じる';

  @override
  String get useStirNotification => 'STIRからの通知を使用する';

  @override
  String get useStirNotificationDescription => '着信に対してSTIR通知を有効にする';

  @override
  String get cancelLocalNotificationDescription => 'ローカル通知を自動的に閉じる';

  @override
  String get callerIdSettingsTitle => '発信者ID設定';

  @override
  String get callerIdSettingsSubtitle => '着信通知と表示モードを設定する';

  @override
  String get purchaseTitle => '購入';

  @override
  String get purchaseSubtitle => 'サービスを購入する';

  @override
  String get callerIdNotificationTitle => '着信情報';

  @override
  String callerIdBody(String phoneNumber) {
    return '番号: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'ブロックされた通話';

  @override
  String blockedCallBody(String phoneNumber) {
    return '$phoneNumberからのブロックされた通話';
  }

  @override
  String get stirVerified => '検証済み';

  @override
  String get stirNotVerified => '未検証';

  @override
  String get stirFailed => '検証失敗';

  @override
  String get stirUnknown => '不明な検証ステータス';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN検証';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '番号$phoneNumberの$stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => 'スクロールセキュリティメッセージ設定';

  @override
  String get messageColor => 'メッセージの色';

  @override
  String get messageFontSize => 'メッセージフォントサイズ';

  @override
  String get messagePosition => 'メッセージの位置';

  @override
  String get containerWidth => 'コンテナの幅';

  @override
  String get scrollSpeed => 'スクロール速度';

  @override
  String get enableSecurityMessage => 'セキュリティメッセージを有効にする';

  @override
  String get fraudAlertTitle => '詐欺アラート';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '$phoneNumberからの潜在的な詐欺通話';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'ルールの読み込みに失敗しました: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '通話履歴の読み込みに失敗しました: $error';
  }

  @override
  String get noBlockedTypeData => 'ブロックされた種類のデータはありません';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeNameをインポート';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeNameのインポートに成功しました。合計$count件のレコードがインポートされました';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeNameのインポートに失敗しました: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeNameをエクスポート';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeNameのエクスポートに成功しました';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeNameのエクスポートに失敗しました: $error';
  }

  @override
  String get cloudSyncService => 'クラウド同期サービス';

  @override
  String get membershipCenter => 'メンバーシップセンター';

  @override
  String get redeemVipWithMarks => 'マークでVIPを交換';

  @override
  String get currentMarkCount => '現在のマーク数';

  @override
  String get markMoreNumbersForMore => 'さらに多くのマークのためにさらに多くの番号をマーク';

  @override
  String get noAds => '広告なし';

  @override
  String get cloudBackup => 'クラウドバックアップ';

  @override
  String get callerIdEnhancement => '発信者IDの強化';

  @override
  String get voiceRecognition => '音声認識';

  @override
  String get feature => '機能';

  @override
  String get normalUser => '通常ユーザー';

  @override
  String get vipUser => 'VIPユーザー';

  @override
  String get temporaryVip => '一時的なVIP';

  @override
  String get removeAds => '広告を削除';

  @override
  String get unknownAction => '不明なアクション';

  @override
  String get settingsBackup => '設定のバックアップ ';

  @override
  String get allServicesStatusTitle => '現在のサービスステータス';

  @override
  String get allServicesStatusSubtitle => '各クラウドサービスの現在のステータス';

  @override
  String get redirect => 'リダイレクト';

  @override
  String get notify => '通知';

  @override
  String get log => 'ログ';

  @override
  String get custom => 'カスタム';

  @override
  String get allowActionDescription => '番号がブロックリストに載っていても、通話は許可されます。';

  @override
  String get blockActionDescription => '通話はブロックされ、通話履歴に表示されます。';

  @override
  String get silenceActionDescription => '通話はサイレントになりますが、通話履歴に表示されます。';

  @override
  String get noneActionDescription => '通話に対して特別なアクションは実行されません。';

  @override
  String get redirectActionDescription => '通話を指定された番号にリダイレクトします。';

  @override
  String get labelActionDescription => '識別しやすいように通話にラベルを追加します。';

  @override
  String get notifyActionDescription => '通話を受信したときに通知を送信します。';

  @override
  String get logActionDescription => '他のアクションを実行せずに、通話情報を記録します。';

  @override
  String get customActionDescription => 'カスタムアクションを実行します。';

  @override
  String get synced => '同期済み';

  @override
  String get needVipAccess => 'この機能を使用するには、VIPアクセスが必要です';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeNameデータをインポートまたはエクスポートします';
  }

  @override
  String get importExportTitle => 'インポート/エクスポート';

  @override
  String get noPhoneRules => '電話ルールが見つかりません';

  @override
  String get noRegexRules => '正規表現ルールが見つかりません';

  @override
  String get noAllowedBlockedRules => '許可/ブロックルールが見つかりません';

  @override
  String get importExport => 'インポート/エクスポート';

  @override
  String get filterByAction => 'アクションでフィルタリング';

  @override
  String get upgradeToVip => 'VIPにアップグレード';

  @override
  String get batteryOptimizationPermission => 'バッテリー最適化';

  @override
  String get batteryOptimizationPermissionDescription =>
      '発信者番号などのサービスを提供するために、アプリがバックグラウンドで実行されることを許可します。';

  @override
  String get permissionTitle => '特別許可';

  @override
  String get permissionSubtitle => 'オーバーレイとバッテリー最適化の許可を管理します';

  @override
  String get themeSettingsTitle => 'テーマ設定';

  @override
  String get themeSettingsSubtitle => 'お気に入りのテーマを選択してください';

  @override
  String get databaseSyncTitle => 'データベース同期';

  @override
  String get countrySyncSettingsTitle => '国別データベース同期設定';

  @override
  String get countrySyncSettingsSubtitle => 'データ同期する国を選択してください';

  @override
  String get countryDataDisclaimer =>
      'ご注意ください: データベースには、すべての特定の国または地域のデータが含まれていない場合があります。';

  @override
  String get editSubscription => 'サブスクリプションを編集';

  @override
  String get searchByNameOrPhoneNumber => '名前または電話番号で検索';

  @override
  String get allowedBlockedRulesInfo =>
      '許可/ブロックルールは、特定の電話番号への通話に一致させるために使用され、これが最優先されます。';

  @override
  String get searchPhoneRulesHint => '電話ルールを検索';

  @override
  String get phoneRulesInfo =>
      '電話ルールは、特定の電話番号への通話に一致させるために使用され、優先順位が低くなります。一部はphoneRuleサブスクリプションから取得されます';

  @override
  String get searchSubscriptionsHint => 'サブスクリプションを検索';

  @override
  String get searchPluginsHint => 'プラグインを検索';

  @override
  String get searchLabelsHint => 'ラベルを検索';

  @override
  String get pluginDescription => 'プラグインの説明';

  @override
  String get enterPluginDescription => 'プラグインの説明を入力してください';

  @override
  String get searchRegexRulesHint => '正規表現ルールを検索';

  @override
  String get regexRulesInfo => '正規表現ルールは、正規表現パターンに基づいて通話をフィルタリングするために使用されます。';

  @override
  String get searchMarkedPhonesHint => 'マークされた電話を検索';

  @override
  String get searchContactSubscriptionsHint => '連絡先サブスクリプションを検索';

  @override
  String get showAllContacts => 'すべての連絡先を表示';

  @override
  String get showFavorites => 'お気に入りを表示';

  @override
  String get manualEntry => '手動入力情報';

  @override
  String get scriptSaved => 'スクリプトを保存しました';

  @override
  String editScriptFor(String pluginName) {
    return '$pluginNameのスクリプトを編集';
  }

  @override
  String get saveScript => 'スクリプトを保存';

  @override
  String get testPlugin => 'プラグインをテスト';

  @override
  String get description => '説明';

  @override
  String get accessTargetUrl => 'ターゲットURLへのアクセス';

  @override
  String get result => '結果';

  @override
  String get editScript => 'スクリプトを編集';

  @override
  String get numberFormat => '番号形式';

  @override
  String get nationalNumber => '国内番号';

  @override
  String get e164Number => 'E164番号';

  @override
  String get pluginRulesInfo =>
      'セキュリティのため、信頼できるソースのプラグインのみを使用してください。独自のカスタムプラグインを作成するために、当社のテンプレートをご自由にお使いください！';

  @override
  String get advancedMode => '詳細モード';

  @override
  String get pleaseEnterAtLeastOneNumber => '少なくとも1つの番号を入力してください。';

  @override
  String get openInWebView => 'WebViewで開く';

  @override
  String get pluginLabel => 'プラグインラベル';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'メッセージの背景色';

  @override
  String get clearAllCallLogs => 'すべての通話履歴をクリア';

  @override
  String get clearAllCallLogsConfirmation => 'すべての通話履歴をクリアすることを確認してください';

  @override
  String get allCallLogsCleared => 'すべての通話履歴がクリアされました';

  @override
  String get unblocked => 'ブロック解除されました';

  @override
  String get blockNumber => 'ブロック番号';

  @override
  String get blockNumberSuccess => 'ブロック番号成功';

  @override
  String get blockNumberFailed => 'ブロック番号失敗';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '$phoneNumberのブロックを解除してもよろしいですか？';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '$phoneNumberに電話中...';
  }

  @override
  String get viewDetails => '詳細を表示';

  @override
  String get unblock => 'ブロック解除';

  @override
  String get unblockNumber => '番号ブロック解除';

  @override
  String get unblockNumberSuccess => '番号のブロックを正常に解除しました';

  @override
  String get unblockNumberFailed => '番号のブロック解除に失敗しました';

  @override
  String get serviceNotAvailable => 'サービスは利用できません';

  @override
  String get callingNumberFailed => '電話番号への発信に失敗しました';

  @override
  String get listView => 'リストビュー';

  @override
  String get timelineView => 'タイムラインビュー';

  @override
  String get nameCannotBeEmpty => '名前は空にできません';

  @override
  String get selectAction => 'アクションを選択';

  @override
  String get selectTargetService => '対象サービスを選択';

  @override
  String get callDetails => '通話の詳細';

  @override
  String get callType => '通話タイプ';

  @override
  String get callTime => '通話時間';

  @override
  String get numberInvalidFormat => '番号の形式が正しくありません';

  @override
  String get membershipFeature => 'メンバーシップ機能';

  @override
  String get medium => '媒体';

  @override
  String get verificationReport => '検証レポート';

  @override
  String get finalRisk => '最終的なリスク';

  @override
  String get simState => 'SIM状態';

  @override
  String get ipCountry => 'IP国';

  @override
  String get simCountry => 'SIM国';

  @override
  String get isRoaming => 'ローミング中';

  @override
  String get isNumberMatch => '番号の一致';

  @override
  String get support => 'サポート';

  @override
  String get rewardedAdService => 'リワード広告サービス';

  @override
  String get hasVipPrivilegeExceptAds => '既にVIP特典（広告を除く）があります';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '既に一時的な特典があり、有効期限は$expiryDateです';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '一時的なVIP特典を得るには、さらに$count個の広告を視聴する必要があります';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '$days日間の期間限定購入特典が付与されました。有効期限：$expiryDate';
  }

  @override
  String get tempPurchaseExpired => '一時的な購入特典が期限切れになりました';

  @override
  String get loadingAd => '広告を読み込み中...';

  @override
  String get earnedTempVip => '一時的なVIPを獲得しました';

  @override
  String get vipExchangeService => 'VIP交換サービス';

  @override
  String get marksInsufficient => '交換に必要なポイントが不足しています';

  @override
  String get invalidExchangeRule => '無効な交換ルール';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '$descriptionと交換しました。有効期限：$expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '交換に失敗しました: $error';
  }

  @override
  String get vip3DaysWithAds => '広告付き3日間VIP (同期のみ)';

  @override
  String get vip5DaysNoAds => '広告なし5日間フル機能VIP';

  @override
  String get vip7DaysNoAds => '広告なし7日間フル機能VIP';

  @override
  String get noNotifications => '通知はありません';

  @override
  String get clearAllNotifications => 'すべての通知をクリア';

  @override
  String get clearAllNotificationsConfirmation => 'すべての通知をクリアすることを確認しますか？';

  @override
  String get allNotificationsCleared => 'すべての通知をクリアしました';

  @override
  String get clearButton => 'クリア';

  @override
  String get justNow => 'たった今';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count分前',
      one: '1分前',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count時間前',
      one: '1時間前',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日前',
      one: '1日前',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '昨日';

  @override
  String get deletionProposal => '削除提案';

  @override
  String get deletionProposals => '削除提案';

  @override
  String get createProposal => '提案を作成';

  @override
  String get createProposalTitle => '削除提案を作成';

  @override
  String get reason => '理由';

  @override
  String get reasonOutdated => '古くなった番号';

  @override
  String get reasonPrivacy => 'プライバシーの問題';

  @override
  String get reasonNotInService => 'サービス対象外';

  @override
  String get reasonWronglyIdentified => '誤って識別された';

  @override
  String get reasonInaccurateInfo => '不正確な情報';

  @override
  String get reasonWrongMarked => '誤ってマークされた';

  @override
  String get reasonOther => 'その他';

  @override
  String get submit => '送信';

  @override
  String get cancel => 'キャンセル';

  @override
  String get proposalStatus => 'ステータス';

  @override
  String get statusPending => '保留中';

  @override
  String get statusActive => 'アクティブ';

  @override
  String get statusCompleted => '完了';

  @override
  String get statusExpired => '期限切れ';

  @override
  String get riskLevel => 'リスクレベル';

  @override
  String get riskLevelVerified => '検証済み';

  @override
  String get riskLevelLow => '低';

  @override
  String get riskLevelHigh => '高';

  @override
  String get riskLevelUnknown => '不明';

  @override
  String get votingProgress => '投票の進行状況';

  @override
  String agreeVotes(int count) {
    return '賛成: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '反対: $count';
  }

  @override
  String totalVotes(int count) {
    return '合計: $count';
  }

  @override
  String get voteAgree => '賛成';

  @override
  String get voteDisagree => '反対';

  @override
  String createdAt(String date) {
    return '作成日: $date';
  }

  @override
  String get showReport => 'レポートを表示';

  @override
  String get hideReport => 'レポートを非表示';

  @override
  String get proposalStatistics => '提案統計';

  @override
  String get totalProposals => '提案の合計';

  @override
  String get activeProposals => 'アクティブな提案';

  @override
  String get completedProposals => '完了した提案';

  @override
  String get myVotes => '私の投票';

  @override
  String get proposalCreated => '提案が正常に作成されました';

  @override
  String get proposalCreateFailed => '提案の作成に失敗しました';

  @override
  String get voteSubmitted => '投票が正常に送信されました';

  @override
  String get voteSubmitFailed => '投票の送信に失敗しました';

  @override
  String get noProposalsFound => '提案が見つかりませんでした';

  @override
  String get loadingProposals => '提案を読み込んでいます...';

  @override
  String get refreshProposals => '提案を更新';

  @override
  String get totalPendingProposals => '保留中の提案の合計';

  @override
  String get highRisk => '高リスク';

  @override
  String get mediumRisk => '中リスク';

  @override
  String get lowRisk => '低リスク';

  @override
  String get communityImpact => 'コミュニティへの影響';

  @override
  String get criticalIssues => '重大な問題';

  @override
  String get communityParticipation => 'コミュニティへの参加';

  @override
  String get noActivity => '活動なし';

  @override
  String get low => '低';

  @override
  String get moderate => '中程度';

  @override
  String get high => '高';

  @override
  String get veryHigh => '非常に高い';

  @override
  String get voted => '投票済み';

  @override
  String get communityVotes => 'コミュニティ投票';

  @override
  String get waitingForMoreVotes => 'より多くのコミュニティ投票を待機中';

  @override
  String get proposalProcessed => 'この提案は処理されました';

  @override
  String get supported => '支持';

  @override
  String get opposed => '反対';

  @override
  String get approved => '承認済み';

  @override
  String get rejected => '拒否されました';

  @override
  String get completed => '完了';

  @override
  String get pending => '保留中';

  @override
  String get critical => '重大';

  @override
  String get oppose => '反対する';

  @override
  String get veryLow => '非常に低い';

  @override
  String get deletionProposalNotificationDescription => '削除提案の投票結果と更新に関する通知。';

  @override
  String get deletionProposalCreated => '削除提案が作成されました';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '$phoneNumber の削除提案がコミュニティレビューのために提出されました。';
  }

  @override
  String get proposalApproved => '提案承認 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber の削除提案がコミュニティによって承認されました (支持率 $supportPercentage%, 総投票数 $totalVotes票)。';
  }

  @override
  String get proposalRejected => '提案拒否 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber の削除提案がコミュニティによって拒否されました (支持率 $supportPercentage%, 総投票数 $totalVotes票)。';
  }

  @override
  String get communityVotingStarted => 'コミュニティ投票が開始されました';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '$phoneNumber の新しい削除提案がコミュニティ投票のために公開されました。';
  }

  @override
  String get votingCompleted => '投票が完了しました';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '$phoneNumber のコミュニティ投票が終了しました。結果: $result ($supportPercentage% 支持)。';
  }

  @override
  String get newVoteReceived => '新しい投票を受信しました';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '誰かが $phoneNumber の削除に $voteType と投票しました。現在の投票数: $totalVotes。';
  }

  @override
  String get loadVoteCountFailed => '投票数の読み込みに失敗しました';

  @override
  String get voteCount => '投票数';

  @override
  String get deletionProposalInfo => '削除提案の情報';

  @override
  String get deletionProposalDescription =>
      'コミュニティガイドラインに違反する削除対象の番号を提案します。あなたの参加はプラットフォームの安全維持に役立ちます。';

  @override
  String get voteToEarnVip => 'VIP特典を獲得するために提案に投票しましょう！';

  @override
  String get voteFailed => '投票に失敗しました';

  @override
  String get searchProposals => '提案を検索';

  @override
  String get defaultNotifications => 'デフォルトの通知';

  @override
  String get defaultNotificationsDescription => 'アプリのデフォルト通知チャネル。';

  @override
  String get blockedCallNotifications => 'ブロックされた通話の通知';

  @override
  String get blockedCallNotificationsDescription => 'ブロックされた通話に関する情報を表示します。';

  @override
  String get stirVerification => 'STIR/SHAKEN認証';

  @override
  String get stirVerificationDescription => '番号のSTIR/SHAKEN認証結果を表示します。';

  @override
  String get fraudAlerts => '詐欺アラート';

  @override
  String get fraudAlertsDescription => '詐欺の可能性のある通話に関する警告を表示します。';

  @override
  String get notificationFrequencyDescription =>
      '新しい削除提案に関する通知を受け取る頻度を選択します。即時、バッチ、またはカスタムの間隔で受信できます。';

  @override
  String get immediateNotifications => '即時';

  @override
  String get immediateNotificationsDescription => '提案が作成されたらすぐに通知を受け取ります。';

  @override
  String get batchNotifications => 'バッチ';

  @override
  String get batchNotificationsDescription => '通知の概要を定期的に受け取ります。';

  @override
  String get customNotifications => 'カスタム';

  @override
  String get customNotificationsDescription => '通知を受け取るための独自の間隔を定義します。';

  @override
  String get customFrequency => 'カスタム頻度';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 分';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 時間';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 時間 $minutes 分';
  }

  @override
  String get pendingProposals => '保留中の提案';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件あります',
      one: '1件あります',
      zero: 'ありません',
    );
    return '保留中の提案が$_temp0。';
  }

  @override
  String get guidelinesLabel => 'ガイドライン';

  @override
  String get reportingGuidelines =>
      '• 実際に問題のある番号のみを報告する\n• 正確で詳細な理由を提供する\n• 深刻度に応じて適切なリスクレベルを選択する\n• 虚偽の報告はアカウントの制限につながる可能性があります';

  @override
  String get riskLevelLabel => 'リスクレベル';

  @override
  String get riskLevelDescription => '番号のリスクレベル';

  @override
  String get phoneNumberMinDigits => '電話番号は7桁以上である必要があります';

  @override
  String get provideDetailedExplanation => '詳細な説明を提供する（10文字以上）';

  @override
  String get reasonMinCharacters => '理由は10文字以上である必要があります';

  @override
  String get countryCodeTwoLetters => '国コード (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '国コード (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '例：US、CN、GB';

  @override
  String get countryCodeRequired => '国コードは必須です';

  @override
  String get countryCodeLengthError => '国コードは2文字でなければなりません';

  @override
  String get phoneNumberLengthError => '電話番号は7桁以上である必要があります';

  @override
  String get reasonHint => '詳細な説明を提供する（10文字以上）';

  @override
  String get reasonRequired => '理由は必須です';

  @override
  String get reasonLengthError => '理由は10文字以上である必要があります';

  @override
  String get guidelinesTitle => 'ガイドライン';

  @override
  String get guidelinesText =>
      '• 実際に問題のある番号のみを報告する\n• 正確で詳細な理由を提供する\n• 深刻度に応じて適切なリスクレベルを選択する\n• 虚偽の報告はアカウントの制限につながる可能性があります';

  @override
  String get riskLevelCritical => '重大';

  @override
  String get riskLevelMedium => '中';

  @override
  String get riskLevelVeryLow => '非常に低い';

  @override
  String get riskDescriptionVeryLow => '非常に低い - 軽度の迷惑行為、まれな通話';

  @override
  String get riskDescriptionLow => '低い - 時折迷惑な通話';

  @override
  String get riskDescriptionMedium => '中 - 定期的なスパムまたはテレマーケティング';

  @override
  String get riskDescriptionHigh => '高い - しつこい嫌がらせまたは詐欺の試み';

  @override
  String get riskDescriptionCritical => '重大 - 危険な詐欺または脅威';

  @override
  String get notificationFrequencyTitle => '通知頻度';

  @override
  String get notificationFrequencyLabel => '通知頻度（時間）';

  @override
  String errorMessage(String error) {
    return 'エラー: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '投票: $totalVotes ($supportPercentage% 支持)';
  }

  @override
  String supportCount(int supportCount) {
    return '支持 ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return '反対 ($opposeCount)';
  }

  @override
  String get timeJustNow => 'たった今';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days日前';
  }

  @override
  String get notificationFrequencyHours => '通知頻度（時間）';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes 票（$supportPercentage% 支持）';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 時間',
      one: '1 時間',
      zero: '0 時間',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '重要なお知らせ';

  @override
  String get dataSourceDisclaimer =>
      '数値はインターネットとユーザーからの投稿に基づいています。削除された数値が、他のユーザーまたはソースによって再投稿されないことを保証することはできません。積極的に情報を検索し、検証してください。';

  @override
  String get avatar => 'アバター';

  @override
  String get location => '場所';

  @override
  String get simCardTitle => 'SIMカード';

  @override
  String get liveActivitiesSettingsTitle => 'ライブアクティビティ設定';

  @override
  String get elementsSettingsTitle => '要素設定';

  @override
  String get liveActivityMode => 'ライブアクティビティ';

  @override
  String get liveActivityModeDescription =>
      '通話情報を、ロック画面とダイナミックアイランド（iOS）に永続的な通知として表示します。';

  @override
  String get phoneNumberType => '電話番号の種類';

  @override
  String get liveActivitiesTestEndActivity => 'アクティビティを終了';

  @override
  String get liveActivitiesTestSendNewActivity => '新しいアクティビティを送信';

  @override
  String get liveActivitiesTestUpdateActivity => 'アクティビティを更新';

  @override
  String get liveActivityControlsTitle => 'ライブアクティビティコントロール';

  @override
  String get liveActivitiesTestTitle => 'ライブアクティビティテスト';

  @override
  String get liveActivitiesTestSubtitle => 'ライブアクティビティ通知をテストします。';

  @override
  String get liveNotificationCustomizationTitle => 'ライブ通知のカスタマイズ';

  @override
  String get liveNotificationCustomizationSubtitle => 'ライブ通知の外観をカスタマイズします。';

  @override
  String get notification_instructions =>
      '手順:\n1. 「送信」をタップして通知を作成または更新します。\n2. ホーム画面に移動するか、通知トレイを引き下げて結果を確認します。\n3. 「終了」をタップして通知を閉じます。';

  @override
  String get autoCancelNotification => '自動通知キャンセル';

  @override
  String get autoCancelNotificationDescription =>
      'チェックすると、ユーザーが通知をタップしたときに通知が自動的に閉じられます。';

  @override
  String get setDelayTime => '遅延時間を設定';

  @override
  String get proposalDetails => '提案の詳細';

  @override
  String get filterByStatus => 'ステータスでフィルタリング';

  @override
  String get proposalNotFound => '提案が見つかりません';

  @override
  String get processed => '処理済み';

  @override
  String get showAll => 'すべて表示';

  @override
  String get filterAndSortTitle => 'フィルターと並べ替え';

  @override
  String get filterVerifiedOwner => '検証済みの所有者をフィルタリング';

  @override
  String get filterBy => 'フィルター';

  @override
  String get sortOldest => '古い順に並べ替え';

  @override
  String get sortNewest => '新しい順に並べ替え';

  @override
  String get sortMostPopular => '人気順に並べ替え';

  @override
  String get sortLeastPopular => '不人気順に並べ替え';

  @override
  String get sortBy => '並べ替え';

  @override
  String get simRulesNotFound => 'SIMルールが見つかりません';

  @override
  String get simSlotRules => 'SIMスロットルール';

  @override
  String get noSimCardDetected => 'SIMカードが検出されません';

  @override
  String get invalidSimData => '無効なSIMデータ';

  @override
  String get simCardData => 'SIMカードデータ';

  @override
  String get simSlot => 'SIMスロット';

  @override
  String get enableFiltering => 'フィルタリングを有効にする';

  @override
  String get detailedSettingsTitle => '詳細設定';

  @override
  String get entryPointViewTitle => 'エントリーポイントビュー';

  @override
  String get callTypeRejected => '拒否';

  @override
  String get callTypeSilenced => 'サイレント';

  @override
  String get callTypeVoicemail => 'ボイスメール';

  @override
  String get callTypeUnknownIntercept => '不明なインターセプト';

  @override
  String andMoreItems(int count) {
    return '他$count件';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Cloud Sync Settings';

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
  String get configSaved => 'Configuration Saved!';

  @override
  String get masterDeviceLabel => 'Is Master Device (Admin)';

  @override
  String get masterDeviceHelp =>
      'Only the master device can initialize the database structure.';

  @override
  String get syncIntervalLabel => 'Auto-sync Interval';

  @override
  String syncIntervalValue(int hours) {
    return 'Every $hours hours';
  }

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';
}
