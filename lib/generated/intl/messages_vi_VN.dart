// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi_VN locale. All the
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
  String get localeName => 'vi_VN';

  static String m0(permissionName) =>
      "Quyền ${permissionName} đã không được cấp.";

  static String m1(listType) => "Thêm vào ${listType}";

  static String m2(listType) => "Thêm vào ${listType}";

  static String m3(permissionName) =>
      "Bạn cần tắt thủ công quyền ${permissionName} trong cài đặt ứng dụng.";

  static String m4(listType) => "Xóa ${listType}";

  static String m5(listType) => "Xóa ${listType}";

  static String m6(permissionName) =>
      "Bạn cần tắt thủ công quyền ${permissionName} trong cài đặt ứng dụng.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("Giới thiệu"),
        "accept": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Đã bật quảng cáo:"),
        "add": MessageLookupByLibrary.simpleMessage("Thêm vào"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Thêm trang mục nhập được phép"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang danh sách đen"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang bị chặn"),
        "addContact": MessageLookupByLibrary.simpleMessage("Thêm liên hệ"),
        "addContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang đăng ký liên hệ"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage("Thêm trang nhãn"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang plugin"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang Regex"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Thêm trang danh sách đen SMS"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang đăng ký SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Thêm trang danh sách đen văn bản SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Thêm trang danh sách trắng văn bản SMS"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Thêm trang danh sách trắng SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang đăng ký"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage(
            "Thêm vào danh sách được phép"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Thêm vào danh sách bị chặn"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("Thêm vào nhãn"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Thêm trang danh sách trắng"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("đã thêm thành công"),
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Cho phép tất cả các số được phép"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Cho phép tất cả các số trong danh sách đen"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Cho phép tất cả các số trong danh sách trắng"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("Cho phép các số bị chặn"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Cho phép các mẫu danh sách đen Regex"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Cho phép các mẫu danh sách trắng Regex"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Cho phép cuộc gọi đến lặp lại"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Cho phép ứng dụng này hiển thị ID người gọi"),
        "allowed": MessageLookupByLibrary.simpleMessage("Được phép"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Trang mục nhập được phép"),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("Chế độ xem trang được phép"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Trả lời rồi cúp máy"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Bạn có chắc chắn muốn xóa mục này không"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Bạn có chắc chắn muốn xóa liên hệ này không?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Tự động đóng thông báo cục bộ"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("Đã tắt tự động cập nhật"),
        "autoUpdateEnabled":
            MessageLookupByLibrary.simpleMessage("Đã bật tự động cập nhật"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes": MessageLookupByLibrary.simpleMessage(
            "Kích thước Avatar và Biểu tượng"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Màu viền Avatar"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Kích thước viền Avatar"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("Vị trí Avatar"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Kích thước Avatar"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("URL hoặc đường dẫn Avatar"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Gradient nền"),
        "backup": MessageLookupByLibrary.simpleMessage("Sao lưu"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Sao lưu và khôi phục"),
        "bank": MessageLookupByLibrary.simpleMessage("Ngân hàng"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Tối ưu hóa pin"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Danh sách đen"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Trang danh sách đen"),
        "blacklistingAndWhitelisting": MessageLookupByLibrary.simpleMessage(
            "Danh sách đen và danh sách trắng"),
        "blacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách đen"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Chặn cuộc gọi từ mã vùng cụ thể:"),
        "blockInternationalCalls":
            MessageLookupByLibrary.simpleMessage("Chặn cuộc gọi quốc tế:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bị chặn"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("Hành động cuộc gọi bị chặn"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("Thông báo cuộc gọi bị chặn"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("Thống kê cuộc gọi bị chặn"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("Trang bị chặn"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("Chế độ xem trang bị chặn"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Cả ứng dụng gọi gốc & thông báo cục bộ"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Cả SMS gốc & thông báo cục bộ"),
        "call": MessageLookupByLibrary.simpleMessage("Cuộc gọi"),
        "callHistory": MessageLookupByLibrary.simpleMessage("Lịch sử cuộc gọi"),
        "callLog": MessageLookupByLibrary.simpleMessage("Nhật ký cuộc gọi"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Quyền truy cập nhật ký cuộc gọi bị từ chối"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Yêu cầu vai trò sàng lọc cuộc gọi không thành công!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Yêu cầu vai trò sàng lọc cuộc gọi thành công!"),
        "callerIdApp":
            MessageLookupByLibrary.simpleMessage("Ứng dụng ID người gọi"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Kiểu ID người gọi"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("nội dung kiểu ID người gọi"),
        "calltypeIconColor": MessageLookupByLibrary.simpleMessage(
            "Màu biểu tượng loại cuộc gọi"),
        "cancel": MessageLookupByLibrary.simpleMessage("hủy bỏ"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Nhà mạng:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("Màu nhà mạng"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ nhà mạng"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Vị trí nhà mạng"),
        "charity": MessageLookupByLibrary.simpleMessage("Từ thiện"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Chọn Avatar (Cục bộ hoặc Mạng):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Chọn từ thư viện"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("Chỉ chọn liên kết hoặc tệp"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Chọn hành động chặn mặc định"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Chọn ngôn ngữ của bạn"),
        "clientId": MessageLookupByLibrary.simpleMessage("ID khách hàng"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("Tên thư mục sao lưu đám mây"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Sao lưu đám mây yêu cầu tự động sao lưu"),
        "cloudServices":
            MessageLookupByLibrary.simpleMessage("Dịch vụ đám mây"),
        "collection": MessageLookupByLibrary.simpleMessage("Thu thập"),
        "configurationExportedToFile":
            MessageLookupByLibrary.simpleMessage("Đã xuất cấu hình sang tệp!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Đã nhập cấu hình"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Đã nhập cấu hình thành công"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Đã lưu cấu hình!"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("Xác nhận xóa"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Tệp liên hệ"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Trang đăng ký liên hệ"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Liên hệ chúng tôi"),
        "contacts": MessageLookupByLibrary.simpleMessage("Danh bạ"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Đã xuất danh bạ thành công"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Đã nhập danh bạ thành công"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("Trang danh bạ"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("danh bạ có số"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Danh sách đăng ký liên hệ"),
        "countColor": MessageLookupByLibrary.simpleMessage("Màu số lượng"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ số lượng"),
        "countPosition":
            MessageLookupByLibrary.simpleMessage("Vị trí số lượng"),
        "country": MessageLookupByLibrary.simpleMessage("Quốc gia:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Màu tên quốc gia"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ tên quốc gia"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Vị trí tên quốc gia"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Cắt Avatar"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Dịch vụ khách hàng"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Tùy chỉnh ID người gọi"),
        "dark": MessageLookupByLibrary.simpleMessage("Tối"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Chế độ tối"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("Xóa liên hệ"),
        "deleted": MessageLookupByLibrary.simpleMessage("Đã xóa"),
        "delivery": MessageLookupByLibrary.simpleMessage("Giao hàng"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Bạn đã từ chối quyền. Bạn có thể bật thủ công quyền trong Cài đặt."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Tắt thông báo cuộc gọi bị chặn"),
        "disablePermission": MessageLookupByLibrary.simpleMessage("Tắt quyền"),
        "disableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Tắt thông báo SMS cục bộ"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Tắt ứng dụng này hiển thị ID người gọi"),
        "disabled": MessageLookupByLibrary.simpleMessage("Đã tắt"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("Thương mại điện tử"),
        "edit": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("Chỉnh sửa Avatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Chỉnh sửa mã"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa liên hệ"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa mã plugin"),
        "education": MessageLookupByLibrary.simpleMessage("Giáo dục"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Vị trí phần tử"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Bật thông báo cuộc gọi bị chặn"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Bật chế độ tối dựa trên thời gian"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("Bật quyền lớp phủ"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Bật thông báo SMS cục bộ"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("Bật để xóa quảng cáo"),
        "enabled": MessageLookupByLibrary.simpleMessage("Đã bật"),
        "endColor": MessageLookupByLibrary.simpleMessage("Màu kết thúc"),
        "endcall": MessageLookupByLibrary.simpleMessage("Kết thúc cuộc gọi"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Nhập URL hình ảnh"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("Nhập mã plugin vào đây"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Nhập URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Mục nhập"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("đã thêm mục nhập thành công"),
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("Lỗi khi xuất danh bạ:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Lỗi khi nhận trạng thái quyền"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("Lỗi khi nhập"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Lỗi khi yêu cầu vai trò sàng lọc cuộc gọi:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Xuất khẩu"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Xuất trang mục nhập được phép"),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Xuất dưới dạng CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Xuất dưới dạng JSON"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Xuất dưới dạng VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Xuất dưới dạng YAML"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang danh sách đen"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang bị chặn"),
        "exportContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang đăng ký liên hệ"),
        "exportContacts": MessageLookupByLibrary.simpleMessage("Xuất danh bạ"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Xuất không thành công"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("định dạng xuất:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang nhãn"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang plugin"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang Regex"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Xuất trang danh sách đen SMS"),
        "exportSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang đăng ký SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Xuất trang danh sách đen văn bản SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Xuất trang danh sách trắng văn bản SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Xuất trang danh sách trắng SMS"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang đăng ký"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Xuất thành công"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Xuất trang danh sách trắng"),
        "failed": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("Không thể thêm:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("Không thể thêm mục nhập:"),
        "feature": MessageLookupByLibrary.simpleMessage("Tính năng"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("mô tả tính năng"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("Lọc tin nhắn SMS đến"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("Lọc cuộc gọi đến lặp lại"),
        "financial": MessageLookupByLibrary.simpleMessage("Tài chính"),
        "firstName": MessageLookupByLibrary.simpleMessage("Tên"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Có thể là lừa đảo"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập Google Drive không thành công"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập Google Drive thành công"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Cài đặt Google Drive"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("Cấp quyền"),
        "group": MessageLookupByLibrary.simpleMessage("Nhóm"),
        "height": MessageLookupByLibrary.simpleMessage("Chiều cao"),
        "history": MessageLookupByLibrary.simpleMessage("Lịch sử"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize":
            MessageLookupByLibrary.simpleMessage("Kích thước biểu tượng"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Nhập khẩu"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Nhập trang mục nhập được phép"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang danh sách đen"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang mục nhập bị chặn"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Nhập Cấu hình"),
        "importContacts": MessageLookupByLibrary.simpleMessage("Nhập danh bạ"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("Nhập từ CSV"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("Nhập từ tệp"),
        "importFromJson": MessageLookupByLibrary.simpleMessage("Nhập từ JSON"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("Nhập từ URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("Nhập từ VCF"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage("Nhập từ YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang nhãn"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang plugin"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang Regex"),
        "importSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang đăng ký SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Nhập trang danh sách đen văn bản SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Nhập trang danh sách trắng văn bản SMS"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang đăng ký"),
        "importWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Nhập trang danh sách trắng"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("Đã nhập thành công từ URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled": MessageLookupByLibrary.simpleMessage(
            "Đã bật mua hàng trong ứng dụng"),
        "incomingCallInterceptAction":
            MessageLookupByLibrary.simpleMessage("Hành động chặn cuộc gọi đến"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Đang khởi tạo..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Đang khởi tạo cơ sở dữ liệu..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Nhập thông tin đăng nhập OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Bảo hiểm"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Chặn các cuộc gọi đến lặp lại trong phạm vi thời gian"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Định dạng JSON không hợp lệ"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("chưa đăng ký"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("đã đăng ký"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Tham gia Kênh và Nhóm Telegram để biết thêm Thông tin"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Chỉ giữ bản sao lưu mới nhất"),
        "keyword": MessageLookupByLibrary.simpleMessage("Từ khóa"),
        "label": MessageLookupByLibrary.simpleMessage("Nhãn"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Màu biểu tượng nhãn"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Trang nhãn"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Chế độ xem trang nhãn"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Màu nhãn"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage("Cỡ chữ nhãn"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("Vị trí nhãn"),
        "lastName": MessageLookupByLibrary.simpleMessage("Họ"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Sáng"),
        "link": MessageLookupByLibrary.simpleMessage("Liên kết"),
        "loading": MessageLookupByLibrary.simpleMessage("Đang tải..."),
        "loan": MessageLookupByLibrary.simpleMessage("Khoản vay"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Thư mục sao lưu cục bộ chỉ nằm trong thư mục Tải xuống"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Thẻ cục bộ 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("nội dung thẻ cục bộ 1"),
        "locationColor": MessageLookupByLibrary.simpleMessage("Màu vị trí"),
        "locationFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ vị trí"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Màu biểu tượng vị trí"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Vị trí vị trí"),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thất bại"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Đăng nhập Google Drive"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập/Đăng xuất Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Đăng xuất Google Drive"),
        "manageRules": MessageLookupByLibrary.simpleMessage("Quản lý quy tắc"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("Sao lưu thủ công"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Được đánh dấu bởi"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("Khớp với bất kỳ ký tự nào:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Khớp với số điện thoại chứa chữ số cụ thể:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Khớp với số điện thoại có ký tự cụ thể ở giữa:"),
        "medical": MessageLookupByLibrary.simpleMessage("Y tế"),
        "merge": MessageLookupByLibrary.simpleMessage("Hợp nhất"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Hợp nhất danh bạ"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Hợp nhất đã chọn"),
        "message": MessageLookupByLibrary.simpleMessage("Tin nhắn"),
        "mins": MessageLookupByLibrary.simpleMessage("phút"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Tên"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Tên không được để trống"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Màu tên"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage("Cỡ chữ tên"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Vị trí tên"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp theo"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected": MessageLookupByLibrary.simpleMessage(
            "Không có hình ảnh nào được chọn"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Không có bộ lọc tin nhắn SMS đến"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Chưa xác minh"),
        "notifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Màu số"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage("Cỡ chữ số"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("Vị trí số"),
        "numberType": MessageLookupByLibrary.simpleMessage("Loại số"),
        "numberTypeColor": MessageLookupByLibrary.simpleMessage("Màu loại số"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ loại số"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Vị trí loại số"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Cài đặt OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Đăng ký ID người gọi trực tuyến"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Chỉ thông báo ứng dụng gọi gốc"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Chỉ đổ chuông thông báo cục bộ"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Chỉ sử dụng thông báo SMS gốc"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Mở thư mục cục bộ"),
        "other": MessageLookupByLibrary.simpleMessage("Khác"),
        "overlay": MessageLookupByLibrary.simpleMessage("Lớp phủ"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Quyền lớp phủ không được cấp, điều này có thể ảnh hưởng đến chức năng hiển thị ID người gọi. Bạn có thể bật quyền trong cài đặt ứng dụng."),
        "page": MessageLookupByLibrary.simpleMessage("Trang"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Dán JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Dán Cấu hình JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Dán JSON vào đây"),
        "pattern": MessageLookupByLibrary.simpleMessage("Mẫu"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Quyền bị từ chối"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Đã cấp quyền"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Bạn cần tắt thủ công quyền trong cài đặt ứng dụng."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "quyền trong cài đặt ứng dụng."),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("quyền đã không được cấp."),
        "permissions": MessageLookupByLibrary.simpleMessage("Quyền"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Quyền bắt buộc"),
        "phone": MessageLookupByLibrary.simpleMessage("Điện thoại"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Điện thoại cố định"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Điện thoại cố định,Di động"),
        "phoneNumberTypeMobile":
            MessageLookupByLibrary.simpleMessage("Di động"),
        "phoneNumberTypePager":
            MessageLookupByLibrary.simpleMessage("Máy nhắn tin"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Số cá nhân"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Cao cấp"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Chia sẻ chi phí"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Miễn phí"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Thư thoại"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("Vui lòng nhập"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Vui lòng nhập số điện thoại"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Vui lòng nhập một mẫu"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Vui lòng nhập một url"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn một tệp hoặc nhập URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("Vui lòng chọn một nhãn"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn một thư mục xuất"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("Vui lòng chọn tệp đầu ra:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn mục nhập để xuất"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng nhấn \"Cấp quyền\" và cho phép quyền trong màn hình tiếp theo."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng nhấn \"Thiết lập mặc định\" và cho phép quyền trong màn hình tiếp theo."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng đợi quá trình khởi tạo cơ sở dữ liệu hoàn tất."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Trang plugin"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugin"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Chế độ xem trang plugin"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Chính trị"),
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
        "regex": MessageLookupByLibrary.simpleMessage("Regex"),
        "regexPage": MessageLookupByLibrary.simpleMessage("Trang Regex"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Giải thích mẫu Regex"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Các mẫu Regex là các biểu thức chính quy được sử dụng để khớp với số điện thoại."),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("Chế độ xem trang Regex"),
        "region": MessageLookupByLibrary.simpleMessage("Khu vực:"),
        "reject": MessageLookupByLibrary.simpleMessage("Từ chối"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Từ chối tất cả các số"),
        "remove": MessageLookupByLibrary.simpleMessage("Xóa bỏ"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Xóa quảng cáo và bật sao lưu trực tuyến"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage(
            "Xóa khỏi danh sách được phép"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Xóa khỏi danh sách bị chặn"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Cuộc gọi bị chặn lặp lại trong"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Cuộc gọi lặp lại"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Khôi phục từ Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Khôi phục từ cục bộ"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Khôi phục từ OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Khôi phục từ WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing":
            MessageLookupByLibrary.simpleMessage("Chia sẻ chuyến đi"),
        "risk": MessageLookupByLibrary.simpleMessage("Rủi ro"),
        "robocall": MessageLookupByLibrary.simpleMessage("Cuộc gọi tự động"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm danh bạ"),
        "searchEntries":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm mục nhập"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("Chọn một nhãn:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Chọn tất cả"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Chọn màu"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("Chọn mã quốc gia (Tùy chọn)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("Chọn mục nhập"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("Chọn mục nhập để xuất"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Đã hợp nhất thành công các liên hệ đã chọn"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("Nhãn đã chọn"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("chọn thư mục xuất"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Khoảng thời gian cập nhật dịch vụ (ngày)"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "settingsSaved": MessageLookupByLibrary.simpleMessage("Đã lưu cài đặt"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Thiết lập mặc định"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Thiết lập ứng dụng ID người gọi mặc định"),
        "sharing": MessageLookupByLibrary.simpleMessage("Chia sẻ"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Hiển thị nút liên hệ"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Hiển thị nút biểu tượng liên hệ"),
        "showTelegram":
            MessageLookupByLibrary.simpleMessage("Hiển thị Telegram"),
        "showWhatsapp":
            MessageLookupByLibrary.simpleMessage("Hiển thị WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Hiển thị kết quả cho"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Im lặng không trả lời"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("Màu thẻ SIM"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ thẻ SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Vị trí thẻ SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Trang danh sách đen SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("Lọc SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Lọc SMS yêu cầu quyền SMS, thông báo và điện thoại. Vui lòng cấp các quyền này để bật tính năng này."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Thông báo SMS cục bộ"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("Thông báo SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Trang đăng ký SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Trang danh sách trắng văn bản SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách đen SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Danh sách đăng ký SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách đen văn bản SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách trắng văn bản SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách trắng SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("Có thể là thư rác"),
        "startColor": MessageLookupByLibrary.simpleMessage("Màu bắt đầu"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Phạm vi thời gian thống kê (phút):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Màu STIR"),
        "stirFontSize": MessageLookupByLibrary.simpleMessage("Cỡ chữ STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Vị trí STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Lưu trữ"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Đã đăng ký"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Liên kết đã đăng ký"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Trang danh sách đăng ký"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Danh sách đăng ký"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successfully": MessageLookupByLibrary.simpleMessage("thành công"),
        "survey": MessageLookupByLibrary.simpleMessage("Khảo sát"),
        "sync": MessageLookupByLibrary.simpleMessage("Đồng bộ hóa"),
        "system": MessageLookupByLibrary.simpleMessage("Hệ thống"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Mang đi"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing":
            MessageLookupByLibrary.simpleMessage("Tiếp thị qua điện thoại"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Kiểm tra"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Màu văn bản & nhãn"),
        "textType": MessageLookupByLibrary.simpleMessage("Loại văn bản"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Ứng dụng này là một công cụ ID người gọi mạnh mẽ cho phép bạn xác định người gọi không xác định và chặn các cuộc gọi không mong muốn. Nó có các tính năng:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Ứng dụng này cần truy cập thông tin nhật ký cuộc gọi của bạn để hoạt động bình thường. Vui lòng cấp quyền."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Quyền này là bắt buộc để ứng dụng của chúng tôi trở thành ứng dụng ID người gọi mặc định."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Quyền này là bắt buộc để ứng dụng của chúng tôi hiển thị thông tin quan trọng trên các ứng dụng khác. \\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Hướng dẫn"),
        "unknown": MessageLookupByLibrary.simpleMessage("Không xác định"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Đã hủy đăng ký"),
        "url": MessageLookupByLibrary.simpleMessage("Url"),
        "urlFormatIsIncorrect": MessageLookupByLibrary.simpleMessage(
            "Định dạng URL không chính xác"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Sử dụng hình ảnh mạng"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Sử dụng ký tự \'.\' để khớp với bất kỳ ký tự đơn nào. Ví dụ: mẫu \'123.456\' khớp với \'123-456\', \'123.456\', \'123a456\', v.v."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Sử dụng mẫu \'^0[0-9]{2,3}\' để khớp với số điện thoại bắt đầu bằng \'0\' theo sau là 2 hoặc 3 chữ số, thường đại diện cho mã vùng. \nSử dụng mẫu \'^010\' để chặn cuộc gọi từ mã vùng Bắc Kinh (010). \nSử dụng mẫu \'^202\' để chặn cuộc gọi từ mã vùng Washington (202). \nThay thế mã vùng \'^0[0-9]{2,3}\' bằng mã cụ thể bạn muốn chặn."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Sử dụng mẫu \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' để khớp với số điện thoại ở định dạng \'XXX-XXXX-XXXX\'. Thay thế \'X\' bằng các chữ số cụ thể bạn muốn khớp."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Sử dụng mẫu \'^\\+\' để khớp với tất cả các số điện thoại bắt đầu bằng dấu cộng, thường cho biết số quốc tế."),
        "userName": MessageLookupByLibrary.simpleMessage("Tên người dùng"),
        "verified": MessageLookupByLibrary.simpleMessage("Đã xác minh"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Cài đặt WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Trang web"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Danh sách trắng"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Trang danh sách trắng"),
        "whitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Chế độ xem trang danh sách trắng"),
        "width": MessageLookupByLibrary.simpleMessage("Chiều rộng"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Hỗ trợ ký tự đại diện để lọc linh hoạt"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Kích thước cửa sổ"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Bạn có thể sử dụng cú pháp biểu thức chính quy tiêu chuẩn để xác định các mẫu, hoặc yêu cầu AI tạo mẫu cho Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Bạn đã từ chối quyền. Bạn có thể bật thủ công quyền trong Cài đặt."),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("Bạn đã bật quyền."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("Bạn cần tắt thủ công"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
