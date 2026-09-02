// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get aboutContactSubscription => '연락처 구독 정보';

  @override
  String get aboutLabels => '라벨 정보';

  @override
  String get aboutPhoneSubscriptionRules => '전화 구독 규칙 정보';

  @override
  String get aboutPhoneSubscriptions => '전화 구독 정보';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'URL을 통해 전화 규칙 목록을 구독하고, 규칙을 자동으로 업데이트합니다. JSON, CSV 형식의 규칙 파일을 지원합니다.';

  @override
  String get aboutSmsFilter => 'SMS 필터 정보';

  @override
  String get aboutSmsSubscriptionRules => 'SMS 구독 규칙 정보';

  @override
  String get aboutSubtitle => '애플리케이션 버전 및 법적 정보';

  @override
  String get aboutTitle => '정보';

  @override
  String get action => '작업';

  @override
  String get actionAll => '모두';

  @override
  String get actionAllow => '허용';

  @override
  String get actionBlock => '차단';

  @override
  String get actionFilterAll => '모든 필터';

  @override
  String get actionFilterTitle => '작업 유형으로 필터링';

  @override
  String get actionFilterTooltip => '작업 필터';

  @override
  String get actionNone => '작업 없음';

  @override
  String get actionSilence => '무음';

  @override
  String actionTag(Object actionType) {
    return '작업: $actionType';
  }

  @override
  String get actionType => '작업 유형';

  @override
  String get actionUnknown => '알 수 없음';

  @override
  String get add => '추가';

  @override
  String get addAllowedBlockedRule => '허용/차단 규칙 추가';

  @override
  String get addAllowSubscription => '허용 구독 추가';

  @override
  String get addBlockSubscription => '차단 구독 추가';

  @override
  String get addContactButton => '연락처 추가';

  @override
  String addContactFailed(Object error) {
    return '연락처 추가 실패: $error';
  }

  @override
  String get addedToAllowedRules => '허용 규칙에 추가됨';

  @override
  String get addedToBlacklist => '블랙리스트에 추가됨';

  @override
  String get addedToBlockedRules => '차단 규칙에 추가됨';

  @override
  String get addedToFavoriteContacts => '즐겨찾는 연락처에 추가됨';

  @override
  String get addedToFavorites => '즐겨찾는 연락처에 추가됨';

  @override
  String get addedToWhitelist => '화이트리스트에 추가됨';

  @override
  String get addFavorite => '즐겨찾기 추가';

  @override
  String get addFilter => '필터 추가';

  @override
  String get addLabel => '라벨 추가';

  @override
  String get addLabelButton => '라벨 추가';

  @override
  String addLabelFailed(Object error) {
    return '라벨 추가 실패: $error';
  }

  @override
  String get addLabelToCall => '통화 기록에 라벨 추가';

  @override
  String get addName => '이름 추가';

  @override
  String get addNoneSubscription => '없음 구독 추가';

  @override
  String get addOrEditContactInfo => '연락처 정보를 추가하거나 편집하는 데 사용';

  @override
  String get addPhoneMark => '전화 번호 표시 추가';

  @override
  String get addPhoneNumberRule => '전화 번호 규칙 추가';

  @override
  String get addPlugin => '플러그인 추가';

  @override
  String get addPluginFailed => '플러그인 추가 실패';

  @override
  String addPluginFailedWithError(Object error) {
    return '플러그인 추가 실패: $error';
  }

  @override
  String get addPluginFromLocalFile => '로컬 파일에서 플러그인 추가';

  @override
  String get addPluginFromUrl => 'URL에서 플러그인 추가';

  @override
  String get addRegexRule => '정규식 규칙 추가';

  @override
  String get addRule => '규칙 추가';

  @override
  String get addRuleButton => '규칙 추가';

  @override
  String addRuleFailed(Object error) {
    return '규칙 추가 실패: $error';
  }

  @override
  String get addRuleTooltip => '규칙 추가';

  @override
  String get addSilenceSubscription => '무음 구독 추가';

  @override
  String get addSimRuleButton => 'SIM 규칙 추가';

  @override
  String get addSmsFilterRule => 'SMS 필터 규칙 추가';

  @override
  String get addSmsRule => 'SMS 규칙 추가';

  @override
  String get addSmsSubscription => 'SMS 구독 추가';

  @override
  String get addSubscription => '구독 추가';

  @override
  String get addSubscriptionButton => '구독 추가';

  @override
  String addSubscriptionFailed(Object error) {
    return '구독 추가 실패: $error';
  }

  @override
  String get addSubscriptionTooltip => '구독 추가';

  @override
  String get addToAllowedRules => '허용 규칙에 추가';

  @override
  String get addToBlacklist => '블랙리스트에 추가';

  @override
  String get addToBlockedRules => '차단된 규칙에 추가';

  @override
  String get addToFavoriteContacts => '즐겨찾는 연락처에 추가';

  @override
  String get addToFavorites => '즐겨찾기에 추가';

  @override
  String get addToRules => '규칙에 추가';

  @override
  String get addToWhitelist => '화이트리스트에 추가';

  @override
  String get adPlaceholder => '광고 자리 표시자';

  @override
  String get agent => '에이전트';

  @override
  String get all => '전체';

  @override
  String get allCallsTab => '전체';

  @override
  String get allDataClearedSuccessfully => '모든 데이터가 성공적으로 삭제되었습니다.';

  @override
  String get allow => '허용';

  @override
  String get allowAllAllowRules => '모든 허용 규칙 허용';

  @override
  String get allowAllAllowRulesDesc => '허용 규칙에서 통화 허용';

  @override
  String get allowAllBlacklistedNumbers => '모든 블랙리스트 번호 허용';

  @override
  String get allowAllBlacklistedNumbersDesc => '블랙리스트에서 통화 허용';

  @override
  String get allowAllBlockRules => '모든 차단 규칙 허용';

  @override
  String get allowAllBlockRulesDesc => '차단 규칙에서 통화 허용';

  @override
  String get allowAllowedNumbers => '허용된 번호 허용';

  @override
  String get allowAllowedNumbersDesc => '화이트리스트에서 통화 허용';

  @override
  String get allowBlock => '허용/차단';

  @override
  String get allowBlockedNumbers => '차단된 번호 허용';

  @override
  String get allowBlockedNumbersDesc => '블랙리스트에서 통화 허용';

  @override
  String get allowedBlockedRule => '허용/차단 규칙';

  @override
  String get allowedBlockedRuleEditDialogTitle => '허용/차단 규칙 편집';

  @override
  String get allowedBlockedRuleManagement => '허용/차단 규칙 관리';

  @override
  String get allowNonExceededNumbers => '초과하지 않은 번호 허용';

  @override
  String get allowNonExceededNumbersDescription =>
      '수량 임계값을 초과하지 않는 번호를 자동으로 허용';

  @override
  String get allowRegexAllowRules => '정규식 허용 규칙 허용';

  @override
  String get allowRegexAllowRulesDesc => '허용 규칙에 대한 정규식 패턴 일치 활성화';

  @override
  String get allowRegexAllowRulesDescription => '정규식 기반 허용 규칙 활성화';

  @override
  String get allowRegexBlockRules => '정규식 차단 규칙 허용';

  @override
  String get allowRegexBlockRulesDesc => '차단 규칙에 대한 정규식 패턴 일치 활성화';

  @override
  String get allowRegexBlockRulesDescription => '정규식 기반 차단 규칙 활성화';

  @override
  String get allowRule => '허용 규칙';

  @override
  String get allowRules => '허용 규칙';

  @override
  String get allowWhitelistedNumbers => '화이트리스트 번호 허용';

  @override
  String get allowWhitelistedNumbersDescription => '화이트리스트에 있는 모든 번호 허용';

  @override
  String get allPermissionsGranted => '모든 권한이 부여되었습니다';

  @override
  String get allSettingsCompleted => '모든 설정이 완료되었습니다.';

  @override
  String allUpdateSuccess(Object count) {
    return '모든 업데이트 완료 ($count 규칙)';
  }

  @override
  String get answerThenHangup => '응답 후 끊기';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. 모든 권리 보유.';

  @override
  String get applicationSoftware => '응용 프로그램 소프트웨어';

  @override
  String get apply => '적용';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      '인증 실패: 클라이언트 ID 및 키를 확인하십시오';

  @override
  String get authorizationFailedMessage => '인증 실패';

  @override
  String get authorizationSuccessMessage => '인증 성공';

  @override
  String get authorizeLoginButton => '로그인 인증';

  @override
  String get automotiveIndustry => '자동차 산업';

  @override
  String get autoSyncLabel => '자동 동기화';

  @override
  String get autoUpdate => '자동 업데이트';

  @override
  String get autoUpdateDescription => '구독에 대한 자동 업데이트 간격을 설정하거나 수동으로 업데이트';

  @override
  String get autoUpdateSettings => '자동 업데이트 설정';

  @override
  String get autoUpdateSettingsSubtitle => '규칙 및 플러그인의 자동 업데이트 관리';

  @override
  String get autoUpdateSettingsTitle => '자동 업데이트 설정';

  @override
  String get autoUpdateSubtitle => '규칙 및 플러그인의 자동 업데이트 관리';

  @override
  String get autoUpdateTitle => '자동 업데이트';

  @override
  String get avatarBorderColor => '아바타 테두리 색상';

  @override
  String get avatarBorderSize => '아바타 테두리 크기';

  @override
  String get avatarIconSizesSetting => '아바타 및 아이콘 크기';

  @override
  String get avatarPosition => '아바타 위치';

  @override
  String get avatarSize => '아바타 크기';

  @override
  String axisPosition(Object axis) {
    return '$axis 위치';
  }

  @override
  String get backgroundGradientSetting => '배경 그라데이션';

  @override
  String get backup => '백업';

  @override
  String get backupAndRestore => '백업 및 복원';

  @override
  String get backupAndRestoreSubtitle => '응용 프로그램 데이터를 백업 또는 복원';

  @override
  String get backupAndRestoreTitle => '백업 및 복원';

  @override
  String get backupFailed => '백업 실패';

  @override
  String get backupFailedMessage => '백업 실패';

  @override
  String backupFailedWithError(Object error) {
    return '백업 실패: $error';
  }

  @override
  String get backupRestoreSubtitle => '응용 프로그램 데이터를 백업 또는 복원';

  @override
  String get backupRestoreTitle => '백업 및 복원';

  @override
  String get backupSectionTitle => '백업';

  @override
  String get backupSettings => '백업 설정';

  @override
  String get backupSettingsDialogTitle => '백업 설정';

  @override
  String get backupSettingsTitle => '백업 설정';

  @override
  String get backupSuccessMessage => '클라우드에 성공적으로 백업되었습니다';

  @override
  String backupSuccessToLocal(Object path) {
    return '다음 위치에 백업 성공: $path';
  }

  @override
  String get backupToCloud => '클라우드로 백업';

  @override
  String get backupToCloudDescription => '설정 및 규칙을 클라우드 저장소에 백업';

  @override
  String backupToCloudFailed(Object error) {
    return '클라우드로 백업 실패: $error';
  }

  @override
  String get backupToCloudLabel => '클라우드로 백업';

  @override
  String get backupToCloudSuccess => '클라우드에 성공적으로 백업되었습니다';

  @override
  String get backupToCloudTitle => '클라우드에 백업';

  @override
  String get backupToLocalLabel => '로컬에 백업';

  @override
  String get bank => '은행';

  @override
  String get basicInfo => '기본 정보';

  @override
  String get basicRuleFilter => '기본 규칙 필터';

  @override
  String get basicRuleFiltering => '기본 규칙 필터링';

  @override
  String get basicRuleFilteringExplanation =>
      '• 기본 규칙 필터링: 블랙리스트, 화이트리스트 및 정규 표현식을 기반으로 하는 필터링 규칙';

  @override
  String get basicRuleFilterSettings => '기본 규칙 필터 설정';

  @override
  String get basicRuleFilterSubtitle => '블랙리스트/화이트리스트 및 정규 표현식을 사용하여 통화 필터링';

  @override
  String get batchDeleteContacts => '연락처 일괄 삭제';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '$count개의 선택된 연락처를 삭제하시겠습니까?';
  }

  @override
  String get batchDeleteFailed => '일괄 삭제 실패';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '$count개의 라벨을 삭제하시겠습니까?';
  }

  @override
  String get blacklist => '블랙리스트';

  @override
  String get blacklistingAndWhitelisting => '블랙리스트 및 화이트리스트';

  @override
  String get blacklistLabel => '블랙리스트';

  @override
  String get blackWhiteList => '블랙/화이트 목록';

  @override
  String get block => '차단';

  @override
  String get blockCalls => '통화 차단';

  @override
  String get blocked => '차단됨';

  @override
  String get blockedCallAction => '차단된 통화 작업';

  @override
  String get blockedCalls => '차단된 통화';

  @override
  String get blockedCallsTitle => '차단된 통화';

  @override
  String get blockedCommunications => '차단된 커뮤니케이션';

  @override
  String get blockedPhoneLabel => '차단된 통화';

  @override
  String get blockedSpamCalls => '차단된 스팸 통화';

  @override
  String get blockingTrend => '차단 추세';

  @override
  String get blockInternationalCalls => '+ 또는 00으로 시작하지 않는 번호와 일치';

  @override
  String get blockInternationalCallsTitle => '국제 전화 차단';

  @override
  String get blockLandlineNumbersTitle => '유선 전화 번호 차단';

  @override
  String get blockMobileNumbers => '13-19로 시작하지 않는 번호와 일치';

  @override
  String get blockMobileNumbersTitle => '휴대폰 번호 차단';

  @override
  String get blockPremiumRateNumbers => '118 또는 120-190으로 시작하지 않는 번호와 일치';

  @override
  String get blockPremiumRateNumbersTitle => '프리미엄 요금 번호 차단';

  @override
  String get blockRule => '차단 규칙';

  @override
  String get blockRules => '차단 규칙';

  @override
  String get blockSpecificAreaCodes => '0 + 2-3자리 숫자로 시작하는 번호와 일치';

  @override
  String get blockSpecificAreaCodesTitle => '특정 지역 번호 차단:';

  @override
  String get blockTypeAnalysisTitle => '차단 유형 분석';

  @override
  String get both => '모두';

  @override
  String get bulkDelete => '일괄 삭제 연락처';

  @override
  String get bulkDeleteContacts => '연락처 일괄 삭제';

  @override
  String get bulkDeleteLabels => '라벨 일괄 삭제';

  @override
  String get call => '전화';

  @override
  String get callback => '다시 전화';

  @override
  String callbackTo(String number) {
    return '$number로 다시 전화';
  }

  @override
  String get callBlocking => '통화 차단';

  @override
  String get callerIdApp => '발신자 ID 앱';

  @override
  String get callerIdCustomizationTitle => '발신자 ID 사용자 지정';

  @override
  String get callerIdDialogTitle => '발신자 ID 정보';

  @override
  String get callerIdDisplayMode => '발신자 ID 표시 모드';

  @override
  String callerIdMarkedByCount(Object count) {
    return '$count에 의해 표시됨';
  }

  @override
  String get callerIdPreview => '발신자 ID 미리보기';

  @override
  String get callFilter => '통화 필터';

  @override
  String get callFilterDescription =>
      '활성화되면 수신 전화가 아래 규칙 목록에 대해 확인됩니다. 통화 필터링 규칙은 기본적으로 장치 간에 동기화되지 않습니다.';

  @override
  String get callFilterRules => '통화 필터 규칙';

  @override
  String get callFilterRulesDescription => '통화 필터링에 대한 기본 규칙 설정';

  @override
  String get callFilterSettings => '통화 필터 설정';

  @override
  String get callFrequencyInterceptionSubtitle => '통화 빈도 제한 및 차단 규칙 설정';

  @override
  String get callFrequencyInterceptionTitle => '통화 빈도 차단';

  @override
  String get callHistory => '통화 기록';

  @override
  String get callHistoryInfoDesc => '수신, 발신 및 부재중 전화를 포함한 통화 기록을 보여줍니다.';

  @override
  String get callHistoryInfoTitle => '통화 기록';

  @override
  String callHistoryInitFailed(Object error) {
    return '통화 기록을 초기화하지 못했습니다: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return '통화 기록을 새로 고치지 못했습니다: $error';
  }

  @override
  String get callHistoryTab => '통화 기록';

  @override
  String get callHistoryTimelineEarlier => '이전';

  @override
  String get callHistoryTimelineToday => '오늘';

  @override
  String get callHistoryTimelineYesterday => '어제';

  @override
  String get callScreeningPermission => '통화 스크리닝 권한';

  @override
  String get callScreeningPermissionDescription =>
      '스팸 통화를 스크리닝하고 차단하는 데 사용됩니다.';

  @override
  String get callScreeningPermissionNotGranted =>
      '통화 스크리닝 권한이 부여되지 않아 앱 기능에 영향을 미칠 수 있습니다.';

  @override
  String get callSettingsSubtitle => '발신자 ID, 필터링 및 차단 설정';

  @override
  String get callSettingsTitle => '통화 설정';

  @override
  String get callStatistics => '통화 통계';

  @override
  String get callTypeAnswered => '응답됨';

  @override
  String get callTypeBlocked => '차단됨';

  @override
  String get callTypeIconColor => '통화 유형 아이콘 색상';

  @override
  String get callTypeMissed => ' 부재중 전화';

  @override
  String get callTypeOutgoing => '발신';

  @override
  String get callTypePosition => '통화 유형 위치';

  @override
  String get callTypeUnknown => '알 수 없음';

  @override
  String get cancelButton => '취소';

  @override
  String get carRental => '렌터카';

  @override
  String get carrier => '통신사';

  @override
  String get carrierColor => '통신사 색상';

  @override
  String get carrierFontSize => '통신사 글꼴 크기';

  @override
  String get carrierPosition => '통신사 위치';

  @override
  String get changeLabel => '레이블 변경';

  @override
  String changePluginStatusFailed(Object error) {
    return '플러그인 상태를 변경하지 못했습니다: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return '구독 상태를 변경하지 못했습니다: $error';
  }

  @override
  String get changeTag => '태그 변경';

  @override
  String get charity => '자선 단체';

  @override
  String chartMonthFormat(int month) {
    return '$month월';
  }

  @override
  String get chartOneDayAgo => '1일 전';

  @override
  String get chartOneMonthAgo => '1개월 전';

  @override
  String get chartOneWeekAgo => '1주 전';

  @override
  String get chartTenDaysAgo => '10일 전';

  @override
  String get chartThreeDaysAgo => '3일 전';

  @override
  String get chartToday => '오늘';

  @override
  String get checkFileFormat => '파일 형식 또는 권한을 확인하십시오.';

  @override
  String checkPermissionFailed(Object error) {
    return '권한 확인 실패: $error';
  }

  @override
  String get chooseDefaultInterceptAction => '기본 차단 작업을 선택하세요.';

  @override
  String get clearAllData => '모든 데이터 지우기';

  @override
  String get clearAllDataConfirmation =>
      '정말로 모든 애플리케이션 데이터를 지우시겠습니까? 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get clearAllDataDescription => '모든 애플리케이션 데이터 지우기';

  @override
  String get clearAllDataLabel => '모든 데이터 지우기';

  @override
  String get clearFilter => '필터 지우기';

  @override
  String get clearLabelFilter => '라벨 필터 지우기';

  @override
  String get clearLabelFilterButton => '라벨 필터 지우기';

  @override
  String get closeButton => '닫기';

  @override
  String get cloudSync => '클라우드 동기화';

  @override
  String get cloudSyncAndBackupTitle => '클라우드 동기화 및 백업';

  @override
  String get cloudSyncSettingsSubtitle => 'WebDAV, OneDrive 및 Google Drive 구성';

  @override
  String get cloudSyncSettingsTitle => '클라우드 동기화 설정';

  @override
  String get cloudSyncTitle => '클라우드 동기화';

  @override
  String get collapseLabelSelector => '라벨 선택기 축소';

  @override
  String get collection => '채권 추심';

  @override
  String get colorPickerTitle => '색상 선택';

  @override
  String get configManagement => '구성 관리';

  @override
  String get configUpdated => '구성 업데이트됨';

  @override
  String get configurationAdvice =>
      '적절한 구성을 통해 업무용 및 개인용 SIM 카드에 대해 서로 다른 필터링 전략을 설정할 수 있습니다.';

  @override
  String get configureBackupOptions => '백업 옵션 구성';

  @override
  String get configureBackupOptionsSubtitle => '백업 옵션 구성';

  @override
  String get configureCloudSyncService => '클라우드 동기화 서비스 구성';

  @override
  String get configureCloudSyncServiceHint =>
      '다중 장치 동기화를 사용하려면 클라우드 동기화 서비스를 구성하세요.';

  @override
  String get configureCloudSyncServiceMessage =>
      '다중 장치 동기화를 사용하려면 클라우드 동기화 서비스를 구성하세요.';

  @override
  String get configureSimCardFilterRules => 'SIM 카드 필터 규칙 구성';

  @override
  String get configureSyncServiceHint => '먼저 클라우드 동기화 설정에서 동기화 서비스를 구성하세요.';

  @override
  String get confirm => '확인';

  @override
  String get confirmBatchDeleteContacts => '선택한 항목을 삭제하시겠습니까?';

  @override
  String get confirmButton => '확인';

  @override
  String get confirmDelete => '삭제 확인';

  @override
  String get confirmDeleteContact => '정말로 삭제하시겠습니까?';

  @override
  String get confirmDeleteContactName => '삭제를 확인하시겠습니까?';

  @override
  String get confirmDeleteFilter => '이 필터를 삭제하시겠습니까?';

  @override
  String confirmDeleteLabel(Object name) {
    return '라벨 \"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '플러그인 \"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '$count개의 플러그인을 삭제하시겠습니까?';
  }

  @override
  String get confirmDeleteRuleMessage => '이 규칙을 삭제하시겠습니까? 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get confirmDeleteSelectedContacts => '선택한 연락처를 삭제하시겠습니까?';

  @override
  String get confirmDeleteSmsFilterRule => '이 SMS 필터 규칙을 삭제하시겠습니까?';

  @override
  String get confirmDeleteSmsRule => '이 SMS 규칙을 삭제하시겠습니까?';

  @override
  String get confirmDeleteSubscription => '이 구독을 삭제하시겠습니까?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '$name을(를) 삭제하시겠습니까?';
  }

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get confirmPasswordLabel => '비밀번호 확인';

  @override
  String get connectedStatus => '연결됨';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      '연결 실패: 서버 주소, 사용자 이름 및 비밀번호를 확인하세요.';

  @override
  String get connectionFailedMessage => '연결 실패';

  @override
  String get connectionStatusLabel => '연결 상태';

  @override
  String get connectionSuccessMessage => '연결 성공';

  @override
  String get contactAddSuccess => '연락처가 성공적으로 추가되었습니다.';

  @override
  String get contactDeleted => '연락처가 삭제되었습니다.';

  @override
  String get contactEditDialog => '연락처 편집 대화 상자';

  @override
  String get contactNameHint => '연락처 이름 입력 (선택 사항)';

  @override
  String get contactNameLabel => '이름';

  @override
  String get contactNameOptional => '연락처 이름 (선택 사항)';

  @override
  String get contactNotFound => '연락처를 찾을 수 없습니다.';

  @override
  String get contacts => '연락처';

  @override
  String contactsDeleted(Object count) {
    return '$count개의 연락처가 삭제되었습니다.';
  }

  @override
  String get contactSettingsSubtitle => '연락처 관리 및 레이블 설정';

  @override
  String get contactSettingsTitle => '연락처 설정';

  @override
  String contactsLoadingFailed(Object error) {
    return '연락처를 로드하는 데 실패했습니다: $error';
  }

  @override
  String get contactsManagement => '연락처 관리';

  @override
  String get contactsManagementPageTitle => '연락처 관리 페이지';

  @override
  String get contactsPageTitle => '연락처 관리';

  @override
  String get contactsPermission => '연락처 권한';

  @override
  String get contactsPermissionDescription => '연락처 통화를 식별하는 데 사용됩니다.';

  @override
  String get contactsTab => '연락처';

  @override
  String get contactSubscriptionDescription =>
      'URL을 통해 연락처 목록을 구독하고, 연락처 정보와 레이블을 자동으로 업데이트합니다. JSON 형식 데이터를 지원합니다.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return '연락처 구독을 로드하는 데 실패했습니다: $error';
  }

  @override
  String get contactSubscriptionPageTitle => '연락처 구독';

  @override
  String get contactUpdateSuccess => '연락처가 성공적으로 업데이트되었습니다.';

  @override
  String get contactUs => '문의하기';

  @override
  String get content => '내용';

  @override
  String get contentRegex => '내용 정규식';

  @override
  String get countColor => '개수 색상';

  @override
  String get countFontSize => '개수 글꼴 크기';

  @override
  String get countPosition => '개수 위치';

  @override
  String get country => '국가';

  @override
  String get countryNameColor => '국가 이름 색상';

  @override
  String get countryNameFontSize => '국가 이름 글꼴 크기';

  @override
  String get countryRegionNamePosition => '국가/지역 이름 위치';

  @override
  String get countrySelectionDialog => '국가 선택 대화 상자';

  @override
  String get countrySelectionDialogDescription =>
      '발신자 ID 정보를 쿼리하기 위해 국가를 선택하는 데 사용됩니다.';

  @override
  String get countThresholdDescription =>
      '필터링 작업을 트리거하는 데 필요한 최소 개수 임계값을 설정합니다.';

  @override
  String get countThresholdLabel => '개수 임계값';

  @override
  String get countThresholdSettings => '개수 임계값 설정';

  @override
  String countThresholdValue(Object count) {
    return '개수 임계값: $count';
  }

  @override
  String get createdRules => '생성된 규칙';

  @override
  String get csvFormat => 'CSV 형식';

  @override
  String get currentDeviceChip => '현재';

  @override
  String get currentDeviceLabel => '현재 기기 라벨';

  @override
  String get currentDeviceTitle => '현재 기기';

  @override
  String get currentLabels => '현재 레이블:';

  @override
  String get currentLanguage => '현재 언어';

  @override
  String get currentPasswordLabel => '현재 비밀번호';

  @override
  String get customerService => '고객 서비스';

  @override
  String get customRange => '사용자 지정 범위';

  @override
  String get dailyStatistics => '일일 통계';

  @override
  String get dailyStatisticsDesc => '차단된 전화 및 메시지에 대한 일일 통계를 받으세요.';

  @override
  String get dashboardTab => '대시보드';

  @override
  String get dataAnalysis => '데이터 분석';

  @override
  String get dataAnalysisDashboardPage => '데이터 분석 대시보드 페이지';

  @override
  String get dataExport => '데이터 내보내기';

  @override
  String dataLoadFailure(Object error) {
    return '데이터 로드 실패: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return '데이터 로드 실패: $error';
  }

  @override
  String get dataMigration => '데이터 마이그레이션';

  @override
  String get dataMigrationDescription =>
      '이 기능을 사용하면 기기 간에 모든 데이터를 전송할 수 있습니다. 현재 백업 및 복원 기능을 사용하여 데이터를 수동으로 마이그레이션할 수 있습니다.';

  @override
  String get dataMigrationDialogContent =>
      '이 기능을 사용하면 기기 간에 모든 데이터를 전송할 수 있습니다. 현재 백업 및 복원 기능을 사용하여 데이터를 수동으로 마이그레이션할 수 있습니다.';

  @override
  String get dataMigrationDialogTitle => '데이터 마이그레이션';

  @override
  String get dataMigrationSectionTitle => '데이터 마이그레이션';

  @override
  String get dataSourceReminder => '데이터 소스 알림';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
      one: '1일',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days일 VIP';
  }

  @override
  String get debtCollection => '채권 추심';

  @override
  String get defaultPeriod => '주';

  @override
  String get delete => '삭제';

  @override
  String get deleteButton => '삭제';

  @override
  String get deleteContact => '연락처 삭제';

  @override
  String deleteContactConfirm(Object name) {
    return '$name을(를) 삭제하시겠습니까?';
  }

  @override
  String get deleteContactConfirmation => '연락처를 삭제하시겠습니까?';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '$deviceName을(를) 삭제하시겠습니까?';
  }

  @override
  String get deleteDeviceDialogTitle => '기기 삭제';

  @override
  String deleteFailed(Object error) {
    return '삭제 실패: $error';
  }

  @override
  String get deleteFilter => '필터 삭제';

  @override
  String get deleteLabel => '레이블 삭제';

  @override
  String deleteLabelFailed(Object error) {
    return '레이블 삭제 실패: $error';
  }

  @override
  String get deletePlugin => '플러그인 삭제';

  @override
  String deletePluginFailed(Object error) {
    return '플러그인 삭제 실패: $error';
  }

  @override
  String get deletePlugins => '플러그인 삭제';

  @override
  String deletePluginsFailed(Object error) {
    return '플러그인 삭제 실패: $error';
  }

  @override
  String get deleteRule => '규칙 삭제';

  @override
  String deleteRuleFailed(Object error) {
    return '삭제 실패: $error';
  }

  @override
  String get deleteSelected => '선택 항목 삭제';

  @override
  String get deleteSmsRule => 'SMS 규칙 삭제';

  @override
  String get deleteSubscription => '구독 삭제';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '구독 \"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return '구독 삭제 실패: $error';
  }

  @override
  String get deleteSuccess => '삭제 성공';

  @override
  String get delivery => '전달';

  @override
  String get deviceDeletedSuccessfully => '기기가 성공적으로 삭제되었습니다.';

  @override
  String get deviceDeletedSuccessfullyMessage => '기기가 성공적으로 삭제되었습니다.';

  @override
  String get deviceIdLabel => '기기 ID';

  @override
  String get deviceIDLabel => '기기 ID';

  @override
  String get deviceManagementSubtitle => '다중 기기 동기화 관리';

  @override
  String get deviceManagementTitle => '기기 관리';

  @override
  String get deviceModelLabel => '기기 모델';

  @override
  String get deviceName => '기기 이름';

  @override
  String get deviceNameCannotBeEmpty => '기기 이름은 비워둘 수 없습니다.';

  @override
  String get deviceNameHint => '기기 이름을 입력하세요.';

  @override
  String get deviceNameLabel => '기기 이름';

  @override
  String get deviceRenamedSuccessfully => '기기 이름이 성공적으로 변경되었습니다.';

  @override
  String get deviceRenamedSuccessfullyMessage => '기기 이름이 성공적으로 변경되었습니다.';

  @override
  String get devicesSyncedSuccessfully => '기기가 성공적으로 동기화되었습니다.';

  @override
  String get devicesSyncedSuccessfullyMessage => '기기가 성공적으로 동기화되었습니다.';

  @override
  String get devicesSynchronizedSuccessfullyMessage => '기기가 성공적으로 동기화되었습니다.';

  @override
  String get deviceUnregisteredSuccessfullyMessage => '기기 등록이 성공적으로 해제되었습니다.';

  @override
  String get dialogTitle => '정규식 패턴 설명';

  @override
  String get differentFromLocalCounter =>
      '이 기능은 장기적인 마킹 횟수가 아닌 짧은 시간 내의 반복적인 통화 패턴에 초점을 맞추므로 로컬 카운터 필터와 다릅니다.';

  @override
  String get disabled => '사용 안 함';

  @override
  String get disabledStatus => '사용 안 함';

  @override
  String get disableGlobalPlugins => '글로벌 플러그인 비활성화';

  @override
  String get disableSubscriptionSuccessfully => '구독을 성공적으로 비활성화했습니다.';

  @override
  String get disconnectButton => '연결 해제';

  @override
  String get disconnectedMessage => '연결 해제됨';

  @override
  String get disconnectedStatus => '연결 해제됨';

  @override
  String get disconnectFailedMessage => '연결 해제 실패';

  @override
  String get done => '완료';

  @override
  String get dualSimAdvice =>
      '이 기능은 특히 듀얼 SIM 폰에서 업무 및 개인 SIM 카드에 대해 서로 다른 필터링 전략을 설정하는 데 유용합니다.';

  @override
  String get earlier => '이전';

  @override
  String get ecommerce => '전자 상거래';

  @override
  String get edit => '편집';

  @override
  String get editContact => '연락처 편집';

  @override
  String get editFilter => '필터 편집';

  @override
  String get editLabel => '레이블 편집';

  @override
  String get editPhoneRule => '전화 규칙 편집';

  @override
  String get editPhoneRules => '전화 규칙 편집에 사용';

  @override
  String get editPhoneRuleTitle => '전화 규칙 편집';

  @override
  String get editRule => '규칙 편집';

  @override
  String get editSmsRule => 'SMS 규칙 편집';

  @override
  String get education => '교육';

  @override
  String get elementPositionsSetting => '요소 위치';

  @override
  String get email => '이메일';

  @override
  String get emailOptional => '이메일(선택 사항)';

  @override
  String get enableCallFilter => '통화 필터 활성화';

  @override
  String get enableCallFilterDescription =>
      '활성화되면 수신 전화가 아래 규칙 목록과 대조됩니다. 통화 필터링 규칙은 기본적으로 기기 간에 동기화되지 않습니다.';

  @override
  String get enabled => '사용';

  @override
  String get enabledStatus => '사용';

  @override
  String get enableEncryption => '암호화 활성화';

  @override
  String get enableEncryptionDescription => '백업 파일 암호화';

  @override
  String get enableEncryptionLabel => '암호화 활성화';

  @override
  String get enableEncryptionSubtitle => '백업 파일이 암호화됩니다.';

  @override
  String get enableEncryptionTitle => '암호화 활성화';

  @override
  String get enableGlobalPlugins => '글로벌 플러그인 활성화';

  @override
  String get enableLocalCountFilter => '로컬 수 카운트 필터 활성화';

  @override
  String get enableLocalCountFilterDescription =>
      '통화 마킹 횟수를 기준으로 스팸 통화를 자동으로 필터링합니다.';

  @override
  String get enableLocalNotification => '로컬 알림 사용';

  @override
  String get enableLocalNotificationDescription =>
      '활성화되면 필터링된 메시지에 대한 알림이 기기에 표시됩니다.';

  @override
  String get enableLocationSummary => '위치';

  @override
  String get enableMuteRules => '음소거 규칙 사용';

  @override
  String get enableMuteRulesDesc => '음소거 차단 규칙 설정을 적용합니다.';

  @override
  String get enableNoneActionRules => '작업 없음 규칙 사용';

  @override
  String get enableNoneActionRulesDesc => '차단 작업이 없는 규칙 설정을 허용합니다.';

  @override
  String get enableNotifications => '알림 사용';

  @override
  String get enableRemoteNumberFilter => '원격 번호 필터 사용';

  @override
  String get enableRemoteNumberFilterDescription =>
      '원격 데이터베이스를 사용하여 번호를 필터링합니다.';

  @override
  String get enableRule => '규칙 사용';

  @override
  String get enableSmsFilter => 'SMS 필터링 사용';

  @override
  String get enableSmsFilterDescription => '활성화되면 규칙에 따라 메시지가 자동으로 필터링됩니다.';

  @override
  String get enableStatisticsNotifications => '통계 알림 사용';

  @override
  String get enableSubscriptionSuccessfully => '구독 성공적으로 사용';

  @override
  String get enableTimeInterception => '시간 차단 사용';

  @override
  String get enableTimeInterceptionDescription => '짧은 시간 내에 반복되는 통화를 차단합니다.';

  @override
  String get enableTimeInterceptor => '시간 차단기 사용';

  @override
  String get endCallImmediately => '즉시 통화 종료';

  @override
  String get endColor => '종료 색상';

  @override
  String get endDate => '종료 날짜';

  @override
  String get enhancedFilterInstructionsTitle => '향상된 필터 시스템';

  @override
  String get enhancedFilterSettings => '향상된 필터 설정';

  @override
  String get enhancedFilterSettingsTitle => '향상된 필터 설정';

  @override
  String get enhancedFilterSystemDescription =>
      '향상된 필터 시스템은 글로벌 규칙과 SIM 카드별 필터링 설정을 모두 지원합니다.';

  @override
  String get enterBothPhoneNumberAndRegexPattern => '전화번호와 정규식 패턴을 모두 입력하세요';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      '전화번호와 정규식 패턴을 모두 입력하세요.';

  @override
  String get enterContactName => '연락처 이름을 입력하세요';

  @override
  String get enterCurrentPasswordHint => '현재 비밀번호를 입력하세요';

  @override
  String get enterDeviceName => '기기 이름 입력';

  @override
  String get enterDeviceNameHint => '기기 이름을 입력하세요';

  @override
  String get enterEmail => '이메일 주소 입력';

  @override
  String get enterEmailOptional => '이메일 주소 입력 (선택 사항)';

  @override
  String get enterEncryptionPasswordHint => '암호화 비밀번호 입력';

  @override
  String get enterEncryptionPasswordTitle => '암호화 비밀번호 입력';

  @override
  String get enterFilterName => '필터 이름을 입력하세요';

  @override
  String get enterFilterPattern => '필터 패턴을 입력하세요';

  @override
  String get enterIconCode => '아이콘 코드 입력';

  @override
  String get enterName => '연락처 이름 입력';

  @override
  String get enterNewDeviceNameHint => '이 기기의 새 이름을 입력하세요';

  @override
  String get enterNewPasswordHint => '새 비밀번호를 입력하세요';

  @override
  String get enterPasswordAgain => '비밀번호 다시 입력';

  @override
  String get enterPasswordHint => '비밀번호를 입력하세요';

  @override
  String get enterPhoneNumber => '전화번호 입력';

  @override
  String get enterPhoneNumberHint => '테스트할 전화번호 입력';

  @override
  String get enterPhoneNumberMultiple => '전화번호를 입력하세요. 여러 번호는 쉼표로 구분합니다.';

  @override
  String get enterPhoneNumberToStartSearch => '검색을 시작할 전화번호를 입력하세요';

  @override
  String get enterPhoneNumberToVerify => '확인할 전화번호를 입력하세요';

  @override
  String get enterPluginName => '플러그인 이름 입력';

  @override
  String get enterPluginUrl => '플러그인 URL 주소 입력';

  @override
  String get enterRegexHint => '정규식 패턴 입력';

  @override
  String get enterRuleNameAndPattern => '규칙 이름과 패턴을 입력하세요';

  @override
  String get enterRuleNameAndPatternMessage => '규칙 이름과 정규식 패턴을 모두 입력하세요.';

  @override
  String get enterRuleNameHint => '규칙 이름 입력';

  @override
  String get enterSearchContent => '검색 내용을 입력하세요.';

  @override
  String get enterSubscriptionName => '구독 이름 입력';

  @override
  String get enterSubscriptionUrl => '구독 URL 입력';

  @override
  String get enterSyncFolderNameHint =>
      '동기화 폴더 이름 입력 (기본값: NotificationManager)';

  @override
  String get entertainment => '엔터테인먼트';

  @override
  String get enterValidNameAndUrl => '유효한 이름과 URL을 입력하세요.';

  @override
  String get enterValidUrl => '유효한 URL을 입력하세요.';

  @override
  String get enterVersion => '버전 입력';

  @override
  String get enterWebDAVPasswordHint => 'WebDAV 비밀번호를 입력하세요.';

  @override
  String get enterWebDAVServerAddressHint => 'WebDAV 서버 주소를 입력하세요.';

  @override
  String get enterWebDAVUsernameHint => 'WebDAV 사용자 이름을 입력하세요.';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return '기기 삭제 오류: $error';
  }

  @override
  String get errorLoadingPlugin => '플러그인 로딩 오류';

  @override
  String errorOccurredMessage(Object error) {
    return '오류 발생: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return '기기 이름 변경 오류: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return '기기 동기화 오류: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return '기기 동기화 오류: $error';
  }

  @override
  String get errorText => '오류';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return '기기 등록 해제 오류: $error';
  }

  @override
  String get exampleBlock400Prefix => '예: 400 접두사 번호 차단';

  @override
  String get exampleBlockMarketingSms => '예: 마케팅 SMS 차단';

  @override
  String get exampleContentRegex => '예: .*offer.*';

  @override
  String get exampleContentRegexHint => '예시 내용 정규식';

  @override
  String get exampleCouponPromotionDiscount => '예: .*(쿠폰|프로모션|할인).*';

  @override
  String get exampleFamilyFriends => '예: 가족, 친구 등';

  @override
  String get examplePhoneNumber => '예: 10086, 12345 등';

  @override
  String get exampleRegex400Prefix => '400 접두사 예시 정규식';

  @override
  String get exampleRegexFormat => '예시: ^10086\$ 형식';

  @override
  String get exampleSenderRegexHint => '예시';

  @override
  String get exchange => '교환';

  @override
  String get exchangeNow => '지금 교환';

  @override
  String get exchangeVip => 'VIP 교환';

  @override
  String get expandLabelSelector => '라벨 선택기 확장';

  @override
  String expiryTime(Object time) {
    return '만료 시간: $time';
  }

  @override
  String get export => '내보내기';

  @override
  String get exportAllApplicationSettings => '모든 애플리케이션 설정 내보내기';

  @override
  String get exportAllApplicationSettingsSubtitle => '모든 애플리케이션 설정 내보내기';

  @override
  String get exportAllRuleConfigurations => '모든 규칙 구성 내보내기';

  @override
  String get exportAllRuleConfigurationsSubtitle => '모든 규칙 구성 내보내기';

  @override
  String get exportComplete => '내보내기 완료';

  @override
  String get exportConfig => '구성 내보내기';

  @override
  String get exportContacts => '연락처 내보내기';

  @override
  String get exportData => '데이터 내보내기';

  @override
  String get exportError => '내보내기 오류';

  @override
  String get exportFailed => '내보내기 실패';

  @override
  String get exportFailure => '구성 내보내기 실패';

  @override
  String get exportFeatureComingSoon => '내보내기 기능은 곧 제공될 예정입니다.';

  @override
  String get exporting => '내보내는 중...';

  @override
  String get exportLabels => '라벨 내보내기';

  @override
  String exportLabelsFailed(Object error) {
    return '라벨 내보내기 실패: $error';
  }

  @override
  String get exportPluginList => '플러그인 목록 내보내기';

  @override
  String exportPluginListFailed(Object error) {
    return '플러그인 목록 내보내기 실패: $error';
  }

  @override
  String get exportRules => '규칙 내보내기';

  @override
  String get exportRulesDialogTitle => '규칙 내보내기';

  @override
  String get exportRulesTitle => '규칙 내보내기';

  @override
  String get exportSmsRules => 'SMS 규칙 내보내기';

  @override
  String get exportStatisticsData => '통계 데이터 내보내기';

  @override
  String get exportSuccess => '내보내기 성공';

  @override
  String get exportSuccesslly => '구성 내보내기 성공';

  @override
  String get failedToAddContact => '연락처 추가 실패';

  @override
  String failedToAddRule(Object error) {
    return '규칙 추가 실패: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS 규칙 추가 실패: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS 구독 추가 실패: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return '설정 백업 실패: $error';
  }

  @override
  String get failedToDecryptBackupFile => '백업 파일 해독 실패';

  @override
  String get failedToDeleteDevice => '기기 삭제 실패';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS 규칙 삭제 실패: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return '규칙 내보내기 실패: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS 규칙 내보내기 실패: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return '발신자 정보 가져오기 실패: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return '규칙 가져오기 실패: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS 규칙 가져오기 실패: $error';
  }

  @override
  String get failedToLoadContacts => '연락처 로드 실패';

  @override
  String get failedToLoadPlugin => '플러그인 로드 실패';

  @override
  String get failedToRenameDevice => '기기 이름 변경 실패';

  @override
  String get failedToRestoreSettings => '설정 복원 실패';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return '설정 복원 실패: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return '비밀번호 설정 실패: $error';
  }

  @override
  String get failedToSyncDevices => '기기 동기화 실패';

  @override
  String failedToToggleRuleStatus(Object error) {
    return '규칙 상태 전환 실패: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => '구독 상태 전환 실패';

  @override
  String get failedToUpdateContact => '연락처 업데이트 실패';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS 규칙 업데이트 실패: $error';
  }

  @override
  String get failure => '실패';

  @override
  String get favoriteContacts => '즐겨찾는 연락처';

  @override
  String get featureAddRules => '• 전화번호별 규칙 추가';

  @override
  String get featureCenter => '기능 센터';

  @override
  String get featureEnableDisable => '• SIM 카드별로 다른 필터 활성화/비활성화';

  @override
  String get featureListTitle => '기능:';

  @override
  String get featureManageRules => '• SIM 카드별 규칙 목록 관리';

  @override
  String get features => '기능';

  @override
  String get fetchingCallerIdInfo => '발신자 정보 가져오는 중...';

  @override
  String fileSavedTo(Object path) {
    return '파일 저장 위치: $path';
  }

  @override
  String get filter => '필터';

  @override
  String get filterByLabel => '라벨별 필터';

  @override
  String get filterClear => '필터 지우기';

  @override
  String get filterControlPanelTitle => '필터 제어판';

  @override
  String get filterControlSubtitle => '모든 필터의 켜짐/꺼짐 상태 관리';

  @override
  String get filterControlTitle => '필터 제어';

  @override
  String get filterDeleteFailed => '필터 삭제 실패';

  @override
  String get filterDeleteSuccess => '필터가 성공적으로 삭제되었습니다';

  @override
  String get filterDetails => '필터 세부 정보';

  @override
  String get filtered => '필터링됨';

  @override
  String get filteredSms => '필터링된 SMS';

  @override
  String get filteredSmsLabel => '필터링된 SMS';

  @override
  String get filterExplanation => '필터 설명';

  @override
  String get filterManagement => '필터 관리';

  @override
  String get filterName => '필터 이름';

  @override
  String get filterPattern => '필터 패턴';

  @override
  String get filterPriorityNote =>
      '참고: 필터 간에 우선 순위 관계가 있습니다. 자세한 내용은 도움말 문서를 참조하십시오.';

  @override
  String get filterSaveFailed => '필터 저장 실패';

  @override
  String get filterSaveSuccess => '필터가 성공적으로 저장되었습니다';

  @override
  String get filterSettings => '필터 설정';

  @override
  String get filterSettingsTitle => '필터 설정';

  @override
  String get filterSMS => '필터 SMS';

  @override
  String get filterToggleInstructions => '이 SIM 슬롯에 대한 필터를 활성화 또는 비활성화합니다:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$filterName 필터: $status';
  }

  @override
  String get filterType => '필터 유형';

  @override
  String get financial => '금융';

  @override
  String get flexibleCombinationFeature => '• 유연한 조합: SIM 슬롯별로 필터 활성화/비활성화';

  @override
  String get fontSizesSetting => '글꼴 크기';

  @override
  String foundRules(Object count) {
    return '$count개의 규칙을 찾았습니다';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count개의 규칙을 찾았습니다. 가져오시겠습니까?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count개의 규칙을 찾았습니다. 가져오시겠습니까?';
  }

  @override
  String get fraudAlert => '사기 경고 - 통화를 끊으십시오';

  @override
  String get fraudScamLikely => '사기 사기 가능성';

  @override
  String get free => '무료';

  @override
  String get functionSettingsTitle => '기능 설정';

  @override
  String generalUpdateFailure(Object error) {
    return '업데이트 실패: $error';
  }

  @override
  String get getFree => '무료로 받기';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => '모든 SIM 카드에 대한 글로벌 필터 구성:';

  @override
  String get globalFilterFeature => '• 글로벌 필터: 모든 수신 전화에 대한 기본 규칙';

  @override
  String get globalFilterSettings => '글로벌 필터 설정';

  @override
  String get globalFilterToggleInstructions =>
      '모든 SIM 슬롯에 적용되는 글로벌 필터 설정을 구성합니다:';

  @override
  String get globalSearchSubtitle => '연락처, 레이블, 블랙리스트, 화이트리스트 등을 검색합니다.';

  @override
  String get globalSearchTitle => '글로벌 검색';

  @override
  String get globalSettings => '글로벌 설정';

  @override
  String get googleAdDisplayPosition => 'Google 광고 표시 위치';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob 광고를 여기에 통합할 수 있습니다';

  @override
  String get googleDriveAuthDescription =>
      '시스템 구성 Google 드라이브 클라이언트 ID 및 키를 사용하여 권한 부여';

  @override
  String get googleDriveAuthorizationHint =>
      '시스템 구성 Google 드라이브 클라이언트 ID 및 키를 사용하여 권한 부여';

  @override
  String get googleDriveConfigTitle => 'Google 드라이브 구성';

  @override
  String get googleDriveConfigurationTitle => 'Google 드라이브 구성';

  @override
  String get government => '정부';

  @override
  String get granted => '허용됨';

  @override
  String get grantNecessaryPermissions => '필요한 권한 부여';

  @override
  String get grantPermissions => '권한 부여';

  @override
  String get headhunter => '헤드헌터';

  @override
  String get height => '높이';

  @override
  String get homePageTitle => '홈 페이지';

  @override
  String get homeTab => '홈';

  @override
  String get howItWorksPoint1 => '• 시스템은 설정된 시간 내에 동일한 번호로부터의 전화를 자동으로 허용합니다.';

  @override
  String get howItWorksPoint2 =>
      '• 짧은 시간 창은 더 엄격한 가로채기를 초래하고, 긴 시간 창은 더 느슨한 가로채기를 초래합니다.';

  @override
  String get howItWorksPoint3 => '• 시스템은 통화 기록을 확인하여 반복된 통화인지 확인합니다.';

  @override
  String get howItWorksTitle => '작동 방식:';

  @override
  String get iconCodeOptional => '아이콘 코드 (선택 사항)';

  @override
  String get iconSize => '아이콘 크기';

  @override
  String get import => '가져오기';

  @override
  String get important => '중요';

  @override
  String get importButton => '가져오기';

  @override
  String get importConfig => '구성 가져오기';

  @override
  String get importContacts => '연락처 가져오기';

  @override
  String get importExportContacts => '연락처 가져오기/내보내기';

  @override
  String get importExportContactsTooltip => '연락처 가져오기/내보내기';

  @override
  String get importExportRules => '규칙 가져오기/내보내기';

  @override
  String importFailed(Object error) {
    return '가져오기 실패: $error';
  }

  @override
  String get importFailure => '구성 가져오기 실패';

  @override
  String get importFeatureComingSoon => '가져오기 기능은 곧 제공될 예정입니다.';

  @override
  String get importLabels => '라벨 가져오기';

  @override
  String importLabelsFailed(Object error) {
    return '라벨 가져오기 실패: $error';
  }

  @override
  String get importPluginList => '플러그인 목록 가져오기';

  @override
  String importPluginListFailed(Object error) {
    return '플러그인 목록 가져오기 실패: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '$count개의 플러그인을 성공적으로 가져왔습니다.';
  }

  @override
  String get importRuleConfigurationsFromFile => '파일에서 규칙 구성 가져오기';

  @override
  String get importRuleConfigurationsFromFileSubtitle => '파일에서 규칙 구성 가져오기';

  @override
  String get importRules => '규칙 가져오기';

  @override
  String get importRulesButton => '규칙 가져오기';

  @override
  String get importRulesDialogTitle => '규칙 가져오기';

  @override
  String importRulesError(Object error) {
    return '규칙 가져오기 실패: $error';
  }

  @override
  String get importRulesInstructions => 'CSV 파일에서 규칙 가져오기';

  @override
  String get importRulesSuccess => '규칙이 성공적으로 가져왔습니다.';

  @override
  String get importRulesTitle => '규칙 가져오기';

  @override
  String get importSuccess => '가져오기 성공';

  @override
  String get incomingCallInterceptAction => '수신 전화 가로채기 작업';

  @override
  String get incomingCallNotification => '수신 전화 알림';

  @override
  String get incorrectPassword => '잘못된 비밀번호';

  @override
  String get initializing => '초기화 중';

  @override
  String get installed => '설치됨';

  @override
  String get insufficientMarks => '표시 부족';

  @override
  String get insurance => '보험';

  @override
  String get interceptAction => '가로채기 작업';

  @override
  String get interceptionActionSettingsSubtitle => '차단된 통화 처리 방법 설정';

  @override
  String get interceptionActionSettingsTitle => '가로채기 작업 설정';

  @override
  String get interceptionTimeInterval => '가로채기 시간 간격';

  @override
  String get internet => '인터넷';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service 업데이트 간격이 $days일로 설정되었습니다.';
  }

  @override
  String get invalidContentRegex => '잘못된 내용 정규식';

  @override
  String get invalidLabel => '잘못된 라벨';

  @override
  String get invalidRegexPattern => '잘못된 정규식 패턴';

  @override
  String get invalidSenderRegex => '잘못된 발신자 정규식';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      '자세한 내용은 Telegram 채널 및 그룹에 가입하십시오.';

  @override
  String get jsLogsTitle => 'JS 로그';

  @override
  String get jsonFormat => 'JSON 형식';

  @override
  String get keepAllVersions => '모든 버전 유지';

  @override
  String get keepAllVersionsDescription => '각 백업의 모든 기록 버전을 유지합니다.';

  @override
  String get keepAllVersionsLabel => '모든 버전 유지';

  @override
  String get keepAllVersionsSubtitle => '각 백업의 기록 버전 유지';

  @override
  String get keepAllVersionsTitle => '모든 버전 유지';

  @override
  String get label => '라벨';

  @override
  String labelAddedSuccessfully(Object name) {
    return '\"$name\" 라벨이 성공적으로 추가되었습니다.';
  }

  @override
  String get labelCategories => '라벨 카테고리';

  @override
  String get labelDeleted => '라벨이 삭제되었습니다.';

  @override
  String get labelDescription =>
      '라벨을 사용하면 연락처를 더 잘 관리하고, 전화 및 메시지를 쉽게 식별하기 위해 전화번호에 사용자 정의 라벨을 추가할 수 있습니다.';

  @override
  String get labelFilter => '라벨 필터';

  @override
  String get labelFilterTooltip => '라벨 필터';

  @override
  String get labelIconColor => '라벨 아이콘 색상';

  @override
  String get labelManagement => '라벨 관리';

  @override
  String get labelNotFound => '라벨을 찾을 수 없습니다.';

  @override
  String get labelRemoved => '라벨이 제거되었습니다.';

  @override
  String labelRemoveFailed(Object error) {
    return '라벨을 제거하지 못했습니다: $error';
  }

  @override
  String get labels => '라벨';

  @override
  String get labelsColor => '라벨 색상';

  @override
  String labelsDeleted(Object count) {
    return '$count 개의 라벨이 삭제되었습니다.';
  }

  @override
  String get labelsExportedSuccessfully => '라벨이 성공적으로 내보내졌습니다.';

  @override
  String get labelsFontSize => '라벨 글꼴 크기';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count 개의 라벨을 성공적으로 가져왔습니다.';
  }

  @override
  String get labelsPosition => '라벨 위치';

  @override
  String labelTag(Object labelId) {
    return '라벨: $labelId';
  }

  @override
  String get labelUpdated => '라벨이 업데이트되었습니다.';

  @override
  String labelUpdateFailed(Object error) {
    return '라벨을 업데이트하지 못했습니다: $error';
  }

  @override
  String get labelUpdateSuccess => '\"\$labelText\" 라벨이 성공적으로 업데이트되었습니다.';

  @override
  String get languageSettings => '언어 설정';

  @override
  String get languageSettingsSubtitle => '애플리케이션 표시 언어 변경';

  @override
  String get languageSettingsTitle => '언어 설정';

  @override
  String get last30Days => '지난 30일';

  @override
  String get last7Days => '지난 7일';

  @override
  String get lastSyncLabel => '마지막 동기화';

  @override
  String lastUpdated(Object date) {
    return '마지막 업데이트: $date';
  }

  @override
  String get lifetimeMembership => '평생 멤버십';

  @override
  String get lifetimeMembershipDescription =>
      '1회 구매로 모든 프리미엄 기능과 향후 업데이트를 영구적으로 잠금 해제합니다.';

  @override
  String loadContactsFailed(Object error) {
    return '연락처를 로드하지 못했습니다: $error';
  }

  @override
  String get loadDataFailed => '데이터를 로드하지 못했습니다';

  @override
  String get loadFailed => '로드 실패';

  @override
  String get loading => '로드 중...';

  @override
  String get loadingData => '데이터 로드 중...';

  @override
  String get loadingTags => '태그 로드 중...';

  @override
  String loadLabelFailed(Object error) {
    return '라벨을 로드하지 못했습니다: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return '라벨을 불러오는 데 실패했습니다: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return '표시된 전화번호를 불러오는 데 실패했습니다: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return '표시된 전화번호를 불러오는 데 실패했습니다: $error';
  }

  @override
  String get loadMore => '더 보기';

  @override
  String get loadPluginButton => '플러그인 로드';

  @override
  String loadPluginsFailed(Object error) {
    return '플러그인을 불러오는 데 실패했습니다: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return '설정을 불러오는 데 실패했습니다: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'SMS 규칙을 불러오는 데 실패했습니다: $error';
  }

  @override
  String get loadStatusFailedMessage => '상태를 불러오는 데 실패했습니다';

  @override
  String loadSubscriptionsFailed(Object error) {
    return '구독을 불러오는 데 실패했습니다: $error';
  }

  @override
  String get loan => '대출';

  @override
  String get localBackupTitle => '로컬 백업';

  @override
  String get localCounterFilter => '로컬 카운터 필터';

  @override
  String get localCounterFilterSubtitle => '통화 빈도에 따라 스팸 통화를 자동으로 필터링합니다.';

  @override
  String get localCountFilter => '로컬 카운트 필터';

  @override
  String get localCountFilterDescription => '로컬 번호 수를 기반으로 빈번한 통화를 가로챕니다.';

  @override
  String get localCountFilterExplanationContent =>
      '로컬 카운트 필터는 통화 기록을 분석하여 빈번한 스팸 통화를 자동으로 식별하고 차단합니다.';

  @override
  String get localCountFilterExplanationTitle => '로컬 카운트 필터 설명';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• 번호의 카운트 값을 기준으로 차단 여부를 결정합니다.';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• 번호의 카운트가 설정된 임계값을 초과하면 자동으로 차단하도록 선택할 수 있습니다.';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• 임계값을 초과하지 않는 번호는 선택적으로 허용할 수 있습니다.';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• 모든 쿼리 로그를 기록할지 여부를 선택할 수 있습니다.';

  @override
  String get localCountFiltering => '로컬 카운트 필터링';

  @override
  String get localCountFilteringExplanation =>
      '• 로컬 카운트 필터링: 로컬 마킹 카운트를 기반으로 필터링 규칙을 설정합니다.';

  @override
  String get localCountFilterSettings => '로컬 카운트 필터 설정';

  @override
  String get localCountFilterUseCases =>
      '이 필터는 자동 다이얼 스팸 통화 및 마케팅 통화를 식별하는 데 특히 적합합니다.';

  @override
  String get localFilterSettings => '로컬 필터 설정';

  @override
  String get localNotificationDisabled => '로컬 알림 비활성화됨';

  @override
  String get localNotificationEnabled => '로컬 알림 활성화됨';

  @override
  String get localServices => '로컬 서비스';

  @override
  String get locationColor => '위치 색상';

  @override
  String get locationFontSize => '위치 글꼴 크기';

  @override
  String get locationIconColor => '위치 아이콘 색상';

  @override
  String get locationPosition => '위치';

  @override
  String get logAllLocalQueries => '모든 로컬 쿼리 기록';

  @override
  String get logAllLocalQueriesDescription => '모든 로컬 번호 쿼리에 대한 로그를 기록합니다.';

  @override
  String get logAllRemoteQueries => '모든 원격 쿼리 기록';

  @override
  String get logAllRemoteQueriesDescription => '모든 원격 번호 쿼리 작업을 기록합니다.';

  @override
  String get manage => '연락처 관리';

  @override
  String get manageContacts => '관리';

  @override
  String get manageFavoriteContacts => '즐겨찾는 연락처 관리';

  @override
  String get manageFilterRules => '필터 규칙 관리';

  @override
  String get manageFilterRulesDescription => 'SMS 필터 규칙을 추가, 편집 또는 삭제합니다.';

  @override
  String get manageFrequentContacts => '자주 연락하는 연락처 관리';

  @override
  String get markCounts => '마크 수';

  @override
  String get markCount => '마크 수';

  @override
  String markedByCount(Object count) {
    return '$count에 의해 표시됨';
  }

  @override
  String get markedPhonesList => '표시된 전화 번호';

  @override
  String get markExchange => '마크 교환';

  @override
  String get markPhone => '전화 번호 표시';

  @override
  String markPhoneFailed(Object error) {
    return '전화 번호 표시 실패: $error';
  }

  @override
  String get markPhoneManagementSubtitle => '전화 번호 표시';

  @override
  String get markPhoneManagementTitle => '전화 번호 관리';

  @override
  String get markPhoneSuccess => '전화 번호가 성공적으로 표시되었습니다.';

  @override
  String get matchFailed => '일치 실패!';

  @override
  String get matchFailedMessage => '일치 실패.';

  @override
  String get matchNumbersWithSpecialCharacters => '특정 번호 형식 일치';

  @override
  String get matchNumbersWithSpecialCharactersTitle => '특수 문자가 있는 번호 일치:';

  @override
  String get matchSpecificDigitPatterns => 'XXX-XXXX-XXXX 형식 일치';

  @override
  String get matchSpecificDigitPatternsTitle => '특정 숫자 패턴 일치:';

  @override
  String get matchSuccessful => '일치 성공!';

  @override
  String get matchSuccessfulMessage => '일치 성공!';

  @override
  String get medical => '의료';

  @override
  String get membershipPrivileges => '회원 혜택';

  @override
  String get migrationTool => '마이그레이션 도구';

  @override
  String get migrationToolTitle => '마이그레이션 도구';

  @override
  String get minutes => '분';

  @override
  String get month => '월';

  @override
  String get monthly => '매월';

  @override
  String get monthlyCallCount => '월별 통화';

  @override
  String get monthlyChartTitle => '월별 차단된 통화';

  @override
  String get monthlyMembership => '월간 멤버십';

  @override
  String get monthlyMembershipDescription => '모든 프리미엄 기능을 잠금 해제하고 매월 자동 갱신됩니다.';

  @override
  String get monthlyTotal => '월간 총액';

  @override
  String get monthlyTotalLabel => '월간 총액';

  @override
  String get moreOptions => '더 많은 옵션';

  @override
  String get mute => '음소거';

  @override
  String get name => '이름';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => '이름과 전화번호는 비워둘 수 없습니다.';

  @override
  String get nameAndPhoneNumberRequired => '이름과 전화번호가 필요합니다.';

  @override
  String get nameColor => '이름 색상';

  @override
  String get nameFontSize => '이름 글꼴 크기';

  @override
  String nameLabel(Object name) {
    return '이름: $name';
  }

  @override
  String get namePosition => '이름 위치';

  @override
  String get nameUnknown => '이름: 알 수 없음';

  @override
  String nameWithValue(String name) {
    return '이름: $name';
  }

  @override
  String get newPasswordLabel => '새 비밀번호';

  @override
  String get nextStep => '다음';

  @override
  String get noAction => '작업 없음';

  @override
  String get noActionRules => '작업 규칙 없음';

  @override
  String get noActiveCloudSyncServiceMessage => '활성 클라우드 동기화 서비스 없음';

  @override
  String get noCallLogs => '통화 기록 없음';

  @override
  String get noCallRecords => '통화 기록 없음';

  @override
  String get noContacts => '아직 연락처가 없습니다';

  @override
  String get noContactsYet => '아직 연락처가 없습니다';

  @override
  String get noData => '데이터 없음';

  @override
  String get noDevicesRegisteredMessage => '등록된 기기가 없습니다';

  @override
  String get noDevicesRegisteredYet => '등록된 기기가 없습니다.';

  @override
  String get noFilters => '아직 필터가 없습니다';

  @override
  String get noLabels => '아직 레이블이 없습니다';

  @override
  String get noMarkedPhones => '표시된 전화 번호 없음';

  @override
  String get noMatchingContacts => '일치하는 연락처 없음';

  @override
  String get noMatchingContactsFound => '일치하는 연락처를 찾을 수 없음';

  @override
  String get noMatchingNumbersFound => '일치하는 번호를 찾을 수 없음';

  @override
  String get noMatchingRecords => '일치하는 통화 기록 없음';

  @override
  String noMatchingRules(Object ruleType) {
    return '일치하는 $ruleType 없음';
  }

  @override
  String get none => '없음';

  @override
  String get noneServiceType => '없음';

  @override
  String get noPlugins => '아직 플러그인이 없습니다';

  @override
  String get noRecords => '통화 기록 없음';

  @override
  String get noResultReturned => '결과가 반환되지 않음';

  @override
  String get noResultReturnedLog => '플러그인에서 결과가 반환되지 않음';

  @override
  String noRules(Object ruleType) {
    return '아직 $ruleType 없음';
  }

  @override
  String get noRulesPrompt => '규칙을 찾을 수 없습니다. 규칙을 추가하십시오.';

  @override
  String get noRulesToExport => '내보낼 규칙이 없습니다.';

  @override
  String get noSmsFilterRulesYet => '아직 SMS 필터 규칙이 없습니다.';

  @override
  String get noSmsRulesYet => '아직 SMS 규칙이 없습니다.';

  @override
  String get noSubscriptions => '구독 없음';

  @override
  String get noSubscriptionsYet => '아직 구독이 없습니다';

  @override
  String get notGranted => '승인되지 않음';

  @override
  String get notificationModeDescription => '알림 표시줄에 발신자 정보 표시';

  @override
  String get notificationPermission => '알림 권한';

  @override
  String get notificationPermissionDescription =>
      '수신 전화 및 메시지 알림을 표시하는 데 사용됩니다.';

  @override
  String get notifications => '알림';

  @override
  String get notificationSettings => '알림 설정';

  @override
  String get notificationSettingsSaved => '알림 설정이 성공적으로 저장되었습니다';

  @override
  String get notSet => '설정되지 않음';

  @override
  String get notVerifiedText => '확인되지 않음';

  @override
  String get noValidSmsRulesFoundInFile => '파일에서 유효한 SMS 규칙을 찾을 수 없음';

  @override
  String get number => '번호';

  @override
  String get numberColor => '번호 색상';

  @override
  String get numberFontSize => '번호 글꼴 크기';

  @override
  String get numberPosition => '번호 위치';

  @override
  String get numberSearch => '번호 검색';

  @override
  String get numberTypeColor => '번호 유형 색상';

  @override
  String get numberTypeFontSize => '번호 유형 글꼴 크기';

  @override
  String get numberTypePosition => '번호 유형 위치';

  @override
  String get ok => '확인';

  @override
  String get okButton => '확인';

  @override
  String get onboardingCompleteDescription =>
      '통화 보안 관리자가 준비되었습니다. 안전한 통화 경험을 즐기세요!';

  @override
  String get onboardingLanguageDescription => '최상의 경험을 위해 선호하는 언어를 선택하세요.';

  @override
  String get onboardingPermissionsDescription => '전체 서비스를 제공하려면 다음 권한이 필요합니다:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      '스팸 통화 및 메시지 원클릭 차단, 차단 규칙 사용자 지정, 조용한 환경 제공.';

  @override
  String get onboardingSmartCallerIdDescription =>
      '알 수 없는 전화를 자동으로 식별하고, 의심스러운 번호를 표시하며, 통화 안전을 보호합니다.';

  @override
  String get onboardingWelcomeDescription =>
      '종합적인 통화 식별 및 차단 서비스를 제공하는 통화 관리 전문가.';

  @override
  String get oneDriveAuthDescription =>
      '시스템 구성 OneDrive 클라이언트 ID 및 키를 사용하여 권한 부여';

  @override
  String get oneDriveAuthorizationHint =>
      '시스템 구성 OneDrive 클라이언트 ID 및 키를 사용하여 권한 부여';

  @override
  String get oneDriveConfigTitle => 'OneDrive 구성';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive 구성';

  @override
  String get onlineCallerIdSubscription => '온라인 발신자 ID 구독';

  @override
  String get openAppSettings => '앱 설정 열기';

  @override
  String openAppSettingsFailed(Object error) {
    return '앱 설정을 여는 데 실패했습니다: $error';
  }

  @override
  String operationFailed(Object error) {
    return '작업 실패: $error';
  }

  @override
  String get operationFailure => '작업 실패';

  @override
  String get operationSuccess => '작업 성공';

  @override
  String get other => '기타';

  @override
  String get ourOtherApps => '다른 앱';

  @override
  String get overlayMode => '플로팅 윈도우';

  @override
  String get overlayModeDescription => '플로팅 윈도우에서 발신자 정보 표시';

  @override
  String get overlayPermission => '오버레이 권한';

  @override
  String get overlayPermissionDescription => '수신 전화 오버레이를 표시하는 데 사용됩니다.';

  @override
  String get overview => '개요';

  @override
  String get password => '비밀번호';

  @override
  String get passwordCannotBeEmpty => '비밀번호는 비워둘 수 없습니다';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get passwordSetSuccessfully => '비밀번호가 성공적으로 설정되었습니다';

  @override
  String get pattern => '패턴';

  @override
  String get pendingSync => '동기화 대기 중';

  @override
  String get periodMonth => '개월';

  @override
  String get periodWeek => '주';

  @override
  String get periodYear => '년';

  @override
  String get permissionDenied => '권한 요청 거부됨';

  @override
  String get permissionGranted => '권한 허용됨';

  @override
  String get permissionManagement => '권한 관리';

  @override
  String get phoneCallsTab => '전화';

  @override
  String get phoneNumber => '전화번호';

  @override
  String get phoneNumberCannotBeEmpty => '전화번호는 비워둘 수 없습니다';

  @override
  String get phoneNumberHintText => '규칙을 추가하려면 전화번호를 입력하세요';

  @override
  String get phoneNumberLabel => '전화번호';

  @override
  String get phoneNumberRegexRequired => '전화번호와 정규식 패턴을 모두 입력하세요';

  @override
  String get phoneNumberTypeFixedLine => '유선 전화';

  @override
  String get phoneNumberTypeFixedLineOrMobile => '유선 전화 또는 휴대폰';

  @override
  String get phoneNumberTypeMobile => '휴대폰';

  @override
  String get phoneNumberTypePager => '호출기';

  @override
  String get phoneNumberTypePersonalNumber => '개인 번호';

  @override
  String get phoneNumberTypePremiumRate => '프리미엄 요금';

  @override
  String get phoneNumberTypeSharedCost => '분담 비용';

  @override
  String get phoneNumberTypeTollFree => '무료 전화';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => '알 수 없음';

  @override
  String get phoneNumberTypeVoicemail => '음성 사서함';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => '전화 권한';

  @override
  String get phonePermissionDescription => '수신 통화를 식별하고 차단하는 데 사용됩니다.';

  @override
  String get phoneRule => '전화 규칙';

  @override
  String get phoneRuleEditDialog => '전화 규칙 편집 대화 상자';

  @override
  String get phoneRuleManagement => '전화 규칙 관리';

  @override
  String get phoneRuleSubscription => '전화 규칙 구독';

  @override
  String get phoneSubscription => '전화 구독';

  @override
  String get phoneSubscriptionRulesDescription =>
      'URL을 통해 전화 규칙 목록을 구독하여 화이트리스트 및 블랙리스트 규칙을 자동으로 업데이트합니다. JSON 형식의 규칙 파일을 지원합니다.';

  @override
  String get phoneSubscriptionTitle => '전화 규칙 구독';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      '레이블을 선택하고 유효한 전화번호를 입력하세요.';

  @override
  String pluginAddedSuccess(Object name) {
    return '플러그인 \"$name\"이(가) 성공적으로 추가되었습니다.';
  }

  @override
  String get pluginDeleted => '플러그인이 삭제되었습니다.';

  @override
  String get pluginLatestVersion => '플러그인이 이미 최신 버전입니다.';

  @override
  String get pluginListExportSuccess => '플러그인 목록이 성공적으로 내보내졌습니다.';

  @override
  String get pluginLoadedSuccessfully => '플러그인이 성공적으로 로드되었습니다.';

  @override
  String get pluginManagement => '플러그인 관리';

  @override
  String get pluginManagementSubtitle => '타사 플러그인을 관리하고 구성합니다.';

  @override
  String get pluginManagementTitle => '플러그인 관리';

  @override
  String get pluginName => '플러그인 이름';

  @override
  String get pluginNotLoaded => '플러그인이 아직 로드되지 않았습니다. 먼저 플러그인을 로드하십시오.';

  @override
  String pluginsDeleted(Object count) {
    return '$count개의 플러그인이 성공적으로 삭제되었습니다.';
  }

  @override
  String get pluginService => '플러그인 서비스';

  @override
  String get pluginTestPageTitle => '플러그인 테스트';

  @override
  String get pluginUpdateSuccess => '플러그인이 성공적으로 업데이트되었습니다.';

  @override
  String get pluginUrl => '플러그인 URL';

  @override
  String get pluginUrlCannotBeEmpty => '플러그인 URL은 비워둘 수 없습니다.';

  @override
  String get pluginUrlHint => '플러그인 URL을 입력하세요.';

  @override
  String get pluginUrlLabel => '플러그인 URL';

  @override
  String get pluginVersion => '플러그인 버전';

  @override
  String get political => '정치적';

  @override
  String get powerfulSpamBlocking => '강력한 스팸 차단';

  @override
  String get previousStep => '이전 단계';

  @override
  String get prioritizeRemoteAction => '원격 작업 설정 우선 순위';

  @override
  String get prioritizeRemoteActionDescription => '원격 데이터베이스에서 작업 설정을 우선시합니다.';

  @override
  String get processing => '처리 중...';

  @override
  String get processingOperation => '처리 중...';

  @override
  String get purchase => '구매';

  @override
  String get quarterlyMembership => '분기별 멤버십';

  @override
  String get quarterlyMembershipDescription =>
      '모든 프리미엄 기능을 잠금 해제하고 분기별로 자동 갱신합니다.';

  @override
  String get queryButton => '쿼리';

  @override
  String get queryFailed => '쿼리 실패';

  @override
  String get queryFailedLog => '쿼리 실패';

  @override
  String get querying => '쿼리 중...';

  @override
  String get queryingPhoneNumber => '전화번호 쿼리 중';

  @override
  String get queryResultTitle => '쿼리 결과';

  @override
  String get ready => '준비 완료!';

  @override
  String get receiveWeeklyStatistics => '주간 통계 수신';

  @override
  String get recruiter => '모집인';

  @override
  String get reEnterPasswordHint => '비밀번호를 다시 입력하세요.';

  @override
  String get refresh => '새로 고침';

  @override
  String get refreshPermissionStatus => '권한 상태 새로 고침';

  @override
  String get refreshTooltip => '새로 고침';

  @override
  String regexError(Object error) {
    return '정규식 오류: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return '정규식 오류: $error';
  }

  @override
  String get regexPattern => '정규식 패턴';

  @override
  String get regexPatternExplanation => '정규식 패턴 설명';

  @override
  String get regexPatternExplanationButton => '정규식 패턴 설명';

  @override
  String get regexPatternLabel => '정규식 패턴';

  @override
  String get regexPatternsExamples => '패턴을 정의하려면 표준 정규식 구문을 사용하십시오. 예: ';

  @override
  String get regexPatternsForPhoneNumberMatching => '전화 번호 일치를 위한 정규식 패턴';

  @override
  String get regexRule => '정규식 규칙';

  @override
  String regexRuleAddFailed(Object error) {
    return '정규식 규칙 추가 실패: $error';
  }

  @override
  String get regexRuleAddSuccess => '정규식 규칙이 성공적으로 추가되었습니다';

  @override
  String get regexRuleManagement => '정규식 규칙 관리';

  @override
  String get regexRuleNamePatternRequired => '규칙 이름과 정규식 패턴은 비워둘 수 없습니다';

  @override
  String get regexRules => '정규식 규칙';

  @override
  String get regexTesterTitle => '정규식 테스터';

  @override
  String regexValidationFailed(Object error) {
    return '정규식 유효성 검사 실패: $error';
  }

  @override
  String get regexValidationSuccess => '정규식 유효성 검사 성공';

  @override
  String get region => '지역';

  @override
  String get registeredDevicesTitle => '등록된 기기';

  @override
  String get rejectAllCalls => '모든 통화 거부';

  @override
  String get rejectAllCallsDescription => '활성화하면 모든 통화가 최고 우선 순위로 거부됩니다.';

  @override
  String get rejectAllNumbers => '모든 번호 거부';

  @override
  String get rejectAllNumbersDesc => '활성화되면 모든 수신 전화를 거부합니다.';

  @override
  String get rejectExceededNumbers => '초과된 번호 거부';

  @override
  String get rejectExceededNumbersDescription => '수량 임계값을 초과하는 번호를 자동으로 거부합니다.';

  @override
  String get remoteFilterSettings => '원격 필터 설정';

  @override
  String get remoteFilterSettingsPageTitle => '원격 번호 필터 설정';

  @override
  String get remoteNumberFilter => '원격 번호 필터';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      '이 필터는 최신 번호 정보를 얻기 위해 독립적인 원격 데이터베이스를 사용합니다.';

  @override
  String get remoteNumberFilterDescription =>
      '원격 데이터베이스 정보를 기반으로 괴롭힘 전화를 차단합니다.';

  @override
  String get remoteNumberFilterExplanationContent =>
      '원격 번호 필터는 번호 발생 빈도를 기반으로 원격 데이터베이스를 쿼리하여 스팸 전화를 식별하고 차단합니다.';

  @override
  String get remoteNumberFilterExplanationTitle => '원격 번호 필터 설명';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• 수량 임계값: 번호 발생 빈도를 기준으로 결정';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• 필터 작업: 임계값을 초과하는 번호 처리 방법 구성';

  @override
  String get remoteNumberFilterFeaturePriority => '• 우선 순위 설정: 원격 작업의 우선 순위 설정';

  @override
  String get remoteNumberFilterFeatures => '기능:';

  @override
  String get remoteNumberFiltering => '원격 번호 필터링';

  @override
  String get remoteNumberFilteringExplanation =>
      '• 원격 번호 필터링: 원격 데이터베이스 정보를 기반으로 필터링 규칙';

  @override
  String get remoteNumberFilterSubtitle =>
      '클라우드 데이터베이스 및 커뮤니티 보고서를 사용하여 스팸 전화 식별';

  @override
  String get removeAdsDescription => '더 부드러운 환경을 위해 앱의 모든 광고를 영구적으로 제거합니다.';

  @override
  String get removeAdsTitle => '광고 제거';

  @override
  String get removedFromFavoriteContacts => '즐겨찾는 연락처에서 삭제됨';

  @override
  String get removedFromFavorites => '즐겨찾기에서 삭제됨';

  @override
  String get removeFavorite => '즐겨찾기 삭제';

  @override
  String get removeFromFavorites => '즐겨찾기에서 삭제';

  @override
  String get renameButton => '이름 바꾸기';

  @override
  String get renameDeviceDialogTitle => '기기 이름 바꾸기';

  @override
  String get renameDeviceTitle => '기기 이름 바꾸기';

  @override
  String get replaceCurrentSettingsConfirmation =>
      '이렇게 하면 현재 설정이 모두 교체됩니다. 계속하시겠습니까?';

  @override
  String get requestAllPermissions => '모든 권한 요청';

  @override
  String get requestPermission => '권한 요청';

  @override
  String requestPermissionFailed(Object error) {
    return '권한 요청 실패: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count 마크';
  }

  @override
  String get reset => '재설정';

  @override
  String get restore => '복원';

  @override
  String get restoreApplicationSettingsFromBackup => '백업에서 앱 설정 복원';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => '백업에서 앱 설정 복원';

  @override
  String get restoreButton => '복원';

  @override
  String restoreFailedWithError(Object error) {
    return '클라우드에서 복원 실패: $error';
  }

  @override
  String get restoreFromCloud => '클라우드에서 복원';

  @override
  String get restoreFromCloudDescription => '클라우드 저장소에서 설정 및 규칙 복원';

  @override
  String restoreFromCloudFailed(Object error) {
    return '클라우드에서 복원 실패: $error';
  }

  @override
  String get restoreFromCloudLabel => '클라우드에서 복원';

  @override
  String get restoreFromCloudSuccess => '클라우드에서 성공적으로 복원되었습니다.';

  @override
  String get restoreFromCloudTitle => '클라우드에서 복원';

  @override
  String get restoreFromLocal => '로컬에서 복원';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get restoreSectionTitle => '복원';

  @override
  String get restoreSettings => '설정 복원';

  @override
  String get restoreSettingsConfirmation => '이렇게 하면 현재 설정이 모두 교체됩니다. 계속하시겠습니까?';

  @override
  String get restoreSettingsDialogTitle => '설정 복원';

  @override
  String get restoreSettingsTitle => '설정 복원';

  @override
  String get restoreSuccessFromLocal => '로컬에서 성공적으로 복원되었습니다.';

  @override
  String get restoreSuccessMessage => '클라우드에서 성공적으로 복원되었습니다.';

  @override
  String get retry => '다시 시도';

  @override
  String get ridesharing => '차량 공유';

  @override
  String get risk => '위험';

  @override
  String get robocall => '로보콜';

  @override
  String get ruleAction => '규칙 동작';

  @override
  String get ruleAddButton => '규칙 추가';

  @override
  String get ruleAddedSuccess => '규칙이 성공적으로 추가되었습니다.';

  @override
  String ruleAddFailure(Object error) {
    return '규칙 추가 실패: $error';
  }

  @override
  String get ruleAddSuccess => '규칙이 성공적으로 추가되었습니다.';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '이 $ruleType을(를) 삭제하시겠습니까?';
  }

  @override
  String get ruleDeleteConfirmTitle => '규칙 삭제';

  @override
  String get ruleDeletedSuccess => '규칙이 성공적으로 삭제되었습니다.';

  @override
  String get ruleDeletedSuccessfully => '규칙이 성공적으로 삭제되었습니다.';

  @override
  String ruleDeleteFailed(Object error) {
    return '규칙 삭제 실패: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return '규칙 삭제 실패: $error';
  }

  @override
  String get ruleDeleteSuccess => '규칙이 성공적으로 삭제되었습니다.';

  @override
  String get ruleDisabledSuccessfully => '규칙이 성공적으로 비활성화되었습니다.';

  @override
  String get ruleEnabledSuccessfully => '규칙이 성공적으로 활성화되었습니다.';

  @override
  String ruleLoadFailed(Object error) {
    return '규칙 로드 실패: $error';
  }

  @override
  String get ruleManagement => '규칙 관리';

  @override
  String get ruleManagementTitle => '규칙 관리';

  @override
  String get ruleName => '규칙 이름';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      '규칙 이름과 내용 정규 표현식은 비워둘 수 없습니다.';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => '규칙 이름과 전화번호는 비워둘 수 없습니다.';

  @override
  String get ruleNameHint => '예: 가족, 친구 등';

  @override
  String get ruleNameLabel => '규칙 이름';

  @override
  String get ruleNamePatternRequired => '규칙 이름과 패턴을 입력하세요.';

  @override
  String get ruleNameRequired => '규칙 이름과 전화번호는 비워둘 수 없습니다.';

  @override
  String get ruleNotExist => '규칙이 존재하지 않거나 삭제되었습니다';

  @override
  String ruleNotFound(Object error) {
    return '규칙을 찾을 수 없습니다: $error';
  }

  @override
  String get ruleSavedSuccessfully => '규칙이 성공적으로 저장되었습니다!';

  @override
  String get ruleSavedSuccessMessage => '규칙이 성공적으로 저장되었습니다!';

  @override
  String ruleSaveFailed(Object error) {
    return '저장 실패: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return '저장 실패: $error';
  }

  @override
  String get ruleSaveSuccess => '규칙이 성공적으로 저장되었습니다!';

  @override
  String get rulesExportedSuccessfully => '규칙이 성공적으로 내보내졌습니다';

  @override
  String rulesExportedTo(Object path) {
    return '규칙이 내보내졌습니다: $path';
  }

  @override
  String get rulesImported => '규칙이 성공적으로 가져왔습니다';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count 개의 규칙이 성공적으로 가져왔습니다';
  }

  @override
  String rulesImportFailed(Object error) {
    return '규칙 가져오기 실패: $error';
  }

  @override
  String get ruleStatistics => '규칙 통계';

  @override
  String ruleStatusChanged(Object status) {
    return '규칙 $status 성공';
  }

  @override
  String ruleToggleFailed(Object error) {
    return '작업 실패: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return '규칙 $status 성공';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return '규칙 업데이트 실패: $error';
  }

  @override
  String get ruleUpdateSuccess => '규칙이 성공적으로 업데이트되었습니다';

  @override
  String get ruleVerification => '규칙 확인';

  @override
  String get save => '저장';

  @override
  String get saveButton => '저장';

  @override
  String get saveButtonLabel => '저장';

  @override
  String get saveButtonText => '저장';

  @override
  String saveFailed(Object error) {
    return '저장 실패: $error';
  }

  @override
  String get saveFilter => '필터 저장';

  @override
  String get saveSettings => '설정 저장';

  @override
  String saveSettingsFailed(Object error) {
    return '설정 저장 실패: $error';
  }

  @override
  String get scamsLikely => '스캠 가능성';

  @override
  String get search => '검색';

  @override
  String get searchContacts => '연락처 검색';

  @override
  String searchError(Object error) {
    return '검색 오류: $error';
  }

  @override
  String get searchFilters => '필터 검색';

  @override
  String get searchForContacts => '연락처 검색';

  @override
  String get searchHint => '검색...';

  @override
  String get searchSettingsSubtitle => '연락처, 레이블, 블랙리스트, 화이트리스트 등을 검색하세요.';

  @override
  String get searchSettingsTitle => '검색 설정';

  @override
  String get securityMessage =>
      '어떤 전화도 신뢰하지 마세요. 항상 고객 서비스 번호를 독립적으로 확인하세요. 비밀번호, 인증 코드, 카드 번호 또는 개인 정보를 절대 공유하지 마세요.';

  @override
  String get selectActionToPerform => '규칙이 일치할 때 수행할 작업을 선택하세요';

  @override
  String get selectActionWhenBlockingCalls => '전화 차단 시 작업 선택';

  @override
  String get selectActionWhenRuleMatches => '규칙이 일치할 때 작업 선택';

  @override
  String get selectAll => '모두 선택';

  @override
  String get selectCountry => '국가 선택';

  @override
  String get selectDateRange => '날짜 범위 선택';

  @override
  String get selectedDateRange => '선택된 날짜 범위';

  @override
  String selectedItems(Object count) {
    return '$count 개 항목 선택됨';
  }

  @override
  String get selectedLabel => '선택됨:';

  @override
  String get selectExportFormat => '내보내기 형식 선택';

  @override
  String get selectLabel => '레이블 선택';

  @override
  String get selectLabelAndEnterPhoneNumber => '레이블을 선택하고 유효한 전화 번호를 입력하세요';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get selectMultiple => '여러 개 선택';

  @override
  String get selectPeriod => '기간 선택';

  @override
  String get selectSimCard => 'SIM 카드 선택';

  @override
  String get selectSimSlot => 'SIM 슬롯 선택';

  @override
  String get selectSpecificActionForBlockedCalls =>
      '차단된 통화에 대해 수행할 특정 작업을 선택하세요.';

  @override
  String get selectTag => '태그 선택';

  @override
  String get selectTags => '태그 선택';

  @override
  String get selectTrustedDataSource => '신뢰할 수 있는 데이터 소스를 선택하세요.';

  @override
  String get selectYourLanguage => '언어 선택';

  @override
  String get sender => '발신자';

  @override
  String get senderRegexOptional => '발신자 정규식 (선택 사항)';

  @override
  String get serverAddressLabel => '서버 주소';

  @override
  String get serviceTypeContact => '연락처 구독';

  @override
  String get serviceTypeLabel => '서비스 유형';

  @override
  String get serviceTypePhone => '전화 구독';

  @override
  String get serviceTypePlugin => '플러그인 업데이트';

  @override
  String get serviceTypeSms => 'SMS 구독';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => '설정';

  @override
  String get setEncryptionPassword => '암호화 비밀번호 설정';

  @override
  String get setEncryptionPasswordDescription => '백업 및 복원을 위한 암호화 비밀번호 설정';

  @override
  String get setEncryptionPasswordLabel => '암호화 비밀번호 설정';

  @override
  String get setEncryptionPasswordTitle => '암호화 비밀번호 설정';

  @override
  String get setPasswordButton => '설정';

  @override
  String get settings => '설정';

  @override
  String settingsBackedUpTo(Object path) {
    return '설정이 백업되었습니다: $path';
  }

  @override
  String get settingsLoaded => '설정 로드됨';

  @override
  String settingsLoadFailed(Object error) {
    return '설정을 로드하지 못했습니다: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      '설정이 성공적으로 복원되었습니다. 변경 사항을 적용하려면 앱을 다시 시작하세요.';

  @override
  String get settingsSaved => '설정 저장됨';

  @override
  String settingsSaveFailed(Object error) {
    return '설정을 저장하지 못했습니다: $error';
  }

  @override
  String get settingsTab => '설정';

  @override
  String get settingsTitle => '설정';

  @override
  String get setup => '설정';

  @override
  String get showContactEditDialogStaticMethod => '연락처 편집 대화 상자를 표시하는 정적 메서드';

  @override
  String get showExplanation => '설명 보기';

  @override
  String get silence => '무음';

  @override
  String get silenceAndNoAnswer => '무음 및 응답 없음';

  @override
  String get silenceNoAnswer => '무음 응답 없음';

  @override
  String get silentCallVoiceClone => '무음 통화 음성 복제';

  @override
  String get silentRules => '무음 규칙';

  @override
  String simCard(Object simNumber) {
    return 'SIM 카드 $simNumber';
  }

  @override
  String get simCardColor => 'SIM 카드 색상';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM 카드 구성: 각 SIM 카드에 대해 독립적인 필터링 규칙을 설정합니다.';

  @override
  String get simCardFilterRules => 'SIM 카드 필터 규칙';

  @override
  String get simCardFilterRulesDescription => 'SIM 카드 슬롯에 따라 다른 필터링 규칙을 설정합니다.';

  @override
  String get simCardFontSize => 'SIM 카드 글꼴 크기';

  @override
  String get simCardPosition => 'SIM 카드 위치';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'SIM 카드 정보를 로드하지 못했습니다: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM 슬롯 규칙을 사용하면 각 SIM 슬롯에 대해 독립적인 필터링 규칙을 구성할 수 있습니다.';

  @override
  String get simRuleInstructionsTitle => 'SIM 슬롯 규칙';

  @override
  String get simRuleManagement => 'SIM 슬롯 규칙 관리';

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
    return 'SIM 데이터를 로드하지 못했습니다: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM 슬롯 필터 구성';

  @override
  String get simSlotFilterConfigurationDescription => 'SIM 슬롯별 필터 규칙 설정 허용';

  @override
  String get simSlotFilterDescription => '각 SIM 카드에 대해 독립적인 필터링 규칙을 구성합니다.';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM 슬롯 $slotNumber 필터 설정';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM 슬롯을 로드하지 못했습니다: $error';
  }

  @override
  String get simSlotManagement => 'SIM 슬롯 관리';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM 슬롯 작업 실패: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM 슬롯 위치 $slotNumberString';
  }

  @override
  String get simSlotRuleFeature => '• SIM 슬롯 규칙: SIM별 독립적인 필터링 전략';

  @override
  String get simSlotRuleListTitle => 'SIM 슬롯 규칙 목록';

  @override
  String get simSlotRuleManagement => 'SIM 슬롯 규칙';

  @override
  String get simSlotRuleManagementTitle => '규칙 관리';

  @override
  String get simSlotSettings => 'SIM 슬롯 설정';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM 슬롯 $slotNumber';
  }

  @override
  String get skip => '건너뛰기';

  @override
  String get smartCallerId => '스마트 전화 식별';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS 필터링은 스팸 메시지를 자동으로 필터링하고 메시지 목록을 깔끔하게 유지하는 데 도움이 됩니다. 필터 규칙과 알림 방법을 설정할 수 있습니다.';

  @override
  String get smsFilterDisabled => 'SMS 필터링 비활성화됨';

  @override
  String get smsFilterEnabled => 'SMS 필터링 활성화됨';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMS 필터 규칙이 성공적으로 추가되었습니다.';

  @override
  String get smsFilterRules => 'SMS 필터 규칙';

  @override
  String get smsFilterSettings => 'SMS 필터 설정';

  @override
  String get smsHistory => 'SMS 기록';

  @override
  String get smsManagement => 'SMS 관리';

  @override
  String get smsPermission => 'SMS 권한';

  @override
  String get smsPermissionDescription => '스팸 메시지를 필터링하는 데 사용됩니다.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS 규칙이 성공적으로 추가되었습니다.';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS 규칙이 성공적으로 삭제되었습니다.';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS 규칙을 로드하지 못했습니다: $error';
  }

  @override
  String get smsRuleManagement => 'SMS 규칙 관리';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS 규칙이 $filePath로 성공적으로 내보내졌습니다.';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS 규칙이 성공적으로 가져왔습니다.';

  @override
  String get smsRuleSubscription => 'SMS 규칙 구독';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS 규칙이 성공적으로 업데이트되었습니다.';

  @override
  String get smsSettingsSubtitle => 'SMS 필터링 및 키워드 차단';

  @override
  String get smsSettingsTitle => 'SMS 설정';

  @override
  String get smsSubscription => 'SMS 구독';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS 구독이 성공적으로 추가되었습니다.';

  @override
  String get smsSubscriptionRulesDescription =>
      'URL을 통해 SMS 규칙 목록을 구독하여 정규식 일치 기능을 지원합니다. 차단 또는 허용 작업을 설정할 수 있습니다.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => '일부 권한 요청이 거부되었습니다.';

  @override
  String get spamLikely => '스팸 가능성';

  @override
  String get startColor => '시작 색상';

  @override
  String get startDate => '시작 날짜';

  @override
  String get startUsing => '시작하기';

  @override
  String get statAnswered => '응답됨';

  @override
  String get statBlocked => '차단됨';

  @override
  String get staticMethodShowCallerIdDialog => '발신자 ID 정보 대화 상자를 표시하는 정적 메서드';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      '국가 선택 대화 상자를 표시하는 정적 메서드';

  @override
  String get staticMethodToDisplayDialog => '대화 상자를 표시하는 정적 메서드';

  @override
  String get statistics => '통계';

  @override
  String get statisticsExportFeatureComingSoon => '통계 내보내기 기능이 곧 출시될 예정입니다';

  @override
  String get statisticsGrid => '통계 그리드';

  @override
  String get statisticsPageTitle => '데이터 분석';

  @override
  String get stirColor => 'STIR 색상';

  @override
  String get stirFontSize => 'STIR 글꼴 크기';

  @override
  String get stirPosition => 'STIR 위치';

  @override
  String get storagePermission => '저장소 권한';

  @override
  String get storagePermissionDescription => '설정 및 규칙을 저장하는 데 사용됩니다.';

  @override
  String get subscribe => '구독';

  @override
  String subscriptionAddSuccess(Object name) {
    return '구독 \"$name\"이(가) 성공적으로 추가되었습니다';
  }

  @override
  String get subscriptionDeleteConfirmContent => '이 구독을 삭제하시겠습니까?';

  @override
  String get subscriptionDeleteConfirmTitle => '구독 삭제';

  @override
  String get subscriptionDeleted => '구독이 삭제되었습니다';

  @override
  String get subscriptionDeletedSuccessfully => '구독이 성공적으로 삭제되었습니다';

  @override
  String subscriptionDeleteFailed(Object error) {
    return '구독 삭제에 실패했습니다: $error';
  }

  @override
  String get subscriptionDeleteSuccess => '구독 삭제';

  @override
  String get subscriptionEmptyState => '사용 가능한 구독이 없습니다';

  @override
  String get subscriptionEmptyText => '구독이 아직 없습니다';

  @override
  String subscriptionLoadFailed(Object error) {
    return '구독을 로드하는 데 실패했습니다: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return '구독을 로드하는 데 실패했습니다: $error';
  }

  @override
  String get subscriptionManagementTitle => '구독 관리';

  @override
  String get subscriptionName => '구독 이름';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => '구독 이름과 URL은 비워둘 수 없습니다';

  @override
  String get subscriptionNameHint => '구독 이름을 입력하세요';

  @override
  String get subscriptionPageTitle => '구독 관리';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return '구독 상태를 변경하는 데 실패했습니다: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return '구독 상태를 전환하는 데 실패했습니다: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return '구독을 업데이트하는 데 실패했습니다: $error';
  }

  @override
  String get subscriptionUpdateSuccess => '구독이 성공적으로 업데이트되었습니다';

  @override
  String get subscriptionUrl => '구독 URL';

  @override
  String get subscriptionUrlHint => '구독 URL을 입력하세요';

  @override
  String successfullyImportedRules(Object count) {
    return '$count개의 규칙을 성공적으로 가져왔습니다';
  }

  @override
  String get supportSync => '동기화 지원';

  @override
  String get survey => '설문 조사';

  @override
  String get syncDevicesButton => '기기 동기화';

  @override
  String get syncFailed => '동기화 실패';

  @override
  String get syncFailedMessage => '동기화 실패';

  @override
  String get syncFolderNameHint =>
      '동기화 폴더 이름을 입력하십시오 (기본값: NotificationManager)';

  @override
  String get syncFolderNameLabel => '동기화 폴더 이름';

  @override
  String get synchronized => '동기화됨';

  @override
  String get syncing => '동기화 중...';

  @override
  String get syncNow => '지금 동기화';

  @override
  String get syncNowButton => '지금 동기화';

  @override
  String get syncStatusTitle => '동기화 상태';

  @override
  String get syncStatusUpdatedMessage => '동기화 상태가 업데이트되었습니다';

  @override
  String get syncSuccessful => '동기화 성공';

  @override
  String get syncSuccessMessage => '동기화 성공';

  @override
  String get syncWithCloudStorage => '클라우드 스토리지와 동기화';

  @override
  String get syncWithCloudStorageSubtitle => '클라우드 스토리지와 동기화';

  @override
  String get systemFeatures => '시스템 기능:';

  @override
  String get systemSettingsTitle => '시스템 설정';

  @override
  String get tabAll => '전체';

  @override
  String get tabAnswered => '응답';

  @override
  String get tabBlocked => '차단됨';

  @override
  String get tabMissed => '부재중';

  @override
  String get tabOutgoing => '발신';

  @override
  String tagLabel(String tag) {
    return '태그: $tag';
  }

  @override
  String get tagsUpdated => '태그가 업데이트되었습니다';

  @override
  String get takeaway => '핵심 내용';

  @override
  String get telecommunication => '통신';

  @override
  String get telegram => '텔레그램';

  @override
  String get telemarketing => '텔레마케팅';

  @override
  String get testButton => '테스트';

  @override
  String get testButtonLabel => '테스트';

  @override
  String get testConnectionButton => '연결 테스트';

  @override
  String get textColorsSetting => '텍스트 및 레이블 색상';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      '이 앱은 원치 않는 전화를 식별하고 차단할 수 있는 강력한 발신자 ID 도구입니다.';

  @override
  String get thisWeek => '이번 주';

  @override
  String get timeInterceptor => '시간 인터셉터';

  @override
  String get timeInterceptorDescription => '통화 빈도에 따라 잠재적인 통화를 자동으로 차단/허용합니다.';

  @override
  String get timeInterceptorExplanation =>
      '• 시간 인터셉터: 짧은 시간 내에 반복되는 통화를 차단/허용합니다.';

  @override
  String get timeInterceptorExplanationContent =>
      '통화 빈도 차단 기능은 통화 빈도를 분석하여 빈번한 스팸 전화를 자동으로 식별하고 차단/허용합니다.';

  @override
  String get timeInterceptorExplanationTitle => '통화 빈도 차단 설명';

  @override
  String get timeInterceptorSettingsTitle => '통화 빈도 차단 설정';

  @override
  String get timeInterceptorSubtitle => '통화 빈도에 따라 잠재적인 스팸 전화를 자동으로 차단';

  @override
  String get timeInterceptorTitle => '통화 빈도 차단 활성화';

  @override
  String get timeWindowDescription =>
      '반복되는 통화를 허용하기 위한 시간 창 크기를 설정합니다. 이 창 내의 동일한 번호로부터의 통화는 허용됩니다.';

  @override
  String timeWindowLabel(int minutes) {
    return '차단 시간 창 (분): $minutes';
  }

  @override
  String get timeWindowSetting =>
      '반복되는 통화를 허용하기 위한 시간 창 크기를 설정합니다. 이 창 내의 동일한 번호로부터의 통화는 허용됩니다.';

  @override
  String get today => '오늘';

  @override
  String get total => '총';

  @override
  String get totalBlocked => '총 차단됨';

  @override
  String get totalFiltered => '총 필터링됨';

  @override
  String get transferDataBetweenDevicesOrPlatforms => '기기 또는 플랫폼 간 데이터 전송';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      '기기 또는 플랫폼 간 데이터 전송';

  @override
  String get travelTicketing => '여행 티켓팅';

  @override
  String get trend => '추세';

  @override
  String get trendChart => '추세 차트';

  @override
  String get tutorial => '튜토리얼';

  @override
  String get type => '유형';

  @override
  String get unassignedSIMCard => '할당되지 않은 SIM 카드';

  @override
  String get unknown => '알 수 없음';

  @override
  String get unknownLabel => '알 수 없는 라벨';

  @override
  String get unknownTag => '태그: 알 수 없음';

  @override
  String get unregisterButton => '등록 취소';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '$deviceName의 등록을 취소하시겠습니까?';
  }

  @override
  String get unregisterDeviceTitle => '장치 등록 취소';

  @override
  String get unsupportedFileFormat => '지원되지 않는 파일 형식';

  @override
  String get update => '업데이트';

  @override
  String get updateAllNow => '지금 모두 업데이트';

  @override
  String get updateCallFilterConfig => '통화 필터 구성 업데이트';

  @override
  String updateContactFailed(Object error) {
    return '연락처 업데이트 실패: $error';
  }

  @override
  String get updateFavoriteStatus => '즐겨찾기 상태 업데이트';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return '즐겨찾기 상태 업데이트 실패: $error';
  }

  @override
  String get updateInterval => '업데이트 간격';

  @override
  String get updateLabelFailed => '라벨 업데이트 실패';

  @override
  String get updateNow => '지금 업데이트';

  @override
  String get updatePlugin => '플러그인 업데이트';

  @override
  String updatePluginFailed(Object error) {
    return '플러그인 업데이트 실패: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return '규칙 업데이트 실패: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return '구독 업데이트 실패: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service이(가) 성공적으로 업데이트되었습니다($count개 규칙)';
  }

  @override
  String get updateTags => '태그 업데이트';

  @override
  String get useCasesPoint1 => '• 자동 재다이얼 스팸 통화 식별';

  @override
  String get useCasesPoint2 => '• 짧은 시간 안에 여러 번 전화하는 마케팅 통화 차단';

  @override
  String get useCasesPoint3 => '• 전화 폭탄 및 괴롭힘 방지';

  @override
  String get useCasesTitle => '사용 사례:';

  @override
  String get useGlobalSettings => '글로벌 설정 사용';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => '사용자 이름';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      '표준 정규식 구문을 사용하여 패턴을 정의합니다. 예시:';

  @override
  String get validateRegex => '정규식 검증';

  @override
  String get verificationFailedText => '실패';

  @override
  String get verifiedText => '확인됨';

  @override
  String get verify => '확인';

  @override
  String version(Object version) {
    return '버전: $version';
  }

  @override
  String get vipExchangeDescription => '전화번호 마킹 횟수로 VIP 멤버십 교환';

  @override
  String get vipExchangeTitle => '마크 교환 VIP';

  @override
  String get watchAd => '광고 시청';

  @override
  String get watchAdForTemp => '임시 권한을 위해 광고 시청';

  @override
  String get watchAdForTempDescription =>
      '일부 프리미엄 기능을 임시로 잠금 해제하려면 짧은 광고를 시청하십시오.';

  @override
  String get webDAVConfigTitle => 'WebDAV 구성';

  @override
  String get webdavConfigurationTitle => 'WebDAV 구성';

  @override
  String get webdavPasswordHint => 'WebDAV 비밀번호를 입력하세요.';

  @override
  String get webdavServerAddressHint => 'WebDAV 서버 주소를 입력하세요.';

  @override
  String get webdavUsernameHint => 'WebDAV 사용자 이름을 입력하세요.';

  @override
  String get week => '주';

  @override
  String get weekly => '주간';

  @override
  String get weeklyBlockedCallsSummary => '주간 차단된 통화 요약';

  @override
  String get weeklyChartTitle => '주간 차단된 통화';

  @override
  String get weeklyReport => '주간 보고서';

  @override
  String get weeklyReportDesc => '통화 차단 활동에 대한 주간 요약 보고서를 받으세요.';

  @override
  String get welcome => '환영합니다';

  @override
  String get whitelist => '화이트리스트';

  @override
  String get whitelistLabel => '화이트리스트';

  @override
  String get width => '너비';

  @override
  String get wildcardMatchingDescription =>
      '\'.\'를 사용하여 모든 문자를 일치시킵니다(예: \'123.456\'은 123-456과 일치).';

  @override
  String get wildcardMatchingTitle => '와일드카드 일치:';

  @override
  String get wildcardSupportForFlexibleFiltering => '유연한 필터링을 위한 와일드카드 지원';

  @override
  String get windowSizeSetting => '창 크기';

  @override
  String get year => '년';

  @override
  String get yearly => '연간';

  @override
  String get yearlyChartTitle => '연간 차단된 통화';

  @override
  String get noSimCardsDetected => 'SIM 카드가 감지되지 않았습니다';

  @override
  String get filterManagementDescription => '통화 필터 설정';

  @override
  String get callerIdCustomizationSubtitle => '발신자 ID 레이아웃 사용자 지정';

  @override
  String get fraudAlerSettingTitle => '사기 경고 설정';

  @override
  String get fraudAlerSettingSubtitle => '사기 경고 설정';

  @override
  String get enableFraudAlert => '사기 경고 사용';

  @override
  String get enableFraudAlertDescription => '의심되는 사기 통화에 대한 경고';

  @override
  String get enableVibration => '진동 사용';

  @override
  String get enableVibrationDescription => '사기 통화가 의심될 때 진동';

  @override
  String get notificationSettingsTitle => '알림 설정';

  @override
  String get useLocalNotification => '로컬 알림 사용';

  @override
  String get useLocalNotificationDescription => '수신 통화에 대한 로컬 알림 사용';

  @override
  String get cancelLocalNotification => '로컬 알림 닫기';

  @override
  String get useStirNotification => 'STIR의 알림 사용';

  @override
  String get useStirNotificationDescription => '수신 통화에 대한 STIR 알림 사용';

  @override
  String get cancelLocalNotificationDescription => '로컬 알림 자동 닫기';

  @override
  String get callerIdSettingsTitle => '발신자 ID 설정';

  @override
  String get callerIdSettingsSubtitle => '수신 통화 알림 및 표시 모드 설정';

  @override
  String get purchaseTitle => '구매';

  @override
  String get purchaseSubtitle => '서비스 구매';

  @override
  String get callerIdNotificationTitle => '수신 통화 정보';

  @override
  String callerIdBody(String phoneNumber) {
    return '번호: $phoneNumber';
  }

  @override
  String get blockedCallTitle => '차단된 통화';

  @override
  String blockedCallBody(String phoneNumber) {
    return '$phoneNumber에서 차단된 통화';
  }

  @override
  String get stirVerified => '확인됨';

  @override
  String get stirNotVerified => '확인되지 않음';

  @override
  String get stirFailed => '확인 실패';

  @override
  String get stirUnknown => '확인 상태 알 수 없음';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN 확인';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '번호 $phoneNumber에 대한 $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => '스크롤 보안 메시지 설정';

  @override
  String get messageColor => '메시지 색상';

  @override
  String get messageFontSize => '메시지 글꼴 크기';

  @override
  String get messagePosition => '메시지 위치';

  @override
  String get containerWidth => '컨테이너 너비';

  @override
  String get scrollSpeed => '스크롤 속도';

  @override
  String get enableSecurityMessage => '보안 메시지 사용';

  @override
  String get fraudAlertTitle => '사기 경고';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '$phoneNumber에서 잠재적 사기 통화';
  }

  @override
  String loadRulesFailed(Object error) {
    return '규칙을 로드하지 못했습니다: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return '통화 기록을 로드하지 못했습니다: $error';
  }

  @override
  String get noBlockedTypeData => '차단된 유형 데이터가 없습니다';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeName 가져오기';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName을 성공적으로 가져왔습니다, 총 $count개 레코드 가져오기';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName 가져오기 실패: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeName 내보내기';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName을 성공적으로 내보냈습니다';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName 내보내기 실패: $error';
  }

  @override
  String get cloudSyncService => '클라우드 동기화 서비스';

  @override
  String get membershipCenter => '멤버십 센터';

  @override
  String get redeemVipWithMarks => '마크로 VIP 사용';

  @override
  String get currentMarkCount => '현재 마크 수';

  @override
  String get markMoreNumbersForMore => '더 많은 마크를 위해 더 많은 번호 마킹';

  @override
  String get noAds => '광고 없음';

  @override
  String get cloudBackup => '클라우드 백업';

  @override
  String get callerIdEnhancement => '발신자 ID 향상';

  @override
  String get voiceRecognition => '음성 인식';

  @override
  String get feature => '기능';

  @override
  String get normalUser => '일반 사용자';

  @override
  String get vipUser => 'VIP 사용자';

  @override
  String get temporaryVip => '임시 VIP';

  @override
  String get removeAds => '광고 제거';

  @override
  String get unknownAction => '알 수 없는 작업';

  @override
  String get settingsBackup => '설정 백업';

  @override
  String get allServicesStatusTitle => '현재 서비스 상태';

  @override
  String get allServicesStatusSubtitle => '각 클라우드 서비스의 현재 상태';

  @override
  String get redirect => '리디렉션';

  @override
  String get notify => '알림';

  @override
  String get log => '로그';

  @override
  String get custom => '사용자 정의';

  @override
  String get allowActionDescription => '번호가 차단 목록에 있어도 통화가 허용됩니다.';

  @override
  String get blockActionDescription => '통화가 차단되고 통화 기록에 표시됩니다.';

  @override
  String get silenceActionDescription => '통화는 음소거되지만 통화 기록에 표시됩니다.';

  @override
  String get noneActionDescription => '통화에 대해 특별한 조치가 취해지지 않습니다.';

  @override
  String get redirectActionDescription => '지정된 번호로 통화를 리디렉션합니다.';

  @override
  String get labelActionDescription => '쉽게 식별할 수 있도록 통화에 레이블을 추가합니다.';

  @override
  String get notifyActionDescription => '통화가 수신되면 알림을 보냅니다.';

  @override
  String get logActionDescription => '다른 조치를 취하지 않고 통화 정보를 기록합니다.';

  @override
  String get customActionDescription => '사용자 정의 작업을 수행합니다.';

  @override
  String get synced => '동기화됨';

  @override
  String get needVipAccess => '이 기능을 사용하려면 VIP 액세스가 필요합니다';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeName 데이터를 가져오거나 내보냅니다.';
  }

  @override
  String get importExportTitle => '가져오기/내보내기';

  @override
  String get noPhoneRules => '전화 규칙을 찾을 수 없습니다';

  @override
  String get noRegexRules => '정규식 규칙을 찾을 수 없습니다';

  @override
  String get noAllowedBlockedRules => '허용/차단 규칙을 찾을 수 없습니다';

  @override
  String get importExport => '가져오기/내보내기';

  @override
  String get filterByAction => '작업별 필터링';

  @override
  String get upgradeToVip => 'VIP로 업그레이드';

  @override
  String get batteryOptimizationPermission => '배터리 최적화';

  @override
  String get batteryOptimizationPermissionDescription =>
      '발신자 ID와 같은 서비스를 제공하기 위해 백그라운드에서 앱을 실행하도록 허용합니다.';

  @override
  String get permissionTitle => '특별 권한';

  @override
  String get permissionSubtitle => '오버레이 및 배터리 최적화 권한 관리';

  @override
  String get themeSettingsTitle => '테마 설정';

  @override
  String get themeSettingsSubtitle => '좋아하는 테마를 선택하세요';

  @override
  String get databaseSyncTitle => '데이터베이스 동기화';

  @override
  String get countrySyncSettingsTitle => '국가별 데이터베이스 동기화 설정';

  @override
  String get countrySyncSettingsSubtitle => '데이터 동기화를 위한 국가 선택';

  @override
  String get countryDataDisclaimer =>
      '참고: 데이터베이스에 특정 국가 또는 지역의 데이터가 포함되지 않을 수 있습니다.';

  @override
  String get editSubscription => '구독 수정';

  @override
  String get searchByNameOrPhoneNumber => '이름 또는 전화번호로 검색';

  @override
  String get allowedBlockedRulesInfo =>
      '허용/차단 규칙은 특정 전화번호에 대한 통화를 일치시키는 데 사용되며, 최우선 순위를 갖습니다.';

  @override
  String get searchPhoneRulesHint => '전화 규칙 검색';

  @override
  String get phoneRulesInfo =>
      '전화 규칙은 특정 전화번호에 대한 통화를 일치시키는 데 사용되며, 우선 순위가 낮습니다. 일부는 phoneRule 구독에서 가져옵니다.';

  @override
  String get searchSubscriptionsHint => '구독 검색';

  @override
  String get searchPluginsHint => '플러그인 검색';

  @override
  String get searchLabelsHint => '라벨 검색';

  @override
  String get pluginDescription => '플러그인 설명';

  @override
  String get enterPluginDescription => '플러그인 설명 입력';

  @override
  String get searchRegexRulesHint => '정규식 규칙 검색';

  @override
  String get regexRulesInfo => '정규식 규칙은 정규식 패턴을 기반으로 통화를 필터링하는 데 사용됩니다.';

  @override
  String get searchMarkedPhonesHint => '표시된 전화 검색';

  @override
  String get searchContactSubscriptionsHint => '연락처 구독 검색';

  @override
  String get showAllContacts => '모든 연락처 표시';

  @override
  String get showFavorites => '즐겨찾기 표시';

  @override
  String get manualEntry => '수동 입력 정보';

  @override
  String get scriptSaved => '스크립트 저장됨';

  @override
  String editScriptFor(String pluginName) {
    return '$pluginName에 대한 스크립트 편집';
  }

  @override
  String get saveScript => '스크립트 저장';

  @override
  String get testPlugin => '플러그인 테스트';

  @override
  String get description => '설명';

  @override
  String get accessTargetUrl => '대상 URL 액세스';

  @override
  String get result => '결과';

  @override
  String get editScript => '스크립트 편집';

  @override
  String get numberFormat => '번호 형식';

  @override
  String get nationalNumber => '국내 번호';

  @override
  String get e164Number => 'E164 번호';

  @override
  String get pluginRulesInfo =>
      '보안을 위해 신뢰할 수 있는 소스의 플러그인만 사용하십시오. 사용자 정의 플러그인을 만들려면 템플릿을 자유롭게 사용하세요!';

  @override
  String get advancedMode => '고급 모드';

  @override
  String get pleaseEnterAtLeastOneNumber => '하나 이상의 숫자를 입력하십시오.';

  @override
  String get openInWebView => 'WebView에서 열기';

  @override
  String get pluginLabel => '플러그인 라벨';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => '메시지 배경색';

  @override
  String get clearAllCallLogs => '모든 통화 기록 삭제';

  @override
  String get clearAllCallLogsConfirmation => '모든 통화 기록 삭제를 확인합니다.';

  @override
  String get allCallLogsCleared => '모든 통화 기록이 삭제되었습니다.';

  @override
  String get unblocked => '차단 해제됨';

  @override
  String get blockNumber => '차단 번호';

  @override
  String get blockNumberSuccess => '번호 차단 성공';

  @override
  String get blockNumberFailed => '번호 차단 실패';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '$phoneNumber의 차단을 해제하시겠습니까?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '$phoneNumber에 전화 거는 중...';
  }

  @override
  String get viewDetails => '세부 정보 보기';

  @override
  String get unblock => '차단 해제';

  @override
  String get unblockNumber => '번호 차단 해제';

  @override
  String get unblockNumberSuccess => '번호 차단 해제 성공';

  @override
  String get unblockNumberFailed => '번호 차단 해제 실패';

  @override
  String get serviceNotAvailable => '서비스를 사용할 수 없습니다';

  @override
  String get callingNumberFailed => '전화 걸기 실패';

  @override
  String get listView => '목록 보기';

  @override
  String get timelineView => '타임라인 보기';

  @override
  String get nameCannotBeEmpty => '이름을 비워둘 수 없습니다';

  @override
  String get selectAction => '작업 선택';

  @override
  String get selectTargetService => '대상 서비스 선택';

  @override
  String get callDetails => '통화 세부 정보';

  @override
  String get callType => '통화 유형';

  @override
  String get callTime => '통화 시간';

  @override
  String get numberInvalidFormat => '번호 형식이 잘못되었습니다';

  @override
  String get membershipFeature => '멤버십 기능';

  @override
  String get medium => '매체';

  @override
  String get finalRisk => '최종 위험';

  @override
  String get simState => 'SIM 상태';

  @override
  String get ipCountry => 'IP 국가';

  @override
  String get simCountry => 'SIM 국가';

  @override
  String get isRoaming => '로밍 중';

  @override
  String get isNumberMatch => '번호 일치';

  @override
  String get support => '지원';

  @override
  String get rewardedAdService => '보상 광고 서비스';

  @override
  String get hasVipPrivilegeExceptAds => '이미 VIP 혜택을 받고 있습니다 (광고 제외)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return '이미 임시 혜택을 받고 있습니다. 만료일: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return '임시 VIP 혜택을 받으려면 $count개의 광고를 더 시청해야 합니다';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '$days일의 임시 구매 혜택이 부여되었습니다. 만료일: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => '임시 구매 혜택이 만료되었습니다';

  @override
  String get loadingAd => '광고 로딩 중...';

  @override
  String get earnedTempVip => '임시 VIP 획득';

  @override
  String get vipExchangeService => 'VIP 교환 서비스';

  @override
  String get marksInsufficient => '교환할 점수가 부족합니다';

  @override
  String get invalidExchangeRule => '잘못된 교환 규칙';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '$description으로 성공적으로 교환되었습니다. 만료일: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return '교환 실패: $error';
  }

  @override
  String get vip3DaysWithAds => '3일 VIP (광고 포함)';

  @override
  String get vip5DaysNoAds => '5일 풀 기능 광고 없음 VIP';

  @override
  String get vip7DaysNoAds => '7일 풀 기능 광고 없음 VIP';

  @override
  String get noNotifications => '알림 없음';

  @override
  String get clearAllNotifications => '모든 알림 지우기';

  @override
  String get clearAllNotificationsConfirmation => '모든 알림을 지우시겠습니까?';

  @override
  String get allNotificationsCleared => '모든 알림을 지웠습니다';

  @override
  String get clearButton => '지우기';

  @override
  String get justNow => '방금';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분 전',
      one: '1분 전',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간 전',
      one: '1시간 전',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 전',
      one: '1일 전',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => '어제';

  @override
  String get deletionProposal => '삭제 제안';

  @override
  String get createProposal => '제안 생성';

  @override
  String get createProposalTitle => '삭제 제안 생성';

  @override
  String get reason => '사유';

  @override
  String get reasonOutdated => '오래된 번호';

  @override
  String get reasonPrivacy => '개인 정보 관련';

  @override
  String get reasonNotInService => '서비스 없음';

  @override
  String get reasonWronglyIdentified => '잘못된 식별';

  @override
  String get reasonInaccurateInfo => '정확하지 않은 정보';

  @override
  String get reasonWrongMarked => '잘못 표시됨';

  @override
  String get reasonOther => '기타';

  @override
  String get submit => '제출';

  @override
  String get cancel => '취소';

  @override
  String get proposalStatus => '상태';

  @override
  String get statusPending => '보류 중';

  @override
  String get statusActive => '활성';

  @override
  String get statusCompleted => '완료됨';

  @override
  String get statusExpired => '만료됨';

  @override
  String get riskLevel => '위험 수준';

  @override
  String get riskLevelVerified => '확인됨';

  @override
  String get riskLevelLow => '낮음';

  @override
  String get riskLevelHigh => '높음';

  @override
  String get riskLevelUnknown => '알 수 없음';

  @override
  String get votingProgress => '투표 진행률';

  @override
  String agreeVotes(int count) {
    return '동의: $count';
  }

  @override
  String disagreeVotes(int count) {
    return '반대: $count';
  }

  @override
  String totalVotes(int count) {
    return '총: $count';
  }

  @override
  String get voteAgree => '동의';

  @override
  String get voteDisagree => '반대';

  @override
  String createdAt(String date) {
    return '생성됨: $date';
  }

  @override
  String get verificationReport => '인증 보고서';

  @override
  String get showReport => '보고서 보기';

  @override
  String get hideReport => '보고서 숨기기';

  @override
  String get proposalStatistics => '제안 통계';

  @override
  String get totalProposals => '총 제안';

  @override
  String get activeProposals => '활성 제안';

  @override
  String get completedProposals => '완료된 제안';

  @override
  String get myVotes => '내 투표';

  @override
  String get proposalCreated => '제안이 성공적으로 생성되었습니다';

  @override
  String get proposalCreateFailed => '제안 생성에 실패했습니다';

  @override
  String get voteSubmitted => '투표가 성공적으로 제출되었습니다';

  @override
  String get voteSubmitFailed => '투표 제출에 실패했습니다';

  @override
  String get noProposalsFound => '제안이 없습니다';

  @override
  String get loadingProposals => '제안 로딩 중...';

  @override
  String get refreshProposals => '제안 새로 고침';

  @override
  String get totalPendingProposals => '총 보류 중인 제안';

  @override
  String get highRisk => '높은 위험';

  @override
  String get mediumRisk => '중간 위험';

  @override
  String get lowRisk => '낮은 위험';

  @override
  String get communityImpact => '커뮤니티 영향';

  @override
  String get criticalIssues => '심각한 문제';

  @override
  String get communityParticipation => '커뮤니티 참여';

  @override
  String get noActivity => '활동 없음';

  @override
  String get low => '낮음';

  @override
  String get moderate => '보통';

  @override
  String get high => '높음';

  @override
  String get veryHigh => '매우 높음';

  @override
  String get voted => '투표함';

  @override
  String get communityVotes => '커뮤니티 투표';

  @override
  String get waitingForMoreVotes => '더 많은 커뮤니티 투표 대기 중';

  @override
  String get proposalProcessed => '이 제안은 처리되었습니다.';

  @override
  String get supported => '지지';

  @override
  String get opposed => '반대';

  @override
  String get approved => '승인됨';

  @override
  String get rejected => '거부됨';

  @override
  String get completed => '완료됨';

  @override
  String get pending => '대기 중';

  @override
  String get critical => '심각';

  @override
  String get oppose => '반대';

  @override
  String get veryLow => '매우 낮음';

  @override
  String get deletionProposals => '삭제 제안';

  @override
  String get deletionProposalNotificationDescription =>
      '삭제 제안 투표 결과 및 업데이트에 대한 알림.';

  @override
  String get deletionProposalCreated => '삭제 제안 생성됨';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '$phoneNumber에 대한 삭제 제안이 커뮤니티 검토를 위해 제출되었습니다.';
  }

  @override
  String get proposalApproved => '제안 승인됨 ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '커뮤니티에서 $phoneNumber에 대한 삭제 제안이 승인되었습니다($supportPercentage% 지지, $totalVotes표).';
  }

  @override
  String get proposalRejected => '제안 거부됨 ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '커뮤니티에서 $phoneNumber에 대한 삭제 제안이 거부되었습니다($supportPercentage% 지지, $totalVotes표).';
  }

  @override
  String get communityVotingStarted => '커뮤니티 투표 시작됨';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '$phoneNumber에 대한 새로운 삭제 제안이 커뮤니티 투표를 위해 열렸습니다.';
  }

  @override
  String get votingCompleted => '투표 완료됨';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '$phoneNumber에 대한 커뮤니티 투표가 종료되었습니다. 결과: $result ($supportPercentage% 지지).';
  }

  @override
  String get newVoteReceived => '새로운 투표 받음';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return '누군가 $phoneNumber의 삭제에 대해 $voteType했습니다. 현재 투표 수: $totalVotes표.';
  }

  @override
  String get loadVoteCountFailed => '투표 수 로드 실패';

  @override
  String get voteCount => '투표 수';

  @override
  String get deletionProposalInfo => '삭제 제안 정보';

  @override
  String get deletionProposalDescription =>
      '커뮤니티 가이드라인을 위반하는 삭제할 번호를 제안하세요. 참여는 플랫폼 안전을 유지하는 데 도움이 됩니다.';

  @override
  String get voteToEarnVip => 'VIP 특권을 얻기 위해 제안에 투표하세요!';

  @override
  String get voteFailed => '투표 실패';

  @override
  String get searchProposals => '제안 검색';

  @override
  String get defaultNotifications => '기본 알림';

  @override
  String get defaultNotificationsDescription => '앱의 기본 알림 채널.';

  @override
  String get blockedCallNotifications => '차단된 통화 알림';

  @override
  String get blockedCallNotificationsDescription => '차단된 통화에 대한 정보를 표시합니다.';

  @override
  String get stirVerification => 'STIR/SHAKEN 인증';

  @override
  String get stirVerificationDescription => '번호에 대한 STIR/SHAKEN 인증 결과를 표시합니다.';

  @override
  String get fraudAlerts => '사기 알림';

  @override
  String get fraudAlertsDescription => '잠재적인 사기 통화에 대한 경고를 표시합니다.';

  @override
  String get notificationFrequencyDescription =>
      '새로운 삭제 제안에 대한 알림을 얼마나 자주 받을지 선택하세요. 즉시, 일괄적으로 또는 사용자 지정 간격으로 받을 수 있습니다.';

  @override
  String get notificationMode => '알림 모드';

  @override
  String get immediateNotifications => '즉시';

  @override
  String get immediateNotificationsDescription => '제안이 생성되는 즉시 알림을 받습니다.';

  @override
  String get batchNotifications => '일괄 처리됨';

  @override
  String get batchNotificationsDescription => '알림 요약을 주기적으로 받습니다.';

  @override
  String get customNotifications => '사용자 지정';

  @override
  String get customNotificationsDescription => '알림 수신 간격을 직접 정의합니다.';

  @override
  String get customFrequency => '사용자 지정 빈도';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes 분';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours 시간';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours 시간 $minutes 분';
  }

  @override
  String get pendingProposals => '대기 중인 제안';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 있습니다',
      one: '1개 있습니다',
      zero: '없습니다',
    );
    return '대기 중인 제안이 $_temp0.';
  }

  @override
  String get guidelinesLabel => '가이드라인';

  @override
  String get riskLevelLabel => '위험 수준';

  @override
  String get riskLevelDescription => '전화번호의 위험 수준';

  @override
  String get phoneNumberMinDigits => '전화번호는 최소 7자리여야 합니다.';

  @override
  String get provideDetailedExplanation => '상세한 설명을 제공하세요 (최소 10자)';

  @override
  String get reasonMinCharacters => '이유는 최소 10자 이상이어야 합니다.';

  @override
  String get countryCodeTwoLetters => '국가 코드 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => '국가 코드 (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => '예: US, CN, GB';

  @override
  String get countryCodeRequired => '국가 코드가 필요합니다.';

  @override
  String get countryCodeLengthError => '국가 코드는 2글자여야 합니다.';

  @override
  String get phoneNumberHint => '전화번호를 입력하세요';

  @override
  String get phoneNumberRequired => '전화번호는 필수입니다';

  @override
  String get phoneNumberLengthError => '전화번호는 최소 7자리여야 합니다.';

  @override
  String get reasonHint => '상세한 설명을 제공하세요 (최소 10자)';

  @override
  String get reasonRequired => '이유가 필요합니다.';

  @override
  String get reasonLengthError => '이유는 최소 10자 이상이어야 합니다.';

  @override
  String get guidelinesTitle => '가이드라인';

  @override
  String get guidelinesText =>
      '• 정말 문제 있는 번호만 신고하세요.\n• 정확하고 상세한 이유를 제공하세요.\n• 심각성에 따라 적절한 위험 수준을 선택하세요.\n• 허위 신고는 계정 제한으로 이어질 수 있습니다.';

  @override
  String get riskLevelCritical => '위험';

  @override
  String get riskLevelMedium => '중간';

  @override
  String get riskLevelVeryLow => '매우 낮음';

  @override
  String get riskDescriptionVeryLow => '매우 낮음 - 약간의 불쾌감, 드문 통화';

  @override
  String get riskDescriptionLow => '낮음 - 가끔 원치 않는 전화';

  @override
  String get riskDescriptionMedium => '중간 - 정기적인 스팸 또는 텔레마케팅';

  @override
  String get riskDescriptionHigh => '높음 - 지속적인 괴롭힘 또는 사기 시도';

  @override
  String get riskDescriptionCritical => '위험 - 위험한 사기 또는 위협';

  @override
  String get notificationFrequencyTitle => '알림 빈도';

  @override
  String get notificationFrequencyLabel => '알림 빈도 (시간)';

  @override
  String errorMessage(String error) {
    return '오류: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return '투표: $totalVotes (찬성 $supportPercentage%)';
  }

  @override
  String get timeJustNow => '방금 전';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes분 전';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours시간 전';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days일 전';
  }

  @override
  String get reportingGuidelines =>
      '• 정말 문제 있는 번호만 신고하세요.\n• 정확하고 상세한 이유를 제공하세요.\n• 심각성에 따라 적절한 위험 수준을 선택하세요.\n• 허위 신고는 계정 제한으로 이어질 수 있습니다.';

  @override
  String get notificationFrequencyHours => '알림 빈도 (시간)';

  @override
  String supportCount(int supportCount) {
    return '찬성 ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return '반대 ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes표 ($supportPercentage% 지지)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 시간',
      one: '1 시간',
      zero: '0 시간',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => '중요 공지';

  @override
  String get dataSourceDisclaimer =>
      '숫자는 인터넷 및 사용자 제출을 통해 얻습니다. 삭제된 숫자가 다른 사용자 또는 출처에서 다시 제출되지 않도록 보장할 수 없습니다. 정보를 적극적으로 검색하고 확인하십시오.';

  @override
  String get avatar => '아바타';

  @override
  String get location => '위치';

  @override
  String get simCardTitle => 'SIM 카드';

  @override
  String get liveActivitiesSettingsTitle => '실시간 활동 설정';

  @override
  String get elementsSettingsTitle => '요소 설정';

  @override
  String get liveActivityMode => '실시간 활동';

  @override
  String get liveActivityModeDescription =>
      '잠금 화면 및 Dynamic Island (iOS)에 통화 정보를 지속적인 알림으로 표시합니다.';

  @override
  String get phoneNumberType => '전화번호 유형';

  @override
  String get liveActivitiesTestEndActivity => '활동 종료';

  @override
  String get liveActivitiesTestSendNewActivity => '새 활동 전송';

  @override
  String get liveActivitiesTestUpdateActivity => '활동 업데이트';

  @override
  String get liveActivityControlsTitle => '실시간 활동 제어';

  @override
  String get liveActivitiesTestTitle => '실시간 활동 테스트';

  @override
  String get liveActivitiesTestSubtitle => '실시간 활동 알림을 테스트합니다.';

  @override
  String get liveNotificationCustomizationTitle => '실시간 알림 사용자 지정';

  @override
  String get liveNotificationCustomizationSubtitle => '실시간 알림의 모양을 사용자 지정합니다.';

  @override
  String get notification_instructions =>
      '지침:\n1. 알림을 생성하거나 업데이트하려면 \"보내기\"를 탭하세요.\n2. 결과를 확인하려면 홈 화면으로 이동하거나 알림 트레이를 아래로 당기세요.\n3. 알림을 닫으려면 \"종료\"를 탭하세요.';

  @override
  String get autoCancelNotification => '자동 알림 취소';

  @override
  String get autoCancelNotificationDescription =>
      '선택하면 사용자가 알림을 탭할 때 알림이 자동으로 닫힙니다.';

  @override
  String get setDelayTime => '지연 시간 설정';

  @override
  String get proposalDetails => '제안 세부 정보';

  @override
  String get filterByStatus => '상태별 필터링';

  @override
  String get proposalNotFound => '제안을 찾을 수 없습니다';

  @override
  String get processed => '처리됨';

  @override
  String get showAll => '모두 보기';

  @override
  String get filterAndSortTitle => '필터 및 정렬';

  @override
  String get filterVerifiedOwner => '확인된 소유자 필터링';

  @override
  String get filterBy => '필터 기준';

  @override
  String get sortOldest => '오래된순 정렬';

  @override
  String get sortNewest => '최신순 정렬';

  @override
  String get sortMostPopular => '인기순 정렬';

  @override
  String get sortLeastPopular => '비인기순 정렬';

  @override
  String get sortBy => '정렬 기준';

  @override
  String get simRulesNotFound => 'SIM 규칙을 찾을 수 없습니다';

  @override
  String get simSlotRules => 'SIM 슬롯 규칙';

  @override
  String get noSimCardDetected => 'SIM 카드가 감지되지 않았습니다.';

  @override
  String get invalidSimData => '잘못된 SIM 데이터';

  @override
  String get simCardData => 'SIM 카드 데이터';

  @override
  String get simSlot => 'SIM 슬롯';

  @override
  String get enableFiltering => '필터링 활성화';

  @override
  String get detailedSettingsTitle => '상세 설정';

  @override
  String get entryPointViewTitle => '진입점 보기';

  @override
  String get callTypeRejected => '거절됨';

  @override
  String get callTypeSilenced => '무음';

  @override
  String get callTypeVoicemail => '음성 사서함';

  @override
  String get callTypeUnknownIntercept => '알 수 없는 가로채기';

  @override
  String andMoreItems(int count) {
    return '그리고 $count개 더';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

  @override
  String get localDatabaseSyncSubtitle => 'Sync data across devices';

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
  String get leaveEmptyToUseDefault => 'Leave empty to use default';

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Failed to load settings schema: $error';
  }

  @override
  String get noSettingsAvailable => 'No settings available for this plugin.';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get answerThenHangupDescription =>
      'Automatically answer the incoming call and then immediately hang up to terminate it';
}
