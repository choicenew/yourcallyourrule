// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko_KR locale. All the
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
  String get localeName => 'ko_KR';

  static String m0(permissionName) => "${permissionName} 권한이 부여되지 않았습니다.";

  static String m1(listType) => "${listType}에 추가";

  static String m2(listType) => "${listType}에 추가";

  static String m3(permissionName) =>
      "앱 설정에서 ${permissionName} 권한을 수동으로 비활성화해야 합니다.";

  static String m4(listType) => "${listType} 제거";

  static String m5(listType) => "${listType} 제거";

  static String m6(permissionName) =>
      "앱 설정에서 ${permissionName} 권한을 수동으로 비활성화해야 합니다.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("정보"),
        "accept": MessageLookupByLibrary.simpleMessage("수락"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("광고 활성화:"),
        "add": MessageLookupByLibrary.simpleMessage("추가"),
        "addAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("허용된 항목 페이지 추가"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("차단 목록 페이지 추가"),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage("차단된 페이지 추가"),
        "addContact": MessageLookupByLibrary.simpleMessage("연락처 추가"),
        "addContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("연락처 구독 페이지 추가"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage("레이블 페이지 추가"),
        "addPluginPage": MessageLookupByLibrary.simpleMessage("플러그인 페이지 추가"),
        "addRegexPage": MessageLookupByLibrary.simpleMessage("정규식 페이지 추가"),
        "addSmsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMS 차단 목록 페이지 추가"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS 구독 페이지 추가"),
        "addSmsTextBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 차단 목록 페이지 추가"),
        "addSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 허용 목록 페이지 추가"),
        "addSmsWhitelistPage":
            MessageLookupByLibrary.simpleMessage("SMS 허용 목록 페이지 추가"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("구독 페이지 추가"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage("허용 목록에 추가"),
        "addToAllowedtype": m1,
        "addToBlocked": MessageLookupByLibrary.simpleMessage("차단 목록에 추가"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("레이블에 추가"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("허용 목록 페이지 추가"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("성공적으로 추가되었습니다"),
        "agent": MessageLookupByLibrary.simpleMessage("Agent"),
        "all": MessageLookupByLibrary.simpleMessage("전체"),
        "allowAllAllowedNumbers":
            MessageLookupByLibrary.simpleMessage("모든 허용된 번호 허용"),
        "allowAllBlacklistedNumbers":
            MessageLookupByLibrary.simpleMessage("모든 차단 목록 번호 허용"),
        "allowAllWhitelistedNumbers":
            MessageLookupByLibrary.simpleMessage("모든 허용 목록 번호 허용"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("차단된 번호 허용"),
        "allowOtherNumbers":
            MessageLookupByLibrary.simpleMessage("Allow Other Numbers"),
        "allowRegexBlacklistedPatterns":
            MessageLookupByLibrary.simpleMessage("정규식 차단 목록 패턴 허용"),
        "allowRegexWhitelistedPatterns":
            MessageLookupByLibrary.simpleMessage("정규식 허용 목록 패턴 허용"),
        "allowRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("반복되는 수신 전화 허용"),
        "allowThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("이 앱이 발신자 ID를 표시하도록 허용"),
        "allowed": MessageLookupByLibrary.simpleMessage("허용됨"),
        "allowedEntryPage": MessageLookupByLibrary.simpleMessage("허용된 항목 페이지"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage("허용된 페이지 보기"),
        "answerthenhangup": MessageLookupByLibrary.simpleMessage("응답 후 끊기"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage("항목을 삭제하시겠습니까?"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage("이 연락처를 삭제하시겠습니까?"),
        "autoCloseLocalNotification":
            MessageLookupByLibrary.simpleMessage("로컬 알림 자동 닫기"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("자동 업데이트 비활성화됨"),
        "autoUpdateEnabled":
            MessageLookupByLibrary.simpleMessage("자동 업데이트 활성화됨"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatar": MessageLookupByLibrary.simpleMessage("Avatar"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("아바타 및 아이콘 크기"),
        "avatarBorderColor": MessageLookupByLibrary.simpleMessage("아바타 테두리 색상"),
        "avatarBorderSize": MessageLookupByLibrary.simpleMessage("아바타 테두리 크기"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("아바타 위치"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("아바타 크기"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("아바타 URL 또는 경로"),
        "backgroundGradient": MessageLookupByLibrary.simpleMessage("배경 그라디언트"),
        "backup": MessageLookupByLibrary.simpleMessage("백업"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage("백업 및 복원"),
        "bank": MessageLookupByLibrary.simpleMessage("은행"),
        "batteryOptimization": MessageLookupByLibrary.simpleMessage("배터리 최적화"),
        "blacklist": MessageLookupByLibrary.simpleMessage("차단 목록"),
        "blacklistPage": MessageLookupByLibrary.simpleMessage("차단 목록 페이지"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("차단 목록 및 허용 목록"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("차단 목록 페이지 보기"),
        "blockCallsFromSpecificAreaCodes":
            MessageLookupByLibrary.simpleMessage("특정 지역 번호에서 걸려오는 전화 차단:"),
        "blockInternationalCalls":
            MessageLookupByLibrary.simpleMessage("국제 전화 차단:"),
        "blocked": MessageLookupByLibrary.simpleMessage("차단됨"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage("차단된 통화 조치"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("차단된 통화 알림"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("차단된 통화 통계"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("차단된 페이지"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage("차단된 페이지 보기"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage("원래 통화 앱 및 로컬 알림 모두"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("원래 SMS 및 로컬 알림 모두"),
        "call": MessageLookupByLibrary.simpleMessage("통화"),
        "callHistory": MessageLookupByLibrary.simpleMessage("통화 기록"),
        "callLog": MessageLookupByLibrary.simpleMessage("통화 기록"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("통화 기록 권한이 거부되었습니다"),
        "callScreeningRoleRequestFailed":
            MessageLookupByLibrary.simpleMessage("통화 스크리닝 역할 요청 실패!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage("통화 스크리닝 역할 요청 성공!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("발신자 ID 앱"),
        "callerIdData": MessageLookupByLibrary.simpleMessage("Caller ID Data:"),
        "callerIdDataIsNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Caller ID Data is not available"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle": MessageLookupByLibrary.simpleMessage("발신자 ID 스타일"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("발신자 ID 스타일 콘텐츠"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("통화 유형 아이콘 색상"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("통신사:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("통신사 색상"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage("통신사 글꼴 크기"),
        "carrierPosition": MessageLookupByLibrary.simpleMessage("통신사 위치"),
        "charity": MessageLookupByLibrary.simpleMessage("자선 단체"),
        "chooseAvatarLocalOrNetwork":
            MessageLookupByLibrary.simpleMessage("아바타 선택(로컬 또는 네트워크):"),
        "chooseFromGallery": MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("링크 또는 파일 중 하나만 선택하세요"),
        "chooseTheDefaultInterceptAction":
            MessageLookupByLibrary.simpleMessage("기본 차단 조치 선택"),
        "chooseYourLanguage": MessageLookupByLibrary.simpleMessage("언어 선택"),
        "clientId": MessageLookupByLibrary.simpleMessage("클라이언트 ID"),
        "close": MessageLookupByLibrary.simpleMessage("닫기"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("클라우드 백업 디렉터리 이름"),
        "cloudBackupRequiresAutoBackup":
            MessageLookupByLibrary.simpleMessage("클라우드 백업에는 자동 백업이 필요합니다"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("클라우드 서비스"),
        "collection": MessageLookupByLibrary.simpleMessage("수집"),
        "configurationExportedToFile":
            MessageLookupByLibrary.simpleMessage("구성이 파일에 내보내졌습니다!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("구성이 가져왔습니다"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("구성을 성공적으로 가져왔습니다"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("구성이 저장되었습니다!"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("삭제 확인"),
        "contactFile": MessageLookupByLibrary.simpleMessage("연락처 파일"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("연락처 구독 페이지"),
        "contactUs": MessageLookupByLibrary.simpleMessage("문의하기"),
        "contacts": MessageLookupByLibrary.simpleMessage("연락처"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("연락처를 성공적으로 내보냈습니다"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("연락처를 성공적으로 가져왔습니다"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("연락처 페이지"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("번호가 있는 연락처"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("연락처 구독 목록 보기"),
        "count": MessageLookupByLibrary.simpleMessage("Count"),
        "countColor": MessageLookupByLibrary.simpleMessage("개수 색상"),
        "countFontSize": MessageLookupByLibrary.simpleMessage("개수 글꼴 크기"),
        "countPosition": MessageLookupByLibrary.simpleMessage("개수 위치"),
        "country": MessageLookupByLibrary.simpleMessage("국가:"),
        "countryCode": MessageLookupByLibrary.simpleMessage("Country Code"),
        "countryName": MessageLookupByLibrary.simpleMessage("Country Name"),
        "countryNameColor": MessageLookupByLibrary.simpleMessage("국가 이름 색상"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("국가 이름 글꼴 크기"),
        "countryNamePosition": MessageLookupByLibrary.simpleMessage("국가 이름 위치"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("아바타 자르기"),
        "customerService": MessageLookupByLibrary.simpleMessage("고객 서비스"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("발신자 ID 사용자 지정"),
        "dark": MessageLookupByLibrary.simpleMessage("어둡게"),
        "darkMode": MessageLookupByLibrary.simpleMessage("다크 모드"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("연락처 삭제"),
        "deleted": MessageLookupByLibrary.simpleMessage("삭제됨"),
        "delivery": MessageLookupByLibrary.simpleMessage("배달"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "권한이 거부되었습니다. 설정에서 수동으로 권한을 활성화할 수 있습니다."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("차단된 통화 알림 비활성화"),
        "disablePermission": MessageLookupByLibrary.simpleMessage("권한 비활성화"),
        "disableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMS 로컬 알림 비활성화"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId":
            MessageLookupByLibrary.simpleMessage("이 앱이 발신자 ID를 표시하지 못하도록 비활성화"),
        "disabled": MessageLookupByLibrary.simpleMessage("비활성화됨"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("전자상거래"),
        "edit": MessageLookupByLibrary.simpleMessage("편집"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("아바타 편집"),
        "editCode": MessageLookupByLibrary.simpleMessage("코드 편집"),
        "editContact": MessageLookupByLibrary.simpleMessage("연락처 편집"),
        "editPluginCode": MessageLookupByLibrary.simpleMessage("플러그인 코드 편집"),
        "education": MessageLookupByLibrary.simpleMessage("교육"),
        "elementPositions": MessageLookupByLibrary.simpleMessage("요소 위치"),
        "email": MessageLookupByLibrary.simpleMessage("이메일"),
        "enableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("차단된 통화 알림 활성화"),
        "enableDarkModeBasedOnTime":
            MessageLookupByLibrary.simpleMessage("시간 기반 다크 모드 활성화"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("오버레이 권한 활성화"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMS 로컬 알림 활성화"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("광고를 제거하려면 활성화하세요"),
        "enabled": MessageLookupByLibrary.simpleMessage("활성화됨"),
        "endColor": MessageLookupByLibrary.simpleMessage("끝 색상"),
        "endcall": MessageLookupByLibrary.simpleMessage("통화 종료"),
        "enterCountryCode": MessageLookupByLibrary.simpleMessage(
            "Enter country code (e.g., US, CA)"),
        "enterImageUrl": MessageLookupByLibrary.simpleMessage("이미지 URL 입력"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("여기에 플러그인 코드를 입력하세요"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("URL 입력"),
        "entry": MessageLookupByLibrary.simpleMessage("항목"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("항목이 성공적으로 추가되었습니다"),
        "error": MessageLookupByLibrary.simpleMessage("오류"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("연락처 내보내기 오류:"),
        "errorGettingPermissionStatus":
            MessageLookupByLibrary.simpleMessage("권한 상태를 가져오는 중 오류 발생"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("가져오는 중 오류 발생"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage("통화 스크리닝 역할 요청 오류:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("내보내기"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("허용된 항목 페이지 내보내기"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("CSV로 내보내기"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("JSON으로 내보내기"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("VCF로 내보내기"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("YAML로 내보내기"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("차단 목록 페이지 내보내기"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("차단된 페이지 내보내기"),
        "exportContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("연락처 구독 페이지 내보내기"),
        "exportContacts": MessageLookupByLibrary.simpleMessage("연락처 내보내기"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("내보내기 실패"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("내보내기 형식:"),
        "exportLabelPage": MessageLookupByLibrary.simpleMessage("레이블 페이지 내보내기"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("플러그인 페이지 내보내기"),
        "exportRegexPage": MessageLookupByLibrary.simpleMessage("정규식 페이지 내보내기"),
        "exportSmsBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 차단 목록 페이지 내보내기"),
        "exportSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS 구독 페이지 내보내기"),
        "exportSmsTextBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 차단 목록 페이지 내보내기"),
        "exportSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 허용 목록 페이지 내보내기"),
        "exportSmsWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 허용 목록 페이지 내보내기"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("구독 페이지 내보내기"),
        "exportSuccessful": MessageLookupByLibrary.simpleMessage("내보내기 성공"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("허용 목록 페이지 내보내기"),
        "failed": MessageLookupByLibrary.simpleMessage("실패"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("추가 실패:"),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage("항목 추가 실패:"),
        "feature": MessageLookupByLibrary.simpleMessage("기능"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription": MessageLookupByLibrary.simpleMessage("기능 설명"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("수신 SMS 메시지 필터링"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("반복되는 수신 전화 필터링"),
        "financial": MessageLookupByLibrary.simpleMessage("금융"),
        "firstName": MessageLookupByLibrary.simpleMessage("이름"),
        "fraudScamLikely": MessageLookupByLibrary.simpleMessage("사기 가능성 높음"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("시작하기"),
        "googleDriveLoginFailed":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 로그인 실패"),
        "googleDriveLoginSuccessfully":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 로그인 성공"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 설정"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("권한 부여"),
        "group": MessageLookupByLibrary.simpleMessage("그룹"),
        "headhunter": MessageLookupByLibrary.simpleMessage("Headhunter"),
        "height": MessageLookupByLibrary.simpleMessage("높이"),
        "history": MessageLookupByLibrary.simpleMessage("기록"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("아이콘 크기"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("가져오기"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("허용된 항목 페이지 가져오기"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("차단 목록 페이지 가져오기"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("차단된 항목 페이지 가져오기"),
        "importConfiguration": MessageLookupByLibrary.simpleMessage("구성 가져오기"),
        "importContacts": MessageLookupByLibrary.simpleMessage("연락처 가져오기"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("CSV에서 가져오기"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("파일에서 가져오기"),
        "importFromJson": MessageLookupByLibrary.simpleMessage("JSON에서 가져오기"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("URL에서 가져오기"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("VCF에서 가져오기"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage("YAML에서 가져오기"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage("레이블 페이지 가져오기"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("플러그인 페이지 가져오기"),
        "importRegexPage": MessageLookupByLibrary.simpleMessage("정규식 페이지 가져오기"),
        "importSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS 구독 페이지 가져오기"),
        "importSmsTextBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 차단 목록 페이지 가져오기"),
        "importSmsTextWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 허용 목록 페이지 가져오기"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("구독 페이지 가져오기"),
        "importWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("허용 목록 페이지 가져오기"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("URL에서 성공적으로 가져왔습니다"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("인앱 구매 활성화됨"),
        "incomingCallInterceptAction":
            MessageLookupByLibrary.simpleMessage("수신 전화 차단 조치"),
        "initializing": MessageLookupByLibrary.simpleMessage("초기화 중..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("데이터베이스 초기화 중..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials":
            MessageLookupByLibrary.simpleMessage("OneDrive 자격 증명 입력"),
        "insurance": MessageLookupByLibrary.simpleMessage("보험"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage("시간 범위 내에서 반복되는 수신 전화 차단"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("잘못된 JSON 형식"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("구독되지 않음"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("구독됨"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "자세한 내용은 Telegram 채널 및 그룹에 가입하세요"),
        "keepOnlyLatestBackup":
            MessageLookupByLibrary.simpleMessage("최신 백업만 유지"),
        "keyword": MessageLookupByLibrary.simpleMessage("키워드"),
        "label": MessageLookupByLibrary.simpleMessage("레이블"),
        "labelIconColor": MessageLookupByLibrary.simpleMessage("레이블 아이콘 색상"),
        "labelPage": MessageLookupByLibrary.simpleMessage("레이블 페이지"),
        "labelpageview": MessageLookupByLibrary.simpleMessage("레이블 페이지 보기"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("레이블 색상"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage("레이블 글꼴 크기"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("레이블 위치"),
        "lastName": MessageLookupByLibrary.simpleMessage("성"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("밝게"),
        "link": MessageLookupByLibrary.simpleMessage("링크"),
        "loading": MessageLookupByLibrary.simpleMessage("로드 중..."),
        "loan": MessageLookupByLibrary.simpleMessage("대출"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "로컬 백업 디렉터리는 다운로드 폴더 아래에만 있습니다"),
        "localCard1": MessageLookupByLibrary.simpleMessage("로컬 카드 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("로컬 카드 1 콘텐츠"),
        "locationColor": MessageLookupByLibrary.simpleMessage("위치 색상"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage("위치 글꼴 크기"),
        "locationIconColor": MessageLookupByLibrary.simpleMessage("위치 아이콘 색상"),
        "locationPosition": MessageLookupByLibrary.simpleMessage("위치 위치"),
        "login": MessageLookupByLibrary.simpleMessage("로그인"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("로그인 실패"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 로그인"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 로그인/로그아웃"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Google 드라이브 로그아웃"),
        "manageRules": MessageLookupByLibrary.simpleMessage("규칙 관리"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("수동 백업"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("표시자"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage("임의의 문자 일치:"),
        "matchFailed": MessageLookupByLibrary.simpleMessage("Match failed!"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage("특정 숫자가 포함된 전화번호 일치:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage("중간에 특정 문자가 있는 전화번호 일치:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("의료"),
        "merge": MessageLookupByLibrary.simpleMessage("병합"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("연락처 병합"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("선택 항목 병합"),
        "message": MessageLookupByLibrary.simpleMessage("메시지"),
        "mins": MessageLookupByLibrary.simpleMessage("분"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("이름"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("이름은 비워둘 수 없습니다"),
        "nameColor": MessageLookupByLibrary.simpleMessage("이름 색상"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage("이름 글꼴 크기"),
        "namePosition": MessageLookupByLibrary.simpleMessage("이름 위치"),
        "next": MessageLookupByLibrary.simpleMessage("다음"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("이미지가 선택되지 않았습니다"),
        "noIncomingSmsMessagesFilter":
            MessageLookupByLibrary.simpleMessage("수신 SMS 메시지 필터 없음"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("확인되지 않음"),
        "notifications": MessageLookupByLibrary.simpleMessage("알림"),
        "numberColor": MessageLookupByLibrary.simpleMessage("번호 색상"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage("번호 글꼴 크기"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("번호 위치"),
        "numberType": MessageLookupByLibrary.simpleMessage("번호 유형"),
        "numberTypeColor": MessageLookupByLibrary.simpleMessage("번호 유형 색상"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("번호 유형 글꼴 크기"),
        "numberTypePosition": MessageLookupByLibrary.simpleMessage("번호 유형 위치"),
        "ok": MessageLookupByLibrary.simpleMessage("확인"),
        "onedriveSetting": MessageLookupByLibrary.simpleMessage("OneDrive 설정"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("온라인 발신자 ID 구독"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification":
            MessageLookupByLibrary.simpleMessage("원래 통화 앱 알림만"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("로컬 알림만 울림"),
        "onlyUseOriginalSmsNotification":
            MessageLookupByLibrary.simpleMessage("원래 SMS 알림만 사용"),
        "openLocalFolder": MessageLookupByLibrary.simpleMessage("로컬 폴더 열기"),
        "other": MessageLookupByLibrary.simpleMessage("기타"),
        "overlay": MessageLookupByLibrary.simpleMessage("오버레이"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "오버레이 권한이 부여되지 않아 발신자 ID 표시 기능에 영향을 줄 수 있습니다. 앱 설정에서 권한을 활성화할 수 있습니다."),
        "page": MessageLookupByLibrary.simpleMessage("페이지"),
        "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("JSON 붙여넣기"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("JSON 구성 붙여넣기"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("여기에 JSON을 붙여넣으세요"),
        "pattern": MessageLookupByLibrary.simpleMessage("패턴"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied": MessageLookupByLibrary.simpleMessage("권한 거부됨"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("권한이 부여되었습니다"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":앱 설정에서 권한을 수동으로 비활성화해야 합니다."),
        "permissionInTheAppSettings":
            MessageLookupByLibrary.simpleMessage("앱 설정에서 권한을 비활성화해야 합니다."),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("권한이 부여되지 않았습니다."),
        "permissions": MessageLookupByLibrary.simpleMessage("권한"),
        "permissionsRequired": MessageLookupByLibrary.simpleMessage("필요한 권한"),
        "phone": MessageLookupByLibrary.simpleMessage("전화"),
        "phoneNumberTypeFixedLine": MessageLookupByLibrary.simpleMessage("유선"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("유선 또는 휴대폰"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("휴대폰"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("호출기"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("개인 번호"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("프리미엄 요금"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("공유 비용"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("수신자 부담"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("음성 메일"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("전화번호"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("입력하세요"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("전화번호를 입력하세요"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterARegexPattern": MessageLookupByLibrary.simpleMessage(
            "Please enter a regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("패턴을 입력하세요"),
        "pleaseEnterAnUrl": MessageLookupByLibrary.simpleMessage("URL을 입력하세요"),
        "pleaseSelectAFileOrInputAUrl":
            MessageLookupByLibrary.simpleMessage("파일을 선택하거나 URL을 입력하세요"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("레이블을 선택하세요"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("내보낼 폴더를 선택하세요"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("출력 파일을 선택하세요:"),
        "pleaseSelectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("내보낼 항목을 선택하세요"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "\"권한 부여\"를 탭하고 다음 화면에서 권한을 허용하세요."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "\"기본 설정\"을 탭하고 다음 화면에서 권한을 허용하세요."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage("데이터베이스 초기화가 완료될 때까지 기다려주세요."),
        "pluginData": MessageLookupByLibrary.simpleMessage("Plugin Data:"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("플러그인 페이지"),
        "plugins": MessageLookupByLibrary.simpleMessage("플러그인"),
        "pluginspageview": MessageLookupByLibrary.simpleMessage("플러그인 페이지 보기"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("정치"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "recordbackup": MessageLookupByLibrary.simpleMessage("RecordBackup"),
        "recruiter": MessageLookupByLibrary.simpleMessage("Recruiter"),
        "regex": MessageLookupByLibrary.simpleMessage("정규식"),
        "regexPage": MessageLookupByLibrary.simpleMessage("정규식 페이지"),
        "regexPattern": MessageLookupByLibrary.simpleMessage("Regex Pattern"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("정규식 패턴 설명"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "정규식 패턴은 전화번호를 일치시키는 데 사용되는 정규식입니다."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview": MessageLookupByLibrary.simpleMessage("정규식 페이지 보기"),
        "region": MessageLookupByLibrary.simpleMessage("지역:"),
        "reject": MessageLookupByLibrary.simpleMessage("거부"),
        "rejectAllNumbers": MessageLookupByLibrary.simpleMessage("모든 번호 거부"),
        "remove": MessageLookupByLibrary.simpleMessage("제거"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup":
            MessageLookupByLibrary.simpleMessage("광고 제거 및 온라인 백업 활성화"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage("허용 목록에서 제거"),
        "removeAllowedtype": m4,
        "removeBlocked": MessageLookupByLibrary.simpleMessage("차단 목록에서 제거"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("반복 차단된 통화(분):"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("반복 통화"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Google 드라이브에서 복원"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage("로컬에서 복원"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("OneDrive에서 복원"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("WebDAV에서 복원"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("차량 공유"),
        "risk": MessageLookupByLibrary.simpleMessage("위험"),
        "robocall": MessageLookupByLibrary.simpleMessage("로보콜"),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts": MessageLookupByLibrary.simpleMessage("연락처 검색"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("항목 검색"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("레이블 선택:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("모두 선택"),
        "selectColor": MessageLookupByLibrary.simpleMessage("색상 선택"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("국가 코드 선택(선택 사항)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("항목 선택"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("내보낼 항목 선택"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage("선택한 연락처를 성공적으로 병합했습니다"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("선택된 레이블"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("내보낼 폴더 선택 중"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays":
            MessageLookupByLibrary.simpleMessage("서비스 업데이트 간격(일)"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "settingsSaved": MessageLookupByLibrary.simpleMessage("설정이 저장되었습니다"),
        "setupDefault": MessageLookupByLibrary.simpleMessage("기본 설정"),
        "setupDefaultCallerIdApp":
            MessageLookupByLibrary.simpleMessage("기본 발신자 ID 앱 설정"),
        "sharing": MessageLookupByLibrary.simpleMessage("공유"),
        "showContactButton": MessageLookupByLibrary.simpleMessage("연락처 버튼 표시"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("연락처 아이콘 버튼 표시"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("Telegram 표시"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp 표시"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("다음에 대한 결과 표시:"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer": MessageLookupByLibrary.simpleMessage("무음 무응답"),
        "silentCallvoiceClone":
            MessageLookupByLibrary.simpleMessage("Silent Call(Voice Clone?)"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("SIM 카드 색상"),
        "simCardFontSize": MessageLookupByLibrary.simpleMessage("SIM 카드 글꼴 크기"),
        "simCardPosition": MessageLookupByLibrary.simpleMessage("SIM 카드 위치"),
        "skip": MessageLookupByLibrary.simpleMessage("건너뛰기"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMS 차단 목록 페이지"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("SMS 필터링"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "SMS 필터링에는 SMS, 알림 및 전화 권한이 필요합니다. 이 기능을 활성화하려면 이러한 권한을 부여하세요."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("SMS 로컬 알림"),
        "smsNotification": MessageLookupByLibrary.simpleMessage("SMS 알림"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS 구독 페이지"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 허용 목록 페이지"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview":
            MessageLookupByLibrary.simpleMessage("SMS 차단 목록 페이지 보기"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("SMS 구독 목록 보기"),
        "smstextblacklistpageview":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 차단 목록 페이지 보기"),
        "smstextwhitelistpageview":
            MessageLookupByLibrary.simpleMessage("SMS 텍스트 허용 목록 페이지 보기"),
        "smswhitelistpageview":
            MessageLookupByLibrary.simpleMessage("SMS 허용 목록 페이지 보기"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("스팸 가능성 높음"),
        "startColor": MessageLookupByLibrary.simpleMessage("시작 색상"),
        "statisticsTimeRangeMinutes":
            MessageLookupByLibrary.simpleMessage("통계 시간 범위(분):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("STIR 색상"),
        "stirFontSize": MessageLookupByLibrary.simpleMessage("STIR 글꼴 크기"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("STIR 위치"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("저장용량"),
        "subscribe": MessageLookupByLibrary.simpleMessage("구독"),
        "subscribed": MessageLookupByLibrary.simpleMessage("구독됨"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("구독된 링크"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("구독 목록 페이지"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("구독 목록 보기"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("성공적으로"),
        "survey": MessageLookupByLibrary.simpleMessage("설문 조사"),
        "sync": MessageLookupByLibrary.simpleMessage("동기화"),
        "system": MessageLookupByLibrary.simpleMessage("시스템"),
        "takeaway": MessageLookupByLibrary.simpleMessage("테이크아웃"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("텔레마케팅"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("테스트"),
        "testCallerIdOverlay":
            MessageLookupByLibrary.simpleMessage("Test Caller ID Overlay"),
        "textLabelColors": MessageLookupByLibrary.simpleMessage("텍스트 및 레이블 색상"),
        "textType": MessageLookupByLibrary.simpleMessage("텍스트 유형"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "이 앱은 알 수 없는 발신자를 식별하고 원치 않는 전화를 차단할 수 있는 강력한 발신자 ID 도구입니다. 다음과 같은 기능을 제공합니다."),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "이 앱이 제대로 작동하려면 통화 기록 정보에 액세스해야 합니다. 권한을 부여하세요."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "이 권한은 앱이 기본 발신자 ID 앱이 되는 데 필요합니다."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "이 권한은 앱이 다른 앱 위에 중요한 정보를 표시하는 데 필요합니다.\\n\\n"),
        "toTestRules": MessageLookupByLibrary.simpleMessage("To test rules"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("튜토리얼"),
        "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("구독 취소됨"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("URL 형식이 잘못되었습니다"),
        "useNetworkImage": MessageLookupByLibrary.simpleMessage("네트워크 이미지 사용"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "임의의 단일 문자를 일치시키려면 \'.\' 문자를 사용하세요. 예를 들어 \'123.456\' 패턴은 \'123-456\', \'123.456\', \'123a456\' 등과 일치합니다."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "\'0\'으로 시작하고 2~3자리 숫자가 뒤따르는 전화번호를 일치시키려면 \'^0[0-9]{2,3}\' 패턴을 사용하세요. 일반적으로 지역 번호를 나타냅니다.\n베이징 지역 번호(010)에서 걸려오는 전화를 차단하려면 \'^010\' 패턴을 사용하세요.\n워싱턴 지역 번호(202)에서 걸려오는 전화를 차단하려면 \'^202\' 패턴을 사용하세요.\n\'^0[0-9]{2,3}\' 지역 번호를 차단하려는 특정 지역 번호로 바꾸세요."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "\'XXX-XXXX-XXXX\' 형식의 전화번호를 일치시키려면 \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' 패턴을 사용하세요. \'X\'를 일치시키려는 특정 숫자로 바꾸세요."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "플러스 기호로 시작하는 모든 전화번호를 일치시키려면 \'^\\+\' 패턴을 사용하세요. 일반적으로 국제 번호를 나타냅니다."),
        "userName": MessageLookupByLibrary.simpleMessage("사용자 이름"),
        "verificationPageRules":
            MessageLookupByLibrary.simpleMessage("Verification Page (Rules)"),
        "verificationResultsRules": MessageLookupByLibrary.simpleMessage(
            "Verification Results (shouldAcceptCall Rules):"),
        "verified": MessageLookupByLibrary.simpleMessage("확인됨"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Verify Phone Number"),
        "video": MessageLookupByLibrary.simpleMessage("비디오"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("WebDAV 설정"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
        "website": MessageLookupByLibrary.simpleMessage("웹사이트"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("허용 목록"),
        "whitelistPage": MessageLookupByLibrary.simpleMessage("허용 목록 페이지"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("허용 목록 페이지 보기"),
        "width": MessageLookupByLibrary.simpleMessage("너비"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage("유연한 필터링을 위한 와일드카드 지원"),
        "windowSize": MessageLookupByLibrary.simpleMessage("창 크기"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "표준 정규식 구문을 사용하여 패턴을 정의하거나 AI에게 Flutter용 패턴 생성을 요청할 수 있습니다. "),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "권한이 거부되었습니다. 설정에서 수동으로 권한을 활성화할 수 있습니다."),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("권한을 활성화했습니다."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("수동으로 비활성화해야 합니다."),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
