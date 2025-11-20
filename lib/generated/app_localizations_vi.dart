// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get aboutContactSubscription => 'Giới thiệu Đăng ký Danh bạ';

  @override
  String get aboutLabels => 'Giới thiệu Nhãn';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Giới thiệu Quy tắc Đăng ký Điện thoại';

  @override
  String get aboutPhoneSubscriptions => 'Giới thiệu Đăng ký Điện thoại';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Đăng ký danh sách quy tắc điện thoại qua URL, tự động cập nhật quy tắc. Hỗ trợ tệp quy tắc định dạng JSON, CSV.';

  @override
  String get aboutSmsFilter => 'Giới thiệu Lọc SMS';

  @override
  String get aboutSmsSubscriptionRules => 'Giới thiệu Quy tắc Đăng ký SMS';

  @override
  String get aboutSubtitle => 'Phiên bản ứng dụng và thông tin pháp lý';

  @override
  String get aboutTitle => 'Giới thiệu';

  @override
  String get action => 'Hành động';

  @override
  String get actionAll => 'Tất cả';

  @override
  String get actionAllow => 'Cho phép';

  @override
  String get actionBlock => 'Chặn';

  @override
  String get actionFilterAll => 'Tất cả Bộ lọc';

  @override
  String get actionFilterTitle => 'Lọc theo Loại Hành động';

  @override
  String get actionFilterTooltip => 'Bộ lọc Hành động';

  @override
  String get actionNone => 'Không Hành động';

  @override
  String get actionSilence => 'Im lặng';

  @override
  String actionTag(Object actionType) {
    return 'Hành động: $actionType';
  }

  @override
  String get actionType => 'Loại Hành động';

  @override
  String get actionUnknown => 'Không xác định';

  @override
  String get add => 'Thêm';

  @override
  String get addAllowedBlockedRule => 'Thêm Quy tắc Cho phép/Chặn';

  @override
  String get addAllowSubscription => 'Thêm Đăng ký Cho phép';

  @override
  String get addBlockSubscription => 'Thêm Đăng ký Chặn';

  @override
  String get addContactButton => 'Thêm Danh bạ';

  @override
  String addContactFailed(Object error) {
    return 'Thêm danh bạ thất bại: $error';
  }

  @override
  String get addedToAllowedRules => 'Đã thêm vào Quy tắc Cho phép';

  @override
  String get addedToBlacklist => 'Đã thêm vào Danh sách chặn';

  @override
  String get addedToBlockedRules => 'Đã thêm vào Quy tắc Chặn';

  @override
  String get addedToFavoriteContacts => 'Đã thêm vào danh bạ yêu thích';

  @override
  String get addedToFavorites => 'Đã thêm vào danh bạ yêu thích';

  @override
  String get addedToWhitelist => 'Đã thêm vào Danh sách cho phép';

  @override
  String get addFavorite => 'Thêm Yêu thích';

  @override
  String get addFilter => 'Thêm Bộ lọc';

  @override
  String get addLabel => 'Thêm Nhãn';

  @override
  String get addLabelButton => 'Thêm Nhãn';

  @override
  String addLabelFailed(Object error) {
    return 'Thêm nhãn thất bại: $error';
  }

  @override
  String get addLabelToCall => 'Thêm Nhãn vào Bản ghi Cuộc gọi';

  @override
  String get addName => 'Thêm Tên';

  @override
  String get addNoneSubscription => 'Thêm Đăng ký Không hành động';

  @override
  String get addOrEditContactInfo =>
      'Dùng để thêm hoặc chỉnh sửa thông tin liên hệ';

  @override
  String get addPhoneMark => 'Thêm Nhãn điện thoại';

  @override
  String get addPhoneNumberRule => 'Thêm Quy tắc Số điện thoại';

  @override
  String get addPlugin => 'Thêm Plugin';

  @override
  String get addPluginFailed => 'Thêm plugin thất bại';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Thêm plugin thất bại: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Thêm Plugin từ Tệp cục bộ';

  @override
  String get addPluginFromUrl => 'Thêm Plugin từ URL';

  @override
  String get addRegexRule => 'Thêm Quy tắc Regex';

  @override
  String get addRule => 'Thêm Quy tắc';

  @override
  String get addRuleButton => 'Thêm Quy tắc';

  @override
  String addRuleFailed(Object error) {
    return 'Thêm quy tắc thất bại: $error';
  }

  @override
  String get addRuleTooltip => 'Thêm Quy tắc';

  @override
  String get addSilenceSubscription => 'Thêm Đăng ký Im lặng';

  @override
  String get addSimRuleButton => 'Thêm Quy tắc SIM';

  @override
  String get addSmsFilterRule => 'Thêm Quy tắc Lọc SMS';

  @override
  String get addSmsRule => 'Thêm Quy tắc SMS';

  @override
  String get addSmsSubscription => 'Thêm Đăng ký SMS';

  @override
  String get addSubscription => 'Thêm Đăng ký';

  @override
  String get addSubscriptionButton => 'Thêm Đăng ký';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Thêm đăng ký thất bại: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Thêm Đăng ký';

  @override
  String get addToAllowedRules => 'Thêm vào Quy tắc Cho phép';

  @override
  String get addToBlacklist => 'Thêm vào Danh sách chặn';

  @override
  String get addToBlockedRules => 'Thêm vào Quy tắc Chặn';

  @override
  String get addToFavoriteContacts => 'Thêm vào Danh bạ Yêu thích';

  @override
  String get addToFavorites => 'Thêm vào Mục Yêu thích';

  @override
  String get addToRules => 'Thêm vào Quy tắc';

  @override
  String get addToWhitelist => 'Thêm vào Danh sách cho phép';

  @override
  String get adPlaceholder => 'Vị trí Quảng cáo';

  @override
  String get agent => 'Tác nhân';

  @override
  String get all => 'Tất cả';

  @override
  String get allCallsTab => 'Tất cả';

  @override
  String get allDataClearedSuccessfully => 'Xóa tất cả dữ liệu thành công';

  @override
  String get allow => 'Cho phép';

  @override
  String get allowAllAllowRules => 'Cho phép Tất cả Quy tắc Cho phép';

  @override
  String get allowAllAllowRulesDesc =>
      'Cho phép các cuộc gọi từ quy tắc cho phép';

  @override
  String get allowAllBlacklistedNumbers =>
      'Cho phép Tất cả Số điện thoại trong Danh sách chặn';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Cho phép các cuộc gọi từ danh sách chặn';

  @override
  String get allowAllBlockRules => 'Cho phép Tất cả Quy tắc Chặn';

  @override
  String get allowAllBlockRulesDesc => 'Cho phép các cuộc gọi từ quy tắc chặn';

  @override
  String get allowAllowedNumbers => 'Cho phép các số đã cho phép';

  @override
  String get allowAllowedNumbersDesc =>
      'Cho phép các cuộc gọi từ danh sách cho phép';

  @override
  String get allowBlock => 'Cho phép/Chặn';

  @override
  String get allowBlockedNumbers => 'Cho phép Số điện thoại đã chặn';

  @override
  String get allowBlockedNumbersDesc =>
      'Cho phép các cuộc gọi từ danh sách chặn';

  @override
  String get allowedBlockedRule => 'Quy tắc Cho phép/Chặn';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Chỉnh sửa Quy tắc Cho phép/Chặn';

  @override
  String get allowedBlockedRuleManagement => 'Quản lý Quy tắc Cho phép/Chặn';

  @override
  String get allowNonExceededNumbers => 'Cho phép Số không vượt quá giới hạn';

  @override
  String get allowNonExceededNumbersDescription =>
      'Tự động cho phép các số không vượt quá ngưỡng số lượng';

  @override
  String get allowRegexAllowRules => 'Cho phép Quy tắc Cho phép Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'Bật đối sánh mẫu regex cho quy tắc cho phép';

  @override
  String get allowRegexAllowRulesDescription =>
      'Bật quy tắc cho phép dựa trên regex';

  @override
  String get allowRegexBlockRules => 'Cho phép Quy tắc Chặn Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'Bật đối sánh mẫu regex cho quy tắc chặn';

  @override
  String get allowRegexBlockRulesDescription =>
      'Bật quy tắc chặn dựa trên regex';

  @override
  String get allowRule => 'Quy tắc Cho phép';

  @override
  String get allowRules => 'Quy tắc Cho phép';

  @override
  String get allowWhitelistedNumbers => 'Cho phép số trong danh sách trắng';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Cho phép tất cả các số trong danh sách trắng';

  @override
  String get allPermissionsGranted => 'Đã cấp tất cả quyền';

  @override
  String get allSettingsCompleted => 'Đã hoàn tất tất cả cài đặt.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Đã hoàn thành tất cả cập nhật ($count quy tắc)';
  }

  @override
  String get answerThenHangup => 'Trả lời rồi cúp máy';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. Bảo lưu mọi quyền.';

  @override
  String get applicationSoftware => 'Phần mềm ứng dụng';

  @override
  String get apply => 'Áp dụng';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Ủy quyền thất bại: Vui lòng kiểm tra ID khách hàng và khóa';

  @override
  String get authorizationFailedMessage => 'Ủy quyền thất bại';

  @override
  String get authorizationSuccessMessage => 'Ủy quyền thành công';

  @override
  String get authorizeLoginButton => 'Ủy quyền Đăng nhập';

  @override
  String get automotiveIndustry => 'Ngành công nghiệp ô tô';

  @override
  String get autoSyncLabel => 'Tự động đồng bộ';

  @override
  String get autoUpdate => 'Tự động cập nhật';

  @override
  String get autoUpdateDescription =>
      'Đặt khoảng thời gian tự động cập nhật cho các đăng ký hoặc cập nhật thủ công';

  @override
  String get autoUpdateSettings => 'Cài đặt tự động cập nhật';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Quản lý cập nhật tự động cho quy tắc và plugin';

  @override
  String get autoUpdateSettingsTitle => 'Cài đặt tự động cập nhật';

  @override
  String get autoUpdateSubtitle =>
      'Quản lý cập nhật tự động cho quy tắc và plugin';

  @override
  String get autoUpdateTitle => 'Tự động cập nhật';

  @override
  String get avatarBorderColor => 'Màu viền ảnh đại diện';

  @override
  String get avatarBorderSize => 'Kích thước viền ảnh đại diện';

  @override
  String get avatarIconSizesSetting => 'Kích thước ảnh đại diện & biểu tượng';

  @override
  String get avatarPosition => 'Vị trí ảnh đại diện';

  @override
  String get avatarSize => 'Kích thước ảnh đại diện';

  @override
  String axisPosition(Object axis) {
    return 'Vị trí $axis';
  }

  @override
  String get backgroundGradientSetting => 'Màu nền chuyển sắc';

  @override
  String get backup => 'Sao lưu';

  @override
  String get backupAndRestore => 'Sao lưu và khôi phục';

  @override
  String get backupAndRestoreSubtitle =>
      'Sao lưu hoặc khôi phục dữ liệu ứng dụng';

  @override
  String get backupAndRestoreTitle => 'Sao lưu & Khôi phục';

  @override
  String get backupFailed => 'Sao lưu thất bại';

  @override
  String get backupFailedMessage => 'Sao lưu thất bại';

  @override
  String backupFailedWithError(Object error) {
    return 'Sao lưu thất bại: $error';
  }

  @override
  String get backupRestoreSubtitle => 'Sao lưu hoặc khôi phục dữ liệu ứng dụng';

  @override
  String get backupRestoreTitle => 'Sao lưu & Khôi phục';

  @override
  String get backupSectionTitle => 'Sao lưu';

  @override
  String get backupSettings => 'Cài đặt sao lưu';

  @override
  String get backupSettingsDialogTitle => 'Cài đặt sao lưu';

  @override
  String get backupSettingsTitle => 'Cài đặt sao lưu';

  @override
  String get backupSuccessMessage => 'Sao lưu lên đám mây thành công';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Sao lưu thành công vào: $path';
  }

  @override
  String get backupToCloud => 'Sao lưu lên đám mây';

  @override
  String get backupToCloudDescription =>
      'Sao lưu cài đặt và quy tắc vào bộ nhớ đám mây';

  @override
  String backupToCloudFailed(Object error) {
    return 'Không thể sao lưu lên đám mây: $error';
  }

  @override
  String get backupToCloudLabel => 'Sao lưu lên đám mây';

  @override
  String get backupToCloudSuccess => 'Sao lưu lên đám mây thành công';

  @override
  String get backupToCloudTitle => 'Sao lưu lên đám mây';

  @override
  String get backupToLocalLabel => 'Sao lưu vào thiết bị';

  @override
  String get bank => 'Ngân hàng';

  @override
  String get basicInfo => 'Thông tin cơ bản';

  @override
  String get basicRuleFilter => 'Bộ lọc quy tắc cơ bản';

  @override
  String get basicRuleFiltering => 'Lọc quy tắc cơ bản';

  @override
  String get basicRuleFilteringExplanation =>
      '• Lọc quy tắc cơ bản: Lọc quy tắc dựa trên danh sách đen, danh sách trắng và biểu thức chính quy';

  @override
  String get basicRuleFilterSettings => 'Cài đặt bộ lọc quy tắc cơ bản';

  @override
  String get basicRuleFilterSubtitle =>
      'Lọc cuộc gọi bằng danh sách đen/trắng và biểu thức chính quy';

  @override
  String get batchDeleteContacts => 'Xóa hàng loạt danh bạ';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Bạn có chắc chắn muốn xóa $count danh bạ đã chọn không?';
  }

  @override
  String get batchDeleteFailed => 'Xóa hàng loạt thất bại';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Bạn có chắc chắn muốn xóa $count nhãn đã chọn không?';
  }

  @override
  String get blacklist => 'Danh sách đen';

  @override
  String get blacklistingAndWhitelisting => 'Danh sách đen và Danh sách trắng';

  @override
  String get blacklistLabel => 'Danh sách đen';

  @override
  String get blackWhiteList => 'Danh sách đen/trắng';

  @override
  String get block => 'Chặn';

  @override
  String get blockCalls => 'Chặn cuộc gọi';

  @override
  String get blocked => 'Đã chặn';

  @override
  String get blockedCallAction => 'Hành động khi cuộc gọi bị chặn';

  @override
  String get blockedCalls => 'Cuộc gọi bị chặn';

  @override
  String get blockedCallsTitle => 'Cuộc gọi bị chặn';

  @override
  String get blockedCommunications => 'Giao tiếp bị chặn';

  @override
  String get blockedPhoneLabel => 'Cuộc gọi bị chặn';

  @override
  String get blockedSpamCalls => 'Cuộc gọi rác bị chặn';

  @override
  String get blockingTrend => 'Xu hướng chặn';

  @override
  String get blockInternationalCalls =>
      'khớp với các số không bắt đầu bằng + hoặc 00';

  @override
  String get blockInternationalCallsTitle => 'Chặn cuộc gọi quốc tế';

  @override
  String get blockLandlineNumbersTitle => 'Chặn số điện thoại cố định';

  @override
  String get blockMobileNumbers => 'khớp với các số không bắt đầu bằng 13-19';

  @override
  String get blockMobileNumbersTitle => 'Chặn số điện thoại di động';

  @override
  String get blockPremiumRateNumbers =>
      'khớp với các số không bắt đầu bằng 118 hoặc 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Chặn số dịch vụ giá cao';

  @override
  String get blockRule => 'Quy tắc chặn';

  @override
  String get blockRules => 'Quy tắc chặn';

  @override
  String get blockSpecificAreaCodes =>
      'khớp với các số bắt đầu bằng 0 + 2-3 chữ số';

  @override
  String get blockSpecificAreaCodesTitle => 'Chặn mã vùng cụ thể:';

  @override
  String get blockTypeAnalysisTitle => 'Phân tích loại chặn';

  @override
  String get both => 'Cả hai';

  @override
  String get bulkDelete => 'Xóa hàng loạt danh bạ';

  @override
  String get bulkDeleteContacts => 'Xóa hàng loạt danh bạ';

  @override
  String get bulkDeleteLabels => 'Xóa hàng loạt nhãn';

  @override
  String get call => 'Gọi';

  @override
  String get callback => 'Gọi lại';

  @override
  String callbackTo(String number) {
    return 'Gọi lại $number';
  }

  @override
  String get callBlocking => 'Chặn cuộc gọi';

  @override
  String get callerIdApp => 'Ứng dụng hiển thị ID người gọi';

  @override
  String get callerIdCustomizationTitle => 'Tùy chỉnh ID người gọi';

  @override
  String get callerIdDialogTitle => 'Thông tin ID người gọi';

  @override
  String get callerIdDisplayMode => 'Chế độ hiển thị ID người gọi';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Được đánh dấu bởi $count';
  }

  @override
  String get callerIdPreview => 'Xem trước ID người gọi';

  @override
  String get callFilter => 'Bộ lọc cuộc gọi';

  @override
  String get callFilterDescription =>
      'Khi được bật, các cuộc gọi đến sẽ được kiểm tra theo danh sách quy tắc bên dưới. Theo mặc định, các quy tắc lọc cuộc gọi không được đồng bộ hóa giữa các thiết bị.';

  @override
  String get callFilterRules => 'Quy tắc lọc cuộc gọi';

  @override
  String get callFilterRulesDescription =>
      'Đặt các quy tắc cơ bản để lọc cuộc gọi';

  @override
  String get callFilterSettings => 'Cài đặt Bộ lọc cuộc gọi';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Đặt giới hạn tần suất cuộc gọi và quy tắc chặn';

  @override
  String get callFrequencyInterceptionTitle => 'Chặn theo tần suất cuộc gọi';

  @override
  String get callHistory => 'Lịch sử cuộc gọi';

  @override
  String get callHistoryInfoDesc =>
      'Tại đây hiển thị lịch sử cuộc gọi của bạn, bao gồm các cuộc gọi đến, đi và bị nhỡ.';

  @override
  String get callHistoryInfoTitle => 'Lịch sử cuộc gọi';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Khởi tạo lịch sử cuộc gọi thất bại: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Làm mới lịch sử cuộc gọi thất bại: $error';
  }

  @override
  String get callHistoryTab => 'Lịch sử cuộc gọi';

  @override
  String get callHistoryTimelineEarlier => 'Sớm hơn';

  @override
  String get callHistoryTimelineToday => 'Hôm nay';

  @override
  String get callHistoryTimelineYesterday => 'Hôm qua';

  @override
  String get callScreeningPermission => 'Quyền sàng lọc cuộc gọi';

  @override
  String get callScreeningPermissionDescription =>
      'Được sử dụng để sàng lọc và chặn các cuộc gọi rác.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Quyền sàng lọc cuộc gọi chưa được cấp, có thể ảnh hưởng đến chức năng ứng dụng.';

  @override
  String get callSettingsSubtitle => 'Cài đặt ID người gọi, lọc và chặn';

  @override
  String get callSettingsTitle => 'Cài đặt cuộc gọi';

  @override
  String get callStatistics => 'Thống kê cuộc gọi';

  @override
  String get callTypeAnswered => 'Đã trả lời';

  @override
  String get callTypeBlocked => 'Đã bị chặn';

  @override
  String get callTypeIconColor => 'Màu biểu tượng loại cuộc gọi';

  @override
  String get callTypeMissed => 'Cuộc gọi nhỡ';

  @override
  String get callTypeOutgoing => 'Cuộc gọi đi';

  @override
  String get callTypePosition => 'Vị trí loại cuộc gọi';

  @override
  String get callTypeUnknown => 'Không xác định';

  @override
  String get cancelButton => 'Hủy';

  @override
  String get carRental => 'Thuê xe';

  @override
  String get carrier => 'Nhà mạng';

  @override
  String get carrierColor => 'Màu nhà mạng';

  @override
  String get carrierFontSize => 'Cỡ chữ nhà mạng';

  @override
  String get carrierPosition => 'Vị trí nhà mạng';

  @override
  String get changeLabel => 'Đổi nhãn';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Thay đổi trạng thái plugin thất bại: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Thay đổi trạng thái đăng ký thất bại: $error';
  }

  @override
  String get changeTag => 'Đổi thẻ';

  @override
  String get charity => 'Từ thiện';

  @override
  String chartMonthFormat(int month) {
    return 'Tháng $month';
  }

  @override
  String get chartOneDayAgo => '1 ngày trước';

  @override
  String get chartOneMonthAgo => '1 tháng trước';

  @override
  String get chartOneWeekAgo => '1 tuần trước';

  @override
  String get chartTenDaysAgo => '10 ngày trước';

  @override
  String get chartThreeDaysAgo => '3 ngày trước';

  @override
  String get chartToday => 'Hôm nay';

  @override
  String get checkFileFormat => 'Vui lòng kiểm tra định dạng tệp hoặc quyền';

  @override
  String checkPermissionFailed(Object error) {
    return 'Kiểm tra quyền thất bại: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Chọn hành động chặn mặc định';

  @override
  String get clearAllData => 'Xóa tất cả dữ liệu';

  @override
  String get clearAllDataConfirmation =>
      'Bạn có chắc chắn muốn xóa tất cả dữ liệu ứng dụng không? Hành động này không thể hoàn tác.';

  @override
  String get clearAllDataDescription => 'Xóa tất cả dữ liệu ứng dụng';

  @override
  String get clearAllDataLabel => 'Xóa tất cả dữ liệu';

  @override
  String get clearFilter => 'Xóa bộ lọc';

  @override
  String get clearLabelFilter => 'Xóa bộ lọc nhãn';

  @override
  String get clearLabelFilterButton => 'Xóa bộ lọc nhãn';

  @override
  String get closeButton => 'Đóng';

  @override
  String get cloudSync => 'Đồng bộ đám mây';

  @override
  String get cloudSyncAndBackupTitle => 'Đồng bộ đám mây & Sao lưu';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Cấu hình WebDAV, OneDrive và Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Cài đặt Đồng bộ đám mây';

  @override
  String get cloudSyncTitle => 'Đồng bộ đám mây';

  @override
  String get collapseLabelSelector => 'Thu gọn bộ chọn nhãn';

  @override
  String get collection => 'Thu hồi nợ';

  @override
  String get colorPickerTitle => 'Chọn màu';

  @override
  String get configManagement => 'Quản lý cấu hình';

  @override
  String get configUpdated => 'Đã cập nhật cấu hình';

  @override
  String get configurationAdvice =>
      'Thông qua cấu hình phù hợp, bạn có thể đặt các chiến lược lọc khác nhau cho SIM công việc và SIM cá nhân.';

  @override
  String get configureBackupOptions => 'Cấu hình tùy chọn sao lưu';

  @override
  String get configureBackupOptionsSubtitle => 'Cấu hình tùy chọn sao lưu';

  @override
  String get configureCloudSyncService => 'Cấu hình Dịch vụ Đồng bộ đám mây';

  @override
  String get configureCloudSyncServiceHint =>
      'Vui lòng cấu hình dịch vụ đồng bộ đám mây để bật đồng bộ hóa đa thiết bị.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Vui lòng cấu hình dịch vụ đồng bộ đám mây để bật đồng bộ hóa đa thiết bị.';

  @override
  String get configureSimCardFilterRules => 'Cấu hình Quy tắc lọc SIM';

  @override
  String get configureSyncServiceHint =>
      'Vui lòng cấu hình dịch vụ đồng bộ hóa trong cài đặt đồng bộ đám mây trước';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get confirmBatchDeleteContacts =>
      'Bạn có chắc chắn muốn xóa những mục đã chọn';

  @override
  String get confirmButton => 'Xác nhận';

  @override
  String get confirmDelete => 'Xác nhận xóa';

  @override
  String get confirmDeleteContact => 'Bạn có chắc chắn muốn xóa';

  @override
  String get confirmDeleteContactName => 'Xác nhận xóa?';

  @override
  String get confirmDeleteFilter =>
      'Bạn có chắc chắn muốn xóa bộ lọc này không?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Bạn có chắc chắn muốn xóa nhãn \"$name\" không';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Bạn có chắc chắn muốn xóa plugin \"$name\" không?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Bạn có chắc chắn muốn xóa $count plugin không?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Bạn có chắc chắn muốn xóa quy tắc này không? Hành động này không thể hoàn tác.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Bạn có chắc chắn muốn xóa các liên hệ đã chọn không?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Bạn có chắc chắn muốn xóa quy tắc lọc SMS này không?';

  @override
  String get confirmDeleteSmsRule =>
      'Bạn có chắc chắn muốn xóa quy tắc SMS này không?';

  @override
  String get confirmDeleteSubscription =>
      'Bạn có chắc chắn muốn xóa đăng ký này không?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Bạn có chắc chắn muốn xóa $name không?';
  }

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get confirmPasswordLabel => 'Xác nhận mật khẩu';

  @override
  String get connectedStatus => 'Đã kết nối';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Kết nối thất bại: Vui lòng kiểm tra địa chỉ máy chủ, tên người dùng và mật khẩu';

  @override
  String get connectionFailedMessage => 'Kết nối thất bại';

  @override
  String get connectionStatusLabel => 'Trạng thái kết nối';

  @override
  String get connectionSuccessMessage => 'Kết nối thành công';

  @override
  String get contactAddSuccess => 'Đã thêm liên hệ thành công';

  @override
  String get contactDeleted => 'Đã xóa liên hệ';

  @override
  String get contactEditDialog => 'Hộp thoại chỉnh sửa liên hệ';

  @override
  String get contactNameHint => 'Nhập tên liên hệ (tùy chọn)';

  @override
  String get contactNameLabel => 'Tên';

  @override
  String get contactNameOptional => 'Tên liên hệ (tùy chọn)';

  @override
  String get contactNotFound => 'Không tìm thấy liên hệ';

  @override
  String get contacts => 'liên hệ';

  @override
  String contactsDeleted(Object count) {
    return 'Đã xóa $count liên hệ';
  }

  @override
  String get contactSettingsSubtitle => 'Quản lý liên hệ và cài đặt nhãn';

  @override
  String get contactSettingsTitle => 'Cài đặt liên hệ';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Không thể tải liên hệ: $error';
  }

  @override
  String get contactsManagement => 'Quản lý liên hệ';

  @override
  String get contactsManagementPageTitle => 'Trang quản lý liên hệ';

  @override
  String get contactsPageTitle => 'Quản lý liên hệ';

  @override
  String get contactsPermission => 'Quyền truy cập danh bạ';

  @override
  String get contactsPermissionDescription =>
      'Được sử dụng để xác định cuộc gọi từ liên hệ.';

  @override
  String get contactsTab => 'Liên hệ';

  @override
  String get contactSubscriptionDescription =>
      'Đăng ký danh sách liên hệ qua URL, tự động cập nhật thông tin và nhãn liên hệ. Hỗ trợ dữ liệu định dạng JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Không thể tải đăng ký liên hệ: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Đăng ký liên hệ';

  @override
  String get contactUpdateSuccess => 'Đã cập nhật liên hệ thành công';

  @override
  String get contactUs => 'Liên hệ với chúng tôi';

  @override
  String get content => 'Nội dung';

  @override
  String get contentRegex => 'Regex Nội dung';

  @override
  String get countColor => 'Màu số lượng';

  @override
  String get countFontSize => 'Cỡ chữ số lượng';

  @override
  String get countPosition => 'Vị trí số lượng';

  @override
  String get country => 'Quốc gia';

  @override
  String get countryNameColor => 'Màu tên quốc gia';

  @override
  String get countryNameFontSize => 'Cỡ chữ tên quốc gia';

  @override
  String get countryRegionNamePosition => 'Vị trí tên Quốc gia/Khu vực';

  @override
  String get countrySelectionDialog => 'Hộp thoại chọn quốc gia';

  @override
  String get countrySelectionDialogDescription =>
      'Được sử dụng để chọn quốc gia truy vấn thông tin ID người gọi';

  @override
  String get countThresholdDescription =>
      'Đặt ngưỡng số lượng tối thiểu cần thiết để kích hoạt hành động lọc';

  @override
  String get countThresholdLabel => 'Ngưỡng số lượng';

  @override
  String get countThresholdSettings => 'Cài đặt ngưỡng số lượng';

  @override
  String countThresholdValue(Object count) {
    return 'Ngưỡng số lượng: $count';
  }

  @override
  String get createdRules => 'Các quy tắc đã tạo';

  @override
  String get csvFormat => 'Định dạng CSV';

  @override
  String get currentDeviceChip => 'Hiện tại';

  @override
  String get currentDeviceLabel => 'Nhãn thiết bị hiện tại';

  @override
  String get currentDeviceTitle => 'Thiết bị hiện tại';

  @override
  String get currentLabels => 'Nhãn hiện tại:';

  @override
  String get currentLanguage => 'Ngôn ngữ hiện tại';

  @override
  String get currentPasswordLabel => 'Mật khẩu hiện tại';

  @override
  String get customerService => 'Dịch vụ khách hàng';

  @override
  String get customRange => 'Phạm vi tùy chỉnh';

  @override
  String get dailyStatistics => 'Thống kê hàng ngày';

  @override
  String get dailyStatisticsDesc =>
      'Nhận thống kê hàng ngày về các cuộc gọi và tin nhắn bị chặn';

  @override
  String get dashboardTab => 'Bảng điều khiển';

  @override
  String get dataAnalysis => 'Phân tích dữ liệu';

  @override
  String get dataAnalysisDashboardPage =>
      'Trang Bảng điều khiển Phân tích dữ liệu';

  @override
  String get dataExport => 'Xuất dữ liệu';

  @override
  String dataLoadFailure(Object error) {
    return 'Tải dữ liệu thất bại: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Không thể tải dữ liệu: $error';
  }

  @override
  String get dataMigration => 'Di chuyển dữ liệu';

  @override
  String get dataMigrationDescription =>
      'Tính năng này cho phép bạn chuyển tất cả dữ liệu của mình giữa các thiết bị. Hiện tại, bạn có thể sử dụng tính năng sao lưu và khôi phục để di chuyển dữ liệu thủ công.';

  @override
  String get dataMigrationDialogContent =>
      'Tính năng này cho phép bạn chuyển tất cả dữ liệu của mình giữa các thiết bị. Hiện tại, bạn có thể sử dụng tính năng sao lưu và khôi phục để di chuyển dữ liệu thủ công.';

  @override
  String get dataMigrationDialogTitle => 'Di chuyển dữ liệu';

  @override
  String get dataMigrationSectionTitle => 'Mục Di chuyển dữ liệu';

  @override
  String get dataSourceReminder => 'Nhắc nhở nguồn dữ liệu';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày',
      one: '1 ngày',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days VIP';
  }

  @override
  String get debtCollection => 'Thu nợ';

  @override
  String get defaultPeriod => 'Tuần';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteButton => 'Xóa';

  @override
  String get deleteContact => 'Xóa liên hệ';

  @override
  String deleteContactConfirm(Object name) {
    return 'Bạn có chắc chắn muốn xóa $name không?';
  }

  @override
  String get deleteContactConfirmation =>
      'Bạn có chắc chắn muốn xóa liên hệ không';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Bạn có chắc chắn muốn xóa $deviceName không?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Xóa thiết bị';

  @override
  String deleteFailed(Object error) {
    return 'Xóa thất bại: $error';
  }

  @override
  String get deleteFilter => 'Xóa bộ lọc';

  @override
  String get deleteLabel => 'Xóa nhãn';

  @override
  String deleteLabelFailed(Object error) {
    return 'Không thể xóa nhãn: $error';
  }

  @override
  String get deletePlugin => 'Xóa plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Không thể xóa plugin: $error';
  }

  @override
  String get deletePlugins => 'Xóa các plugin';

  @override
  String deletePluginsFailed(Object error) {
    return 'Không thể xóa các plugin: $error';
  }

  @override
  String get deleteRule => 'Xóa quy tắc';

  @override
  String deleteRuleFailed(Object error) {
    return 'Xóa thất bại: $error';
  }

  @override
  String get deleteSelected => 'Xóa đã chọn';

  @override
  String get deleteSmsRule => 'Xóa quy tắc SMS';

  @override
  String get deleteSubscription => 'Xóa đăng ký';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Bạn có chắc chắn muốn xóa đăng ký \"$name\" không?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Không thể xóa đăng ký: $error';
  }

  @override
  String get deleteSuccess => 'Xóa thành công';

  @override
  String get delivery => 'Phân phối';

  @override
  String get deviceDeletedSuccessfully => 'Đã xóa thiết bị thành công';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Đã xóa thiết bị thành công';

  @override
  String get deviceIdLabel => 'ID thiết bị';

  @override
  String get deviceIDLabel => 'ID thiết bị';

  @override
  String get deviceManagementSubtitle => 'Quản lý đồng bộ hóa đa thiết bị';

  @override
  String get deviceManagementTitle => 'Quản lý thiết bị';

  @override
  String get deviceModelLabel => 'Mô hình thiết bị';

  @override
  String get deviceName => 'Tên thiết bị';

  @override
  String get deviceNameCannotBeEmpty => 'Tên thiết bị không được để trống';

  @override
  String get deviceNameHint => 'Vui lòng nhập tên thiết bị';

  @override
  String get deviceNameLabel => 'Tên Thiết Bị';

  @override
  String get deviceRenamedSuccessfully => 'Đổi tên thiết bị thành công';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Đổi tên thiết bị thành công';

  @override
  String get devicesSyncedSuccessfully => 'Đồng bộ hóa thiết bị thành công';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Đồng bộ hóa thiết bị thành công';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Đồng bộ hóa thiết bị thành công';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Hủy đăng ký thiết bị thành công';

  @override
  String get dialogTitle => 'Giải thích mẫu Regex';

  @override
  String get differentFromLocalCounter =>
      'Tính năng này khác với bộ lọc bộ đếm cục bộ, vì nó tập trung vào các kiểu cuộc gọi lặp lại trong thời gian ngắn thay vì số lần đánh dấu dài hạn.';

  @override
  String get disabled => 'Đã tắt';

  @override
  String get disabledStatus => 'Đã tắt';

  @override
  String get disableGlobalPlugins => 'Tắt plugin toàn cầu';

  @override
  String get disableSubscriptionSuccessfully => 'Hủy đăng ký thành công';

  @override
  String get disconnectButton => 'Ngắt kết nối';

  @override
  String get disconnectedMessage => 'Đã ngắt kết nối';

  @override
  String get disconnectedStatus => 'Đã ngắt kết nối';

  @override
  String get disconnectFailedMessage => 'Ngắt kết nối thất bại';

  @override
  String get done => 'Xong';

  @override
  String get dualSimAdvice =>
      'Tính năng này đặc biệt hữu ích cho điện thoại hai SIM để đặt các chiến lược lọc khác nhau cho thẻ SIM công việc và cá nhân.';

  @override
  String get earlier => 'Trước đó';

  @override
  String get ecommerce => 'Thương mại điện tử';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get editContact => 'Chỉnh sửa liên hệ';

  @override
  String get editFilter => 'Chỉnh sửa bộ lọc';

  @override
  String get editLabel => 'Chỉnh sửa nhãn';

  @override
  String get editPhoneRule => 'Chỉnh sửa quy tắc điện thoại';

  @override
  String get editPhoneRules => 'Dùng để chỉnh sửa các quy tắc điện thoại';

  @override
  String get editPhoneRuleTitle => 'Chỉnh sửa quy tắc điện thoại';

  @override
  String get editRule => 'Chỉnh sửa quy tắc';

  @override
  String get editSmsRule => 'Chỉnh sửa quy tắc SMS';

  @override
  String get education => 'Giáo dục';

  @override
  String get elementPositionsSetting => 'Vị trí phần tử';

  @override
  String get email => 'Email';

  @override
  String get emailOptional => 'Email (Không bắt buộc)';

  @override
  String get enableCallFilter => 'Bật Bộ lọc cuộc gọi';

  @override
  String get enableCallFilterDescription =>
      'Khi được bật, các cuộc gọi đến sẽ được kiểm tra dựa trên danh sách quy tắc bên dưới. Các quy tắc lọc cuộc gọi không được đồng bộ hóa giữa các thiết bị theo mặc định.';

  @override
  String get enabled => 'Đã bật';

  @override
  String get enabledStatus => 'Đã bật';

  @override
  String get enableEncryption => 'Bật mã hóa';

  @override
  String get enableEncryptionDescription => 'Mã hóa các tập tin sao lưu';

  @override
  String get enableEncryptionLabel => 'Bật mã hóa';

  @override
  String get enableEncryptionSubtitle => 'Các tập tin sao lưu sẽ được mã hóa';

  @override
  String get enableEncryptionTitle => 'Bật mã hóa';

  @override
  String get enableGlobalPlugins => 'Bật plugin toàn cầu';

  @override
  String get enableLocalCountFilter => 'Bật Bộ lọc số lần cục bộ';

  @override
  String get enableLocalCountFilterDescription =>
      'Tự động lọc cuộc gọi rác dựa trên số lần đánh dấu cuộc gọi';

  @override
  String get enableLocalNotification => 'Sử dụng thông báo cục bộ';

  @override
  String get enableLocalNotificationDescription =>
      'Khi được bật, thông báo về tin nhắn đã lọc sẽ được hiển thị trên thiết bị';

  @override
  String get enableLocationSummary => 'Vị trí';

  @override
  String get enableMuteRules => 'Bật Quy tắc im lặng';

  @override
  String get enableMuteRulesDesc => 'Áp dụng cấu hình quy tắc chặn im lặng';

  @override
  String get enableNoneActionRules => 'Bật Quy tắc hành động None';

  @override
  String get enableNoneActionRulesDesc =>
      'Cho phép cấu hình quy tắc không có hành động chặn nào';

  @override
  String get enableNotifications => 'Bật thông báo';

  @override
  String get enableRemoteNumberFilter => 'Bật Bộ lọc số từ xa';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Sử dụng cơ sở dữ liệu từ xa để lọc số';

  @override
  String get enableRule => 'Bật Quy tắc';

  @override
  String get enableSmsFilter => 'Bật Lọc SMS';

  @override
  String get enableSmsFilterDescription =>
      'Khi được bật, tin nhắn sẽ được tự động lọc theo các quy tắc';

  @override
  String get enableStatisticsNotifications => 'Bật thông báo thống kê';

  @override
  String get enableSubscriptionSuccessfully => 'Bật đăng ký thành công';

  @override
  String get enableTimeInterception => 'Bật Chặn theo thời gian';

  @override
  String get enableTimeInterceptionDescription =>
      'Chặn các cuộc gọi lặp lại trong thời gian ngắn';

  @override
  String get enableTimeInterceptor => 'Bật Bộ chặn theo thời gian';

  @override
  String get endCallImmediately => 'Kết thúc cuộc gọi ngay lập tức';

  @override
  String get endColor => 'Màu kết thúc';

  @override
  String get endDate => 'Ngày kết thúc';

  @override
  String get enhancedFilterInstructionsTitle => 'Hệ thống lọc nâng cao';

  @override
  String get enhancedFilterSettings => 'Cài đặt bộ lọc nâng cao';

  @override
  String get enhancedFilterSettingsTitle => 'Cài đặt bộ lọc nâng cao';

  @override
  String get enhancedFilterSystemDescription =>
      'Hệ thống lọc nâng cao hỗ trợ cả quy tắc toàn cầu và cấu hình lọc cho từng thẻ SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Vui lòng nhập cả số điện thoại và mẫu regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Vui lòng nhập cả số điện thoại và mẫu regex.';

  @override
  String get enterContactName => 'Vui lòng nhập tên liên hệ';

  @override
  String get enterCurrentPasswordHint => 'Vui lòng nhập mật khẩu hiện tại';

  @override
  String get enterDeviceName => 'Nhập tên thiết bị';

  @override
  String get enterDeviceNameHint => 'Vui lòng nhập tên thiết bị';

  @override
  String get enterEmail => 'Vui lòng nhập email';

  @override
  String get enterEmailOptional => 'Vui lòng nhập email (không bắt buộc)';

  @override
  String get enterEncryptionPasswordHint => 'Nhập mật khẩu mã hóa';

  @override
  String get enterEncryptionPasswordTitle => 'Nhập mật khẩu mã hóa';

  @override
  String get enterFilterName => 'Vui lòng nhập tên bộ lọc';

  @override
  String get enterFilterPattern => 'Vui lòng nhập mẫu bộ lọc';

  @override
  String get enterIconCode => 'Nhập mã biểu tượng';

  @override
  String get enterName => 'Nhập tên liên hệ';

  @override
  String get enterNewDeviceNameHint => 'Nhập tên mới cho thiết bị này';

  @override
  String get enterNewPasswordHint => 'Vui lòng nhập mật khẩu mới';

  @override
  String get enterPasswordAgain => 'Nhập lại mật khẩu';

  @override
  String get enterPasswordHint => 'Vui lòng nhập mật khẩu';

  @override
  String get enterPhoneNumber => 'Nhập số điện thoại';

  @override
  String get enterPhoneNumberHint => 'Nhập số điện thoại để kiểm tra';

  @override
  String get enterPhoneNumberMultiple =>
      'Vui lòng nhập số điện thoại, nhiều số cách nhau bằng dấu phẩy';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Nhập số điện thoại để bắt đầu tìm kiếm';

  @override
  String get enterPhoneNumberToVerify => 'Nhập số điện thoại để xác minh';

  @override
  String get enterPluginName => 'Nhập tên Plugin';

  @override
  String get enterPluginUrl => 'Nhập địa chỉ URL plugin';

  @override
  String get enterRegexHint => 'Nhập mẫu regex';

  @override
  String get enterRuleNameAndPattern => 'Vui lòng nhập tên quy tắc và mẫu';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Vui lòng nhập cả tên quy tắc và mẫu regex.';

  @override
  String get enterRuleNameHint => 'Nhập tên quy tắc';

  @override
  String get enterSearchContent => 'Vui lòng nhập nội dung tìm kiếm';

  @override
  String get enterSubscriptionName => 'Nhập tên đăng ký';

  @override
  String get enterSubscriptionUrl => 'Nhập URL đăng ký';

  @override
  String get enterSyncFolderNameHint =>
      'Vui lòng nhập tên thư mục đồng bộ (mặc định: NotificationManager)';

  @override
  String get entertainment => 'Giải trí';

  @override
  String get enterValidNameAndUrl => 'Vui lòng nhập tên và URL hợp lệ';

  @override
  String get enterValidUrl => 'Vui lòng nhập URL hợp lệ';

  @override
  String get enterVersion => 'Nhập Phiên bản';

  @override
  String get enterWebDAVPasswordHint => 'Vui lòng nhập mật khẩu WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Vui lòng nhập địa chỉ máy chủ WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'Vui lòng nhập tên người dùng WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Lỗi khi xóa thiết bị: $error';
  }

  @override
  String get errorLoadingPlugin => 'Lỗi tải plugin';

  @override
  String errorOccurredMessage(Object error) {
    return 'Đã xảy ra lỗi: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Lỗi khi đổi tên thiết bị: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Lỗi đồng bộ hóa thiết bị: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Lỗi đồng bộ thiết bị: $error';
  }

  @override
  String get errorText => 'Lỗi';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Lỗi khi hủy đăng ký thiết bị: $error';
  }

  @override
  String get exampleBlock400Prefix => 'ví dụ: Chặn các số có tiền tố 400';

  @override
  String get exampleBlockMarketingSms => 'ví dụ: Chặn tin nhắn SMS tiếp thị';

  @override
  String get exampleContentRegex => 'ví dụ: .*offer.*';

  @override
  String get exampleContentRegexHint => 'Ví dụ Regex Nội dung';

  @override
  String get exampleCouponPromotionDiscount =>
      'ví dụ: .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'ví dụ: Gia đình, Bạn bè, v.v.';

  @override
  String get examplePhoneNumber => 'ví dụ: 10086, 12345, v.v.';

  @override
  String get exampleRegex400Prefix => 'Ví dụ regex cho tiền tố 400';

  @override
  String get exampleRegexFormat => 'Ví dụ: định dạng ^10086\$';

  @override
  String get exampleSenderRegexHint => 'Ví dụ';

  @override
  String get exchange => 'Trao đổi';

  @override
  String get exchangeNow => 'Đổi ngay';

  @override
  String get exchangeVip => 'Đổi VIP';

  @override
  String get expandLabelSelector => 'Mở rộng Bộ chọn Nhãn';

  @override
  String expiryTime(Object time) {
    return 'Thời gian hết hạn: $time';
  }

  @override
  String get export => 'Xuất';

  @override
  String get exportAllApplicationSettings => 'Xuất tất cả cài đặt ứng dụng';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Xuất tất cả cài đặt ứng dụng';

  @override
  String get exportAllRuleConfigurations => 'Xuất Tất cả Cấu hình Quy tắc';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Xuất tất cả cấu hình quy tắc';

  @override
  String get exportComplete => 'Xuất hoàn tất';

  @override
  String get exportConfig => 'Xuất Cấu hình';

  @override
  String get exportContacts => 'Xuất Danh bạ';

  @override
  String get exportData => 'Xuất Dữ liệu';

  @override
  String get exportError => 'Lỗi Xuất';

  @override
  String get exportFailed => 'Xuất thất bại';

  @override
  String get exportFailure => 'Không thể xuất cấu hình';

  @override
  String get exportFeatureComingSoon => 'Tính năng xuất sẽ sớm ra mắt';

  @override
  String get exporting => 'Đang xuất...';

  @override
  String get exportLabels => 'Xuất Nhãn';

  @override
  String exportLabelsFailed(Object error) {
    return 'Không thể xuất nhãn: $error';
  }

  @override
  String get exportPluginList => 'Xuất Danh sách Plugin';

  @override
  String exportPluginListFailed(Object error) {
    return 'Không thể xuất danh sách plugin: $error';
  }

  @override
  String get exportRules => 'Xuất Quy tắc';

  @override
  String get exportRulesDialogTitle => 'Xuất Quy tắc';

  @override
  String get exportRulesTitle => 'Xuất Quy tắc';

  @override
  String get exportSmsRules => 'Xuất Quy tắc SMS';

  @override
  String get exportStatisticsData => 'Xuất Dữ liệu Thống kê';

  @override
  String get exportSuccess => 'Xuất thành công';

  @override
  String get exportSuccesslly => 'Đã xuất cấu hình thành công';

  @override
  String get failedToAddContact => 'Không thể thêm liên hệ';

  @override
  String failedToAddRule(Object error) {
    return 'Không thể thêm quy tắc: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Không thể thêm quy tắc SMS: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Không thể thêm đăng ký SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Không thể sao lưu cài đặt: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'Không thể giải mã tệp sao lưu';

  @override
  String get failedToDeleteDevice => 'Không thể xóa thiết bị';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Không thể xóa quy tắc SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Không thể xuất quy tắc: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Không thể xuất quy tắc SMS: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Không thể lấy thông tin ID người gọi: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Không thể nhập quy tắc: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Không thể nhập quy tắc SMS: $error';
  }

  @override
  String get failedToLoadContacts => 'Không thể tải danh bạ';

  @override
  String get failedToLoadPlugin => 'Không thể tải plugin';

  @override
  String get failedToRenameDevice => 'Không thể đổi tên thiết bị';

  @override
  String get failedToRestoreSettings => 'Không thể khôi phục cài đặt';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Không thể khôi phục cài đặt: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Không thể đặt mật khẩu: $error';
  }

  @override
  String get failedToSyncDevices => 'Không thể đồng bộ thiết bị';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Không thể chuyển đổi trạng thái quy tắc: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Không thể chuyển đổi trạng thái đăng ký';

  @override
  String get failedToUpdateContact => 'Không thể cập nhật liên hệ';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Không thể cập nhật quy tắc SMS: $error';
  }

  @override
  String get failure => 'Thất bại';

  @override
  String get favoriteContacts => 'Liên hệ yêu thích';

  @override
  String get featureAddRules => '• Thêm quy tắc cụ thể cho số điện thoại';

  @override
  String get featureCenter => 'Trung tâm Tính năng';

  @override
  String get featureEnableDisable =>
      '• Bật/tắt các bộ lọc khác nhau cho từng SIM';

  @override
  String get featureListTitle => 'Tính năng:';

  @override
  String get featureManageRules => '• Quản lý danh sách quy tắc cho từng SIM';

  @override
  String get features => 'Tính năng';

  @override
  String get fetchingCallerIdInfo => 'Đang tìm nạp thông tin ID người gọi...';

  @override
  String fileSavedTo(Object path) {
    return 'Tệp đã lưu tại: $path';
  }

  @override
  String get filter => 'Bộ lọc';

  @override
  String get filterByLabel => 'Lọc theo Nhãn';

  @override
  String get filterClear => 'Xóa Bộ lọc';

  @override
  String get filterControlPanelTitle => 'Bảng điều khiển Bộ lọc';

  @override
  String get filterControlSubtitle =>
      'Quản lý trạng thái bật/tắt của tất cả bộ lọc';

  @override
  String get filterControlTitle => 'Điều khiển bộ lọc';

  @override
  String get filterDeleteFailed => 'Xóa bộ lọc thất bại';

  @override
  String get filterDeleteSuccess => 'Xóa bộ lọc thành công';

  @override
  String get filterDetails => 'Chi tiết bộ lọc';

  @override
  String get filtered => 'Đã lọc';

  @override
  String get filteredSms => 'SMS đã lọc';

  @override
  String get filteredSmsLabel => 'SMS đã lọc';

  @override
  String get filterExplanation => 'Giải thích bộ lọc';

  @override
  String get filterManagement => 'Quản lý bộ lọc';

  @override
  String get filterName => 'Tên bộ lọc';

  @override
  String get filterPattern => 'Mẫu bộ lọc';

  @override
  String get filterPriorityNote =>
      'Lưu ý: Có mối quan hệ ưu tiên giữa các bộ lọc, vui lòng tham khảo tài liệu trợ giúp để biết chi tiết';

  @override
  String get filterSaveFailed => 'Lưu bộ lọc thất bại';

  @override
  String get filterSaveSuccess => 'Lưu bộ lọc thành công';

  @override
  String get filterSettings => 'Cài đặt bộ lọc';

  @override
  String get filterSettingsTitle => 'Cài đặt bộ lọc';

  @override
  String get filterSMS => 'Lọc SMS';

  @override
  String get filterToggleInstructions => 'Bật hoặc tắt bộ lọc cho khe SIM này:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Bộ lọc $status: $filterName';
  }

  @override
  String get filterType => 'Loại bộ lọc';

  @override
  String get financial => 'Tài chính';

  @override
  String get flexibleCombinationFeature =>
      '• Kết hợp linh hoạt: Bật/tắt bộ lọc cho từng khe SIM';

  @override
  String get fontSizesSetting => 'Cỡ chữ';

  @override
  String foundRules(Object count) {
    return 'Tìm thấy $count quy tắc';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Tìm thấy $count quy tắc. Bạn có muốn nhập chúng không?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Tìm thấy $count quy tắc. Bạn có muốn nhập chúng không?';
  }

  @override
  String get fraudAlert => 'CẢNH BÁO LỪA ĐẢO - Dừng cuộc gọi';

  @override
  String get fraudScamLikely => 'Có thể là lừa đảo';

  @override
  String get free => 'Miễn phí';

  @override
  String get functionSettingsTitle => 'Cài đặt chức năng';

  @override
  String generalUpdateFailure(Object error) {
    return 'Cập nhật thất bại: $error';
  }

  @override
  String get getFree => 'Nhận miễn phí';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Cấu hình bộ lọc toàn cầu cho tất cả các thẻ SIM:';

  @override
  String get globalFilterFeature =>
      '• Bộ lọc toàn cầu: Các quy tắc cơ bản cho tất cả các cuộc gọi đến';

  @override
  String get globalFilterSettings => 'Cài đặt bộ lọc toàn cầu';

  @override
  String get globalFilterToggleInstructions =>
      'Cấu hình cài đặt bộ lọc toàn cầu áp dụng cho tất cả các khe SIM:';

  @override
  String get globalSearchSubtitle =>
      'Tìm kiếm danh bạ, nhãn, danh sách đen, danh sách trắng, v.v.';

  @override
  String get globalSearchTitle => 'Tìm kiếm toàn cầu';

  @override
  String get globalSettings => 'Cài đặt toàn cầu';

  @override
  String get googleAdDisplayPosition => 'Vị trí hiển thị quảng cáo Google';

  @override
  String get googleAdMobIntegrationText =>
      'Quảng cáo Google AdMob có thể được tích hợp tại đây';

  @override
  String get googleDriveAuthDescription =>
      'Ủy quyền bằng ID và khóa máy khách Google Drive được cấu hình hệ thống';

  @override
  String get googleDriveAuthorizationHint =>
      'Ủy quyền bằng ID và khóa máy khách Google Drive được cấu hình hệ thống';

  @override
  String get googleDriveConfigTitle => 'Cấu hình Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'Cấu hình Google Drive';

  @override
  String get government => 'Chính phủ';

  @override
  String get granted => 'Đã cấp';

  @override
  String get grantNecessaryPermissions => 'Cấp các quyền cần thiết';

  @override
  String get grantPermissions => 'Cấp quyền';

  @override
  String get headhunter => 'Tuyển dụng';

  @override
  String get height => 'Chiều cao';

  @override
  String get homePageTitle => 'Trang chủ';

  @override
  String get homeTab => 'Trang chủ';

  @override
  String get howItWorksPoint1 =>
      '• Hệ thống sẽ tự động cho phép các cuộc gọi từ cùng một số trong khoảng thời gian đã đặt';

  @override
  String get howItWorksPoint2 =>
      '• Khoảng thời gian ngắn hơn dẫn đến chặn nghiêm ngặt hơn; khoảng thời gian dài hơn dẫn đến chặn lỏng hơn';

  @override
  String get howItWorksPoint3 =>
      '• Hệ thống kiểm tra nhật ký cuộc gọi để xác định xem đó có phải là cuộc gọi lặp lại hay không';

  @override
  String get howItWorksTitle => 'Cách hoạt động:';

  @override
  String get iconCodeOptional => 'Mã biểu tượng (Tùy chọn)';

  @override
  String get iconSize => 'Kích thước biểu tượng';

  @override
  String get import => 'Nhập';

  @override
  String get important => 'Quan trọng';

  @override
  String get importButton => 'Nhập';

  @override
  String get importConfig => 'Nhập cấu hình';

  @override
  String get importContacts => 'Nhập danh bạ';

  @override
  String get importExportContacts => 'Nhập/Xuất danh bạ';

  @override
  String get importExportContactsTooltip => 'Nhập/Xuất danh bạ';

  @override
  String get importExportRules => 'Nhập/Xuất quy tắc';

  @override
  String importFailed(Object error) {
    return 'Nhập thất bại: $error';
  }

  @override
  String get importFailure => 'Nhập cấu hình thất bại';

  @override
  String get importFeatureComingSoon => 'Tính năng nhập sắp ra mắt';

  @override
  String get importLabels => 'Nhập nhãn';

  @override
  String importLabelsFailed(Object error) {
    return 'Nhập nhãn thất bại: $error';
  }

  @override
  String get importPluginList => 'Nhập danh sách plugin';

  @override
  String importPluginListFailed(Object error) {
    return 'Nhập danh sách plugin thất bại: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Đã nhập thành công $count plugin';
  }

  @override
  String get importRuleConfigurationsFromFile => 'Nhập cấu hình quy tắc từ tệp';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Nhập cấu hình quy tắc từ tệp';

  @override
  String get importRules => 'Nhập quy tắc';

  @override
  String get importRulesButton => 'Nhập quy tắc';

  @override
  String get importRulesDialogTitle => 'Nhập quy tắc';

  @override
  String importRulesError(Object error) {
    return 'Nhập quy tắc thất bại: $error';
  }

  @override
  String get importRulesInstructions => 'Nhập quy tắc từ tệp CSV';

  @override
  String get importRulesSuccess => 'Nhập quy tắc thành công';

  @override
  String get importRulesTitle => 'Nhập quy tắc';

  @override
  String get importSuccess => 'Nhập thành công';

  @override
  String get incomingCallInterceptAction => 'Hành động chặn cuộc gọi đến';

  @override
  String get incomingCallNotification => 'Thông báo cuộc gọi đến';

  @override
  String get incorrectPassword => 'Mật khẩu không chính xác';

  @override
  String get initializing => 'Đang khởi tạo';

  @override
  String get installed => 'Đã cài đặt';

  @override
  String get insufficientMarks => 'Không đủ điểm';

  @override
  String get insurance => 'Bảo hiểm';

  @override
  String get interceptAction => 'Hành động chặn';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Đặt cách xử lý các cuộc gọi bị chặn';

  @override
  String get interceptionActionSettingsTitle => 'Cài đặt hành động chặn';

  @override
  String get interceptionTimeInterval => 'Khoảng thời gian chặn';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Khoảng thời gian cập nhật $service đã được đặt thành $days ngày';
  }

  @override
  String get invalidContentRegex => 'Regex nội dung không hợp lệ';

  @override
  String get invalidLabel => 'Nhãn không hợp lệ';

  @override
  String get invalidRegexPattern => 'Mẫu regex không hợp lệ';

  @override
  String get invalidSenderRegex => 'Regex người gửi không hợp lệ';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Tham gia Kênh và Nhóm Telegram để biết thêm thông tin';

  @override
  String get jsLogsTitle => 'Nhật ký JS';

  @override
  String get jsonFormat => 'Định dạng JSON';

  @override
  String get keepAllVersions => 'Giữ tất cả phiên bản';

  @override
  String get keepAllVersionsDescription =>
      'Giữ tất cả các phiên bản lịch sử của mỗi bản sao lưu';

  @override
  String get keepAllVersionsLabel => 'Giữ tất cả phiên bản';

  @override
  String get keepAllVersionsSubtitle =>
      'Giữ các phiên bản lịch sử của mỗi bản sao lưu';

  @override
  String get keepAllVersionsTitle => 'Giữ Tất Cả Phiên Bản';

  @override
  String get label => 'Nhãn';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Nhãn \"$name\" đã được thêm thành công';
  }

  @override
  String get labelCategories => 'Danh mục nhãn';

  @override
  String get labelDeleted => 'Nhãn đã bị xóa';

  @override
  String get labelDescription =>
      'Nhãn giúp bạn quản lý danh bạ tốt hơn, thêm nhãn tùy chỉnh vào số điện thoại để dễ dàng nhận dạng cuộc gọi và tin nhắn.';

  @override
  String get labelFilter => 'Bộ lọc nhãn';

  @override
  String get labelFilterTooltip => 'Bộ lọc nhãn';

  @override
  String get labelIconColor => 'Màu biểu tượng nhãn';

  @override
  String get labelManagement => 'Quản lý nhãn';

  @override
  String get labelNotFound => 'Không tìm thấy nhãn';

  @override
  String get labelRemoved => 'Nhãn đã bị gỡ';

  @override
  String labelRemoveFailed(Object error) {
    return 'Gỡ nhãn không thành công: $error';
  }

  @override
  String get labels => 'Nhãn';

  @override
  String get labelsColor => 'Màu nhãn';

  @override
  String labelsDeleted(Object count) {
    return 'Đã xóa $count nhãn';
  }

  @override
  String get labelsExportedSuccessfully => 'Xuất nhãn thành công';

  @override
  String get labelsFontSize => 'Cỡ chữ nhãn';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Đã nhập thành công $count nhãn';
  }

  @override
  String get labelsPosition => 'Vị trí nhãn';

  @override
  String labelTag(Object labelId) {
    return 'Nhãn: $labelId';
  }

  @override
  String get labelUpdated => 'Nhãn đã được cập nhật';

  @override
  String labelUpdateFailed(Object error) {
    return 'Cập nhật nhãn không thành công: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Nhãn \"\$labelText\" đã cập nhật thành công';

  @override
  String get languageSettings => 'Cài đặt ngôn ngữ';

  @override
  String get languageSettingsSubtitle =>
      'Thay đổi ngôn ngữ hiển thị của ứng dụng';

  @override
  String get languageSettingsTitle => 'Cài đặt ngôn ngữ';

  @override
  String get last30Days => '30 ngày qua';

  @override
  String get last7Days => '7 ngày qua';

  @override
  String get lastSyncLabel => 'Lần đồng bộ cuối';

  @override
  String lastUpdated(Object date) {
    return 'Cập nhật lần cuối: $date';
  }

  @override
  String get lifetimeMembership => 'Thành viên trọn đời';

  @override
  String get lifetimeMembershipDescription =>
      'Mua một lần, mở khóa vĩnh viễn tất cả tính năng cao cấp và các bản cập nhật trong tương lai';

  @override
  String loadContactsFailed(Object error) {
    return 'Không thể tải danh bạ: $error';
  }

  @override
  String get loadDataFailed => 'Không thể tải dữ liệu';

  @override
  String get loadFailed => 'Tải không thành công';

  @override
  String get loading => 'Đang tải...';

  @override
  String get loadingData => 'Đang tải dữ liệu...';

  @override
  String get loadingTags => 'Đang tải thẻ...';

  @override
  String loadLabelFailed(Object error) {
    return 'Không thể tải nhãn: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Không thể tải nhãn: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Không thể tải số điện thoại đã đánh dấu: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Không thể tải số điện thoại đã đánh dấu: $error';
  }

  @override
  String get loadMore => 'Tải thêm';

  @override
  String get loadPluginButton => 'Tải plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Không thể tải plugin: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Không thể tải cài đặt: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Không thể tải quy tắc SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Không thể tải trạng thái';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Không thể tải đăng ký: $error';
  }

  @override
  String get loan => 'Khoản vay';

  @override
  String get localBackupTitle => 'Sao lưu cục bộ';

  @override
  String get localCounterFilter => 'Bộ lọc đếm cục bộ';

  @override
  String get localCounterFilterSubtitle =>
      'Tự động lọc cuộc gọi rác dựa trên tần suất cuộc gọi';

  @override
  String get localCountFilter => 'Bộ lọc đếm cục bộ';

  @override
  String get localCountFilterDescription =>
      'Chặn các cuộc gọi thường xuyên dựa trên số lần đếm cục bộ của số điện thoại';

  @override
  String get localCountFilterExplanationContent =>
      'Bộ lọc đếm cục bộ phân tích lịch sử cuộc gọi để tự động nhận dạng và chặn các cuộc gọi rác thường xuyên.';

  @override
  String get localCountFilterExplanationTitle =>
      'Giải thích về Bộ lọc đếm cục bộ';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Xác định có chặn hay không dựa trên giá trị đếm của số điện thoại';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Khi số lần đếm của một số vượt quá ngưỡng đã đặt, bạn có thể chọn tự động chặn';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Bạn có thể chọn cho phép các số không vượt quá ngưỡng';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Bạn có thể chọn có ghi lại tất cả nhật ký truy vấn hay không';

  @override
  String get localCountFiltering => 'Lọc đếm cục bộ';

  @override
  String get localCountFilteringExplanation =>
      '• Lọc đếm cục bộ: Quy tắc lọc dựa trên số lần đánh dấu cục bộ';

  @override
  String get localCountFilterSettings => 'Cài đặt Bộ lọc đếm cục bộ';

  @override
  String get localCountFilterUseCases =>
      'Bộ lọc này đặc biệt phù hợp để xác định các cuộc gọi rác tự động quay số và cuộc gọi tiếp thị.';

  @override
  String get localFilterSettings => 'Cài đặt Bộ lọc cục bộ';

  @override
  String get localNotificationDisabled => 'Thông báo cục bộ đã tắt';

  @override
  String get localNotificationEnabled => 'Thông báo cục bộ đã bật';

  @override
  String get localServices => 'Dịch vụ cục bộ';

  @override
  String get locationColor => 'Màu vị trí';

  @override
  String get locationFontSize => 'Cỡ chữ vị trí';

  @override
  String get locationIconColor => 'Màu biểu tượng vị trí';

  @override
  String get locationPosition => 'Vị trí';

  @override
  String get logAllLocalQueries => 'Ghi lại tất cả truy vấn cục bộ';

  @override
  String get logAllLocalQueriesDescription =>
      'Ghi lại nhật ký cho tất cả các truy vấn số điện thoại cục bộ';

  @override
  String get logAllRemoteQueries => 'Ghi lại tất cả truy vấn từ xa';

  @override
  String get logAllRemoteQueriesDescription =>
      'Ghi lại tất cả các thao tác truy vấn số điện thoại từ xa';

  @override
  String get manage => 'Quản lý danh bạ';

  @override
  String get manageContacts => 'Quản lý';

  @override
  String get manageFavoriteContacts => 'Quản lý danh bạ yêu thích';

  @override
  String get manageFilterRules => 'Quản lý Quy tắc Lọc';

  @override
  String get manageFilterRulesDescription =>
      'Thêm, sửa đổi hoặc xóa các quy tắc lọc SMS';

  @override
  String get manageFrequentContacts => 'Quản lý danh bạ thường xuyên';

  @override
  String get markCounts => 'Số lần đánh dấu';

  @override
  String get markCount => 'Số lần đánh dấu';

  @override
  String markedByCount(Object count) {
    return 'Được đánh dấu bởi $count người';
  }

  @override
  String get markedPhonesList => 'Số điện thoại đã đánh dấu';

  @override
  String get markExchange => 'Đánh dấu Trao đổi';

  @override
  String get markPhone => 'Đánh dấu số điện thoại';

  @override
  String markPhoneFailed(Object error) {
    return 'Đánh dấu số điện thoại thất bại: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Để Đánh dấu Số điện thoại';

  @override
  String get markPhoneManagementTitle => 'Quản lý Đánh dấu Số điện thoại';

  @override
  String get markPhoneSuccess => 'Đánh dấu số điện thoại thành công';

  @override
  String get matchFailed => 'Khớp thất bại!';

  @override
  String get matchFailedMessage => 'Khớp thất bại.';

  @override
  String get matchNumbersWithSpecialCharacters => 'khớp định dạng số cụ thể';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Khớp các số có ký tự đặc biệt:';

  @override
  String get matchSpecificDigitPatterns => 'khớp định dạng XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle => 'Khớp các mẫu chữ số cụ thể:';

  @override
  String get matchSuccessful => 'Khớp thành công!';

  @override
  String get matchSuccessfulMessage => 'Khớp thành công!';

  @override
  String get medical => 'Y tế';

  @override
  String get membershipPrivileges => 'Đặc quyền Thành viên';

  @override
  String get migrationTool => 'Công cụ Di chuyển';

  @override
  String get migrationToolTitle => 'Công cụ Di chuyển';

  @override
  String get minutes => 'phút';

  @override
  String get month => 'Tháng';

  @override
  String get monthly => 'Hàng tháng';

  @override
  String get monthlyCallCount => 'Số cuộc gọi hàng tháng';

  @override
  String get monthlyChartTitle => 'Biểu đồ Cuộc gọi Bị chặn Hàng tháng';

  @override
  String get monthlyMembership => 'Gói thành viên hàng tháng';

  @override
  String get monthlyMembershipDescription =>
      'Mở khóa tất cả các tính năng cao cấp, tự động gia hạn hàng tháng';

  @override
  String get monthlyTotal => 'Tổng cộng Hàng tháng';

  @override
  String get monthlyTotalLabel => 'Tổng cộng Hàng tháng';

  @override
  String get moreOptions => 'Tùy chọn Khác';

  @override
  String get mute => 'Tắt tiếng';

  @override
  String get name => 'Tên';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Tên và số điện thoại không được để trống';

  @override
  String get nameAndPhoneNumberRequired =>
      'Tên và số điện thoại không được để trống';

  @override
  String get nameColor => 'Màu Tên';

  @override
  String get nameFontSize => 'Cỡ chữ Tên';

  @override
  String nameLabel(Object name) {
    return 'Tên: $name';
  }

  @override
  String get namePosition => 'Vị trí Tên';

  @override
  String get nameUnknown => 'Tên: Không xác định';

  @override
  String nameWithValue(String name) {
    return 'Tên: $name';
  }

  @override
  String get newPasswordLabel => 'Mật khẩu Mới';

  @override
  String get nextStep => 'Tiếp theo';

  @override
  String get noAction => 'Không Hành động';

  @override
  String get noActionRules => 'Không có Quy tắc Hành động nào';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Không có dịch vụ đồng bộ hóa đám mây hoạt động';

  @override
  String get noCallLogs => 'Không có Nhật ký Cuộc gọi';

  @override
  String get noCallRecords => 'Không có bản ghi cuộc gọi';

  @override
  String get noContacts => 'Chưa có danh bạ';

  @override
  String get noContactsYet => 'Chưa có danh bạ';

  @override
  String get noData => 'Không có Dữ liệu';

  @override
  String get noDevicesRegisteredMessage => 'Không có thiết bị nào được đăng ký';

  @override
  String get noDevicesRegisteredYet => 'Chưa có thiết bị nào được đăng ký.';

  @override
  String get noFilters => 'Chưa có bộ lọc nào';

  @override
  String get noLabels => 'Chưa có nhãn nào';

  @override
  String get noMarkedPhones => 'Không có số điện thoại được đánh dấu';

  @override
  String get noMatchingContacts => 'Không có danh bạ phù hợp';

  @override
  String get noMatchingContactsFound => 'Không tìm thấy danh bạ phù hợp';

  @override
  String get noMatchingNumbersFound => 'Không tìm thấy số phù hợp';

  @override
  String get noMatchingRecords => 'Không có bản ghi cuộc gọi phù hợp';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Không có $ruleType phù hợp';
  }

  @override
  String get none => 'Không';

  @override
  String get noneServiceType => 'Không';

  @override
  String get noPlugins => 'Chưa có plugin nào';

  @override
  String get noRecords => 'Không có bản ghi cuộc gọi';

  @override
  String get noResultReturned => 'Không có kết quả được trả về';

  @override
  String get noResultReturnedLog => 'Không có kết quả được trả về từ plugin';

  @override
  String noRules(Object ruleType) {
    return 'Chưa có $ruleType nào';
  }

  @override
  String get noRulesPrompt =>
      'Không tìm thấy quy tắc nào, vui lòng thêm quy tắc';

  @override
  String get noRulesToExport => 'Không có quy tắc nào để xuất';

  @override
  String get noSmsFilterRulesYet => 'Chưa có quy tắc lọc tin nhắn SMS nào';

  @override
  String get noSmsRulesYet => 'Chưa có quy tắc tin nhắn SMS nào';

  @override
  String get noSubscriptions => 'Không có đăng ký';

  @override
  String get noSubscriptionsYet => 'Chưa có Đăng ký nào';

  @override
  String get notGranted => 'Chưa được cấp';

  @override
  String get notificationMode => 'Chế độ Thông báo';

  @override
  String get notificationModeDescription =>
      'Hiển thị thông tin người gọi trên thanh thông báo';

  @override
  String get notificationPermission => 'Quyền Thông báo';

  @override
  String get notificationPermissionDescription =>
      'Được sử dụng để hiển thị thông báo cuộc gọi và tin nhắn đến.';

  @override
  String get notifications => 'Thông báo';

  @override
  String get notificationSettings => 'Cài đặt Thông báo';

  @override
  String get notificationSettingsSaved =>
      'Cài đặt thông báo đã được lưu thành công';

  @override
  String get notSet => 'Chưa Thiết lập';

  @override
  String get notVerifiedText => 'Chưa Xác minh';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Không tìm thấy quy tắc SMS hợp lệ trong tệp';

  @override
  String get number => 'Số';

  @override
  String get numberColor => 'Màu Số';

  @override
  String get numberFontSize => 'Cỡ chữ Số';

  @override
  String get numberPosition => 'Vị trí Số';

  @override
  String get numberSearch => 'Tìm kiếm Số';

  @override
  String get numberTypeColor => 'Màu Loại Số';

  @override
  String get numberTypeFontSize => 'Cỡ chữ Loại Số';

  @override
  String get numberTypePosition => 'Vị trí Loại Số';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Trình quản lý bảo mật cuộc gọi của bạn đã sẵn sàng, hãy bắt đầu tận hưởng trải nghiệm cuộc gọi an toàn!';

  @override
  String get onboardingLanguageDescription =>
      'Chọn ngôn ngữ ưu tiên của bạn để có trải nghiệm tốt nhất.';

  @override
  String get onboardingPermissionsDescription =>
      'Để cung cấp đầy đủ dịch vụ, chúng tôi cần các quyền sau:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Chặn cuộc gọi và tin nhắn rác bằng một cú nhấp chuột, tùy chỉnh quy tắc chặn và mang lại cho bạn môi trường yên tĩnh.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Tự động xác định các cuộc gọi không xác định, đánh dấu các số đáng ngờ và bảo vệ an toàn cuộc gọi của bạn.';

  @override
  String get onboardingWelcomeDescription =>
      'Chuyên gia quản lý cuộc gọi của bạn, cung cấp dịch vụ nhận dạng và chặn cuộc gọi toàn diện.';

  @override
  String get oneDriveAuthDescription =>
      'Cho phép sử dụng ID và khóa client OneDrive được cấu hình hệ thống';

  @override
  String get oneDriveAuthorizationHint =>
      'Cho phép sử dụng ID và khóa client OneDrive được cấu hình hệ thống';

  @override
  String get oneDriveConfigTitle => 'Cấu hình OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'Cấu hình OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Đăng ký Nhận dạng người gọi trực tuyến';

  @override
  String get openAppSettings => 'Mở cài đặt ứng dụng';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Không thể mở cài đặt ứng dụng: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Thao tác thất bại: $error';
  }

  @override
  String get operationFailure => 'Thao tác thất bại';

  @override
  String get operationSuccess => 'Thao tác thành công';

  @override
  String get other => 'Khác';

  @override
  String get ourOtherApps => 'Ứng dụng khác của chúng tôi';

  @override
  String get overlayMode => 'Cửa sổ nổi';

  @override
  String get overlayModeDescription =>
      'Hiển thị thông tin người gọi trong cửa sổ nổi';

  @override
  String get overlayPermission => 'Quyền cửa sổ nổi';

  @override
  String get overlayPermissionDescription =>
      'Được sử dụng để hiển thị lớp phủ cuộc gọi đến.';

  @override
  String get overview => 'Tổng quan';

  @override
  String get password => 'Mật khẩu';

  @override
  String get passwordCannotBeEmpty => 'Mật khẩu không được để trống';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get passwordSetSuccessfully => 'Đặt mật khẩu thành công';

  @override
  String get pattern => 'Mẫu';

  @override
  String get pendingSync => 'Đang chờ đồng bộ';

  @override
  String get periodMonth => 'Tháng';

  @override
  String get periodWeek => 'Tuần';

  @override
  String get periodYear => 'Năm';

  @override
  String get permissionDenied => 'Yêu cầu quyền bị từ chối';

  @override
  String get permissionGranted => 'Quyền đã được cấp';

  @override
  String get permissionManagement => 'Quản lý quyền';

  @override
  String get phoneCallsTab => 'Điện thoại';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get phoneNumberCannotBeEmpty => 'Số điện thoại không được để trống';

  @override
  String get phoneNumberHint => 'Nhập số điện thoại';

  @override
  String get phoneNumberHintText => 'Nhập số điện thoại để thêm quy tắc';

  @override
  String get phoneNumberLabel => 'Số điện thoại';

  @override
  String get phoneNumberRegexRequired =>
      'Vui lòng nhập cả số điện thoại và mẫu regex';

  @override
  String get phoneNumberRequired => 'Số điện thoại là bắt buộc';

  @override
  String get phoneNumberTypeFixedLine => 'Đường dây cố định';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Cố định hoặc di động';

  @override
  String get phoneNumberTypeMobile => 'Di động';

  @override
  String get phoneNumberTypePager => 'Máy nhắn tin';

  @override
  String get phoneNumberTypePersonalNumber => 'Số cá nhân';

  @override
  String get phoneNumberTypePremiumRate => 'Cước phí cao';

  @override
  String get phoneNumberTypeSharedCost => 'Chia sẻ chi phí';

  @override
  String get phoneNumberTypeTollFree => 'Miễn phí';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Không xác định';

  @override
  String get phoneNumberTypeVoicemail => 'Thư thoại';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Quyền điện thoại';

  @override
  String get phonePermissionDescription =>
      'Được sử dụng để nhận dạng và chặn các cuộc gọi đến.';

  @override
  String get phoneRule => 'Quy tắc điện thoại';

  @override
  String get phoneRuleEditDialog => 'Hộp thoại chỉnh sửa quy tắc điện thoại';

  @override
  String get phoneRuleManagement => 'Quản lý quy tắc điện thoại';

  @override
  String get phoneRuleSubscription => 'Đăng ký quy tắc điện thoại';

  @override
  String get phoneSubscription => 'Đăng ký điện thoại';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Đăng ký danh sách quy tắc điện thoại qua URL để tự động cập nhật quy tắc danh sách trắng và danh sách đen. Hỗ trợ tệp quy tắc định dạng JSON.';

  @override
  String get phoneSubscriptionTitle => 'Đăng ký quy tắc điện thoại';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Vui lòng chọn nhãn và nhập số điện thoại hợp lệ';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" đã được thêm thành công';
  }

  @override
  String get pluginDeleted => 'Plugin đã bị xóa';

  @override
  String get pluginLatestVersion => 'Plugin đã là phiên bản mới nhất';

  @override
  String get pluginListExportSuccess =>
      'Danh sách plugin đã được xuất thành công';

  @override
  String get pluginLoadedSuccessfully => 'Plugin đã tải thành công';

  @override
  String get pluginManagement => 'Quản lý Plugin';

  @override
  String get pluginManagementSubtitle =>
      'Quản lý và cấu hình các plugin của bên thứ ba';

  @override
  String get pluginManagementTitle => 'Quản lý Plugin';

  @override
  String get pluginName => 'Tên Plugin';

  @override
  String get pluginNotLoaded =>
      'Plugin chưa được tải. Vui lòng tải plugin trước.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugin đã được xóa thành công.';
  }

  @override
  String get pluginService => 'Dịch vụ Plugin';

  @override
  String get pluginTestPageTitle => 'Kiểm tra Plugin';

  @override
  String get pluginUpdateSuccess => 'Plugin đã cập nhật thành công';

  @override
  String get pluginUrl => 'URL Plugin';

  @override
  String get pluginUrlCannotBeEmpty => 'URL Plugin không được để trống';

  @override
  String get pluginUrlHint => 'Nhập URL plugin';

  @override
  String get pluginUrlLabel => 'URL Plugin';

  @override
  String get pluginVersion => 'Phiên bản Plugin';

  @override
  String get political => 'Chính trị';

  @override
  String get powerfulSpamBlocking => 'Chặn spam mạnh mẽ';

  @override
  String get previousStep => 'Trước';

  @override
  String get prioritizeRemoteAction => 'Ưu tiên cài đặt hành động từ xa';

  @override
  String get prioritizeRemoteActionDescription =>
      'Ưu tiên cài đặt hành động từ cơ sở dữ liệu từ xa';

  @override
  String get processing => 'Đang xử lý...';

  @override
  String get processingOperation => 'Đang xử lý...';

  @override
  String get purchase => 'Mua';

  @override
  String get quarterlyMembership => 'Gói thành viên hàng quý';

  @override
  String get quarterlyMembershipDescription =>
      'Mở khóa tất cả các tính năng cao cấp, tự động gia hạn hàng quý';

  @override
  String get queryButton => 'Truy vấn';

  @override
  String get queryFailed => 'Truy vấn thất bại';

  @override
  String get queryFailedLog => 'Truy vấn thất bại';

  @override
  String get querying => 'Đang truy vấn...';

  @override
  String get queryingPhoneNumber => 'Đang truy vấn số điện thoại';

  @override
  String get queryResultTitle => 'Kết quả truy vấn';

  @override
  String get ready => 'Sẵn sàng!';

  @override
  String get receiveWeeklyStatistics => 'Nhận thống kê hàng tuần';

  @override
  String get recruiter => 'Tuyển dụng';

  @override
  String get reEnterPasswordHint => 'Vui lòng nhập lại mật khẩu';

  @override
  String get refresh => 'Làm mới';

  @override
  String get refreshPermissionStatus => 'Làm mới trạng thái quyền';

  @override
  String get refreshTooltip => 'Làm mới';

  @override
  String regexError(Object error) {
    return 'Lỗi Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Lỗi Regex: $error';
  }

  @override
  String get regexPattern => 'Mẫu Regex';

  @override
  String get regexPatternExplanation => 'Giải thích Mẫu Regex';

  @override
  String get regexPatternExplanationButton => 'Giải thích Mẫu Regex';

  @override
  String get regexPatternLabel => 'Mẫu Regex';

  @override
  String get regexPatternsExamples =>
      'Sử dụng cú pháp regex chuẩn để định nghĩa mẫu. Ví dụ:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Mẫu Regex để khớp Số Điện thoại';

  @override
  String get regexRule => 'Quy tắc Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Thêm quy tắc regex thất bại: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Đã thêm quy tắc regex thành công';

  @override
  String get regexRuleManagement => 'Quản lý Quy tắc Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'Tên quy tắc và mẫu regex không được để trống';

  @override
  String get regexRules => 'Các Quy tắc Regex';

  @override
  String get regexTesterTitle => 'Bộ kiểm tra Regex';

  @override
  String regexValidationFailed(Object error) {
    return 'Xác thực regex thất bại: $error';
  }

  @override
  String get regexValidationSuccess => 'Xác thực regex thành công';

  @override
  String get region => 'Khu vực';

  @override
  String get registeredDevicesTitle => 'Các Thiết bị đã Đăng ký';

  @override
  String get rejectAllCalls => 'Từ chối Tất cả Cuộc gọi';

  @override
  String get rejectAllCallsDescription =>
      'Khi được bật, tất cả cuộc gọi sẽ bị từ chối với ưu tiên cao nhất';

  @override
  String get rejectAllNumbers => 'Từ chối Tất cả các Số';

  @override
  String get rejectAllNumbersDesc => 'Từ chối tất cả cuộc gọi đến khi được bật';

  @override
  String get rejectExceededNumbers => 'Từ chối các Số vượt ngưỡng';

  @override
  String get rejectExceededNumbersDescription =>
      'Tự động từ chối các số vượt quá ngưỡng đếm';

  @override
  String get remoteFilterSettings => 'Cài đặt Bộ lọc từ xa';

  @override
  String get remoteFilterSettingsPageTitle => 'Cài đặt Bộ lọc Số từ xa';

  @override
  String get remoteNumberFilter => 'Bộ lọc Số từ xa';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Bộ lọc này sử dụng cơ sở dữ liệu từ xa độc lập để nhận thông tin số mới nhất.';

  @override
  String get remoteNumberFilterDescription =>
      'Chặn cuộc gọi quấy rối dựa trên thông tin cơ sở dữ liệu từ xa';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Bộ lọc số từ xa xác định và chặn các cuộc gọi spam bằng cách truy vấn cơ sở dữ liệu từ xa dựa trên số lượng cuộc gọi.';

  @override
  String get remoteNumberFilterExplanationTitle => 'Giải thích Bộ lọc Số từ xa';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Ngưỡng Đếm: Xác định dựa trên tần suất xuất hiện của số';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Hành động Lọc: Định cấu hình cách xử lý các số vượt ngưỡng';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Cài đặt Ưu tiên: Đặt ưu tiên cho các hành động từ xa';

  @override
  String get remoteNumberFilterFeatures => 'Tính năng:';

  @override
  String get remoteNumberFiltering => 'Lọc Số từ xa';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Lọc Số từ xa: Các quy tắc lọc dựa trên thông tin cơ sở dữ liệu từ xa';

  @override
  String get remoteNumberFilterSubtitle =>
      'Xác định cuộc gọi spam bằng cách sử dụng cơ sở dữ liệu đám mây và báo cáo cộng đồng';

  @override
  String get removeAdsDescription =>
      'Xóa vĩnh viễn tất cả quảng cáo trong ứng dụng để có trải nghiệm mượt mà hơn';

  @override
  String get removeAdsTitle => 'Xóa Quảng cáo';

  @override
  String get removedFromFavoriteContacts => 'Đã xóa khỏi danh bạ yêu thích';

  @override
  String get removedFromFavorites => 'Đã xóa khỏi danh bạ yêu thích';

  @override
  String get removeFavorite => 'Xóa khỏi Mục yêu thích';

  @override
  String get removeFromFavorites => 'Xóa khỏi Mục yêu thích';

  @override
  String get renameButton => 'Đổi tên';

  @override
  String get renameDeviceDialogTitle => 'Đổi tên Thiết bị';

  @override
  String get renameDeviceTitle => 'Đổi tên Thiết bị';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Thao tác này sẽ thay thế tất cả cài đặt hiện tại của bạn. Bạn có chắc chắn muốn tiếp tục?';

  @override
  String get requestAllPermissions => 'Yêu cầu Tất cả Quyền';

  @override
  String get requestPermission => 'Yêu cầu Quyền';

  @override
  String requestPermissionFailed(Object error) {
    return 'Yêu cầu quyền thất bại: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Dấu hiệu';
  }

  @override
  String get reset => 'Đặt lại';

  @override
  String get restore => 'Khôi phục';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Khôi phục Cài đặt Ứng dụng từ Bản sao lưu';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Khôi phục cài đặt ứng dụng từ bản sao lưu';

  @override
  String get restoreButton => 'Khôi phục';

  @override
  String restoreFailedWithError(Object error) {
    return 'Khôi phục từ đám mây thất bại: $error';
  }

  @override
  String get restoreFromCloud => 'Khôi phục từ Đám mây';

  @override
  String get restoreFromCloudDescription =>
      'Khôi phục cài đặt và quy tắc từ bộ nhớ đám mây';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Khôi phục từ đám mây thất bại: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Khôi phục từ Đám mây';

  @override
  String get restoreFromCloudSuccess => 'Khôi phục từ đám mây thành công';

  @override
  String get restoreFromCloudTitle => 'Khôi phục từ Đám mây';

  @override
  String get restoreFromLocal => 'Khôi phục từ Bộ nhớ cục bộ';

  @override
  String get restorePurchases => 'Khôi phục Giao dịch mua';

  @override
  String get restoreSectionTitle => 'Khôi phục';

  @override
  String get restoreSettings => 'Khôi phục Cài đặt';

  @override
  String get restoreSettingsConfirmation =>
      'Thao tác này sẽ thay thế tất cả cài đặt hiện tại của bạn. Bạn có chắc chắn muốn tiếp tục?';

  @override
  String get restoreSettingsDialogTitle => 'Hộp thoại Khôi phục Cài đặt';

  @override
  String get restoreSettingsTitle => 'Khôi phục Cài đặt';

  @override
  String get restoreSuccessFromLocal => 'Khôi phục từ bộ nhớ cục bộ thành công';

  @override
  String get restoreSuccessMessage => 'Khôi phục từ đám mây thành công';

  @override
  String get retry => 'Thử lại';

  @override
  String get ridesharing => 'Gọi xe chung';

  @override
  String get risk => 'Rủi ro';

  @override
  String get robocall => 'Cuộc gọi tự động';

  @override
  String get ruleAction => 'Hành động Quy tắc';

  @override
  String get ruleAddButton => 'Thêm Quy tắc';

  @override
  String get ruleAddedSuccess => 'Đã thêm quy tắc thành công';

  @override
  String ruleAddFailure(Object error) {
    return 'Thêm quy tắc thất bại: $error';
  }

  @override
  String get ruleAddSuccess => 'Đã thêm quy tắc thành công';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Bạn có chắc chắn muốn xóa $ruleType này không?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Xóa Quy tắc';

  @override
  String get ruleDeletedSuccess => 'Đã xóa quy tắc thành công';

  @override
  String get ruleDeletedSuccessfully => 'Đã xóa quy tắc thành công';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Xóa quy tắc thất bại: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Xóa quy tắc thất bại: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Đã xóa quy tắc thành công';

  @override
  String get ruleDisabledSuccessfully => 'Đã tắt quy tắc thành công';

  @override
  String get ruleEnabledSuccessfully => 'Đã bật quy tắc thành công';

  @override
  String ruleLoadFailed(Object error) {
    return 'Tải quy tắc thất bại: $error';
  }

  @override
  String get ruleManagement => 'Quản lý Quy tắc';

  @override
  String get ruleManagementTitle => 'Quản lý Quy tắc';

  @override
  String get ruleName => 'Tên Quy tắc';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Tên quy tắc và regex nội dung không được để trống';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Tên quy tắc và số điện thoại không được để trống';

  @override
  String get ruleNameHint => 'ví dụ: Gia đình, Bạn bè, v.v.';

  @override
  String get ruleNameLabel => 'Tên Quy tắc';

  @override
  String get ruleNamePatternRequired => 'Vui lòng nhập tên quy tắc và mẫu';

  @override
  String get ruleNameRequired =>
      'Tên quy tắc và số điện thoại không được để trống';

  @override
  String get ruleNotExist => 'Quy tắc không tồn tại hoặc đã bị xóa';

  @override
  String ruleNotFound(Object error) {
    return 'Không tìm thấy quy tắc: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Lưu quy tắc thành công!';

  @override
  String get ruleSavedSuccessMessage => 'Lưu quy tắc thành công!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Lưu thất bại: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Lưu thất bại: $error';
  }

  @override
  String get ruleSaveSuccess => 'Lưu quy tắc thành công!';

  @override
  String get rulesExportedSuccessfully => 'Xuất quy tắc thành công';

  @override
  String rulesExportedTo(Object path) {
    return 'Quy tắc được xuất tới: $path';
  }

  @override
  String get rulesImported => 'Nhập quy tắc thành công';

  @override
  String rulesImportedSuccessfully(Object count) {
    return 'Nhập thành công $count quy tắc';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Nhập quy tắc thất bại: $error';
  }

  @override
  String get ruleStatistics => 'Thống kê quy tắc';

  @override
  String ruleStatusChanged(Object status) {
    return 'Quy tắc $status thành công';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Thao tác thất bại: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Quy tắc $status thành công';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Cập nhật quy tắc thất bại: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Cập nhật quy tắc thành công';

  @override
  String get ruleVerification => 'Xác minh quy tắc';

  @override
  String get save => 'Lưu';

  @override
  String get saveButton => 'Lưu';

  @override
  String get saveButtonLabel => 'LƯU';

  @override
  String get saveButtonText => 'Lưu';

  @override
  String saveFailed(Object error) {
    return 'Lưu thất bại: $error';
  }

  @override
  String get saveFilter => 'Lưu bộ lọc';

  @override
  String get saveSettings => 'Lưu Cài đặt';

  @override
  String saveSettingsFailed(Object error) {
    return 'Lưu cài đặt thất bại: $error';
  }

  @override
  String get scamsLikely => 'Có khả năng lừa đảo';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get searchContacts => 'Tìm kiếm danh bạ';

  @override
  String searchError(Object error) {
    return 'Lỗi tìm kiếm: $error';
  }

  @override
  String get searchFilters => 'Bộ lọc tìm kiếm';

  @override
  String get searchForContacts => 'Tìm kiếm danh bạ';

  @override
  String get searchHint => 'Tìm kiếm...';

  @override
  String get searchSettingsSubtitle =>
      'Tìm kiếm danh bạ, nhãn, danh sách đen, danh sách trắng, v.v.';

  @override
  String get searchSettingsTitle => 'Cài đặt tìm kiếm';

  @override
  String get securityMessage =>
      'Không tin tưởng bất kỳ cuộc gọi điện thoại nào. Luôn xác minh số tổng đài chăm sóc khách hàng một cách độc lập. Không bao giờ chia sẻ mật khẩu, mã xác minh, số thẻ hoặc thông tin cá nhân.';

  @override
  String get selectActionToPerform =>
      'Chọn hành động thực hiện khi quy tắc khớp';

  @override
  String get selectActionWhenBlockingCalls =>
      'Chọn hành động khi chặn cuộc gọi';

  @override
  String get selectActionWhenRuleMatches => 'Chọn hành động khi quy tắc khớp';

  @override
  String get selectAll => 'Chọn tất cả';

  @override
  String get selectCountry => 'Chọn Quốc gia';

  @override
  String get selectDateRange => 'Chọn Khoảng thời gian';

  @override
  String get selectedDateRange => 'Khoảng thời gian đã chọn';

  @override
  String selectedItems(Object count) {
    return 'Đã chọn $count mục';
  }

  @override
  String get selectedLabel => 'Đã chọn:';

  @override
  String get selectExportFormat => 'Chọn Định dạng xuất';

  @override
  String get selectLabel => 'Chọn Nhãn';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Vui lòng chọn nhãn và nhập số điện thoại hợp lệ';

  @override
  String get selectLanguage => 'Chọn Ngôn ngữ';

  @override
  String get selectMultiple => 'Chọn nhiều';

  @override
  String get selectPeriod => 'Chọn Khoảng thời gian';

  @override
  String get selectSimCard => 'Chọn SIM';

  @override
  String get selectSimSlot => 'Chọn Khe SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Chọn hành động cụ thể khi chặn cuộc gọi';

  @override
  String get selectTag => 'Chọn Thẻ';

  @override
  String get selectTags => 'Chọn Thẻ';

  @override
  String get selectTrustedDataSource =>
      'Vui lòng chọn nguồn dữ liệu đáng tin cậy';

  @override
  String get selectYourLanguage => 'Chọn Ngôn ngữ của bạn';

  @override
  String get sender => 'Người gửi';

  @override
  String get senderRegexOptional => 'Regex người gửi (Tùy chọn)';

  @override
  String get serverAddressLabel => 'Địa chỉ máy chủ';

  @override
  String get serviceTypeContact => 'Đăng ký danh bạ';

  @override
  String get serviceTypeLabel => 'Loại dịch vụ';

  @override
  String get serviceTypePhone => 'Đăng ký điện thoại';

  @override
  String get serviceTypePlugin => 'Cập nhật plugin';

  @override
  String get serviceTypeSms => 'Đăng ký SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Đặt';

  @override
  String get setEncryptionPassword => 'Đặt mật khẩu mã hóa';

  @override
  String get setEncryptionPasswordDescription =>
      'Đặt mật khẩu mã hóa để sao lưu và khôi phục';

  @override
  String get setEncryptionPasswordLabel => 'Đặt mật khẩu mã hóa';

  @override
  String get setEncryptionPasswordTitle => 'Đặt mật khẩu mã hóa';

  @override
  String get setPasswordButton => 'Đặt';

  @override
  String get settings => 'Cài đặt';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Cài đặt đã sao lưu tới: $path';
  }

  @override
  String get settingsLoaded => 'Cài đặt đã tải';

  @override
  String settingsLoadFailed(Object error) {
    return 'Tải cài đặt thất bại: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Khôi phục cài đặt thành công. Vui lòng khởi động lại ứng dụng để các thay đổi có hiệu lực.';

  @override
  String get settingsSaved => 'Cài đặt đã lưu';

  @override
  String settingsSaveFailed(Object error) {
    return 'Lưu cài đặt thất bại: $error';
  }

  @override
  String get settingsTab => 'Cài đặt';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get setup => 'Thiết lập';

  @override
  String get showContactEditDialogStaticMethod =>
      'Phương thức tĩnh để hiển thị hộp thoại chỉnh sửa danh bạ';

  @override
  String get showExplanation => 'Hiển thị giải thích';

  @override
  String get silence => 'Im lặng';

  @override
  String get silenceAndNoAnswer => 'Im lặng và Không trả lời';

  @override
  String get silenceNoAnswer => 'Im lặng Không trả lời';

  @override
  String get silentCallVoiceClone => 'Bản sao giọng nói cuộc gọi im lặng';

  @override
  String get silentRules => 'Quy tắc im lặng';

  @override
  String simCard(Object simNumber) {
    return 'SIM $simNumber';
  }

  @override
  String get simCardColor => 'Màu thẻ SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Cấu hình thẻ SIM: Đặt quy tắc lọc độc lập cho từng thẻ SIM';

  @override
  String get simCardFilterRules => 'Quy tắc lọc thẻ SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Đặt các quy tắc lọc khác nhau dựa trên khe cắm SIM';

  @override
  String get simCardFontSize => 'Cỡ chữ thẻ SIM';

  @override
  String get simCardPosition => 'Vị trí thẻ SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Tải thông tin thẻ SIM thất bại: $error';
  }

  @override
  String get simRuleInstructions =>
      'Quy tắc khe cắm SIM cho phép bạn định cấu hình quy tắc lọc độc lập cho từng khe cắm SIM.';

  @override
  String get simRuleInstructionsTitle => 'Quy tắc Khe cắm SIM';

  @override
  String get simRuleManagement => 'Quản lý Quy tắc Khe cắm SIM';

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
    return 'Không thể tải dữ liệu SIM: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'Cấu hình Lọc Khe cắm SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Cho phép đặt quy tắc lọc theo khe cắm SIM';

  @override
  String get simSlotFilterDescription =>
      'Cấu hình quy tắc lọc độc lập cho từng thẻ SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Cài đặt Lọc Khe cắm SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Không thể tải khe cắm SIM: $error';
  }

  @override
  String get simSlotManagement => 'Quản lý Khe cắm SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'Thao tác khe cắm SIM thất bại: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Vị trí Khe cắm SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Quy tắc Khe cắm SIM: Chiến lược lọc độc lập cho mỗi SIM';

  @override
  String get simSlotRuleListTitle => 'Danh sách Quy tắc Khe cắm SIM';

  @override
  String get simSlotRuleManagement => 'Quy tắc Khe cắm SIM';

  @override
  String get simSlotRuleManagementTitle => 'Quản lý Quy tắc';

  @override
  String get simSlotSettings => 'Cài đặt Khe cắm SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Khe cắm SIM $slotNumber';
  }

  @override
  String get skip => 'Bỏ qua';

  @override
  String get smartCallerId => 'Nhận dạng Cuộc gọi Thông minh';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Lọc SMS giúp bạn tự động lọc các tin nhắn rác và giữ cho danh sách tin nhắn của bạn sạch sẽ. Bạn có thể đặt quy tắc lọc và phương thức thông báo.';

  @override
  String get smsFilterDisabled => 'Đã tắt lọc SMS';

  @override
  String get smsFilterEnabled => 'Đã bật lọc SMS';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Đã thêm quy tắc lọc SMS thành công';

  @override
  String get smsFilterRules => 'Quy tắc Lọc SMS';

  @override
  String get smsFilterSettings => 'Cài đặt Lọc SMS';

  @override
  String get smsHistory => 'Lịch sử SMS';

  @override
  String get smsManagement => 'Quản lý SMS';

  @override
  String get smsPermission => 'Quyền SMS';

  @override
  String get smsPermissionDescription => 'Dùng để lọc tin nhắn rác.';

  @override
  String get smsRuleAddedSuccessfully => 'Đã thêm quy tắc SMS thành công';

  @override
  String get smsRuleDeletedSuccessfully => 'Đã xóa quy tắc SMS thành công';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Không thể tải quy tắc SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Quản lý Quy tắc SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'Đã xuất quy tắc SMS thành công đến $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'Đã nhập quy tắc SMS thành công';

  @override
  String get smsRuleSubscription => 'Đăng ký Quy tắc SMS';

  @override
  String get smsRuleUpdatedSuccessfully => 'Đã cập nhật quy tắc SMS thành công';

  @override
  String get smsSettingsSubtitle => 'Lọc SMS và chặn từ khóa';

  @override
  String get smsSettingsTitle => 'Cài đặt SMS';

  @override
  String get smsSubscription => 'Đăng ký SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Đã thêm đăng ký SMS thành công';

  @override
  String get smsSubscriptionRulesDescription =>
      'Đăng ký danh sách quy tắc SMS qua URL, hỗ trợ khớp biểu thức chính quy. Bạn có thể đặt hành động chặn hoặc cho phép.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Một số yêu cầu quyền bị từ chối';

  @override
  String get spamLikely => 'Có thể là thư rác';

  @override
  String get startColor => 'Màu Bắt đầu';

  @override
  String get startDate => 'Ngày Bắt đầu';

  @override
  String get startUsing => 'Bắt đầu sử dụng';

  @override
  String get statAnswered => 'Đã trả lời';

  @override
  String get statBlocked => 'Blocked';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Phương thức tĩnh để hiển thị Hộp thoại Thông tin ID Người gọi';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Phương thức tĩnh để hiển thị hộp thoại chọn quốc gia';

  @override
  String get staticMethodToDisplayDialog =>
      'Phương thức tĩnh để hiển thị hộp thoại';

  @override
  String get statistics => 'Thống kê';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Tính năng xuất thống kê sắp ra mắt';

  @override
  String get statisticsGrid => 'Lưới Thống kê';

  @override
  String get statisticsPageTitle => 'Phân tích Dữ liệu';

  @override
  String get stirColor => 'Màu STIR';

  @override
  String get stirFontSize => 'Cỡ chữ STIR';

  @override
  String get stirPosition => 'Vị trí STIR';

  @override
  String get storagePermission => 'Quyền truy cập Bộ nhớ';

  @override
  String get storagePermissionDescription => 'Dùng để lưu cài đặt và quy tắc.';

  @override
  String get subscribe => 'Đăng ký';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Đã thêm đăng ký \"$name\" thành công';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Bạn có chắc chắn muốn xóa đăng ký này không?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Xóa Đăng ký';

  @override
  String get subscriptionDeleted => 'Đã xóa đăng ký';

  @override
  String get subscriptionDeletedSuccessfully => 'Đã xóa đăng ký thành công';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Không thể xóa đăng ký: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Đã xóa đăng ký';

  @override
  String get subscriptionEmptyState => 'Không có đăng ký nào';

  @override
  String get subscriptionEmptyText => 'Chưa có đăng ký nào';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Không thể tải đăng ký: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Không thể tải đăng ký: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Quản lý Đăng ký';

  @override
  String get subscriptionName => 'Tên Đăng ký';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Tên đăng ký và URL không được để trống';

  @override
  String get subscriptionNameHint => 'Nhập tên đăng ký';

  @override
  String get subscriptionPageTitle => 'Quản lý Đăng ký';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Không thể thay đổi trạng thái đăng ký: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Không thể chuyển đổi trạng thái đăng ký: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Không thể cập nhật đăng ký: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Đã cập nhật đăng ký thành công';

  @override
  String get subscriptionUrl => 'URL Đăng ký';

  @override
  String get subscriptionUrlHint => 'Nhập URL đăng ký';

  @override
  String successfullyImportedRules(Object count) {
    return 'Đã nhập thành công $count quy tắc';
  }

  @override
  String get supportSync => 'Hỗ trợ Đồng bộ hóa';

  @override
  String get survey => 'Khảo sát';

  @override
  String get syncDevicesButton => 'Đồng bộ hóa Thiết bị';

  @override
  String get syncFailed => 'Đồng bộ hóa thất bại';

  @override
  String get syncFailedMessage => 'Đồng bộ hóa thất bại';

  @override
  String get syncFolderNameHint =>
      'Vui lòng nhập tên thư mục đồng bộ hóa (mặc định: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Tên Thư mục Đồng bộ hóa';

  @override
  String get synchronized => 'Đã đồng bộ hóa';

  @override
  String get syncing => 'Đang đồng bộ hóa...';

  @override
  String get syncNow => 'Đồng bộ hóa Ngay';

  @override
  String get syncNowButton => 'Đồng bộ ngay';

  @override
  String get syncStatusTitle => 'Trạng thái đồng bộ';

  @override
  String get syncStatusUpdatedMessage => 'Trạng thái đồng bộ đã cập nhật';

  @override
  String get syncSuccessful => 'Đồng bộ thành công';

  @override
  String get syncSuccessMessage => 'Đồng bộ thành công';

  @override
  String get syncWithCloudStorage => 'Đồng bộ với Kho lưu trữ đám mây';

  @override
  String get syncWithCloudStorageSubtitle => 'Đồng bộ với kho lưu trữ đám mây';

  @override
  String get systemFeatures => 'Tính năng hệ thống:';

  @override
  String get systemSettingsTitle => 'Cài đặt hệ thống';

  @override
  String get tabAll => 'Tất cả';

  @override
  String get tabAnswered => 'Đã trả lời';

  @override
  String get tabBlocked => 'Đã chặn';

  @override
  String get tabMissed => 'Bỏ lỡ';

  @override
  String get tabOutgoing => 'Cuộc gọi đi';

  @override
  String tagLabel(String tag) {
    return 'Thẻ: $tag';
  }

  @override
  String get tagsUpdated => 'Các thẻ đã được cập nhật';

  @override
  String get takeaway => 'Điểm rút gọn';

  @override
  String get telecommunication => 'Viễn thông';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Tiếp thị qua điện thoại';

  @override
  String get testButton => 'KIỂM TRA';

  @override
  String get testButtonLabel => 'KIỂM TRA';

  @override
  String get testConnectionButton => 'Kiểm tra kết nối';

  @override
  String get textColorsSetting => 'Màu văn bản & nhãn';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Ứng dụng này là công cụ nhận dạng người gọi mạnh mẽ cho phép bạn xác định và chặn các cuộc gọi không mong muốn.';

  @override
  String get thisWeek => 'Tuần này';

  @override
  String get timeInterceptor => 'Bộ chặn theo tần suất thời gian';

  @override
  String get timeInterceptorDescription =>
      'Tự động chặn/cho phép các cuộc gọi tiềm năng dựa trên tần suất cuộc gọi';

  @override
  String get timeInterceptorExplanation =>
      '• Bộ chặn theo tần suất thời gian: Chặn/cho phép các cuộc gọi lặp lại trong thời gian ngắn';

  @override
  String get timeInterceptorExplanationContent =>
      'Tính năng chặn theo tần suất cuộc gọi phân tích tần suất cuộc gọi để tự động xác định và chặn/cho phép các cuộc gọi rác thường xuyên.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Giải thích tính năng chặn theo tần suất cuộc gọi';

  @override
  String get timeInterceptorSettingsTitle =>
      'Cài đặt chặn theo tần suất cuộc gọi';

  @override
  String get timeInterceptorSubtitle =>
      'Tự động chặn các cuộc gọi rác tiềm năng dựa trên tần suất cuộc gọi';

  @override
  String get timeInterceptorTitle => 'Bật chặn theo tần suất cuộc gọi';

  @override
  String get timeWindowDescription =>
      'Đặt kích thước cửa sổ thời gian để cho phép các cuộc gọi lặp lại. Các cuộc gọi từ cùng một số trong cửa sổ này sẽ được cho phép';

  @override
  String timeWindowLabel(int minutes) {
    return 'Cửa sổ thời gian chặn (phút): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Đặt kích thước cửa sổ thời gian để cho phép các cuộc gọi lặp lại. Các cuộc gọi từ cùng một số trong cửa sổ này sẽ được cho phép';

  @override
  String get today => 'Hôm nay';

  @override
  String get total => 'Tổng cộng';

  @override
  String get totalBlocked => 'Tổng số đã chặn';

  @override
  String get totalFiltered => 'Tổng số đã lọc';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Chuyển dữ liệu giữa các thiết bị hoặc nền tảng';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Chuyển dữ liệu giữa các thiết bị hoặc nền tảng';

  @override
  String get travelTicketing => 'Vé du lịch';

  @override
  String get trend => 'Xu hướng';

  @override
  String get trendChart => 'Biểu đồ xu hướng';

  @override
  String get tutorial => 'Hướng dẫn';

  @override
  String get type => 'Loại';

  @override
  String get unassignedSIMCard => 'Thẻ SIM chưa được gán';

  @override
  String get unknown => 'Không xác định';

  @override
  String get unknownLabel => 'Nhãn không xác định';

  @override
  String get unknownTag => 'Thẻ: Không xác định';

  @override
  String get unregisterButton => 'Hủy đăng ký';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Bạn có chắc chắn muốn hủy đăng ký $deviceName không?';
  }

  @override
  String get unregisterDeviceTitle => 'Hủy đăng ký thiết bị';

  @override
  String get unsupportedFileFormat => 'Định dạng tệp không được hỗ trợ';

  @override
  String get update => 'Cập nhật';

  @override
  String get updateAllNow => 'Cập nhật tất cả ngay';

  @override
  String get updateCallFilterConfig => 'Cập nhật cấu hình bộ lọc cuộc gọi';

  @override
  String updateContactFailed(Object error) {
    return 'Không thể cập nhật danh bạ: $error';
  }

  @override
  String get updateFavoriteStatus => 'Cập nhật trạng thái yêu thích';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Không thể cập nhật trạng thái yêu thích: $error';
  }

  @override
  String get updateInterval => 'Khoảng thời gian cập nhật';

  @override
  String get updateLabelFailed => 'Không thể cập nhật nhãn';

  @override
  String get updateNow => 'Cập nhật ngay';

  @override
  String get updatePlugin => 'Cập nhật Plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Không thể cập nhật plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Không thể cập nhật quy tắc: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Không thể cập nhật đăng ký: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service đã cập nhật thành công ($count quy tắc)';
  }

  @override
  String get updateTags => 'Cập nhật thẻ';

  @override
  String get useCasesPoint1 => '• Xác định các cuộc gọi rác tự động gọi lại';

  @override
  String get useCasesPoint2 =>
      '• Chặn các cuộc gọi tiếp thị gọi nhiều lần trong thời gian ngắn';

  @override
  String get useCasesPoint3 => '• Ngăn chặn quấy rối và gọi điện khủng bố';

  @override
  String get useCasesTitle => 'Các trường hợp sử dụng:';

  @override
  String get useGlobalSettings => 'Sử dụng cài đặt toàn cục';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Tên người dùng';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Sử dụng cú pháp regex tiêu chuẩn để xác định các mẫu. Ví dụ:';

  @override
  String get validateRegex => 'Xác thực Regex';

  @override
  String get verificationFailedText => 'Thất bại';

  @override
  String get verifiedText => 'Đã xác minh';

  @override
  String get verify => 'Xác minh';

  @override
  String version(Object version) {
    return 'Phiên bản: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Đổi tư cách thành viên VIP bằng số lần đánh dấu số điện thoại';

  @override
  String get vipExchangeTitle => 'Đánh dấu đổi VIP';

  @override
  String get watchAd => 'Xem quảng cáo';

  @override
  String get watchAdForTemp => 'Xem quảng cáo để có đặc quyền tạm thời';

  @override
  String get watchAdForTempDescription =>
      'Xem một quảng cáo ngắn để tạm thời mở khóa một số tính năng cao cấp';

  @override
  String get webDAVConfigTitle => 'Cấu hình WebDAV';

  @override
  String get webdavConfigurationTitle => 'Cấu hình WebDAV';

  @override
  String get webdavPasswordHint => 'Vui lòng nhập mật khẩu WebDAV';

  @override
  String get webdavServerAddressHint => 'Vui lòng nhập địa chỉ máy chủ WebDAV';

  @override
  String get webdavUsernameHint => 'Vui lòng nhập tên người dùng WebDAV';

  @override
  String get week => 'Tuần';

  @override
  String get weekly => 'Hàng tuần';

  @override
  String get weeklyBlockedCallsSummary => 'Tóm tắt cuộc gọi bị chặn hàng tuần';

  @override
  String get weeklyChartTitle => 'Biểu đồ cuộc gọi bị chặn hàng tuần';

  @override
  String get weeklyReport => 'Báo cáo hàng tuần';

  @override
  String get weeklyReportDesc =>
      'Nhận báo cáo tóm tắt hàng tuần về hoạt động chặn cuộc gọi';

  @override
  String get welcome => 'Chào mừng';

  @override
  String get whitelist => 'Danh sách trắng';

  @override
  String get whitelistLabel => 'Danh sách trắng';

  @override
  String get width => 'Chiều rộng';

  @override
  String get wildcardMatchingDescription =>
      'Sử dụng \'.\' để khớp với bất kỳ ký tự nào (ví dụ: \'123.456\' khớp với 123-456)';

  @override
  String get wildcardMatchingTitle => 'Khớp ký tự đại diện:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Hỗ trợ Ký tự đại diện cho Lọc linh hoạt';

  @override
  String get windowSizeSetting => 'Kích thước cửa sổ';

  @override
  String get year => 'Năm';

  @override
  String get yearly => 'Hàng năm';

  @override
  String get yearlyChartTitle => 'Cuộc gọi bị chặn hàng năm';

  @override
  String get noSimCardsDetected => 'Không phát hiện thẻ SIM';

  @override
  String get filterManagementDescription => 'Đặt bộ lọc cuộc gọi';

  @override
  String get callerIdCustomizationSubtitle => 'Tùy chỉnh bố cục Caller ID';

  @override
  String get fraudAlerSettingTitle => 'Cài đặt Cảnh báo Lừa đảo';

  @override
  String get fraudAlerSettingSubtitle => 'Để đặt cảnh báo lừa đảo';

  @override
  String get enableFraudAlert => 'Bật Cảnh báo Lừa đảo';

  @override
  String get enableFraudAlertDescription =>
      'Cảnh báo cho các cuộc gọi lừa đảo bị nghi ngờ';

  @override
  String get enableVibration => 'Bật Rung';

  @override
  String get enableVibrationDescription =>
      'Rung khi cuộc gọi bị nghi ngờ là cuộc gọi lừa đảo';

  @override
  String get notificationSettingsTitle => 'Cài đặt Thông báo';

  @override
  String get useLocalNotification => 'Sử dụng Thông báo cục bộ';

  @override
  String get useLocalNotificationDescription =>
      'Bật thông báo cục bộ cho các cuộc gọi đến';

  @override
  String get cancelLocalNotification => 'Đóng Thông báo cục bộ';

  @override
  String get useStirNotification => 'Sử dụng Thông báo từ STIR';

  @override
  String get useStirNotificationDescription =>
      'Bật thông báo STIR cho các cuộc gọi đến';

  @override
  String get cancelLocalNotificationDescription =>
      'Tự động đóng Thông báo cục bộ';

  @override
  String get callerIdSettingsTitle => 'Cài đặt Caller ID';

  @override
  String get callerIdSettingsSubtitle =>
      'Để thiết lập Thông báo cuộc gọi đến & Chế độ hiển thị';

  @override
  String get purchaseTitle => 'Mua hàng';

  @override
  String get purchaseSubtitle => 'Để mua dịch vụ';

  @override
  String get callerIdNotificationTitle => 'Thông tin cuộc gọi đến';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Số: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Cuộc gọi bị chặn';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Cuộc gọi bị chặn từ $phoneNumber';
  }

  @override
  String get stirVerified => 'Đã xác minh';

  @override
  String get stirNotVerified => 'Chưa xác minh';

  @override
  String get stirFailed => 'Xác minh thất bại';

  @override
  String get stirUnknown => 'Trạng thái xác minh không rõ';

  @override
  String get stirVerificationTitle => 'Xác minh STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage cho số $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Cài đặt Tin nhắn Bảo mật Cuộn';

  @override
  String get messageColor => 'Màu tin nhắn';

  @override
  String get messageFontSize => 'Cỡ chữ tin nhắn';

  @override
  String get messagePosition => 'Vị trí tin nhắn';

  @override
  String get containerWidth => 'Chiều rộng vùng chứa';

  @override
  String get scrollSpeed => 'Tốc độ cuộn';

  @override
  String get enableSecurityMessage => 'Bật Tin nhắn Bảo mật';

  @override
  String get fraudAlertTitle => 'Cảnh báo Lừa đảo';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Cuộc gọi tiềm ẩn lừa đảo từ $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Tải quy tắc thất bại: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Tải nhật ký cuộc gọi thất bại: $error';
  }

  @override
  String get noBlockedTypeData => 'Không có dữ liệu loại bị chặn';

  @override
  String importEntity(Object entityTypeName) {
    return 'Nhập $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName được nhập thành công, tổng cộng $count bản ghi được nhập';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Không thể nhập $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Xuất $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName được xuất thành công';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Không thể xuất $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Dịch vụ đồng bộ hóa đám mây';

  @override
  String get membershipCenter => 'Trung tâm thành viên';

  @override
  String get redeemVipWithMarks => 'Đổi VIP bằng Mark';

  @override
  String get currentMarkCount => 'Số Mark hiện tại';

  @override
  String get markMoreNumbersForMore => 'Gắn dấu nhiều số hơn để nhận thêm Mark';

  @override
  String get noAds => 'Không quảng cáo';

  @override
  String get cloudBackup => 'Sao lưu đám mây';

  @override
  String get callerIdEnhancement => 'Cải tiến Caller ID';

  @override
  String get voiceRecognition => 'Nhận dạng giọng nói';

  @override
  String get feature => 'Tính năng';

  @override
  String get normalUser => 'Người dùng thông thường';

  @override
  String get vipUser => 'Người dùng VIP';

  @override
  String get temporaryVip => 'VIP tạm thời';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get unknownAction => 'Hành động không xác định';

  @override
  String get settingsBackup => 'Sao lưu cài đặt ';

  @override
  String get allServicesStatusTitle => 'Trạng thái Dịch vụ hiện tại';

  @override
  String get allServicesStatusSubtitle =>
      'Trạng thái hiện tại của từng Dịch vụ Đám mây';

  @override
  String get redirect => 'Chuyển hướng';

  @override
  String get notify => 'Thông báo';

  @override
  String get log => 'Ghi nhật ký';

  @override
  String get custom => 'Tùy chỉnh';

  @override
  String get allowActionDescription =>
      'Cuộc gọi sẽ được cho phép, ngay cả khi số đó có trong danh sách chặn.';

  @override
  String get blockActionDescription =>
      'Cuộc gọi sẽ bị chặn và hiển thị trong nhật ký cuộc gọi.';

  @override
  String get silenceActionDescription =>
      'Cuộc gọi sẽ bị im lặng nhưng vẫn hiển thị trong nhật ký cuộc gọi.';

  @override
  String get noneActionDescription =>
      'Không có hành động đặc biệt nào được thực hiện cho cuộc gọi.';

  @override
  String get redirectActionDescription =>
      'Chuyển hướng cuộc gọi đến một số được chỉ định.';

  @override
  String get labelActionDescription =>
      'Thêm nhãn cho cuộc gọi để dễ nhận dạng.';

  @override
  String get notifyActionDescription => 'Gửi thông báo khi có cuộc gọi đến.';

  @override
  String get logActionDescription =>
      'Ghi lại thông tin cuộc gọi mà không thực hiện hành động nào khác.';

  @override
  String get customActionDescription => 'Thực hiện hành động tùy chỉnh.';

  @override
  String get synced => 'Đã đồng bộ';

  @override
  String get needVipAccess =>
      'Bạn cần quyền truy cập VIP để sử dụng tính năng này';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Nhập hoặc xuất dữ liệu $entityTypeName';
  }

  @override
  String get importExportTitle => 'Nhập/Xuất';

  @override
  String get noPhoneRules => 'Không tìm thấy quy tắc điện thoại nào';

  @override
  String get noRegexRules => 'Không tìm thấy quy tắc biểu thức chính quy nào';

  @override
  String get noAllowedBlockedRules =>
      'Không tìm thấy quy tắc cho phép/chặn nào';

  @override
  String get importExport => 'Nhập/Xuất';

  @override
  String get filterByAction => 'Lọc theo Hành động';

  @override
  String get upgradeToVip => 'Nâng cấp lên VIP';

  @override
  String get batteryOptimizationPermission => 'Tối ưu hóa Pin';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Cho phép ứng dụng chạy nền để cung cấp các dịch vụ như nhận diện người gọi.';

  @override
  String get permissionTitle => 'Quyền Đặc biệt';

  @override
  String get permissionSubtitle => 'Quản lý quyền phủ lớp và tối ưu hóa pin';

  @override
  String get themeSettingsTitle => 'Cài đặt Chủ đề';

  @override
  String get themeSettingsSubtitle => 'Chọn chủ đề yêu thích của bạn';

  @override
  String get databaseSyncTitle => 'Đồng bộ hóa Cơ sở dữ liệu';

  @override
  String get countrySyncSettingsTitle =>
      'Cài đặt Đồng bộ hóa Cơ sở dữ liệu theo Quốc gia';

  @override
  String get countrySyncSettingsSubtitle =>
      'Chọn quốc gia để đồng bộ hóa dữ liệu';

  @override
  String get countryDataDisclaimer =>
      'Xin lưu ý: Cơ sở dữ liệu có thể không bao gồm dữ liệu cho tất cả các quốc gia hoặc khu vực cụ thể.';

  @override
  String get editSubscription => 'Chỉnh sửa Đăng ký';

  @override
  String get searchByNameOrPhoneNumber =>
      'Tìm kiếm theo Tên hoặc Số điện thoại';

  @override
  String get allowedBlockedRulesInfo =>
      'Các quy tắc cho phép/chặn được sử dụng để khớp các cuộc gọi với các số điện thoại cụ thể, có ưu tiên cao nhất.';

  @override
  String get searchPhoneRulesHint => 'Tìm kiếm quy tắc điện thoại';

  @override
  String get phoneRulesInfo =>
      'Các quy tắc điện thoại được sử dụng để khớp các cuộc gọi với các số điện thoại cụ thể, có ưu tiên thấp hơn. Một số đến từ các đăng ký phoneRule';

  @override
  String get searchSubscriptionsHint => 'Tìm kiếm đăng ký';

  @override
  String get searchPluginsHint => 'Tìm kiếm plugin';

  @override
  String get searchLabelsHint => 'Tìm kiếm nhãn';

  @override
  String get pluginDescription => 'Mô tả plugin';

  @override
  String get enterPluginDescription => 'Nhập mô tả plugin';

  @override
  String get searchRegexRulesHint => 'Tìm kiếm quy tắc regex';

  @override
  String get regexRulesInfo =>
      'Quy tắc Regex được sử dụng để lọc cuộc gọi dựa trên các Mẫu Regex.';

  @override
  String get searchMarkedPhonesHint => 'Tìm kiếm số điện thoại đã đánh dấu';

  @override
  String get searchContactSubscriptionsHint => 'Tìm kiếm đăng ký liên hệ';

  @override
  String get showAllContacts => 'Hiển thị Tất cả Liên hệ';

  @override
  String get showFavorites => 'Hiển thị Mục yêu thích';

  @override
  String get manualEntry => 'Thông tin Nhập thủ công';

  @override
  String get scriptSaved => 'Kịch bản đã được lưu';

  @override
  String editScriptFor(String pluginName) {
    return 'Chỉnh sửa kịch bản cho $pluginName';
  }

  @override
  String get saveScript => 'Lưu Kịch bản';

  @override
  String get testPlugin => 'Kiểm tra Plugin';

  @override
  String get description => 'Mô tả';

  @override
  String get accessTargetUrl => 'Truy cập URL đích';

  @override
  String get result => 'Kết quả';

  @override
  String get editScript => 'Chỉnh sửa Kịch bản';

  @override
  String get numberFormat => 'Định dạng Số';

  @override
  String get nationalNumber => 'Số Quốc gia';

  @override
  String get e164Number => 'Số E164';

  @override
  String get pluginRulesInfo =>
      'Để đảm bảo an toàn, vui lòng chỉ sử dụng plugin từ các nguồn đáng tin cậy. Hãy thoải mái sử dụng các mẫu của chúng tôi để tạo plugin tùy chỉnh của riêng bạn!';

  @override
  String get advancedMode => 'Chế độ Nâng cao';

  @override
  String get pleaseEnterAtLeastOneNumber => 'Vui lòng nhập ít nhất một số.';

  @override
  String get openInWebView => 'Mở trong WebView';

  @override
  String get pluginLabel => 'Nhãn Plugin';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Màu nền Tin nhắn';

  @override
  String get clearAllCallLogs => 'Xóa Tất cả Nhật ký Cuộc gọi';

  @override
  String get clearAllCallLogsConfirmation =>
      'Xác nhận xóa tất cả nhật ký cuộc gọi';

  @override
  String get allCallLogsCleared => 'Tất cả nhật ký cuộc gọi đã được xóa';

  @override
  String get unblocked => 'Đã bỏ chặn';

  @override
  String get blockNumber => 'Chặn Số';

  @override
  String get blockNumberSuccess => 'Chặn số thành công';

  @override
  String get blockNumberFailed => 'Chặn số thất bại';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Bạn có chắc chắn muốn bỏ chặn $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Đang gọi $phoneNumber...';
  }

  @override
  String get viewDetails => 'Xem Chi tiết';

  @override
  String get unblock => 'Bỏ chặn';

  @override
  String get unblockNumber => 'Bỏ Chặn Số';

  @override
  String get unblockNumberSuccess => 'Bỏ chặn số thành công';

  @override
  String get unblockNumberFailed => 'Bỏ chặn số thất bại';

  @override
  String get serviceNotAvailable => 'Dịch vụ không khả dụng';

  @override
  String get callingNumberFailed => 'Gọi số thất bại';

  @override
  String get listView => 'Chế độ xem Danh sách';

  @override
  String get timelineView => 'Chế độ xem Dòng thời gian';

  @override
  String get nameCannotBeEmpty => 'Tên không được để trống';

  @override
  String get selectAction => 'Chọn hành động';

  @override
  String get selectTargetService => 'Chọn dịch vụ đích';

  @override
  String get callDetails => 'Chi tiết Cuộc gọi';

  @override
  String get callType => 'Loại Cuộc gọi';

  @override
  String get callTime => 'Thời gian Cuộc gọi';

  @override
  String get numberInvalidFormat => 'Định dạng số không hợp lệ';

  @override
  String get membershipFeature => 'Tính năng Thành viên';

  @override
  String get medium => 'Trung bình';

  @override
  String get verificationReport => 'Báo cáo Xác minh';

  @override
  String get finalRisk => 'Rủi ro Cuối cùng';

  @override
  String get simState => 'Trạng thái SIM';

  @override
  String get ipCountry => 'Quốc gia IP';

  @override
  String get simCountry => 'Quốc gia SIM';

  @override
  String get isRoaming => 'Chuyển vùng';

  @override
  String get isNumberMatch => 'Khớp số';

  @override
  String get support => 'Hỗ trợ';

  @override
  String get rewardedAdService => 'Dịch vụ Quảng cáo Thưởng';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Bạn đã có đặc quyền VIP (ngoại trừ quảng cáo)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Bạn đã có đặc quyền tạm thời, ngày hết hạn: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Bạn cần xem thêm $count quảng cáo để nhận đặc quyền VIP tạm thời';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Bạn đã được cấp $days ngày đặc quyền mua hàng tạm thời. Ngày hết hạn: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Đặc quyền mua hàng tạm thời đã hết hạn';

  @override
  String get loadingAd => 'Đang tải Quảng cáo...';

  @override
  String get earnedTempVip => 'Đã nhận VIP tạm thời';

  @override
  String get vipExchangeService => 'Dịch vụ Đổi VIP';

  @override
  String get marksInsufficient => 'Không đủ điểm để đổi';

  @override
  String get invalidExchangeRule => 'Quy tắc đổi không hợp lệ';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Đổi thành công $description, ngày hết hạn: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Đổi thất bại: $error';
  }

  @override
  String get vip3DaysWithAds => 'VIP 3 ngày có quảng cáo (chỉ đồng bộ)';

  @override
  String get vip5DaysNoAds => 'VIP 5 ngày đầy đủ tính năng, không quảng cáo';

  @override
  String get vip7DaysNoAds => 'VIP 7 ngày đầy đủ tính năng, không quảng cáo';

  @override
  String get noNotifications => 'Không có thông báo nào';

  @override
  String get clearAllNotifications => 'Xóa Tất cả Thông báo';

  @override
  String get clearAllNotificationsConfirmation =>
      'Xác nhận xóa tất cả thông báo';

  @override
  String get allNotificationsCleared => 'Đã xóa tất cả thông báo';

  @override
  String get clearButton => 'Xóa';

  @override
  String get justNow => 'Vừa xong';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count phút trước',
      one: '1 phút trước',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giờ trước',
      one: '1 giờ trước',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày trước',
      one: '1 ngày trước',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Hôm qua';

  @override
  String get deletionProposal => 'Đề xuất xóa';

  @override
  String get deletionProposals => 'Các đề xuất xóa';

  @override
  String get createProposal => 'Tạo đề xuất';

  @override
  String get createProposalTitle => 'Tạo đề xuất xóa';

  @override
  String get reason => 'Lý do';

  @override
  String get reasonOutdated => 'Số điện thoại lỗi thời';

  @override
  String get reasonPrivacy => 'Vấn đề riêng tư';

  @override
  String get reasonNotInService => 'Không còn sử dụng';

  @override
  String get reasonWronglyIdentified => 'Nhận dạng sai';

  @override
  String get reasonInaccurateInfo => 'Thông tin không chính xác';

  @override
  String get reasonWrongMarked => 'Đánh dấu sai';

  @override
  String get reasonOther => 'Khác';

  @override
  String get submit => 'Gửi';

  @override
  String get cancel => 'Hủy';

  @override
  String get proposalStatus => 'Trạng thái';

  @override
  String get statusPending => 'Đang chờ';

  @override
  String get statusActive => 'Hoạt động';

  @override
  String get statusCompleted => 'Hoàn thành';

  @override
  String get statusExpired => 'Đã hết hạn';

  @override
  String get riskLevel => 'Mức độ rủi ro';

  @override
  String get riskLevelVerified => 'Đã xác minh';

  @override
  String get riskLevelLow => 'Thấp';

  @override
  String get riskLevelHigh => 'Cao';

  @override
  String get riskLevelUnknown => 'Không xác định';

  @override
  String get votingProgress => 'Tiến độ bỏ phiếu';

  @override
  String agreeVotes(int count) {
    return 'Đồng ý: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Không đồng ý: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Tổng cộng: $count';
  }

  @override
  String get voteAgree => 'Đồng ý';

  @override
  String get voteDisagree => 'Không đồng ý';

  @override
  String createdAt(String date) {
    return 'Được tạo: $date';
  }

  @override
  String get showReport => 'Hiển thị báo cáo';

  @override
  String get hideReport => 'Ẩn báo cáo';

  @override
  String get proposalStatistics => 'Thống kê đề xuất';

  @override
  String get totalProposals => 'Tổng số đề xuất';

  @override
  String get activeProposals => 'Đề xuất đang hoạt động';

  @override
  String get completedProposals => 'Đề xuất đã hoàn thành';

  @override
  String get myVotes => 'Phiếu bầu của tôi';

  @override
  String get proposalCreated => 'Đề xuất đã được tạo thành công';

  @override
  String get proposalCreateFailed => 'Không thể tạo đề xuất';

  @override
  String get voteSubmitted => 'Phiếu bầu đã được gửi thành công';

  @override
  String get voteSubmitFailed => 'Không thể gửi phiếu bầu';

  @override
  String get noProposalsFound => 'Không tìm thấy đề xuất nào';

  @override
  String get loadingProposals => 'Đang tải đề xuất...';

  @override
  String get refreshProposals => 'Làm mới đề xuất';

  @override
  String get totalPendingProposals => 'Tổng số đề xuất đang chờ';

  @override
  String get highRisk => 'Rủi ro cao';

  @override
  String get mediumRisk => 'Rủi ro trung bình';

  @override
  String get lowRisk => 'Rủi ro thấp';

  @override
  String get communityImpact => 'Tác động cộng đồng';

  @override
  String get criticalIssues => 'Vấn đề nghiêm trọng';

  @override
  String get communityParticipation => 'Tham gia cộng đồng';

  @override
  String get noActivity => 'Không có hoạt động';

  @override
  String get low => 'Thấp';

  @override
  String get moderate => 'Trung bình';

  @override
  String get high => 'Cao';

  @override
  String get veryHigh => 'Rất cao';

  @override
  String get voted => 'Đã bầu';

  @override
  String get communityVotes => 'Bình chọn cộng đồng';

  @override
  String get waitingForMoreVotes => 'Đang chờ thêm phiếu bầu từ cộng đồng';

  @override
  String get proposalProcessed => 'Đề xuất này đã được xử lý';

  @override
  String get supported => 'ĐƯỢC HỖ TRỢ';

  @override
  String get opposed => 'BỊ PHẢN ĐỐI';

  @override
  String get approved => 'ĐÃ PHÊ DUYỆT';

  @override
  String get rejected => 'BỊ TỪ CHỐI';

  @override
  String get completed => 'HOÀN THÀNH';

  @override
  String get pending => 'ĐANG CHỜ';

  @override
  String get critical => 'Nghiêm trọng';

  @override
  String get oppose => 'Phản đối';

  @override
  String get veryLow => 'Rất thấp';

  @override
  String get deletionProposalNotificationDescription =>
      'Thông báo về kết quả bỏ phiếu đề xuất xóa và cập nhật.';

  @override
  String get deletionProposalCreated => 'Đã tạo đề xuất xóa';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Đề xuất xóa của bạn cho số $phoneNumber đã được gửi để cộng đồng xem xét.';
  }

  @override
  String get proposalApproved => 'Đề xuất đã được phê duyệt ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Đề xuất xóa cho số $phoneNumber đã được cộng đồng phê duyệt ($supportPercentage% ủng hộ, $totalVotes phiếu bầu).';
  }

  @override
  String get proposalRejected => 'Đề xuất bị từ chối ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Đề xuất xóa cho số $phoneNumber đã bị cộng đồng từ chối ($supportPercentage% ủng hộ, $totalVotes phiếu bầu).';
  }

  @override
  String get communityVotingStarted => 'Bỏ phiếu cộng đồng đã bắt đầu';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Một đề xuất xóa mới cho số $phoneNumber hiện đã mở để cộng đồng bỏ phiếu.';
  }

  @override
  String get votingCompleted => 'Bỏ phiếu đã hoàn thành';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Bỏ phiếu cộng đồng cho số $phoneNumber đã kết thúc. Kết quả: $result ($supportPercentage% ủng hộ).';
  }

  @override
  String get newVoteReceived => 'Đã nhận được phiếu bầu mới';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Ai đó đã bầu $voteType việc xóa số $phoneNumber. Phiếu bầu hiện tại: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Không thể tải số phiếu bầu';

  @override
  String get voteCount => 'Số phiếu bầu';

  @override
  String get deletionProposalInfo => 'Thông tin đề xuất xóa';

  @override
  String get deletionProposalDescription =>
      'Đề xuất các số điện thoại để xóa nếu vi phạm nguyên tắc cộng đồng. Sự tham gia của bạn giúp giữ cho nền tảng an toàn.';

  @override
  String get voteToEarnVip => 'Bỏ phiếu cho các đề xuất để kiếm đặc quyền VIP!';

  @override
  String get voteFailed => 'Bỏ phiếu thất bại';

  @override
  String get searchProposals => 'Tìm kiếm đề xuất';

  @override
  String get defaultNotifications => 'Thông báo mặc định';

  @override
  String get defaultNotificationsDescription =>
      'Kênh thông báo mặc định cho ứng dụng.';

  @override
  String get blockedCallNotifications => 'Thông báo cuộc gọi bị chặn';

  @override
  String get blockedCallNotificationsDescription =>
      'Hiển thị thông tin về các cuộc gọi bị chặn.';

  @override
  String get stirVerification => 'Xác minh STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Hiển thị kết quả xác minh STIR/SHAKEN cho các số điện thoại.';

  @override
  String get fraudAlerts => 'Cảnh báo lừa đảo';

  @override
  String get fraudAlertsDescription =>
      'Hiển thị cảnh báo cho các cuộc gọi có khả năng lừa đảo.';

  @override
  String get notificationFrequencyDescription =>
      'Chọn tần suất bạn nhận thông báo về các đề xuất xóa mới. Bạn có thể nhận ngay lập tức, theo đợt, hoặc theo khoảng thời gian tùy chỉnh.';

  @override
  String get immediateNotifications => 'Ngay lập tức';

  @override
  String get immediateNotificationsDescription =>
      'Nhận thông báo ngay khi đề xuất được tạo.';

  @override
  String get batchNotifications => 'Theo đợt';

  @override
  String get batchNotificationsDescription =>
      'Nhận bản tóm tắt thông báo định kỳ.';

  @override
  String get customNotifications => 'Tùy chỉnh';

  @override
  String get customNotificationsDescription =>
      'Xác định khoảng thời gian nhận thông báo của riêng bạn.';

  @override
  String get customFrequency => 'Tần suất tùy chỉnh';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes phút';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours giờ';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours giờ $minutes phút';
  }

  @override
  String get pendingProposals => 'Đề xuất đang chờ xử lý';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count đề xuất đang chờ xử lý',
      one: '1 đề xuất đang chờ xử lý',
      zero: 'không có đề xuất nào đang chờ xử lý',
    );
    return 'Bạn có $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Hướng dẫn';

  @override
  String get reportingGuidelines =>
      '• Chỉ báo cáo các số thực sự có vấn đề\n• Cung cấp lý do chính xác và chi tiết\n• Chọn mức độ rủi ro phù hợp dựa trên mức độ nghiêm trọng\n• Báo cáo sai có thể dẫn đến hạn chế tài khoản';

  @override
  String get riskLevelLabel => 'Mức độ rủi ro';

  @override
  String get riskLevelDescription => 'Mức độ rủi ro của số điện thoại';

  @override
  String get phoneNumberMinDigits => 'Số điện thoại phải có ít nhất 7 chữ số';

  @override
  String get provideDetailedExplanation =>
      'Cung cấp giải thích chi tiết (tối thiểu 10 ký tự)';

  @override
  String get reasonMinCharacters => 'Lý do phải có ít nhất 10 ký tự';

  @override
  String get countryCodeTwoLetters => 'Mã quốc gia (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Mã quốc gia (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'Ví dụ: US, CN, GB';

  @override
  String get countryCodeRequired => 'Mã quốc gia là bắt buộc';

  @override
  String get countryCodeLengthError => 'Mã quốc gia phải có 2 chữ cái';

  @override
  String get phoneNumberLengthError => 'Số điện thoại phải có ít nhất 7 chữ số';

  @override
  String get reasonHint => 'Cung cấp giải thích chi tiết (tối thiểu 10 ký tự)';

  @override
  String get reasonRequired => 'Lý do là bắt buộc';

  @override
  String get reasonLengthError => 'Lý do phải có ít nhất 10 ký tự';

  @override
  String get guidelinesTitle => 'Hướng dẫn';

  @override
  String get guidelinesText =>
      '• Chỉ báo cáo các số thực sự có vấn đề\n• Cung cấp lý do chính xác và chi tiết\n• Chọn mức độ rủi ro phù hợp dựa trên mức độ nghiêm trọng\n• Báo cáo sai có thể dẫn đến hạn chế tài khoản';

  @override
  String get riskLevelCritical => 'Nghiêm trọng';

  @override
  String get riskLevelMedium => 'Trung bình';

  @override
  String get riskLevelVeryLow => 'Rất thấp';

  @override
  String get riskDescriptionVeryLow =>
      'Rất thấp - Gây phiền nhiễu nhỏ, cuộc gọi không thường xuyên';

  @override
  String get riskDescriptionLow =>
      'Thấp - Cuộc gọi không mong muốn thỉnh thoảng';

  @override
  String get riskDescriptionMedium =>
      'Trung bình - Thư rác hoặc tiếp thị qua điện thoại thường xuyên';

  @override
  String get riskDescriptionHigh =>
      'Cao - Quấy rối dai dẳng hoặc cố gắng lừa đảo';

  @override
  String get riskDescriptionCritical =>
      'Nghiêm trọng - Lừa đảo hoặc đe dọa nguy hiểm';

  @override
  String get notificationFrequencyTitle => 'Tần suất thông báo';

  @override
  String get notificationFrequencyLabel => 'Tần suất thông báo (giờ)';

  @override
  String errorMessage(String error) {
    return 'Lỗi: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Phiếu bầu: $totalVotes ($supportPercentage% ủng hộ)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Ủng hộ ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Phản đối ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Vừa xong';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes phút trước';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours giờ trước';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days ngày trước';
  }

  @override
  String get notificationFrequencyHours => 'Tần suất thông báo (Giờ)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes phiếu bầu ($supportPercentage% ủng hộ)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giờ',
      one: '1 giờ',
      zero: '0 giờ',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Thông báo quan trọng';

  @override
  String get dataSourceDisclaimer =>
      'Các số được lấy từ internet và do người dùng gửi. Chúng tôi không thể đảm bảo rằng một số, sau khi bị xóa, sẽ không được gửi lại bởi những người dùng hoặc nguồn khác. Vui lòng chủ động tìm kiếm và xác minh thông tin.';

  @override
  String get avatar => 'Hình đại diện';

  @override
  String get location => 'Vị trí';

  @override
  String get simCardTitle => 'Thẻ SIM';

  @override
  String get liveActivitiesSettingsTitle => 'Cài đặt Hoạt động trực tiếp';

  @override
  String get elementsSettingsTitle => 'Cài đặt thành phần';

  @override
  String get liveActivityMode => 'Hoạt động trực tiếp';

  @override
  String get liveActivityModeDescription =>
      'Hiển thị thông tin cuộc gọi dưới dạng thông báo cố định trên màn hình khóa và Đảo động (iOS).';

  @override
  String get phoneNumberType => 'Loại số điện thoại';

  @override
  String get liveActivitiesTestEndActivity => 'Kết thúc hoạt động';

  @override
  String get liveActivitiesTestSendNewActivity => 'Gửi hoạt động mới';

  @override
  String get liveActivitiesTestUpdateActivity => 'Cập nhật hoạt động';

  @override
  String get liveActivityControlsTitle => 'Điều khiển Hoạt động trực tiếp';

  @override
  String get liveActivitiesTestTitle => 'Kiểm tra Hoạt động trực tiếp';

  @override
  String get liveActivitiesTestSubtitle =>
      'Kiểm tra thông báo hoạt động trực tiếp.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Tùy chỉnh thông báo trực tiếp';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Tùy chỉnh giao diện của các thông báo trực tiếp.';

  @override
  String get notification_instructions =>
      'Hướng dẫn:\n1. Nhấn \"GỬI\" để tạo hoặc cập nhật thông báo.\n2. Đi tới màn hình chính hoặc kéo xuống khay thông báo để xem kết quả.\n3. Nhấn \"KẾT THÚC\" để loại bỏ thông báo.';

  @override
  String get autoCancelNotification => 'Tự động hủy thông báo';

  @override
  String get autoCancelNotificationDescription =>
      'Nếu được chọn, thông báo sẽ tự động bị loại bỏ khi người dùng nhấn vào.';

  @override
  String get setDelayTime => 'Đặt thời gian trễ';

  @override
  String get proposalDetails => 'Chi tiết đề xuất';

  @override
  String get filterByStatus => 'Lọc theo trạng thái';

  @override
  String get proposalNotFound => 'Không tìm thấy đề xuất';

  @override
  String get processed => 'Đã xử lý';

  @override
  String get showAll => 'Hiển thị tất cả';

  @override
  String get filterAndSortTitle => 'Lọc và Sắp xếp';

  @override
  String get filterVerifiedOwner => 'Lọc Chủ sở hữu đã xác minh';

  @override
  String get filterBy => 'Lọc theo';

  @override
  String get sortOldest => 'Sắp xếp cũ nhất';

  @override
  String get sortNewest => 'Sắp xếp mới nhất';

  @override
  String get sortMostPopular => 'Sắp xếp phổ biến nhất';

  @override
  String get sortLeastPopular => 'Sắp xếp ít phổ biến nhất';

  @override
  String get sortBy => 'Sắp xếp theo';

  @override
  String get simRulesNotFound => 'Không tìm thấy quy tắc SIM';

  @override
  String get simSlotRules => 'Quy tắc khe SIM';

  @override
  String get noSimCardDetected => 'Không phát hiện thẻ SIM';

  @override
  String get invalidSimData => 'Dữ liệu SIM không hợp lệ';

  @override
  String get simCardData => 'Dữ liệu thẻ SIM';

  @override
  String get simSlot => 'Khe SIM';

  @override
  String get enableFiltering => 'Bật lọc';

  @override
  String get detailedSettingsTitle => 'Cài đặt chi tiết';

  @override
  String get entryPointViewTitle => 'Màn hình điểm vào';

  @override
  String get callTypeRejected => 'Từ chối';

  @override
  String get callTypeSilenced => 'Im lặng';

  @override
  String get callTypeVoicemail => 'Thư thoại';

  @override
  String get callTypeUnknownIntercept => 'Chặn không xác định';

  @override
  String andMoreItems(int count) {
    return 'và $count mục khác';
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
