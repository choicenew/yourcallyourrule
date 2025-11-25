// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get aboutContactSubscription => 'เกี่ยวกับ การสมัครรับข้อมูลผู้ติดต่อ';

  @override
  String get aboutLabels => 'เกี่ยวกับ ป้ายกำกับ';

  @override
  String get aboutPhoneSubscriptionRules =>
      'เกี่ยวกับ กฎการสมัครรับข้อมูลโทรศัพท์';

  @override
  String get aboutPhoneSubscriptions => 'เกี่ยวกับ การสมัครรับข้อมูลโทรศัพท์';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'สมัครรับรายการกฎโทรศัพท์ผ่าน URL อัปเดตกฎโดยอัตโนมัติ รองรับไฟล์กฎรูปแบบ JSON, CSV';

  @override
  String get aboutSmsFilter => 'เกี่ยวกับ การกรอง SMS';

  @override
  String get aboutSmsSubscriptionRules => 'เกี่ยวกับ กฎการสมัครรับข้อมูล SMS';

  @override
  String get aboutSubtitle => 'ข้อมูลเวอร์ชันแอปพลิเคชันและข้อมูลทางกฎหมาย';

  @override
  String get aboutTitle => 'เกี่ยวกับ';

  @override
  String get action => 'การดำเนินการ';

  @override
  String get actionAll => 'ทั้งหมด';

  @override
  String get actionAllow => 'อนุญาต';

  @override
  String get actionBlock => 'บล็อก';

  @override
  String get actionFilterAll => 'ตัวกรองทั้งหมด';

  @override
  String get actionFilterTitle => 'กรองตามประเภทการดำเนินการ';

  @override
  String get actionFilterTooltip => 'ตัวกรองการดำเนินการ';

  @override
  String get actionNone => 'ไม่มีการดำเนินการ';

  @override
  String get actionSilence => 'ปิดเสียง';

  @override
  String actionTag(Object actionType) {
    return 'การดำเนินการ: $actionType';
  }

  @override
  String get actionType => 'ประเภทการดำเนินการ';

  @override
  String get actionUnknown => 'ไม่รู้จัก';

  @override
  String get add => 'เพิ่ม';

  @override
  String get addAllowedBlockedRule => 'เพิ่มกฎอนุญาต/บล็อก';

  @override
  String get addAllowSubscription => 'เพิ่มการสมัครรับข้อมูลอนุญาต';

  @override
  String get addBlockSubscription => 'เพิ่มการสมัครรับข้อมูลบล็อก';

  @override
  String get addContactButton => 'เพิ่มผู้ติดต่อ';

  @override
  String addContactFailed(Object error) {
    return 'เพิ่มผู้ติดต่อไม่สำเร็จ: $error';
  }

  @override
  String get addedToAllowedRules => 'เพิ่มในกฎที่อนุญาตแล้ว';

  @override
  String get addedToBlacklist => 'เพิ่มในรายการบล็อกแล้ว';

  @override
  String get addedToBlockedRules => 'เพิ่มในกฎที่บล็อกแล้ว';

  @override
  String get addedToFavoriteContacts => 'เพิ่มในผู้ติดต่อที่ชื่นชอบแล้ว';

  @override
  String get addedToFavorites => 'เพิ่มในรายการโปรดแล้ว';

  @override
  String get addedToWhitelist => 'เพิ่มในรายการที่อนุญาตแล้ว';

  @override
  String get addFavorite => 'เพิ่มรายการโปรด';

  @override
  String get addFilter => 'เพิ่มตัวกรอง';

  @override
  String get addLabel => 'เพิ่มป้ายกำกับ';

  @override
  String get addLabelButton => 'เพิ่มป้ายกำกับ';

  @override
  String addLabelFailed(Object error) {
    return 'เพิ่มป้ายกำกับไม่สำเร็จ: $error';
  }

  @override
  String get addLabelToCall => 'เพิ่มป้ายกำกับไปยังบันทึกการโทร';

  @override
  String get addName => 'เพิ่มชื่อ';

  @override
  String get addNoneSubscription => 'เพิ่มการสมัครรับข้อมูลไม่มี';

  @override
  String get addOrEditContactInfo => 'ใช้เพื่อเพิ่มหรือแก้ไขข้อมูลผู้ติดต่อ';

  @override
  String get addPhoneMark => 'เพิ่มเครื่องหมายโทรศัพท์';

  @override
  String get addPhoneNumberRule => 'เพิ่มกฎหมายเลขโทรศัพท์';

  @override
  String get addPlugin => 'เพิ่มปลั๊กอิน';

  @override
  String get addPluginFailed => 'เพิ่มปลั๊กอินไม่สำเร็จ';

  @override
  String addPluginFailedWithError(Object error) {
    return 'เพิ่มปลั๊กอินไม่สำเร็จ: $error';
  }

  @override
  String get addPluginFromLocalFile => 'เพิ่มปลั๊กอินจากไฟล์ในเครื่อง';

  @override
  String get addPluginFromUrl => 'เพิ่มปลั๊กอินจาก URL';

  @override
  String get addRegexRule => 'เพิ่มกฎ Regex';

  @override
  String get addRule => 'เพิ่มกฎ';

  @override
  String get addRuleButton => 'เพิ่มกฎ';

  @override
  String addRuleFailed(Object error) {
    return 'เพิ่มกฎไม่สำเร็จ: $error';
  }

  @override
  String get addRuleTooltip => 'เพิ่มกฎ';

  @override
  String get addSilenceSubscription => 'เพิ่มการสมัครรับข้อมูลปิดเสียง';

  @override
  String get addSimRuleButton => 'เพิ่มกฎ SIM';

  @override
  String get addSmsFilterRule => 'เพิ่มกฎตัวกรอง SMS';

  @override
  String get addSmsRule => 'เพิ่มกฎ SMS';

  @override
  String get addSmsSubscription => 'เพิ่มการสมัครรับข้อมูล SMS';

  @override
  String get addSubscription => 'เพิ่มการสมัครรับข้อมูล';

  @override
  String get addSubscriptionButton => 'เพิ่มการสมัครรับข้อมูล';

  @override
  String addSubscriptionFailed(Object error) {
    return 'เพิ่มการสมัครรับข้อมูลไม่สำเร็จ: $error';
  }

  @override
  String get addSubscriptionTooltip => 'เพิ่มการสมัครรับข้อมูล';

  @override
  String get addToAllowedRules => 'เพิ่มในกฎที่อนุญาต';

  @override
  String get addToBlacklist => 'เพิ่มในรายการบล็อก';

  @override
  String get addToBlockedRules => 'เพิ่มในกฎที่บล็อก';

  @override
  String get addToFavoriteContacts => 'เพิ่มในผู้ติดต่อที่ชื่นชอบ';

  @override
  String get addToFavorites => 'เพิ่มในรายการโปรด';

  @override
  String get addToRules => 'เพิ่มในกฎ';

  @override
  String get addToWhitelist => 'เพิ่มในรายการที่อนุญาต';

  @override
  String get adPlaceholder => 'ช่องโฆษณา';

  @override
  String get agent => 'ตัวแทน';

  @override
  String get all => 'ทั้งหมด';

  @override
  String get allCallsTab => 'ทั้งหมด';

  @override
  String get allDataClearedSuccessfully => 'ล้างข้อมูลทั้งหมดสำเร็จแล้ว';

  @override
  String get allow => 'อนุญาต';

  @override
  String get allowAllAllowRules => 'อนุญาตกฎอนุญาตทั้งหมด';

  @override
  String get allowAllAllowRulesDesc => 'อนุญาตการโทรจากกฎอนุญาต';

  @override
  String get allowAllBlacklistedNumbers =>
      'อนุญาตหมายเลขที่อยู่ในรายการบล็อกทั้งหมด';

  @override
  String get allowAllBlacklistedNumbersDesc => 'อนุญาตการโทรจากรายการบล็อก';

  @override
  String get allowAllBlockRules => 'อนุญาตกฎบล็อกทั้งหมด';

  @override
  String get allowAllBlockRulesDesc => 'อนุญาตการโทรจากกฎบล็อก';

  @override
  String get allowAllowedNumbers => 'อนุญาตหมายเลขที่อนุญาต';

  @override
  String get allowAllowedNumbersDesc => 'อนุญาตการโทรจากรายการที่อนุญาต';

  @override
  String get allowBlock => 'อนุญาต/บล็อก';

  @override
  String get allowBlockedNumbers => 'อนุญาตหมายเลขที่บล็อก';

  @override
  String get allowBlockedNumbersDesc => 'อนุญาตการโทรจากรายการบล็อก';

  @override
  String get allowedBlockedRule => 'กฎอนุญาต/บล็อก';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'แก้ไขกฎอนุญาต/บล็อก';

  @override
  String get allowedBlockedRuleManagement => 'การจัดการกฎอนุญาต/บล็อก';

  @override
  String get allowNonExceededNumbers => 'อนุญาตหมายเลขที่ไม่เกิน';

  @override
  String get allowNonExceededNumbersDescription =>
      'อนุญาตหมายเลขโดยอัตโนมัติที่ไม่เกินเกณฑ์จำนวน';

  @override
  String get allowRegexAllowRules => 'อนุญาตกฎ Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'เปิดใช้งานการจับคู่รูปแบบ regex สำหรับกฎอนุญาต';

  @override
  String get allowRegexAllowRulesDescription =>
      'เปิดใช้งานกฎตามรูปแบบ Regex สำหรับการอนุญาต';

  @override
  String get allowRegexBlockRules => 'อนุญาตกฎ Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'เปิดใช้งานการจับคู่รูปแบบ regex สำหรับกฎบล็อก';

  @override
  String get allowRegexBlockRulesDescription =>
      'เปิดใช้งานกฎตามรูปแบบ Regex สำหรับการบล็อก';

  @override
  String get allowRule => 'กฎอนุญาต';

  @override
  String get allowRules => 'กฎอนุญาต';

  @override
  String get allowWhitelistedNumbers => 'อนุญาตหมายเลขในรายการที่อนุญาต';

  @override
  String get allowWhitelistedNumbersDescription =>
      'อนุญาตหมายเลขทั้งหมดในรายการที่อนุญาต';

  @override
  String get allPermissionsGranted => 'ได้รับสิทธิ์ทั้งหมดแล้ว';

  @override
  String get allSettingsCompleted => 'ตั้งค่าทั้งหมดเสร็จสมบูรณ์แล้ว';

  @override
  String allUpdateSuccess(Object count) {
    return 'อัปเดตทั้งหมดเสร็จสมบูรณ์แล้ว ($count กฎ)';
  }

  @override
  String get answerThenHangup => 'รับสายแล้ววางสาย';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. สงวนลิขสิทธิ์.';

  @override
  String get applicationSoftware => 'ซอฟต์แวร์แอปพลิเคชัน';

  @override
  String get apply => 'ใช้';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'การยืนยันตัวตนล้มเหลว: โปรดตรวจสอบรหัสไคลเอ็นต์และคีย์';

  @override
  String get authorizationFailedMessage => 'การยืนยันตัวตนล้มเหลว';

  @override
  String get authorizationSuccessMessage => 'การยืนยันตัวตนสำเร็จ';

  @override
  String get authorizeLoginButton => 'อนุญาตการเข้าสู่ระบบ';

  @override
  String get automotiveIndustry => 'อุตสาหกรรมยานยนต์';

  @override
  String get autoSyncLabel => 'ซิงค์อัตโนมัติ';

  @override
  String get autoUpdate => 'อัปเดตอัตโนมัติ';

  @override
  String get autoUpdateDescription =>
      'ตั้งค่าช่วงเวลาอัปเดตอัตโนมัติสำหรับการสมัครสมาชิกหรืออัปเดตด้วยตนเอง';

  @override
  String get autoUpdateSettings => 'การตั้งค่าอัปเดตอัตโนมัติ';

  @override
  String get autoUpdateSettingsSubtitle =>
      'จัดการการอัปเดตอัตโนมัติสำหรับกฎและปลั๊กอิน';

  @override
  String get autoUpdateSettingsTitle => 'การตั้งค่าอัปเดตอัตโนมัติ';

  @override
  String get autoUpdateSubtitle =>
      'จัดการการอัปเดตอัตโนมัติสำหรับกฎและปลั๊กอิน';

  @override
  String get autoUpdateTitle => 'อัปเดตอัตโนมัติ';

  @override
  String get avatarBorderColor => 'สีขอบอวาตาร์';

  @override
  String get avatarBorderSize => 'ขนาดขอบอวาตาร์';

  @override
  String get avatarIconSizesSetting => 'ขนาดอวาตาร์และไอคอน';

  @override
  String get avatarPosition => 'ตำแหน่งอวาตาร์';

  @override
  String get avatarSize => 'ขนาดอวาตาร์';

  @override
  String axisPosition(Object axis) {
    return 'ตำแหน่ง $axis';
  }

  @override
  String get backgroundGradientSetting => 'การไล่ระดับสีพื้นหลัง';

  @override
  String get backup => 'สำรองข้อมูล';

  @override
  String get backupAndRestore => 'สำรองและกู้คืน';

  @override
  String get backupAndRestoreSubtitle => 'สำรองหรือกู้คืนข้อมูลแอปพลิเคชัน';

  @override
  String get backupAndRestoreTitle => 'สำรองและกู้คืน';

  @override
  String get backupFailed => 'การสำรองข้อมูลล้มเหลว';

  @override
  String get backupFailedMessage => 'การสำรองข้อมูลล้มเหลว';

  @override
  String backupFailedWithError(Object error) {
    return 'การสำรองข้อมูลล้มเหลว: $error';
  }

  @override
  String get backupRestoreSubtitle => 'สำรองหรือกู้คืนข้อมูลแอปพลิเคชัน';

  @override
  String get backupRestoreTitle => 'สำรองและกู้คืน';

  @override
  String get backupSectionTitle => 'สำรองข้อมูล';

  @override
  String get backupSettings => 'การตั้งค่าสำรองข้อมูล';

  @override
  String get backupSettingsDialogTitle => 'การตั้งค่าสำรองข้อมูล';

  @override
  String get backupSettingsTitle => 'การตั้งค่าสำรองข้อมูล';

  @override
  String get backupSuccessMessage => 'สำรองข้อมูลไปยังคลาวด์สำเร็จแล้ว';

  @override
  String backupSuccessToLocal(Object path) {
    return 'การสำรองข้อมูลสำเร็จไปยัง: $path';
  }

  @override
  String get backupToCloud => 'สำรองข้อมูลไปยังคลาวด์';

  @override
  String get backupToCloudDescription =>
      'สำรองการตั้งค่าและกฎไปยังที่จัดเก็บข้อมูลบนคลาวด์';

  @override
  String backupToCloudFailed(Object error) {
    return 'ไม่สามารถสำรองข้อมูลไปยังคลาวด์ได้: $error';
  }

  @override
  String get backupToCloudLabel => 'สำรองข้อมูลไปยังคลาวด์';

  @override
  String get backupToCloudSuccess => 'สำรองข้อมูลไปยังคลาวด์สำเร็จแล้ว';

  @override
  String get backupToCloudTitle => 'สำรองข้อมูลไปยังคลาวด์';

  @override
  String get backupToLocalLabel => 'สำรองข้อมูลไปยังเครื่อง';

  @override
  String get bank => 'ธนาคาร';

  @override
  String get basicInfo => 'ข้อมูลพื้นฐาน';

  @override
  String get basicRuleFilter => 'ตัวกรองกฎพื้นฐาน';

  @override
  String get basicRuleFiltering => 'การกรองกฎพื้นฐาน';

  @override
  String get basicRuleFilteringExplanation =>
      '• การกรองกฎพื้นฐาน: กรองกฎตามรายการที่ถูกบล็อก รายการที่อนุญาต และนิพจน์ทั่วไป';

  @override
  String get basicRuleFilterSettings => 'การตั้งค่าตัวกรองกฎพื้นฐาน';

  @override
  String get basicRuleFilterSubtitle =>
      'กรองการโทรโดยใช้รายการที่ถูกบล็อก/รายการที่อนุญาต และนิพจน์ทั่วไป';

  @override
  String get batchDeleteContacts => 'ลบผู้ติดต่อจำนวนมาก';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบผู้ติดต่อที่เลือก $count รายการ';
  }

  @override
  String get batchDeleteFailed => 'การลบจำนวนมากไม่สำเร็จ';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบป้ายกำกับ $count รายการ';
  }

  @override
  String get blacklist => 'รายการที่ถูกบล็อก';

  @override
  String get blacklistingAndWhitelisting => 'การบล็อกและการอนุญาต';

  @override
  String get blacklistLabel => 'รายการที่ถูกบล็อก';

  @override
  String get blackWhiteList => 'รายการที่ถูกบล็อก/รายการที่อนุญาต';

  @override
  String get block => 'บล็อก';

  @override
  String get blockCalls => 'บล็อกการโทร';

  @override
  String get blocked => 'ถูกบล็อก';

  @override
  String get blockedCallAction => 'การดำเนินการเมื่อมีสายที่ถูกบล็อก';

  @override
  String get blockedCalls => 'สายที่ถูกบล็อก';

  @override
  String get blockedCallsTitle => 'สายที่ถูกบล็อก';

  @override
  String get blockedCommunications => 'การสื่อสารที่ถูกบล็อก';

  @override
  String get blockedPhoneLabel => 'สายที่ถูกบล็อก';

  @override
  String get blockedSpamCalls => 'สายสแปมที่ถูกบล็อก';

  @override
  String get blockingTrend => 'แนวโน้มการบล็อก';

  @override
  String get blockInternationalCalls =>
      'ตรงกับหมายเลขที่ไม่ขึ้นต้นด้วย + หรือ 00';

  @override
  String get blockInternationalCallsTitle => 'บล็อกสายต่างประเทศ';

  @override
  String get blockLandlineNumbersTitle => 'บล็อกหมายเลขโทรศัพท์บ้าน';

  @override
  String get blockMobileNumbers => 'ตรงกับหมายเลขที่ไม่ขึ้นต้นด้วย 13-19';

  @override
  String get blockMobileNumbersTitle => 'บล็อกหมายเลขโทรศัพท์มือถือ';

  @override
  String get blockPremiumRateNumbers =>
      'ตรงกับหมายเลขที่ไม่ขึ้นต้นด้วย 118 หรือ 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'บล็อกหมายเลขโทรศัพท์อัตราพรีเมียม';

  @override
  String get blockRule => 'กฎการบล็อก';

  @override
  String get blockRules => 'กฎการบล็อก';

  @override
  String get blockSpecificAreaCodes =>
      'ตรงกับหมายเลขที่ขึ้นต้นด้วย 0 + 2-3 หลัก';

  @override
  String get blockSpecificAreaCodesTitle => 'บล็อกรหัสพื้นที่เฉพาะ:';

  @override
  String get blockTypeAnalysisTitle => 'การวิเคราะห์ประเภทการบล็อก';

  @override
  String get both => 'ทั้งสอง';

  @override
  String get bulkDelete => 'ลบจำนวนมาก';

  @override
  String get bulkDeleteContacts => 'ลบผู้ติดต่อจำนวนมาก';

  @override
  String get bulkDeleteLabels => 'ลบป้ายกำกับจำนวนมาก';

  @override
  String get call => 'โทร';

  @override
  String get callback => 'โทรกลับ';

  @override
  String callbackTo(String number) {
    return 'โทรกลับไปที่ $number';
  }

  @override
  String get callBlocking => 'การบล็อกสาย';

  @override
  String get callerIdApp => 'แอป ID ผู้โทร';

  @override
  String get callerIdCustomizationTitle => 'ปรับแต่ง ID ผู้โทร';

  @override
  String get callerIdDialogTitle => 'ข้อมูล ID ผู้โทร';

  @override
  String get callerIdDisplayMode => 'รูปแบบการแสดงหมายเลขผู้โทร';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'ถูกทำเครื่องหมายโดย $count';
  }

  @override
  String get callerIdPreview => 'แสดงตัวอย่างหมายเลขผู้โทร';

  @override
  String get callFilter => 'การกรองสาย';

  @override
  String get callFilterDescription =>
      'เมื่อเปิดใช้งาน สายเรียกเข้าจะถูกตรวจสอบกับรายการกฎด้านล่าง โดยปกติแล้ว กฎการกรองสายจะไม่ถูกซิงโครไนซ์ระหว่างอุปกรณ์';

  @override
  String get callFilterRules => 'กฎการกรองสาย';

  @override
  String get callFilterRulesDescription => 'ตั้งค่ากฎพื้นฐานสำหรับการกรองสาย';

  @override
  String get callFilterSettings => 'การตั้งค่าการกรองสาย';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'ตั้งค่าขีดจำกัดความถี่การโทรและกฎการบล็อก';

  @override
  String get callFrequencyInterceptionTitle => 'การดักจับความถี่การโทร';

  @override
  String get callHistory => 'ประวัติการโทร';

  @override
  String get callHistoryInfoDesc =>
      'แสดงประวัติการโทรของคุณที่นี่ รวมถึงสายเรียกเข้า สายโทรออก และสายที่ไม่ได้รับ';

  @override
  String get callHistoryInfoTitle => 'ประวัติการโทร';

  @override
  String callHistoryInitFailed(Object error) {
    return 'ไม่สามารถเริ่มต้นประวัติการโทร: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'ไม่สามารถรีเฟรชประวัติการโทร: $error';
  }

  @override
  String get callHistoryTab => 'ประวัติการโทร';

  @override
  String get callHistoryTimelineEarlier => 'ก่อนหน้านี้';

  @override
  String get callHistoryTimelineToday => 'วันนี้';

  @override
  String get callHistoryTimelineYesterday => 'เมื่อวาน';

  @override
  String get callScreeningPermission => 'สิทธิ์การคัดกรองสาย';

  @override
  String get callScreeningPermissionDescription =>
      'ใช้เพื่อคัดกรองและบล็อกสายสแปม';

  @override
  String get callScreeningPermissionNotGranted =>
      'ไม่ได้รับสิทธิ์การคัดกรองสาย อาจส่งผลต่อการทำงานของแอป';

  @override
  String get callSettingsSubtitle =>
      'การตั้งค่าหมายเลขผู้โทร การกรอง และการบล็อก';

  @override
  String get callSettingsTitle => 'การตั้งค่าการโทร';

  @override
  String get callStatistics => 'สถิติการโทร';

  @override
  String get callTypeAnswered => 'รับสาย';

  @override
  String get callTypeBlocked => 'บล็อก';

  @override
  String get callTypeIconColor => 'สีไอคอนประเภทการโทร';

  @override
  String get callTypeMissed => 'สายที่ไม่ได้รับ';

  @override
  String get callTypeOutgoing => 'สายโทรออก';

  @override
  String get callTypePosition => 'ตำแหน่งประเภทการโทร';

  @override
  String get callTypeUnknown => 'ไม่ทราบ';

  @override
  String get cancelButton => 'ยกเลิก';

  @override
  String get carRental => 'เช่ารถ';

  @override
  String get carrier => 'ผู้ให้บริการ';

  @override
  String get carrierColor => 'สีของผู้ให้บริการ';

  @override
  String get carrierFontSize => 'ขนาดตัวอักษรของผู้ให้บริการ';

  @override
  String get carrierPosition => 'ตำแหน่งของผู้ให้บริการ';

  @override
  String get changeLabel => 'เปลี่ยนป้ายกำกับ';

  @override
  String changePluginStatusFailed(Object error) {
    return 'ไม่สามารถเปลี่ยนสถานะปลั๊กอิน: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'ไม่สามารถเปลี่ยนสถานะการสมัครสมาชิก: $error';
  }

  @override
  String get changeTag => 'เปลี่ยนแท็ก';

  @override
  String get charity => 'การกุศล';

  @override
  String chartMonthFormat(int month) {
    return 'เดือน $month';
  }

  @override
  String get chartOneDayAgo => '1 วันที่แล้ว';

  @override
  String get chartOneMonthAgo => '1 เดือนที่แล้ว';

  @override
  String get chartOneWeekAgo => '1 สัปดาห์ที่แล้ว';

  @override
  String get chartTenDaysAgo => '10 วันที่แล้ว';

  @override
  String get chartThreeDaysAgo => '3 วันที่แล้ว';

  @override
  String get chartToday => 'วันนี้';

  @override
  String get checkFileFormat => 'โปรดตรวจสอบรูปแบบไฟล์หรือสิทธิ์';

  @override
  String checkPermissionFailed(Object error) {
    return 'ไม่สามารถตรวจสอบสิทธิ์: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'เลือกการดำเนินการสกัดกั้นเริ่มต้น';

  @override
  String get clearAllData => 'ล้างข้อมูลทั้งหมด';

  @override
  String get clearAllDataConfirmation =>
      'คุณแน่ใจหรือไม่ว่าต้องการล้างข้อมูลแอปพลิเคชันทั้งหมด? การดำเนินการนี้ไม่สามารถยกเลิกได้';

  @override
  String get clearAllDataDescription => 'ล้างข้อมูลแอปพลิเคชันทั้งหมด';

  @override
  String get clearAllDataLabel => 'ล้างข้อมูลทั้งหมด';

  @override
  String get clearFilter => 'ล้างตัวกรอง';

  @override
  String get clearLabelFilter => 'ล้างตัวกรองป้ายกำกับ';

  @override
  String get clearLabelFilterButton => 'ล้างตัวกรองป้ายกำกับ';

  @override
  String get closeButton => 'ปิด';

  @override
  String get cloudSync => 'การซิงโครไนซ์คลาวด์';

  @override
  String get cloudSyncAndBackupTitle => 'การซิงโครไนซ์คลาวด์และการสำรองข้อมูล';

  @override
  String get cloudSyncSettingsSubtitle =>
      'กำหนดค่า WebDAV, OneDrive และ Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'การตั้งค่าการซิงโครไนซ์คลาวด์';

  @override
  String get cloudSyncTitle => 'การซิงโครไนซ์คลาวด์';

  @override
  String get collapseLabelSelector => 'ยุบตัวเลือกป้ายกำกับ';

  @override
  String get collection => 'การทวงหนี้';

  @override
  String get colorPickerTitle => 'เลือกสี';

  @override
  String get configManagement => 'การจัดการการกำหนดค่า';

  @override
  String get configUpdated => 'การกำหนดค่าอัปเดตแล้ว';

  @override
  String get configurationAdvice =>
      'ด้วยการกำหนดค่าที่เหมาะสม คุณสามารถตั้งค่ากลยุทธ์การกรองที่แตกต่างกันสำหรับซิมการ์ดทำงานและซิมการ์ดส่วนตัว';

  @override
  String get configureBackupOptions => 'กำหนดค่าตัวเลือกการสำรองข้อมูล';

  @override
  String get configureBackupOptionsSubtitle => 'กำหนดค่าตัวเลือกการสำรองข้อมูล';

  @override
  String get configureCloudSyncService => 'กำหนดค่าบริการซิงโครไนซ์คลาวด์';

  @override
  String get configureCloudSyncServiceHint =>
      'โปรดกำหนดค่าบริการซิงโครไนซ์คลาวด์เพื่อเปิดใช้งานการซิงโครไนซ์หลายอุปกรณ์';

  @override
  String get configureCloudSyncServiceMessage =>
      'โปรดกำหนดค่าบริการซิงโครไนซ์คลาวด์เพื่อเปิดใช้งานการซิงโครไนซ์หลายอุปกรณ์';

  @override
  String get configureSimCardFilterRules => 'กำหนดค่ากฎการกรองซิมการ์ด';

  @override
  String get configureSyncServiceHint =>
      'โปรดกำหนดค่าบริการซิงโครไนซ์ในการตั้งค่าการซิงโครไนซ์คลาวด์ก่อน';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get confirmBatchDeleteContacts =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบที่เลือก';

  @override
  String get confirmButton => 'ยืนยัน';

  @override
  String get confirmDelete => 'ยืนยันการลบ';

  @override
  String get confirmDeleteContact => 'คุณแน่ใจหรือไม่ว่าต้องการลบ';

  @override
  String get confirmDeleteContactName => 'ยืนยันการลบ?';

  @override
  String get confirmDeleteFilter => 'คุณแน่ใจหรือไม่ว่าต้องการลบตัวกรองนี้?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบป้ายกำกับ \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบปลั๊กอิน \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $count ปลั๊กอิน?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบกฎนี้? การดำเนินการนี้ไม่สามารถยกเลิกได้';

  @override
  String get confirmDeleteSelectedContacts =>
      'คุณแน่ใจหรือไม่ว่าจะลบรายชื่อติดต่อที่เลือก?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบกฎตัวกรอง SMS นี้?';

  @override
  String get confirmDeleteSmsRule => 'คุณแน่ใจหรือไม่ว่าต้องการลบกฎ SMS นี้?';

  @override
  String get confirmDeleteSubscription =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบการสมัครสมาชิกนี้?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $name?';
  }

  @override
  String get confirmPassword => 'ยืนยันรหัสผ่าน';

  @override
  String get confirmPasswordLabel => 'ยืนยันรหัสผ่าน';

  @override
  String get connectedStatus => 'เชื่อมต่อแล้ว';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'การเชื่อมต่อล้มเหลว: โปรดตรวจสอบที่อยู่เซิร์ฟเวอร์ ชื่อผู้ใช้ และรหัสผ่าน';

  @override
  String get connectionFailedMessage => 'การเชื่อมต่อล้มเหลว';

  @override
  String get connectionStatusLabel => 'สถานะการเชื่อมต่อ';

  @override
  String get connectionSuccessMessage => 'เชื่อมต่อสำเร็จ';

  @override
  String get contactAddSuccess => 'เพิ่มผู้ติดต่อสำเร็จ';

  @override
  String get contactDeleted => 'ลบผู้ติดต่อแล้ว';

  @override
  String get contactEditDialog => 'กล่องโต้ตอบแก้ไขผู้ติดต่อ';

  @override
  String get contactNameHint => 'ใส่ชื่อผู้ติดต่อ (ไม่บังคับ)';

  @override
  String get contactNameLabel => 'ชื่อ';

  @override
  String get contactNameOptional => 'ชื่อผู้ติดต่อ (ไม่บังคับ)';

  @override
  String get contactNotFound => 'ไม่พบผู้ติดต่อ';

  @override
  String get contacts => 'ผู้ติดต่อ';

  @override
  String contactsDeleted(Object count) {
    return 'ลบผู้ติดต่อแล้ว $count รายการ';
  }

  @override
  String get contactSettingsSubtitle =>
      'การจัดการผู้ติดต่อและการตั้งค่าป้ายกำกับ';

  @override
  String get contactSettingsTitle => 'การตั้งค่าผู้ติดต่อ';

  @override
  String contactsLoadingFailed(Object error) {
    return 'ไม่สามารถโหลดรายชื่อผู้ติดต่อได้: $error';
  }

  @override
  String get contactsManagement => 'การจัดการผู้ติดต่อ';

  @override
  String get contactsManagementPageTitle => 'หน้าจัดการผู้ติดต่อ';

  @override
  String get contactsPageTitle => 'การจัดการผู้ติดต่อ';

  @override
  String get contactsPermission => 'สิทธิ์การเข้าถึงรายชื่อผู้ติดต่อ';

  @override
  String get contactsPermissionDescription =>
      'ใช้เพื่อระบุสายเรียกเข้าจากผู้ติดต่อ';

  @override
  String get contactsTab => 'ผู้ติดต่อ';

  @override
  String get contactSubscriptionDescription =>
      'สมัครรับรายชื่อผู้ติดต่อผ่าน URL อัปเดตข้อมูลผู้ติดต่อและป้ายกำกับโดยอัตโนมัติ รองรับข้อมูลรูปแบบ JSON';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'ไม่สามารถโหลดการสมัครรับรายชื่อผู้ติดต่อได้: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'การสมัครรับรายชื่อผู้ติดต่อ';

  @override
  String get contactUpdateSuccess => 'อัปเดตผู้ติดต่อสำเร็จ';

  @override
  String get contactUs => 'ติดต่อเรา';

  @override
  String get content => 'เนื้อหา';

  @override
  String get contentRegex => 'นิพจน์ทั่วไปของเนื้อหา';

  @override
  String get countColor => 'สีของจำนวน';

  @override
  String get countFontSize => 'ขนาดตัวอักษรของจำนวน';

  @override
  String get countPosition => 'ตำแหน่งของจำนวน';

  @override
  String get country => 'ประเทศ';

  @override
  String get countryNameColor => 'สีชื่อประเทศ';

  @override
  String get countryNameFontSize => 'ขนาดตัวอักษรชื่อประเทศ';

  @override
  String get countryRegionNamePosition => 'ตำแหน่งชื่อประเทศ/ภูมิภาค';

  @override
  String get countrySelectionDialog => 'กล่องโต้ตอบเลือกประเทศ';

  @override
  String get countrySelectionDialogDescription =>
      'ใช้เพื่อเลือกประเทศเพื่อสอบถามข้อมูลหมายเลขโทรเข้า';

  @override
  String get countThresholdDescription =>
      'ตั้งค่าเกณฑ์จำนวนขั้นต่ำที่ต้องการเพื่อเรียกใช้การดำเนินการกรอง';

  @override
  String get countThresholdLabel => 'เกณฑ์จำนวน';

  @override
  String get countThresholdSettings => 'การตั้งค่าเกณฑ์จำนวน';

  @override
  String countThresholdValue(Object count) {
    return 'เกณฑ์จำนวน: $count';
  }

  @override
  String get createdRules => 'กฎที่สร้างขึ้น';

  @override
  String get csvFormat => 'รูปแบบ CSV';

  @override
  String get currentDeviceChip => 'ปัจจุบัน';

  @override
  String get currentDeviceLabel => 'ป้ายกำกับอุปกรณ์ปัจจุบัน';

  @override
  String get currentDeviceTitle => 'อุปกรณ์ปัจจุบัน';

  @override
  String get currentLabels => 'ป้ายกำกับปัจจุบัน:';

  @override
  String get currentLanguage => 'ภาษาปัจจุบัน';

  @override
  String get currentPasswordLabel => 'รหัสผ่านปัจจุบัน';

  @override
  String get customerService => 'ฝ่ายบริการลูกค้า';

  @override
  String get customRange => 'ช่วงที่กำหนดเอง';

  @override
  String get dailyStatistics => 'สถิติรายวัน';

  @override
  String get dailyStatisticsDesc =>
      'รับสถิติรายวันเกี่ยวกับสายเรียกเข้าและข้อความที่ถูกบล็อก';

  @override
  String get dashboardTab => 'แดชบอร์ด';

  @override
  String get dataAnalysis => 'การวิเคราะห์ข้อมูล';

  @override
  String get dataAnalysisDashboardPage => 'หน้าแดชบอร์ดการวิเคราะห์ข้อมูล';

  @override
  String get dataExport => 'การส่งออกข้อมูล';

  @override
  String dataLoadFailure(Object error) {
    return 'ไม่สามารถโหลดข้อมูลได้: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'ไม่สามารถโหลดข้อมูลได้: $error';
  }

  @override
  String get dataMigration => 'การย้ายข้อมูล';

  @override
  String get dataMigrationDescription =>
      'ฟีเจอร์นี้ช่วยให้คุณถ่ายโอนข้อมูลทั้งหมดระหว่างอุปกรณ์ได้ ขณะนี้คุณสามารถใช้ฟีเจอร์สำรองและกู้คืนเพื่อย้ายข้อมูลของคุณด้วยตนเองได้';

  @override
  String get dataMigrationDialogContent =>
      'ฟีเจอร์นี้ช่วยให้คุณถ่ายโอนข้อมูลทั้งหมดระหว่างอุปกรณ์ได้ ขณะนี้คุณสามารถใช้ฟีเจอร์สำรองและกู้คืนเพื่อย้ายข้อมูลของคุณด้วยตนเองได้';

  @override
  String get dataMigrationDialogTitle => 'การย้ายข้อมูล';

  @override
  String get dataMigrationSectionTitle => 'การย้ายข้อมูล';

  @override
  String get dataSourceReminder => 'คำเตือนแหล่งข้อมูล';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count วัน',
      one: '1 วัน',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days วัน VIP';
  }

  @override
  String get debtCollection => 'การทวงหนี้';

  @override
  String get defaultPeriod => 'สัปดาห์';

  @override
  String get delete => 'ลบ';

  @override
  String get deleteButton => 'ลบ';

  @override
  String get deleteContact => 'ลบผู้ติดต่อ';

  @override
  String deleteContactConfirm(Object name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $name';
  }

  @override
  String get deleteContactConfirmation =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบผู้ติดต่อ';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $deviceName';
  }

  @override
  String get deleteDeviceDialogTitle => 'ลบอุปกรณ์';

  @override
  String deleteFailed(Object error) {
    return 'การล้มเหลวในการลบ: $error';
  }

  @override
  String get deleteFilter => 'ลบตัวกรอง';

  @override
  String get deleteLabel => 'ลบป้ายกำกับ';

  @override
  String deleteLabelFailed(Object error) {
    return 'ไม่สามารถลบป้ายกำกับได้: $error';
  }

  @override
  String get deletePlugin => 'ลบปลั๊กอิน';

  @override
  String deletePluginFailed(Object error) {
    return 'ไม่สามารถลบปลั๊กอินได้: $error';
  }

  @override
  String get deletePlugins => 'ลบปลั๊กอิน';

  @override
  String deletePluginsFailed(Object error) {
    return 'ไม่สามารถลบปลั๊กอินได้: $error';
  }

  @override
  String get deleteRule => 'ลบกฎ';

  @override
  String deleteRuleFailed(Object error) {
    return 'การล้มเหลวในการลบ: $error';
  }

  @override
  String get deleteSelected => 'ลบรายการที่เลือก';

  @override
  String get deleteSmsRule => 'ลบกฎ SMS';

  @override
  String get deleteSubscription => 'ลบการสมัครรับ';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบการสมัครรับ \"$name\"';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'ไม่สามารถลบการสมัครรับได้: $error';
  }

  @override
  String get deleteSuccess => 'ลบสำเร็จ';

  @override
  String get delivery => 'การจัดส่ง';

  @override
  String get deviceDeletedSuccessfully => 'ลบอุปกรณ์สำเร็จแล้ว';

  @override
  String get deviceDeletedSuccessfullyMessage => 'ลบอุปกรณ์สำเร็จแล้ว';

  @override
  String get deviceIdLabel => 'รหัสอุปกรณ์';

  @override
  String get deviceIDLabel => 'รหัสอุปกรณ์';

  @override
  String get deviceManagementSubtitle => 'จัดการการซิงโครไนซ์หลายอุปกรณ์';

  @override
  String get deviceManagementTitle => 'การจัดการอุปกรณ์';

  @override
  String get deviceModelLabel => 'รุ่นอุปกรณ์';

  @override
  String get deviceName => 'ชื่ออุปกรณ์';

  @override
  String get deviceNameCannotBeEmpty => 'ชื่ออุปกรณ์ไม่สามารถว่างเปล่าได้';

  @override
  String get deviceNameHint => 'โปรดป้อนชื่ออุปกรณ์';

  @override
  String get deviceNameLabel => 'ชื่ออุปกรณ์';

  @override
  String get deviceRenamedSuccessfully => 'เปลี่ยนชื่ออุปกรณ์สำเร็จแล้ว';

  @override
  String get deviceRenamedSuccessfullyMessage => 'เปลี่ยนชื่ออุปกรณ์สำเร็จแล้ว';

  @override
  String get devicesSyncedSuccessfully => 'ซิงค์อุปกรณ์สำเร็จแล้ว';

  @override
  String get devicesSyncedSuccessfullyMessage => 'ซิงค์อุปกรณ์สำเร็จแล้ว';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'ซิงโครไนซ์อุปกรณ์สำเร็จแล้ว';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'ยกเลิกการลงทะเบียนอุปกรณ์สำเร็จแล้ว';

  @override
  String get dialogTitle => 'คำอธิบายรูปแบบ Regex';

  @override
  String get differentFromLocalCounter =>
      'ฟีเจอร์นี้แตกต่างจากตัวกรองตัวนับภายในเครื่อง เนื่องจากมุ่งเน้นไปที่รูปแบบการโทรซ้ำๆ ในช่วงเวลาสั้นๆ แทนที่จะเป็นการนับเครื่องหมายในระยะยาว';

  @override
  String get disabled => 'ปิดใช้งาน';

  @override
  String get disabledStatus => 'ปิดใช้งาน';

  @override
  String get disableGlobalPlugins => 'ปิดใช้งานปลั๊กอินทั่วโลก';

  @override
  String get disableSubscriptionSuccessfully =>
      'ปิดการใช้งานการสมัครสมาชิกสำเร็จแล้ว';

  @override
  String get disconnectButton => 'ตัดการเชื่อมต่อ';

  @override
  String get disconnectedMessage => 'ตัดการเชื่อมต่อแล้ว';

  @override
  String get disconnectedStatus => 'ตัดการเชื่อมต่อแล้ว';

  @override
  String get disconnectFailedMessage => 'การตัดการเชื่อมต่อล้มเหลว';

  @override
  String get done => 'เสร็จสิ้น';

  @override
  String get dualSimAdvice =>
      'ฟีเจอร์นี้มีประโยชน์อย่างยิ่งสำหรับโทรศัพท์ Dual-SIM ในการตั้งค่ากลยุทธ์การกรองที่แตกต่างกันสำหรับซิมการ์ดที่ทำงานและส่วนตัว';

  @override
  String get earlier => 'ก่อนหน้านี้';

  @override
  String get ecommerce => 'อีคอมเมิร์ซ';

  @override
  String get edit => 'แก้ไข';

  @override
  String get editContact => 'แก้ไขผู้ติดต่อ';

  @override
  String get editFilter => 'แก้ไขตัวกรอง';

  @override
  String get editLabel => 'แก้ไขป้ายกำกับ';

  @override
  String get editPhoneRule => 'แก้ไขกฎโทรศัพท์';

  @override
  String get editPhoneRules => 'ใช้เพื่อแก้ไขกฎโทรศัพท์';

  @override
  String get editPhoneRuleTitle => 'แก้ไขกฎโทรศัพท์';

  @override
  String get editRule => 'แก้ไขกฎ';

  @override
  String get editSmsRule => 'แก้ไขกฎ SMS';

  @override
  String get education => 'การศึกษา';

  @override
  String get elementPositionsSetting => 'ตำแหน่งองค์ประกอบ';

  @override
  String get email => 'อีเมล';

  @override
  String get emailOptional => 'อีเมล (ไม่บังคับ)';

  @override
  String get enableCallFilter => 'เปิดใช้งานการกรองการโทร';

  @override
  String get enableCallFilterDescription =>
      'เมื่อเปิดใช้งาน การโทรเข้าจะถูกตรวจสอบกับรายการกฎด้านล่าง โดยค่าเริ่มต้น กฎการกรองการโทรจะไม่ถูกซิงโครไนซ์ระหว่างอุปกรณ์';

  @override
  String get enabled => 'เปิดใช้งาน';

  @override
  String get enabledStatus => 'เปิดใช้งาน';

  @override
  String get enableEncryption => 'เปิดใช้งานการเข้ารหัส';

  @override
  String get enableEncryptionDescription => 'เข้ารหัสไฟล์สำรอง';

  @override
  String get enableEncryptionLabel => 'เปิดใช้งานการเข้ารหัส';

  @override
  String get enableEncryptionSubtitle => 'ไฟล์สำรองจะถูกเข้ารหัส';

  @override
  String get enableEncryptionTitle => 'เปิดใช้งานการเข้ารหัส';

  @override
  String get enableGlobalPlugins => 'เปิดใช้งานปลั๊กอินทั่วโลก';

  @override
  String get enableLocalCountFilter => 'เปิดใช้งานตัวกรองตัวนับภายในเครื่อง';

  @override
  String get enableLocalCountFilterDescription =>
      'กรองสายสแปมโดยอัตโนมัติตามจำนวนการตั้งค่าการโทร';

  @override
  String get enableLocalNotification => 'ใช้การแจ้งเตือนภายในเครื่อง';

  @override
  String get enableLocalNotificationDescription =>
      'เมื่อเปิดใช้งาน การแจ้งเตือนสำหรับข้อความที่กรองจะแสดงบนอุปกรณ์';

  @override
  String get enableLocationSummary => 'ตำแหน่ง';

  @override
  String get enableMuteRules => 'เปิดใช้งานกฎปิดเสียง';

  @override
  String get enableMuteRulesDesc => 'ใช้การกำหนดค่ากฎการดักจับแบบปิดเสียง';

  @override
  String get enableNoneActionRules => 'เปิดใช้งานกฎไม่มีการดำเนินการ';

  @override
  String get enableNoneActionRulesDesc =>
      'อนุญาตให้กำหนดค่ากฎที่ไม่มีการดำเนินการดักจับ';

  @override
  String get enableNotifications => 'เปิดใช้งานการแจ้งเตือน';

  @override
  String get enableRemoteNumberFilter => 'เปิดใช้งานตัวกรองหมายเลขระยะไกล';

  @override
  String get enableRemoteNumberFilterDescription =>
      'ใช้ฐานข้อมูลระยะไกลเพื่อกรองหมายเลข';

  @override
  String get enableRule => 'เปิดใช้งานกฎ';

  @override
  String get enableSmsFilter => 'เปิดใช้งานการกรอง SMS';

  @override
  String get enableSmsFilterDescription =>
      'เมื่อเปิดใช้งาน ข้อความจะถูกกรองโดยอัตโนมัติตามกฎ';

  @override
  String get enableStatisticsNotifications => 'เปิดใช้งานการแจ้งเตือนสถิติ';

  @override
  String get enableSubscriptionSuccessfully =>
      'เปิดการใช้งานการสมัครสมาชิกสำเร็จแล้ว';

  @override
  String get enableTimeInterception => 'เปิดใช้งานการดักจับเวลา';

  @override
  String get enableTimeInterceptionDescription =>
      'ดักจับการโทรซ้ำๆ ภายในช่วงเวลาสั้นๆ';

  @override
  String get enableTimeInterceptor => 'เปิดใช้งานตัวดักจับเวลา';

  @override
  String get endCallImmediately => 'วางสายทันที';

  @override
  String get endColor => 'สีสิ้นสุด';

  @override
  String get endDate => 'วันที่สิ้นสุด';

  @override
  String get enhancedFilterInstructionsTitle => 'คำแนะนำระบบตัวกรองขั้นสูง';

  @override
  String get enhancedFilterSettings => 'การตั้งค่าตัวกรองขั้นสูง';

  @override
  String get enhancedFilterSettingsTitle => 'การตั้งค่าตัวกรองขั้นสูง';

  @override
  String get enhancedFilterSystemDescription =>
      'ระบบตัวกรองขั้นสูงรองรับทั้งกฎทั่วโลกและการกำหนดค่าการกรองต่อซิมการ์ด';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'โปรดป้อนทั้งหมายเลขโทรศัพท์และรูปแบบ Regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'โปรดป้อนทั้งหมายเลขโทรศัพท์และรูปแบบ Regex';

  @override
  String get enterContactName => 'โปรดป้อนชื่อผู้ติดต่อ';

  @override
  String get enterCurrentPasswordHint => 'โปรดป้อนรหัสผ่านปัจจุบัน';

  @override
  String get enterDeviceName => 'ป้อนชื่ออุปกรณ์';

  @override
  String get enterDeviceNameHint => 'โปรดป้อนชื่ออุปกรณ์';

  @override
  String get enterEmail => 'โปรดป้อนอีเมล';

  @override
  String get enterEmailOptional => 'โปรดป้อนอีเมล (ไม่บังคับ)';

  @override
  String get enterEncryptionPasswordHint => 'ป้อนรหัสผ่านการเข้ารหัส';

  @override
  String get enterEncryptionPasswordTitle => 'ป้อนรหัสผ่านการเข้ารหัส';

  @override
  String get enterFilterName => 'โปรดป้อนชื่อตัวกรอง';

  @override
  String get enterFilterPattern => 'โปรดป้อนรูปแบบตัวกรอง';

  @override
  String get enterIconCode => 'ป้อนรหัสไอคอน';

  @override
  String get enterName => 'ป้อนชื่อผู้ติดต่อ';

  @override
  String get enterNewDeviceNameHint => 'ป้อนชื่อใหม่สำหรับอุปกรณ์นี้';

  @override
  String get enterNewPasswordHint => 'โปรดป้อนรหัสผ่านใหม่';

  @override
  String get enterPasswordAgain => 'ป้อนรหัสผ่านอีกครั้ง';

  @override
  String get enterPasswordHint => 'โปรดป้อนรหัสผ่าน';

  @override
  String get enterPhoneNumber => 'ป้อนหมายเลขโทรศัพท์';

  @override
  String get enterPhoneNumberHint => 'ป้อนหมายเลขโทรศัพท์เพื่อทดสอบ';

  @override
  String get enterPhoneNumberMultiple =>
      'โปรดป้อนหมายเลขโทรศัพท์ หลายหมายเลขคั่นด้วยเครื่องหมายจุลภาค';

  @override
  String get enterPhoneNumberToStartSearch =>
      'ป้อนหมายเลขโทรศัพท์เพื่อเริ่มการค้นหา';

  @override
  String get enterPhoneNumberToVerify => 'ป้อนหมายเลขโทรศัพท์เพื่อยืนยัน';

  @override
  String get enterPluginName => 'ป้อนชื่อปลั๊กอิน';

  @override
  String get enterPluginUrl => 'ป้อนที่อยู่ URL ของปลั๊กอิน';

  @override
  String get enterRegexHint => 'ป้อนรูปแบบ regex';

  @override
  String get enterRuleNameAndPattern => 'โปรดป้อนชื่อกฎและรูปแบบ';

  @override
  String get enterRuleNameAndPatternMessage => 'กรุณากรอกชื่อกฎและรูปแบบ Regex';

  @override
  String get enterRuleNameHint => 'กรอกชื่อกฎ';

  @override
  String get enterSearchContent => 'กรุณากรอกเนื้อหาที่ต้องการค้นหา';

  @override
  String get enterSubscriptionName => 'กรอกชื่อการสมัครสมาชิก';

  @override
  String get enterSubscriptionUrl => 'กรอก URL การสมัครสมาชิก';

  @override
  String get enterSyncFolderNameHint =>
      'กรุณากรอกชื่อโฟลเดอร์ที่จะซิงค์ (ค่าเริ่มต้น: NotificationManager)';

  @override
  String get entertainment => 'ความบันเทิง';

  @override
  String get enterValidNameAndUrl => 'กรุณากรอกชื่อและ URL ที่ถูกต้อง';

  @override
  String get enterValidUrl => 'กรุณากรอก URL ที่ถูกต้อง';

  @override
  String get enterVersion => 'กรอกเวอร์ชัน';

  @override
  String get enterWebDAVPasswordHint => 'กรุณากรอกรหัสผ่าน WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'กรุณากรอกที่อยู่เซิร์ฟเวอร์ WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'กรุณากรอกชื่อผู้ใช้ WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'เกิดข้อผิดพลาดในการลบอุปกรณ์: $error';
  }

  @override
  String get errorLoadingPlugin => 'เกิดข้อผิดพลาดในการโหลดปลั๊กอิน';

  @override
  String errorOccurredMessage(Object error) {
    return 'เกิดข้อผิดพลาด: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'เกิดข้อผิดพลาดในการเปลี่ยนชื่ออุปกรณ์: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'เกิดข้อผิดพลาดในการซิงค์อุปกรณ์: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'เกิดข้อผิดพลาดในการซิงค์อุปกรณ์: $error';
  }

  @override
  String get errorText => 'ข้อผิดพลาด';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'เกิดข้อผิดพลาดในการยกเลิกการลงทะเบียนอุปกรณ์: $error';
  }

  @override
  String get exampleBlock400Prefix => 'เช่น หมายเลขนำหน้า 400';

  @override
  String get exampleBlockMarketingSms => 'เช่น บล็อก SMS การตลาด';

  @override
  String get exampleContentRegex => 'เช่น .*offer.*';

  @override
  String get exampleContentRegexHint => 'ตัวอย่าง Regex เนื้อหา';

  @override
  String get exampleCouponPromotionDiscount =>
      'เช่น .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'เช่น ครอบครัว, เพื่อน, ฯลฯ';

  @override
  String get examplePhoneNumber => 'เช่น 10086, 12345, ฯลฯ';

  @override
  String get exampleRegex400Prefix => 'ตัวอย่าง Regex สำหรับหมายเลขนำหน้า 400';

  @override
  String get exampleRegexFormat => 'ตัวอย่าง: รูปแบบ ^10086\$';

  @override
  String get exampleSenderRegexHint => 'ตัวอย่าง';

  @override
  String get exchange => 'แลกเปลี่ยน';

  @override
  String get exchangeNow => 'แลกเปลี่ยนทันที';

  @override
  String get exchangeVip => 'แลกเปลี่ยน VIP';

  @override
  String get expandLabelSelector => 'ขยายตัวเลือกป้ายกำกับ';

  @override
  String expiryTime(Object time) {
    return 'เวลาหมดอายุ: $time';
  }

  @override
  String get export => 'ส่งออก';

  @override
  String get exportAllApplicationSettings =>
      'ส่งออกการตั้งค่าแอปพลิเคชันทั้งหมด';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'ส่งออกการตั้งค่าแอปพลิเคชันทั้งหมด';

  @override
  String get exportAllRuleConfigurations => 'ส่งออกการกำหนดค่ากฎทั้งหมด';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'ส่งออกการกำหนดค่ากฎทั้งหมด';

  @override
  String get exportComplete => 'ส่งออกสำเร็จ';

  @override
  String get exportConfig => 'ส่งออกการกำหนดค่า';

  @override
  String get exportContacts => 'ส่งออกรายชื่อติดต่อ';

  @override
  String get exportData => 'ส่งออกข้อมูล';

  @override
  String get exportError => 'ข้อผิดพลาดในการส่งออก';

  @override
  String get exportFailed => 'ส่งออกไม่สำเร็จ';

  @override
  String get exportFailure => 'ส่งออกการกำหนดค่าไม่สำเร็จ';

  @override
  String get exportFeatureComingSoon => 'ฟีเจอร์ส่งออกกำลังจะมาเร็วๆ นี้';

  @override
  String get exporting => 'กำลังส่งออก...';

  @override
  String get exportLabels => 'ส่งออกป้ายกำกับ';

  @override
  String exportLabelsFailed(Object error) {
    return 'ส่งออกป้ายกำกับไม่สำเร็จ: $error';
  }

  @override
  String get exportPluginList => 'ส่งออกรายการปลั๊กอิน';

  @override
  String exportPluginListFailed(Object error) {
    return 'ส่งออกรายการปลั๊กอินไม่สำเร็จ: $error';
  }

  @override
  String get exportRules => 'ส่งออกกฎ';

  @override
  String get exportRulesDialogTitle => 'ส่งออกกฎ';

  @override
  String get exportRulesTitle => 'ส่งออกกฎ';

  @override
  String get exportSmsRules => 'ส่งออกกฎ SMS';

  @override
  String get exportStatisticsData => 'ส่งออกข้อมูลสถิติ';

  @override
  String get exportSuccess => 'ส่งออกสำเร็จ';

  @override
  String get exportSuccesslly => 'ส่งออกการกำหนดค่าสำเร็จแล้ว';

  @override
  String get failedToAddContact => 'เพิ่มรายชื่อติดต่อไม่สำเร็จ';

  @override
  String failedToAddRule(Object error) {
    return 'เพิ่มกฎไม่สำเร็จ: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'เพิ่มกฎ SMS ไม่สำเร็จ: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'เพิ่มการสมัครสมาชิก SMS ไม่สำเร็จ: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'สำรองข้อมูลการตั้งค่าไม่สำเร็จ: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'ถอดรหัสไฟล์สำรองไม่สำเร็จ';

  @override
  String get failedToDeleteDevice => 'ลบอุปกรณ์ไม่สำเร็จ';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'ลบกฎ SMS ไม่สำเร็จ: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'ส่งออกกฎไม่สำเร็จ: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'ส่งออกกฎ SMS ไม่สำเร็จ: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'ไม่สามารถรับข้อมูล ID ผู้โทร: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'นำเข้ากฎไม่สำเร็จ: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'นำเข้ากฎ SMS ไม่สำเร็จ: $error';
  }

  @override
  String get failedToLoadContacts => 'โหลดรายชื่อติดต่อไม่สำเร็จ';

  @override
  String get failedToLoadPlugin => 'โหลดปลั๊กอินไม่สำเร็จ';

  @override
  String get failedToRenameDevice => 'เปลี่ยนชื่ออุปกรณ์ไม่สำเร็จ';

  @override
  String get failedToRestoreSettings => 'กู้คืนการตั้งค่าไม่สำเร็จ';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'กู้คืนการตั้งค่าไม่สำเร็จ: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'ตั้งรหัสผ่านไม่สำเร็จ: $error';
  }

  @override
  String get failedToSyncDevices => 'ซิงค์อุปกรณ์ไม่สำเร็จ';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'เปลี่ยนสถานะกฎไม่สำเร็จ: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'เปลี่ยนสถานะการสมัครสมาชิกไม่สำเร็จ';

  @override
  String get failedToUpdateContact => 'อัปเดตรายชื่อติดต่อไม่สำเร็จ';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'อัปเดตกฎ SMS ไม่สำเร็จ: $error';
  }

  @override
  String get failure => 'ความล้มเหลว';

  @override
  String get favoriteContacts => 'รายชื่อติดต่อที่ชื่นชอบ';

  @override
  String get featureAddRules => '• เพิ่มกฎสำหรับเบอร์โทรศัพท์เฉพาะ';

  @override
  String get featureCenter => 'ศูนย์กลางฟีเจอร์';

  @override
  String get featureEnableDisable => '• เปิด/ปิดตัวกรองต่างๆ ต่อ SIM';

  @override
  String get featureListTitle => 'ฟีเจอร์:';

  @override
  String get featureManageRules => '• จัดการรายการกฎต่อ SIM';

  @override
  String get features => 'ฟีเจอร์';

  @override
  String get fetchingCallerIdInfo => 'กำลังดึงข้อมูล ID ผู้โทร...';

  @override
  String fileSavedTo(Object path) {
    return 'บันทึกไฟล์ที่: $path';
  }

  @override
  String get filter => 'ตัวกรอง';

  @override
  String get filterByLabel => 'กรองตามป้ายกำกับ';

  @override
  String get filterClear => 'ล้างตัวกรอง';

  @override
  String get filterControlPanelTitle => 'แผงควบคุมตัวกรอง';

  @override
  String get filterControlSubtitle => 'จัดการสถานะเปิด/ปิดของตัวกรองทั้งหมด';

  @override
  String get filterControlTitle => 'ตัวควบคุมตัวกรอง';

  @override
  String get filterDeleteFailed => 'การลบตัวกรองล้มเหลว';

  @override
  String get filterDeleteSuccess => 'ลบตัวกรองสำเร็จแล้ว';

  @override
  String get filterDetails => 'รายละเอียดตัวกรอง';

  @override
  String get filtered => 'กรองแล้ว';

  @override
  String get filteredSms => 'SMS ที่ถูกกรอง';

  @override
  String get filteredSmsLabel => 'SMS ที่ถูกกรอง';

  @override
  String get filterExplanation => 'คำอธิบายตัวกรอง';

  @override
  String get filterManagement => 'การจัดการตัวกรอง';

  @override
  String get filterName => 'ชื่อตัวกรอง';

  @override
  String get filterPattern => 'รูปแบบตัวกรอง';

  @override
  String get filterPriorityNote =>
      'หมายเหตุ: มีความสัมพันธ์ลำดับความสำคัญระหว่างตัวกรอง โปรดดูเอกสารช่วยเหลือสำหรับรายละเอียด';

  @override
  String get filterSaveFailed => 'การบันทึกตัวกรองล้มเหลว';

  @override
  String get filterSaveSuccess => 'บันทึกตัวกรองสำเร็จแล้ว';

  @override
  String get filterSettings => 'การตั้งค่าตัวกรอง';

  @override
  String get filterSettingsTitle => 'การตั้งค่าตัวกรอง';

  @override
  String get filterSMS => 'กรอง SMS';

  @override
  String get filterToggleInstructions =>
      'เปิดหรือปิดตัวกรองสำหรับช่อง SIM นี้:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'เปิด/ปิดตัวกรอง: $filterName';
  }

  @override
  String get filterType => 'ประเภทตัวกรอง';

  @override
  String get financial => 'การเงิน';

  @override
  String get flexibleCombinationFeature =>
      '• การผสมผสานที่ยืดหยุ่น: เปิด/ปิดตัวกรองต่อช่อง SIM';

  @override
  String get fontSizesSetting => 'ขนาดตัวอักษร';

  @override
  String foundRules(Object count) {
    return 'พบกฎ $count รายการ';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'พบกฎ $count รายการ คุณต้องการนำเข้าหรือไม่?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'พบกฎ $count รายการ คุณต้องการนำเข้าหรือไม่?';
  }

  @override
  String get fraudAlert => 'การแจ้งเตือนการฉ้อโกง - วางสาย';

  @override
  String get fraudScamLikely => 'น่าจะเป็นการหลอกลวง';

  @override
  String get free => 'ฟรี';

  @override
  String get functionSettingsTitle => 'การตั้งค่าฟังก์ชัน';

  @override
  String generalUpdateFailure(Object error) {
    return 'อัปเดตล้มเหลว: $error';
  }

  @override
  String get getFree => 'รับฟรี';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'กำหนดค่าตัวกรองทั่วโลกสำหรับซิมการ์ดทั้งหมด:';

  @override
  String get globalFilterFeature =>
      '• ตัวกรองทั่วโลก: กฎพื้นฐานสำหรับสายเรียกเข้าทั้งหมด';

  @override
  String get globalFilterSettings => 'การตั้งค่าตัวกรองทั่วโลก';

  @override
  String get globalFilterToggleInstructions =>
      'กำหนดค่าการตั้งค่าตัวกรองทั่วโลกที่จะนำไปใช้กับช่อง SIM ทั้งหมด:';

  @override
  String get globalSearchSubtitle =>
      'ค้นหารายชื่อติดต่อ, ป้ายกำกับ, บัญชีดำ, บัญชีขาว ฯลฯ';

  @override
  String get globalSearchTitle => 'การค้นหาทั่วโลก';

  @override
  String get globalSettings => 'การตั้งค่าทั่วโลก';

  @override
  String get googleAdDisplayPosition => 'ตำแหน่งแสดงโฆษณา Google';

  @override
  String get googleAdMobIntegrationText =>
      'สามารถรวมโฆษณา Google AdMob ได้ที่นี่';

  @override
  String get googleDriveAuthDescription =>
      'อนุญาตโดยใช้รหัสและคีย์ไคลเอ็นต์ Google Drive ที่กำหนดค่าในระบบ';

  @override
  String get googleDriveAuthorizationHint =>
      'อนุญาตโดยใช้รหัสและคีย์ไคลเอ็นต์ Google Drive ที่กำหนดค่าในระบบ';

  @override
  String get googleDriveConfigTitle => 'การกำหนดค่า Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'การกำหนดค่า Google Drive';

  @override
  String get government => 'รัฐบาล';

  @override
  String get granted => 'ได้รับอนุญาตแล้ว';

  @override
  String get grantNecessaryPermissions => 'ให้สิทธิ์ที่จำเป็น';

  @override
  String get grantPermissions => 'ให้สิทธิ์';

  @override
  String get headhunter => 'ผู้สรรหาบุคลากร';

  @override
  String get height => 'ความสูง';

  @override
  String get homePageTitle => 'หน้าหลัก';

  @override
  String get homeTab => 'หน้าแรก';

  @override
  String get howItWorksPoint1 =>
      '• ระบบจะอนุญาตสายเรียกเข้าจากหมายเลขเดียวกันโดยอัตโนมัติภายในกรอบเวลาที่กำหนด';

  @override
  String get howItWorksPoint2 =>
      '• กรอบเวลาที่สั้นลงจะทำให้การสกัดกั้นเข้มงวดขึ้น กรอบเวลาที่ยาวขึ้นจะทำให้การสกัดกั้นหลวมขึ้น';

  @override
  String get howItWorksPoint3 =>
      '• ระบบจะตรวจสอบบันทึกการโทรเพื่อพิจารณาว่าเป็นสายที่โทรซ้ำหรือไม่';

  @override
  String get howItWorksTitle => 'วิธีการทำงาน:';

  @override
  String get iconCodeOptional => 'รหัสไอคอน (ไม่บังคับ)';

  @override
  String get iconSize => 'ขนาดไอคอน';

  @override
  String get import => 'นำเข้า';

  @override
  String get important => 'สำคัญ';

  @override
  String get importButton => 'นำเข้า';

  @override
  String get importConfig => 'นำเข้าการกำหนดค่า';

  @override
  String get importContacts => 'นำเข้าผู้ติดต่อ';

  @override
  String get importExportContacts => 'นำเข้า/ส่งออกผู้ติดต่อ';

  @override
  String get importExportContactsTooltip => 'นำเข้า/ส่งออกผู้ติดต่อ';

  @override
  String get importExportRules => 'นำเข้า/ส่งออกกฎ';

  @override
  String importFailed(Object error) {
    return 'การนำเข้าล้มเหลว: $error';
  }

  @override
  String get importFailure => 'ไม่สามารถนำเข้าการกำหนดค่าได้';

  @override
  String get importFeatureComingSoon => 'ฟีเจอร์นำเข้าจะมาเร็วๆ นี้';

  @override
  String get importLabels => 'นำเข้าป้ายกำกับ';

  @override
  String importLabelsFailed(Object error) {
    return 'ไม่สามารถนำเข้าป้ายกำกับได้: $error';
  }

  @override
  String get importPluginList => 'นำเข้ารายการปลั๊กอิน';

  @override
  String importPluginListFailed(Object error) {
    return 'ไม่สามารถนำเข้ารายการปลั๊กอินได้: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'นำเข้าปลั๊กอินสำเร็จ $count รายการ';
  }

  @override
  String get importRuleConfigurationsFromFile => 'นำเข้าการกำหนดค่ากฎจากไฟล์';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'นำเข้าการกำหนดค่ากฎจากไฟล์';

  @override
  String get importRules => 'นำเข้ากฎ';

  @override
  String get importRulesButton => 'นำเข้ากฎ';

  @override
  String get importRulesDialogTitle => 'นำเข้ากฎ';

  @override
  String importRulesError(Object error) {
    return 'ไม่สามารถนำเข้ากฎได้: $error';
  }

  @override
  String get importRulesInstructions => 'นำเข้ากฎจากไฟล์ CSV';

  @override
  String get importRulesSuccess => 'นำเข้ากฎสำเร็จแล้ว';

  @override
  String get importRulesTitle => 'นำเข้ากฎ';

  @override
  String get importSuccess => 'นำเข้าสำเร็จ';

  @override
  String get incomingCallInterceptAction => 'การดำเนินการสกัดกั้นสายเรียกเข้า';

  @override
  String get incomingCallNotification => 'การแจ้งเตือนสายเรียกเข้า';

  @override
  String get incorrectPassword => 'รหัสผ่านไม่ถูกต้อง';

  @override
  String get initializing => 'กำลังเริ่มต้น';

  @override
  String get installed => 'ติดตั้งแล้ว';

  @override
  String get insufficientMarks => 'คะแนนไม่เพียงพอ';

  @override
  String get insurance => 'ประกันภัย';

  @override
  String get interceptAction => 'การดำเนินการสกัดกั้น';

  @override
  String get interceptionActionSettingsSubtitle =>
      'ตั้งค่าการจัดการสายที่ถูกบล็อก';

  @override
  String get interceptionActionSettingsTitle =>
      'การตั้งค่าการดำเนินการสกัดกั้น';

  @override
  String get interceptionTimeInterval => 'ช่วงเวลาสกัดกั้น';

  @override
  String get internet => 'อินเทอร์เน็ต';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'ตั้งค่าช่วงเวลาอัปเดต $service เป็น $days วันแล้ว';
  }

  @override
  String get invalidContentRegex => 'Regex เนื้อหาไม่ถูกต้อง';

  @override
  String get invalidLabel => 'ป้ายชื่อไม่ถูกต้อง';

  @override
  String get invalidRegexPattern => 'รูปแบบนิพจน์ทั่วไปไม่ถูกต้อง';

  @override
  String get invalidSenderRegex => 'รูปแบบนิพจน์ทั่วไปของผู้ส่งไม่ถูกต้อง';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'เข้าร่วม Telegram Channel และ Group เพื่อข้อมูลเพิ่มเติม';

  @override
  String get jsLogsTitle => 'บันทึก JS';

  @override
  String get jsonFormat => 'รูปแบบ JSON';

  @override
  String get keepAllVersions => 'เก็บทุกเวอร์ชัน';

  @override
  String get keepAllVersionsDescription => 'เก็บประวัติเวอร์ชันสำรองทั้งหมด';

  @override
  String get keepAllVersionsLabel => 'เก็บทุกเวอร์ชัน';

  @override
  String get keepAllVersionsSubtitle => 'เก็บประวัติเวอร์ชันสำรอง';

  @override
  String get keepAllVersionsTitle => 'เก็บทุกเวอร์ชัน';

  @override
  String get label => 'ป้ายชื่อ';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'เพิ่มป้ายชื่อ \"$name\" สำเร็จแล้ว';
  }

  @override
  String get labelCategories => 'หมวดหมู่ป้ายชื่อ';

  @override
  String get labelDeleted => 'ลบป้ายชื่อแล้ว';

  @override
  String get labelDescription =>
      'ป้ายชื่อช่วยให้คุณจัดการผู้ติดต่อได้ดีขึ้น เพิ่มป้ายชื่อแบบกำหนดเองให้กับหมายเลขโทรศัพท์เพื่อระบุการโทรและข้อความได้ง่าย';

  @override
  String get labelFilter => 'ตัวกรองป้ายชื่อ';

  @override
  String get labelFilterTooltip => 'ตัวกรองป้ายชื่อ';

  @override
  String get labelIconColor => 'สีไอคอนป้ายชื่อ';

  @override
  String get labelManagement => 'การจัดการป้ายชื่อ';

  @override
  String get labelNotFound => 'ไม่พบป้ายชื่อ';

  @override
  String get labelRemoved => 'ลบป้ายชื่อแล้ว';

  @override
  String labelRemoveFailed(Object error) {
    return 'ล้มเหลวในการลบป้ายชื่อ: $error';
  }

  @override
  String get labels => 'ป้ายชื่อ';

  @override
  String get labelsColor => 'สีของป้ายชื่อ';

  @override
  String labelsDeleted(Object count) {
    return 'ลบป้ายชื่อแล้ว $count รายการ';
  }

  @override
  String get labelsExportedSuccessfully => 'ส่งออกป้ายชื่อสำเร็จแล้ว';

  @override
  String get labelsFontSize => 'ขนาดตัวอักษรป้ายชื่อ';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'นำเข้าป้ายชื่อสำเร็จแล้ว $count รายการ';
  }

  @override
  String get labelsPosition => 'ตำแหน่งของป้ายชื่อ';

  @override
  String labelTag(Object labelId) {
    return 'ป้ายชื่อ: $labelId';
  }

  @override
  String get labelUpdated => 'อัปเดตป้ายชื่อแล้ว';

  @override
  String labelUpdateFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตป้ายชื่อ: $error';
  }

  @override
  String get labelUpdateSuccess => 'อัปเดตป้ายชื่อ \"\$labelText\" สำเร็จแล้ว';

  @override
  String get languageSettings => 'การตั้งค่าภาษา';

  @override
  String get languageSettingsSubtitle => 'เปลี่ยนภาษาที่แสดงของแอปพลิเคชัน';

  @override
  String get languageSettingsTitle => 'การตั้งค่าภาษา';

  @override
  String get last30Days => '30 วันที่ผ่านมา';

  @override
  String get last7Days => '7 วันที่ผ่านมา';

  @override
  String get lastSyncLabel => 'การซิงค์ครั้งล่าสุด';

  @override
  String lastUpdated(Object date) {
    return 'อัปเดตล่าสุด: $date';
  }

  @override
  String get lifetimeMembership => 'สมาชิกตลอดชีพ';

  @override
  String get lifetimeMembershipDescription =>
      'ซื้อครั้งเดียว ปลดล็อกฟีเจอร์พรีเมียมทั้งหมดและการอัปเดตในอนาคตอย่างถาวร';

  @override
  String loadContactsFailed(Object error) {
    return 'ไม่สามารถโหลดรายชื่อผู้ติดต่อได้: $error';
  }

  @override
  String get loadDataFailed => 'ไม่สามารถโหลดข้อมูลได้';

  @override
  String get loadFailed => 'โหลดไม่สำเร็จ';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get loadingData => 'กำลังโหลดข้อมูล...';

  @override
  String get loadingTags => 'กำลังโหลดแท็ก...';

  @override
  String loadLabelFailed(Object error) {
    return 'ไม่สามารถโหลดป้ายชื่อได้: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'ไม่สามารถโหลดป้ายชื่อได้: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'ไม่สามารถโหลดหมายเลขโทรศัพท์ที่ถูกทำเครื่องหมายได้: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'ไม่สามารถโหลดหมายเลขโทรศัพท์ที่ถูกทำเครื่องหมายได้: $error';
  }

  @override
  String get loadMore => 'โหลดเพิ่มเติม';

  @override
  String get loadPluginButton => 'โหลดปลั๊กอิน';

  @override
  String loadPluginsFailed(Object error) {
    return 'ไม่สามารถโหลดปลั๊กอินได้: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'ไม่สามารถโหลดการตั้งค่าได้: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'ไม่สามารถโหลดกฎ SMS ได้: $error';
  }

  @override
  String get loadStatusFailedMessage => 'ไม่สามารถโหลดสถานะได้';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'ไม่สามารถโหลดการสมัครสมาชิกได้: $error';
  }

  @override
  String get loan => 'เงินกู้';

  @override
  String get localBackupTitle => 'การสำรองข้อมูลภายในเครื่อง';

  @override
  String get localCounterFilter => 'ตัวกรองตัวนับภายในเครื่อง';

  @override
  String get localCounterFilterSubtitle =>
      'กรองสายสแปมโดยอัตโนมัติตามความถี่ในการโทร';

  @override
  String get localCountFilter => 'ตัวกรองจำนวนภายในเครื่อง';

  @override
  String get localCountFilterDescription =>
      'ดักจับสายที่โทรบ่อยตามจำนวนหมายเลขภายในเครื่อง';

  @override
  String get localCountFilterExplanationContent =>
      'ตัวกรองจำนวนภายในเครื่องจะวิเคราะห์บันทึกประวัติการโทรเพื่อระบุและบล็อกสายสแปมที่โทรบ่อยโดยอัตโนมัติ';

  @override
  String get localCountFilterExplanationTitle =>
      'คำอธิบายตัวกรองจำนวนภายในเครื่อง';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• กำหนดว่าจะบล็อกหรือไม่ตามค่าจำนวนของหมายเลข';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• เมื่อจำนวนของหมายเลขเกินเกณฑ์ที่ตั้งไว้ คุณสามารถเลือกที่จะบล็อกโดยอัตโนมัติได้';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• คุณสามารถเลือกอนุญาตหมายเลขที่ไม่เกินเกณฑ์ได้';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• คุณสามารถเลือกว่าจะบันทึกบันทึกการสอบถามทั้งหมดหรือไม่';

  @override
  String get localCountFiltering => 'การกรองจำนวนภายในเครื่อง';

  @override
  String get localCountFilteringExplanation =>
      '• การกรองจำนวนภายในเครื่อง: กฎการกรองตามจำนวนการทำเครื่องหมายภายในเครื่อง';

  @override
  String get localCountFilterSettings => 'การตั้งค่าตัวกรองจำนวนภายในเครื่อง';

  @override
  String get localCountFilterUseCases =>
      'ตัวกรองนี้เหมาะอย่างยิ่งสำหรับการระบุสายสแปมที่โทรอัตโนมัติและสายการตลาด';

  @override
  String get localFilterSettings => 'การตั้งค่าตัวกรองภายในเครื่อง';

  @override
  String get localNotificationDisabled =>
      'การแจ้งเตือนภายในเครื่องปิดใช้งานแล้ว';

  @override
  String get localNotificationEnabled =>
      'การแจ้งเตือนภายในเครื่องเปิดใช้งานแล้ว';

  @override
  String get localServices => 'บริการภายในเครื่อง';

  @override
  String get locationColor => 'สีตำแหน่ง';

  @override
  String get locationFontSize => 'ขนาดตัวอักษรตำแหน่ง';

  @override
  String get locationIconColor => 'สีไอคอนตำแหน่ง';

  @override
  String get locationPosition => 'ตำแหน่งตำแหน่ง';

  @override
  String get logAllLocalQueries => 'บันทึกการสอบถามภายในเครื่องทั้งหมด';

  @override
  String get logAllLocalQueriesDescription =>
      'บันทึกบันทึกสำหรับการสอบถามหมายเลขภายในเครื่องทั้งหมด';

  @override
  String get logAllRemoteQueries => 'บันทึกการสอบถามภายนอกทั้งหมด';

  @override
  String get logAllRemoteQueriesDescription =>
      'บันทึกการดำเนินการสอบถามหมายเลขภายนอกทั้งหมด';

  @override
  String get manage => 'จัดการ';

  @override
  String get manageContacts => 'จัดการรายชื่อผู้ติดต่อ';

  @override
  String get manageFavoriteContacts => 'จัดการรายชื่อผู้ติดต่อที่ชื่นชอบ';

  @override
  String get manageFilterRules => 'จัดการกฎตัวกรอง';

  @override
  String get manageFilterRulesDescription => 'เพิ่ม แก้ไข หรือลบกฎตัวกรอง SMS';

  @override
  String get manageFrequentContacts => 'จัดการรายชื่อผู้ติดต่อที่โทรบ่อย';

  @override
  String get markCounts => 'จำนวนเครื่องหมาย';

  @override
  String get markCount => 'จำนวนเครื่องหมาย';

  @override
  String markedByCount(Object count) {
    return 'ทำเครื่องหมายโดย $count';
  }

  @override
  String get markedPhonesList => 'รายการหมายเลขโทรศัพท์ที่ถูกทำเครื่องหมาย';

  @override
  String get markExchange => 'แลกเปลี่ยนเครื่องหมาย';

  @override
  String get markPhone => 'ทำเครื่องหมายหมายเลขโทรศัพท์';

  @override
  String markPhoneFailed(Object error) {
    return 'ไม่สามารถตั้งค่าหมายเลขโทรศัพท์: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'เพื่อตั้งค่าหมายเลขโทรศัพท์';

  @override
  String get markPhoneManagementTitle => 'การจัดการหมายเลขโทรศัพท์';

  @override
  String get markPhoneSuccess => 'ตั้งค่าหมายเลขโทรศัพท์สำเร็จแล้ว';

  @override
  String get matchFailed => 'ไม่ตรงกัน!';

  @override
  String get matchFailedMessage => 'ไม่ตรงกัน';

  @override
  String get matchNumbersWithSpecialCharacters => 'ตรงกับรูปแบบตัวเลขเฉพาะ';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'ตรงกับตัวเลขที่มีอักขระพิเศษ:';

  @override
  String get matchSpecificDigitPatterns => 'ตรงกับรูปแบบ XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle => 'ตรงกับรูปแบบตัวเลขเฉพาะ:';

  @override
  String get matchSuccessful => 'ตรงกันสำเร็จ!';

  @override
  String get matchSuccessfulMessage => 'ตรงกันสำเร็จ!';

  @override
  String get medical => 'การแพทย์';

  @override
  String get membershipPrivileges => 'สิทธิประโยชน์สมาชิก';

  @override
  String get migrationTool => 'เครื่องมือย้ายข้อมูล';

  @override
  String get migrationToolTitle => 'เครื่องมือย้ายข้อมูล';

  @override
  String get minutes => 'นาที';

  @override
  String get month => 'เดือน';

  @override
  String get monthly => 'รายเดือน';

  @override
  String get monthlyCallCount => 'จำนวนสายรายเดือน';

  @override
  String get monthlyChartTitle => 'สายที่ถูกบล็อกรายเดือน';

  @override
  String get monthlyMembership => 'สมาชิกรายเดือน';

  @override
  String get monthlyMembershipDescription =>
      'ปลดล็อกฟีเจอร์พรีเมียมทั้งหมด, ต่ออายุอัตโนมัติรายเดือน';

  @override
  String get monthlyTotal => 'ยอดรวมรายเดือน';

  @override
  String get monthlyTotalLabel => 'ยอดรวมรายเดือน';

  @override
  String get moreOptions => 'ตัวเลือกเพิ่มเติม';

  @override
  String get mute => 'ปิดเสียง';

  @override
  String get name => 'ชื่อ';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'ชื่อและหมายเลขโทรศัพท์ต้องไม่ว่างเปล่า';

  @override
  String get nameAndPhoneNumberRequired =>
      'ชื่อและหมายเลขโทรศัพท์ต้องไม่ว่างเปล่า';

  @override
  String get nameColor => 'สีชื่อ';

  @override
  String get nameFontSize => 'ขนาดตัวอักษรชื่อ';

  @override
  String nameLabel(Object name) {
    return 'ชื่อ: $name';
  }

  @override
  String get namePosition => 'ตำแหน่งชื่อ';

  @override
  String get nameUnknown => 'ชื่อ: ไม่รู้จัก';

  @override
  String nameWithValue(String name) {
    return 'ชื่อ: $name';
  }

  @override
  String get newPasswordLabel => 'รหัสผ่านใหม่';

  @override
  String get nextStep => 'ถัดไป';

  @override
  String get noAction => 'ไม่มีการดำเนินการ';

  @override
  String get noActionRules => 'ไม่มีกฎการดำเนินการ';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'ไม่มีบริการซิงค์คลาวด์ที่ใช้งานอยู่';

  @override
  String get noCallLogs => 'ไม่มีบันทึกการโทร';

  @override
  String get noCallRecords => 'ไม่มีบันทึกการโทร';

  @override
  String get noContacts => 'ยังไม่มีผู้ติดต่อ';

  @override
  String get noContactsYet => 'ยังไม่มีผู้ติดต่อ';

  @override
  String get noData => 'ไม่มีข้อมูล';

  @override
  String get noDevicesRegisteredMessage => 'ยังไม่มีอุปกรณ์ที่ลงทะเบียน';

  @override
  String get noDevicesRegisteredYet => 'ยังไม่มีอุปกรณ์ที่ลงทะเบียน';

  @override
  String get noFilters => 'ยังไม่มีตัวกรอง';

  @override
  String get noLabels => 'ยังไม่มีป้ายกำกับ';

  @override
  String get noMarkedPhones => 'ยังไม่มีหมายเลขโทรศัพท์ที่ตั้งค่าไว้';

  @override
  String get noMatchingContacts => 'ไม่มีผู้ติดต่อที่ตรงกัน';

  @override
  String get noMatchingContactsFound => 'ไม่พบผู้ติดต่อที่ตรงกัน';

  @override
  String get noMatchingNumbersFound => 'ไม่พบหมายเลขที่ตรงกัน';

  @override
  String get noMatchingRecords => 'ไม่พบรายการที่ตรงกัน';

  @override
  String noMatchingRules(Object ruleType) {
    return 'ไม่พบ $ruleType ที่ตรงกัน';
  }

  @override
  String get none => 'ไม่มี';

  @override
  String get noneServiceType => 'ไม่มี';

  @override
  String get noPlugins => 'ยังไม่มีปลั๊กอิน';

  @override
  String get noRecords => 'ไม่มีบันทึกการโทร';

  @override
  String get noResultReturned => 'ไม่ได้รับผลลัพธ์';

  @override
  String get noResultReturnedLog => 'ไม่ได้รับผลลัพธ์จากปลั๊กอิน';

  @override
  String noRules(Object ruleType) {
    return 'ยังไม่มี $ruleType';
  }

  @override
  String get noRulesPrompt => 'ไม่พบกฎ, โปรดเพิ่มกฎ';

  @override
  String get noRulesToExport => 'ไม่มีกฎให้ส่งออก';

  @override
  String get noSmsFilterRulesYet => 'ยังไม่มีกฎตัวกรอง SMS';

  @override
  String get noSmsRulesYet => 'ยังไม่มีกฎ SMS';

  @override
  String get noSubscriptions => 'ไม่มีการสมัครสมาชิก';

  @override
  String get noSubscriptionsYet => 'ยังไม่มีการสมัครสมาชิก';

  @override
  String get notGranted => 'ไม่ได้รับอนุญาต';

  @override
  String get notificationMode => 'โหมดการแจ้งเตือน';

  @override
  String get notificationModeDescription => 'แสดงข้อมูลผู้โทรในแถบแจ้งเตือน';

  @override
  String get notificationPermission => 'การอนุญาตแจ้งเตือน';

  @override
  String get notificationPermissionDescription =>
      'ใช้เพื่อแสดงการแจ้งเตือนสายเรียกเข้าและข้อความ';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get notificationSettings => 'การตั้งค่าการแจ้งเตือน';

  @override
  String get notificationSettingsSaved =>
      'บันทึกการตั้งค่าการแจ้งเตือนสำเร็จแล้ว';

  @override
  String get notSet => 'ไม่ได้ตั้งค่า';

  @override
  String get notVerifiedText => 'ยังไม่ยืนยัน';

  @override
  String get noValidSmsRulesFoundInFile => 'ไม่พบกฎ SMS ที่ถูกต้องในไฟล์';

  @override
  String get number => 'หมายเลข';

  @override
  String get numberColor => 'สีหมายเลข';

  @override
  String get numberFontSize => 'ขนาดตัวอักษรหมายเลข';

  @override
  String get numberPosition => 'ตำแหน่งหมายเลข';

  @override
  String get numberSearch => 'ค้นหาหมายเลข';

  @override
  String get numberTypeColor => 'สีประเภทหมายเลข';

  @override
  String get numberTypeFontSize => 'ขนาดตัวอักษรประเภทหมายเลข';

  @override
  String get numberTypePosition => 'ตำแหน่งประเภทหมายเลข';

  @override
  String get ok => 'ตกลง';

  @override
  String get okButton => 'ตกลง';

  @override
  String get onboardingCompleteDescription =>
      'ผู้จัดการความปลอดภัยการโทรของคุณพร้อมแล้ว, เริ่มต้นประสบการณ์การโทรที่ปลอดภัย!';

  @override
  String get onboardingLanguageDescription =>
      'เลือกภาษาที่คุณต้องการเพื่อประสบการณ์ที่ดีที่สุด';

  @override
  String get onboardingPermissionsDescription =>
      'เพื่อให้การบริการเต็มรูปแบบ, เราต้องการการอนุญาตดังต่อไปนี้:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'บล็อกสายเรียกเข้าและข้อความสแปมด้วยคลิกเดียว, ปรับแต่งกฎการบล็อก, และมอบสภาพแวดล้อมที่เงียบสงบให้คุณ';

  @override
  String get onboardingSmartCallerIdDescription =>
      'ระบุสายเรียกเข้าที่ไม่รู้จักโดยอัตโนมัติ, ตั้งค่าหมายเลขที่น่าสงสัย, และปกป้องความปลอดภัยการโทรของคุณ';

  @override
  String get onboardingWelcomeDescription =>
      'ผู้เชี่ยวชาญการจัดการการโทรของคุณ, ให้บริการระบุและบล็อกการโทรที่ครอบคลุม';

  @override
  String get oneDriveAuthDescription =>
      'อนุญาตโดยใช้รหัสและคีย์ไคลเอ็นต์ OneDrive ที่กำหนดค่าระบบ';

  @override
  String get oneDriveAuthorizationHint =>
      'อนุญาตโดยใช้รหัสและคีย์ไคลเอ็นต์ OneDrive ที่กำหนดค่าระบบ';

  @override
  String get oneDriveConfigTitle => 'การตั้งค่า OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'การตั้งค่า OneDrive';

  @override
  String get onlineCallerIdSubscription => 'การสมัครสมาชิกหมายเลขผู้โทรออนไลน์';

  @override
  String get openAppSettings => 'เปิดการตั้งค่าแอป';

  @override
  String openAppSettingsFailed(Object error) {
    return 'ไม่สามารถเปิดการตั้งค่าแอปได้: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'การดำเนินการล้มเหลว: $error';
  }

  @override
  String get operationFailure => 'การดำเนินการล้มเหลว';

  @override
  String get operationSuccess => 'การดำเนินการสำเร็จ';

  @override
  String get other => 'อื่นๆ';

  @override
  String get ourOtherApps => 'แอปอื่นๆ ของเรา';

  @override
  String get overlayMode => 'หน้าต่างลอย';

  @override
  String get overlayModeDescription => 'แสดงข้อมูลผู้โทรในหน้าต่างลอย';

  @override
  String get overlayPermission => 'สิทธิ์หน้าต่างลอย';

  @override
  String get overlayPermissionDescription =>
      'ใช้เพื่อแสดงการแจ้งสายเรียกเข้าแบบลอย';

  @override
  String get overview => 'ภาพรวม';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get passwordCannotBeEmpty => 'รหัสผ่านต้องไม่ว่างเปล่า';

  @override
  String get passwordLabel => 'รหัสผ่าน';

  @override
  String get passwordsDoNotMatch => 'รหัสผ่านไม่ตรงกัน';

  @override
  String get passwordSetSuccessfully => 'ตั้งรหัสผ่านสำเร็จ';

  @override
  String get pattern => 'รูปแบบ';

  @override
  String get pendingSync => 'กำลังรอการซิงค์';

  @override
  String get periodMonth => 'เดือน';

  @override
  String get periodWeek => 'สัปดาห์';

  @override
  String get periodYear => 'ปี';

  @override
  String get permissionDenied => 'คำขอสิทธิ์ถูกปฏิเสธ';

  @override
  String get permissionGranted => 'สิทธิ์ได้รับการอนุมัติ';

  @override
  String get permissionManagement => 'การจัดการสิทธิ์';

  @override
  String get phoneCallsTab => 'โทรศัพท์';

  @override
  String get phoneNumber => 'หมายเลขโทรศัพท์';

  @override
  String get phoneNumberCannotBeEmpty => 'หมายเลขโทรศัพท์ต้องไม่ว่างเปล่า';

  @override
  String get phoneNumberHint => 'ป้อนหมายเลขโทรศัพท์';

  @override
  String get phoneNumberHintText => 'ป้อนหมายเลขโทรศัพท์เพื่อเพิ่มกฎ';

  @override
  String get phoneNumberLabel => 'หมายเลขโทรศัพท์';

  @override
  String get phoneNumberRegexRequired =>
      'โปรดป้อนทั้งหมายเลขโทรศัพท์และรูปแบบ regex';

  @override
  String get phoneNumberRequired => 'ต้องมีหมายเลขโทรศัพท์';

  @override
  String get phoneNumberTypeFixedLine => 'โทรศัพท์บ้าน';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'โทรศัพท์บ้านหรือมือถือ';

  @override
  String get phoneNumberTypeMobile => 'มือถือ';

  @override
  String get phoneNumberTypePager => 'เพจเจอร์';

  @override
  String get phoneNumberTypePersonalNumber => 'หมายเลขส่วนตัว';

  @override
  String get phoneNumberTypePremiumRate => 'อัตราพรีเมียม';

  @override
  String get phoneNumberTypeSharedCost => 'ค่าใช้จ่ายร่วมกัน';

  @override
  String get phoneNumberTypeTollFree => 'โทรฟรี';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'ไม่ทราบ';

  @override
  String get phoneNumberTypeVoicemail => 'ข้อความเสียง';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'สิทธิ์โทรศัพท์';

  @override
  String get phonePermissionDescription => 'ใช้เพื่อระบุและบล็อกสายเรียกเข้า';

  @override
  String get phoneRule => 'กฎโทรศัพท์';

  @override
  String get phoneRuleEditDialog => 'กล่องโต้ตอบแก้ไขกฎโทรศัพท์';

  @override
  String get phoneRuleManagement => 'การจัดการกฎโทรศัพท์';

  @override
  String get phoneRuleSubscription => 'การสมัครสมาชิกกฎโทรศัพท์';

  @override
  String get phoneSubscription => 'การสมัครสมาชิกโทรศัพท์';

  @override
  String get phoneSubscriptionRulesDescription =>
      'สมัครรับรายชื่อกฎโทรศัพท์ผ่าน URL เพื่ออัปเดตรายการที่อนุญาตและรายการบล็อกโดยอัตโนมัติ รองรับไฟล์กฎรูปแบบ JSON';

  @override
  String get phoneSubscriptionTitle => 'การสมัครสมาชิกกฎโทรศัพท์';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'โปรดเลือกป้ายกำกับและป้อนหมายเลขโทรศัพท์ที่ถูกต้อง';

  @override
  String pluginAddedSuccess(Object name) {
    return 'เพิ่มปลั๊กอิน \"$name\" สำเร็จแล้ว';
  }

  @override
  String get pluginDeleted => 'ลบปลั๊กอินแล้ว';

  @override
  String get pluginLatestVersion => 'ปลั๊กอินเป็นเวอร์ชันล่าสุดแล้ว';

  @override
  String get pluginListExportSuccess => 'ส่งออกรายชื่อปลั๊กอินสำเร็จแล้ว';

  @override
  String get pluginLoadedSuccessfully => 'โหลดปลั๊กอินสำเร็จแล้ว';

  @override
  String get pluginManagement => 'การจัดการปลั๊กอิน';

  @override
  String get pluginManagementSubtitle =>
      'จัดการและกำหนดค่าปลั๊กอินของบุคคลที่สาม';

  @override
  String get pluginManagementTitle => 'การจัดการปลั๊กอิน';

  @override
  String get pluginName => 'ชื่อปลั๊กอิน';

  @override
  String get pluginNotLoaded => 'ปลั๊กอินยังไม่ได้โหลด โปรดโหลดปลั๊กอินก่อน';

  @override
  String pluginsDeleted(Object count) {
    return 'ลบปลั๊กอิน $count รายการสำเร็จแล้ว';
  }

  @override
  String get pluginService => 'บริการปลั๊กอิน';

  @override
  String get pluginTestPageTitle => 'ทดสอบปลั๊กอิน';

  @override
  String get pluginUpdateSuccess => 'อัปเดตปลั๊กอินสำเร็จแล้ว';

  @override
  String get pluginUrl => 'URL ปลั๊กอิน';

  @override
  String get pluginUrlCannotBeEmpty => 'URL ปลั๊กอินต้องไม่ว่างเปล่า';

  @override
  String get pluginUrlHint => 'ป้อน URL ปลั๊กอิน';

  @override
  String get pluginUrlLabel => 'URL ปลั๊กอิน';

  @override
  String get pluginVersion => 'เวอร์ชันปลั๊กอิน';

  @override
  String get political => 'การเมือง';

  @override
  String get powerfulSpamBlocking => 'การบล็อกสแปมที่ทรงพลัง';

  @override
  String get previousStep => 'ก่อนหน้า';

  @override
  String get prioritizeRemoteAction =>
      'จัดลำดับความสำคัญการตั้งค่าการดำเนินการระยะไกล';

  @override
  String get prioritizeRemoteActionDescription =>
      'จัดลำดับความสำคัญการตั้งค่าการดำเนินการจากฐานข้อมูลระยะไกล';

  @override
  String get processing => 'กำลังประมวลผล...';

  @override
  String get processingOperation => 'กำลังประมวลผล...';

  @override
  String get purchase => 'ซื้อ';

  @override
  String get quarterlyMembership => 'สมาชิกรายไตรมาส';

  @override
  String get quarterlyMembershipDescription =>
      'ปลดล็อกฟีเจอร์พรีเมียมทั้งหมด ต่ออายุอัตโนมัติทุกไตรมาส';

  @override
  String get queryButton => 'ค้นหา';

  @override
  String get queryFailed => 'การค้นหาล้มเหลว';

  @override
  String get queryFailedLog => 'การค้นหาล้มเหลว';

  @override
  String get querying => 'กำลังค้นหา...';

  @override
  String get queryingPhoneNumber => 'กำลังค้นหาหมายเลขโทรศัพท์';

  @override
  String get queryResultTitle => 'ผลการค้นหา';

  @override
  String get ready => 'พร้อมแล้ว!';

  @override
  String get receiveWeeklyStatistics => 'รับสถิติตัวเลขรายสัปดาห์';

  @override
  String get recruiter => 'ผู้สรรหา';

  @override
  String get reEnterPasswordHint => 'โปรดป้อนรหัสผ่านอีกครั้ง';

  @override
  String get refresh => 'รีเฟรช';

  @override
  String get refreshPermissionStatus => 'รีเฟรชสถานะสิทธิ์';

  @override
  String get refreshTooltip => 'รีเฟรช';

  @override
  String regexError(Object error) {
    return 'ข้อผิดพลาด Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'ข้อผิดพลาด Regex: $error';
  }

  @override
  String get regexPattern => 'รูปแบบ Regex';

  @override
  String get regexPatternExplanation => 'คำอธิบายรูปแบบ Regex';

  @override
  String get regexPatternExplanationButton => 'คำอธิบายรูปแบบ Regex';

  @override
  String get regexPatternLabel => 'รูปแบบ Regex';

  @override
  String get regexPatternsExamples =>
      'ใช้ไวยากรณ์ regex มาตรฐานในการกำหนดรูปแบบ ตัวอย่าง:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'รูปแบบ Regex สำหรับการจับคู่หมายเลขโทรศัพท์';

  @override
  String get regexRule => 'กฎ Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'เพิ่มกฎ Regex ไม่สำเร็จ: $error';
  }

  @override
  String get regexRuleAddSuccess => 'เพิ่มกฎ Regex สำเร็จแล้ว';

  @override
  String get regexRuleManagement => 'การจัดการกฎ Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'ชื่อกฎและรูปแบบ Regex ต้องไม่ว่างเปล่า';

  @override
  String get regexRules => 'กฎ Regex';

  @override
  String get regexTesterTitle => 'เครื่องมือทดสอบ Regex';

  @override
  String regexValidationFailed(Object error) {
    return 'การตรวจสอบ Regex ไม่สำเร็จ: $error';
  }

  @override
  String get regexValidationSuccess => 'การตรวจสอบ Regex สำเร็จแล้ว';

  @override
  String get region => 'ภูมิภาค';

  @override
  String get registeredDevicesTitle => 'อุปกรณ์ที่ลงทะเบียน';

  @override
  String get rejectAllCalls => 'ปฏิเสธสายทั้งหมด';

  @override
  String get rejectAllCallsDescription =>
      'เมื่อเปิดใช้งาน สายทั้งหมดจะถูกปฏิเสธด้วยลำดับความสำคัญสูงสุด';

  @override
  String get rejectAllNumbers => 'ปฏิเสธตัวเลขทั้งหมด';

  @override
  String get rejectAllNumbersDesc => 'ปฏิเสธสายเรียกเข้าทั้งหมดเมื่อเปิดใช้งาน';

  @override
  String get rejectExceededNumbers => 'ปฏิเสธตัวเลขที่เกิน';

  @override
  String get rejectExceededNumbersDescription =>
      'ปฏิเสธหมายเลขที่เกินเกณฑ์จำนวนโดยอัตโนมัติ';

  @override
  String get remoteFilterSettings => 'การตั้งค่าตัวกรองระยะไกล';

  @override
  String get remoteFilterSettingsPageTitle => 'การตั้งค่าตัวกรองหมายเลขระยะไกล';

  @override
  String get remoteNumberFilter => 'ตัวกรองหมายเลขระยะไกล';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'ตัวกรองนี้ใช้ฐานข้อมูลระยะไกลอิสระเพื่อรับข้อมูลหมายเลขล่าสุด';

  @override
  String get remoteNumberFilterDescription =>
      'สกัดกั้นสายรบกวนตามข้อมูลฐานข้อมูลระยะไกล';

  @override
  String get remoteNumberFilterExplanationContent =>
      'ตัวกรองหมายเลขระยะไกลจะระบุและบล็อกสายสแปมโดยการสอบถามฐานข้อมูลระยะไกลตามจำนวนหมายเลข';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'คำอธิบายตัวกรองหมายเลขระยะไกล';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• เกณฑ์จำนวน: กำหนดตามความถี่ในการเกิดหมายเลข';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• การดำเนินการตัวกรอง: กำหนดวิธีการจัดการหมายเลขที่เกินเกณฑ์';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• การตั้งค่าลำดับความสำคัญ: ตั้งค่าลำดับความสำคัญสำหรับการดำเนินการระยะไกล';

  @override
  String get remoteNumberFilterFeatures => 'คุณสมบัติ:';

  @override
  String get remoteNumberFiltering => 'การกรองหมายเลขระยะไกล';

  @override
  String get remoteNumberFilteringExplanation =>
      '• การกรองหมายเลขระยะไกล: กฎการกรองตามข้อมูลฐานข้อมูลระยะไกล';

  @override
  String get remoteNumberFilterSubtitle =>
      'ระบุสายสแปมโดยใช้ฐานข้อมูลคลาวด์และรายงานชุมชน';

  @override
  String get removeAdsDescription =>
      'ลบโฆษณาทั้งหมดในแอปอย่างถาวรเพื่อประสบการณ์ที่ราบรื่นยิ่งขึ้น';

  @override
  String get removeAdsTitle => 'ลบโฆษณา';

  @override
  String get removedFromFavoriteContacts => 'นำออกจากผู้ติดต่อที่ชื่นชอบ';

  @override
  String get removedFromFavorites => 'นำออกจากรายการโปรด';

  @override
  String get removeFavorite => 'นำรายการโปรดออก';

  @override
  String get removeFromFavorites => 'นำออกจากรายการโปรด';

  @override
  String get renameButton => 'เปลี่ยนชื่อ';

  @override
  String get renameDeviceDialogTitle => 'เปลี่ยนชื่ออุปกรณ์';

  @override
  String get renameDeviceTitle => 'เปลี่ยนชื่ออุปกรณ์';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'นี่จะแทนที่การตั้งค่าปัจจุบันทั้งหมดของคุณ คุณแน่ใจหรือไม่ว่าต้องการดำเนินการต่อ?';

  @override
  String get requestAllPermissions => 'ขอสิทธิ์ทั้งหมด';

  @override
  String get requestPermission => 'ขอสิทธิ์';

  @override
  String requestPermissionFailed(Object error) {
    return 'ขอสิทธิ์ไม่สำเร็จ: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count เครื่องหมาย';
  }

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get restore => 'กู้คืน';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'กู้คืนการตั้งค่าแอปพลิเคชันจากการสำรองข้อมูล';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'กู้คืนการตั้งค่าแอปพลิเคชันจากการสำรองข้อมูล';

  @override
  String get restoreButton => 'กู้คืน';

  @override
  String restoreFailedWithError(Object error) {
    return 'กู้คืนจากคลาวด์ไม่สำเร็จ: $error';
  }

  @override
  String get restoreFromCloud => 'กู้คืนจากคลาวด์';

  @override
  String get restoreFromCloudDescription =>
      'กู้คืนการตั้งค่าและกฎจากที่เก็บข้อมูลคลาวด์';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'กู้คืนจากคลาวด์ไม่สำเร็จ: $error';
  }

  @override
  String get restoreFromCloudLabel => 'กู้คืนจากคลาวด์';

  @override
  String get restoreFromCloudSuccess => 'กู้คืนจากคลาวด์สำเร็จแล้ว';

  @override
  String get restoreFromCloudTitle => 'กู้คืนจากคลาวด์';

  @override
  String get restoreFromLocal => 'กู้คืนจากเครื่อง';

  @override
  String get restorePurchases => 'กู้คืนการซื้อ';

  @override
  String get restoreSectionTitle => 'กู้คืน';

  @override
  String get restoreSettings => 'กู้คืนการตั้งค่า';

  @override
  String get restoreSettingsConfirmation =>
      'นี่จะแทนที่การตั้งค่าปัจจุบันทั้งหมดของคุณ คุณแน่ใจหรือไม่ว่าต้องการดำเนินการต่อ?';

  @override
  String get restoreSettingsDialogTitle => 'กู้คืนการตั้งค่า';

  @override
  String get restoreSettingsTitle => 'กู้คืนการตั้งค่า';

  @override
  String get restoreSuccessFromLocal => 'กู้คืนจากเครื่องสำเร็จแล้ว';

  @override
  String get restoreSuccessMessage => 'กู้คืนจากคลาวด์สำเร็จแล้ว';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get ridesharing => 'การแชร์รถ';

  @override
  String get risk => 'ความเสี่ยง';

  @override
  String get robocall => 'สายรบกวน';

  @override
  String get ruleAction => 'การดำเนินการกฎ';

  @override
  String get ruleAddButton => 'เพิ่มกฎ';

  @override
  String get ruleAddedSuccess => 'เพิ่มกฎสำเร็จแล้ว';

  @override
  String ruleAddFailure(Object error) {
    return 'เพิ่มกฎไม่สำเร็จ: $error';
  }

  @override
  String get ruleAddSuccess => 'เพิ่มกฎสำเร็จแล้ว';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $ruleType นี้?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'ลบกฎ';

  @override
  String get ruleDeletedSuccess => 'ลบกฎสำเร็จแล้ว';

  @override
  String get ruleDeletedSuccessfully => 'ลบกฎสำเร็จแล้ว';

  @override
  String ruleDeleteFailed(Object error) {
    return 'ลบกฎไม่สำเร็จ: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'ลบกฎไม่สำเร็จ: $error';
  }

  @override
  String get ruleDeleteSuccess => 'ลบกฎสำเร็จแล้ว';

  @override
  String get ruleDisabledSuccessfully => 'ปิดใช้งานกฎสำเร็จแล้ว';

  @override
  String get ruleEnabledSuccessfully => 'เปิดใช้งานกฎสำเร็จแล้ว';

  @override
  String ruleLoadFailed(Object error) {
    return 'โหลดกฎไม่สำเร็จ: $error';
  }

  @override
  String get ruleManagement => 'การจัดการกฎ';

  @override
  String get ruleManagementTitle => 'การจัดการกฎ';

  @override
  String get ruleName => 'ชื่อกฎ';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'ชื่อกฎและเนื้อหา Regex ต้องไม่ว่างเปล่า';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'ชื่อกฎและหมายเลขโทรศัพท์ต้องไม่ว่างเปล่า';

  @override
  String get ruleNameHint => 'เช่น ครอบครัว เพื่อน ฯลฯ';

  @override
  String get ruleNameLabel => 'ชื่อกฎ';

  @override
  String get ruleNamePatternRequired => 'โปรดป้อนชื่อกฎและรูปแบบ';

  @override
  String get ruleNameRequired => 'ชื่อกฎและหมายเลขโทรศัพท์ต้องไม่ว่างเปล่า';

  @override
  String get ruleNotExist => 'กฎนี้ไม่มีอยู่จริง หรือถูกลบไปแล้ว';

  @override
  String ruleNotFound(Object error) {
    return 'ไม่พบกฎ: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'บันทึกกฎสำเร็จแล้ว!';

  @override
  String get ruleSavedSuccessMessage => 'บันทึกกฎสำเร็จแล้ว!';

  @override
  String ruleSaveFailed(Object error) {
    return 'บันทึกไม่สำเร็จ: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'บันทึกไม่สำเร็จ: $error';
  }

  @override
  String get ruleSaveSuccess => 'บันทึกกฎสำเร็จแล้ว!';

  @override
  String get rulesExportedSuccessfully => 'ส่งออกกฎสำเร็จแล้ว';

  @override
  String rulesExportedTo(Object path) {
    return 'ส่งออกกฎไปยัง: $path';
  }

  @override
  String get rulesImported => 'นำเข้ากฎสำเร็จแล้ว';

  @override
  String rulesImportedSuccessfully(Object count) {
    return 'นำเข้ากฎ $count รายการสำเร็จแล้ว';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'นำเข้ากฎไม่สำเร็จ: $error';
  }

  @override
  String get ruleStatistics => 'สถิติของกฎ';

  @override
  String ruleStatusChanged(Object status) {
    return 'เปลี่ยนสถานะกฎเป็น $status สำเร็จแล้ว';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'การดำเนินการไม่สำเร็จ: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'เปลี่ยนสถานะกฎเป็น $status สำเร็จแล้ว';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'อัปเดตกฎไม่สำเร็จ: $error';
  }

  @override
  String get ruleUpdateSuccess => 'อัปเดตกฎสำเร็จแล้ว';

  @override
  String get ruleVerification => 'การยืนยันกฎ';

  @override
  String get save => 'บันทึก';

  @override
  String get saveButton => 'บันทึก';

  @override
  String get saveButtonLabel => 'บันทึก';

  @override
  String get saveButtonText => 'บันทึก';

  @override
  String saveFailed(Object error) {
    return 'บันทึกไม่สำเร็จ: $error';
  }

  @override
  String get saveFilter => 'บันทึกตัวกรอง';

  @override
  String get saveSettings => 'บันทึกการตั้งค่า';

  @override
  String saveSettingsFailed(Object error) {
    return 'บันทึกการตั้งค่าไม่สำเร็จ: $error';
  }

  @override
  String get scamsLikely => 'มีแนวโน้มเป็นการหลอกลวง';

  @override
  String get search => 'ค้นหา';

  @override
  String get searchContacts => 'ค้นหาผู้ติดต่อ';

  @override
  String searchError(Object error) {
    return 'ข้อผิดพลาดในการค้นหา: $error';
  }

  @override
  String get searchFilters => 'ตัวกรองการค้นหา';

  @override
  String get searchForContacts => 'ค้นหาผู้ติดต่อ';

  @override
  String get searchHint => 'ค้นหา...';

  @override
  String get searchSettingsSubtitle =>
      'ค้นหาผู้ติดต่อ, ป้ายกำกับ, บัญชีดำ, บัญชีขาว ฯลฯ';

  @override
  String get searchSettingsTitle => 'การตั้งค่าการค้นหา';

  @override
  String get securityMessage =>
      'อย่าไว้ใจการโทรศัพท์ใดๆ ตรวจสอบหมายเลขบริการลูกค้าด้วยตนเองเสมอ ห้ามเปิดเผยรหัสผ่าน, รหัสยืนยัน, หมายเลขบัตร หรือข้อมูลส่วนตัว';

  @override
  String get selectActionToPerform => 'เลือกการดำเนินการที่จะทำเมนกฎตรงกัน';

  @override
  String get selectActionWhenBlockingCalls =>
      'เลือกการดำเนินการเมื่อบล็อกการโทร';

  @override
  String get selectActionWhenRuleMatches => 'เลือกการดำเนินการเมนกฎตรงกัน';

  @override
  String get selectAll => 'เลือกทั้งหมด';

  @override
  String get selectCountry => 'เลือกประเทศ';

  @override
  String get selectDateRange => 'เลือกช่วงวันที่';

  @override
  String get selectedDateRange => 'ช่วงวันที่ที่เลือก';

  @override
  String selectedItems(Object count) {
    return 'เลือกแล้ว $count รายการ';
  }

  @override
  String get selectedLabel => 'เลือกแล้ว:';

  @override
  String get selectExportFormat => 'เลือกรูปแบบการส่งออก';

  @override
  String get selectLabel => 'เลือกป้ายกำกับ';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'โปรดเลือกป้ายกำกับและกรอกหมายเลขโทรศัพท์ที่ถูกต้อง';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get selectMultiple => 'เลือกหลายรายการ';

  @override
  String get selectPeriod => 'เลือกช่วงเวลา';

  @override
  String get selectSimCard => 'เลือกซิมการ์ด';

  @override
  String get selectSimSlot => 'เลือกสล็อตซิมการ์ด';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'เลือกการดำเนินการเฉพาะเมื่อบล็อกการโทร';

  @override
  String get selectTag => 'เลือกแท็ก';

  @override
  String get selectTags => 'เลือกแท็ก';

  @override
  String get selectTrustedDataSource => 'โปรดเลือกแหล่งข้อมูลที่เชื่อถือได้';

  @override
  String get selectYourLanguage => 'เลือกภาษาของคุณ';

  @override
  String get sender => 'ผู้ส่ง';

  @override
  String get senderRegexOptional => 'นิพจน์ทั่วไปของผู้ส่ง (ไม่บังคับ)';

  @override
  String get serverAddressLabel => 'ที่อยู่เซิร์ฟเวอร์';

  @override
  String get serviceTypeContact => 'การสมัครสมาชิกผู้ติดต่อ';

  @override
  String get serviceTypeLabel => 'ประเภทบริการ';

  @override
  String get serviceTypePhone => 'การสมัครสมาชิกโทรศัพท์';

  @override
  String get serviceTypePlugin => 'การอัปเดตปลั๊กอิน';

  @override
  String get serviceTypeSms => 'การสมัครสมาชิก SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'ตั้งค่า';

  @override
  String get setEncryptionPassword => 'ตั้งรหัสผ่านการเข้ารหัส';

  @override
  String get setEncryptionPasswordDescription =>
      'ตั้งรหัสผ่านการเข้ารหัสสำหรับการสำรองและกู้คืน';

  @override
  String get setEncryptionPasswordLabel => 'ตั้งรหัสผ่านการเข้ารหัส';

  @override
  String get setEncryptionPasswordTitle => 'ตั้งรหัสผ่านการเข้ารหัส';

  @override
  String get setPasswordButton => 'ตั้งค่า';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String settingsBackedUpTo(Object path) {
    return 'สำรองการตั้งค่าไปยัง: $path';
  }

  @override
  String get settingsLoaded => 'โหลดการตั้งค่าสำเร็จแล้ว';

  @override
  String settingsLoadFailed(Object error) {
    return 'โหลดการตั้งค่าไม่สำเร็จ: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'กู้คืนการตั้งค่าสำเร็จแล้ว โปรดรีสตาร์ทแอปเพื่อให้การเปลี่ยนแปลงมีผล';

  @override
  String get settingsSaved => 'บันทึกการตั้งค่าแล้ว';

  @override
  String settingsSaveFailed(Object error) {
    return 'บันทึกการตั้งค่าไม่สำเร็จ: $error';
  }

  @override
  String get settingsTab => 'การตั้งค่า';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get setup => 'ตั้งค่า';

  @override
  String get showContactEditDialogStaticMethod =>
      'เมธอดแบบสแตติกเพื่อแสดงกล่องโต้ตอบแก้ไขผู้ติดต่อ';

  @override
  String get showExplanation => 'แสดงคำอธิบาย';

  @override
  String get silence => 'เงียบ';

  @override
  String get silenceAndNoAnswer => 'เงียบและไม่มีคำตอบ';

  @override
  String get silenceNoAnswer => 'เงียบ ไม่มีคำตอบ';

  @override
  String get silentCallVoiceClone => 'โคลนเสียงโทรแบบเงียบ';

  @override
  String get silentRules => 'กฎแบบเงียบ';

  @override
  String simCard(Object simNumber) {
    return 'ซิมการ์ด $simNumber';
  }

  @override
  String get simCardColor => 'สีของซิมการ์ด';

  @override
  String get simCardConfigurationExplanation =>
      '• การกำหนดค่าซิมการ์ด: ตั้งกฎการกรองที่แตกต่างกันสำหรับแต่ละซิมการ์ด';

  @override
  String get simCardFilterRules => 'กฎการกรองซิมการ์ด';

  @override
  String get simCardFilterRulesDescription =>
      'ตั้งกฎการกรองที่แตกต่างกันตามสล็อตซิมการ์ด';

  @override
  String get simCardFontSize => 'ขนาดตัวอักษรซิมการ์ด';

  @override
  String get simCardPosition => 'ตำแหน่งซิมการ์ด';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'ซิม $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'โหลดข้อมูลซิมการ์ดไม่สำเร็จ: $error';
  }

  @override
  String get simRuleInstructions =>
      'กฎสล็อต SIM ช่วยให้คุณกำหนดกฎการกรองที่แยกจากกันสำหรับแต่ละสล็อต SIM';

  @override
  String get simRuleInstructionsTitle => 'กฎสล็อต SIM';

  @override
  String get simRuleManagement => 'การจัดการกฎสล็อต SIM';

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
    return 'ไม่สามารถโหลดข้อมูล SIM ได้: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'การกำหนดค่าตัวกรองสล็อต SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'อนุญาตให้ตั้งค่ากฎตัวกรองตามสล็อต SIM';

  @override
  String get simSlotFilterDescription =>
      'กำหนดกฎการกรองที่แยกจากกันสำหรับซิมการ์ดแต่ละใบ:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'การตั้งค่าตัวกรองสล็อต SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'ไม่สามารถโหลดสล็อต SIM ได้: $error';
  }

  @override
  String get simSlotManagement => 'การจัดการสล็อต SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'การดำเนินการสล็อต SIM ล้มเหลว: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'ตำแหน่งสล็อต SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• กฎสล็อต SIM: กลยุทธ์การกรองที่แยกจากกันต่อ SIM';

  @override
  String get simSlotRuleListTitle => 'รายการกฎสล็อต SIM';

  @override
  String get simSlotRuleManagement => 'กฎสล็อต SIM';

  @override
  String get simSlotRuleManagementTitle => 'การจัดการกฎ';

  @override
  String get simSlotSettings => 'การตั้งค่าสล็อต SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'สล็อต SIM $slotNumber';
  }

  @override
  String get skip => 'ข้าม';

  @override
  String get smartCallerId => 'การระบุผู้โทรอัจฉริยะ';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'การกรอง SMS ช่วยให้คุณกรองข้อความสแปมโดยอัตโนมัติและรักษาความสะอาดของรายการข้อความของคุณ คุณสามารถตั้งค่ากฎการกรองและวิธีการแจ้งเตือนได้';

  @override
  String get smsFilterDisabled => 'การกรอง SMS ปิดใช้งาน';

  @override
  String get smsFilterEnabled => 'การกรอง SMS เปิดใช้งาน';

  @override
  String get smsFilterRuleAddedSuccessfully => 'เพิ่มกฎตัวกรอง SMS สำเร็จแล้ว';

  @override
  String get smsFilterRules => 'กฎตัวกรอง SMS';

  @override
  String get smsFilterSettings => 'การตั้งค่าตัวกรอง SMS';

  @override
  String get smsHistory => 'ประวัติ SMS';

  @override
  String get smsManagement => 'การจัดการ SMS';

  @override
  String get smsPermission => 'สิทธิ์ SMS';

  @override
  String get smsPermissionDescription => 'ใช้เพื่อกรองข้อความสแปม';

  @override
  String get smsRuleAddedSuccessfully => 'เพิ่มกฎ SMS สำเร็จแล้ว';

  @override
  String get smsRuleDeletedSuccessfully => 'ลบกฎ SMS สำเร็จแล้ว';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'ไม่สามารถโหลดกฎ SMS ได้: $error';
  }

  @override
  String get smsRuleManagement => 'การจัดการกฎ SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'ส่งออกกฎ SMS สำเร็จแล้วไปยัง $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'นำเข้ากฎ SMS สำเร็จแล้ว';

  @override
  String get smsRuleSubscription => 'การสมัครรับข้อมูลกฎ SMS';

  @override
  String get smsRuleUpdatedSuccessfully => 'อัปเดตกฎ SMS สำเร็จแล้ว';

  @override
  String get smsSettingsSubtitle => 'การกรอง SMS และการบล็อกคำสำคัญ';

  @override
  String get smsSettingsTitle => 'การตั้งค่า SMS';

  @override
  String get smsSubscription => 'การสมัครรับข้อมูล SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'เพิ่มการสมัครรับข้อมูล SMS สำเร็จแล้ว';

  @override
  String get smsSubscriptionRulesDescription =>
      'สมัครรับรายการกฎ SMS ผ่าน URL รองรับการจับคู่รูปแบบปกติ คุณสามารถตั้งค่าการบล็อกหรืออนุญาตการดำเนินการได้';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'ปฏิเสธคำขอสิทธิ์บางส่วน';

  @override
  String get spamLikely => 'น่าจะเป็นสแปม';

  @override
  String get startColor => 'สีเริ่มต้น';

  @override
  String get startDate => 'วันที่เริ่มต้น';

  @override
  String get startUsing => 'เริ่มต้นใช้งาน';

  @override
  String get statAnswered => 'รับสาย';

  @override
  String get statBlocked => 'บล็อก';

  @override
  String get staticMethodShowCallerIdDialog =>
      'วิธีคงที่ในการแสดงกล่องโต้ตอบข้อมูลผู้โทร';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'วิธีคงที่ในการแสดงกล่องโต้ตอบเลือกประเทศ';

  @override
  String get staticMethodToDisplayDialog => 'วิธีคงที่ในการแสดงกล่องโต้ตอบ';

  @override
  String get statistics => 'สถิติ';

  @override
  String get statisticsExportFeatureComingSoon =>
      'ฟีเจอร์ส่งออกสถิติจะมาเร็วๆ นี้';

  @override
  String get statisticsGrid => 'ตารางสถิติ';

  @override
  String get statisticsPageTitle => 'การวิเคราะห์ข้อมูล';

  @override
  String get stirColor => 'สี STIR';

  @override
  String get stirFontSize => 'ขนาดตัวอักษร STIR';

  @override
  String get stirPosition => 'ตำแหน่ง STIR';

  @override
  String get storagePermission => 'สิทธิ์ที่เก็บข้อมูล';

  @override
  String get storagePermissionDescription => 'ใช้เพื่อบันทึกการตั้งค่าและกฎ';

  @override
  String get subscribe => 'สมัคร';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'เพิ่มการสมัครรับข้อมูล \"$name\" สำเร็จแล้ว';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบการสมัครรับข้อมูลนี้?';

  @override
  String get subscriptionDeleteConfirmTitle => 'ลบการสมัครรับข้อมูล';

  @override
  String get subscriptionDeleted => 'ลบการสมัครรับข้อมูลแล้ว';

  @override
  String get subscriptionDeletedSuccessfully => 'ลบการสมัครรับข้อมูลสำเร็จแล้ว';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'ไม่สามารถลบการสมัครรับข้อมูลได้: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'ลบการสมัครรับข้อมูลแล้ว';

  @override
  String get subscriptionEmptyState => 'ไม่มีการสมัครรับข้อมูล';

  @override
  String get subscriptionEmptyText => 'ยังไม่มีการสมัครรับข้อมูล';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'ไม่สามารถโหลดการสมัครรับข้อมูลได้: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'ไม่สามารถโหลดการสมัครรับข้อมูลได้: $error';
  }

  @override
  String get subscriptionManagementTitle => 'การจัดการการสมัครรับข้อมูล';

  @override
  String get subscriptionName => 'ชื่อการสมัครรับข้อมูล';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'ชื่อและการสมัครรับข้อมูล URL ต้องไม่ว่างเปล่า';

  @override
  String get subscriptionNameHint => 'ป้อนชื่อการสมัครรับข้อมูล';

  @override
  String get subscriptionPageTitle => 'การจัดการการสมัครรับข้อมูล';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'ไม่สามารถเปลี่ยนสถานะการสมัครรับข้อมูลได้: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'ไม่สามารถสลับสถานะการสมัครรับข้อมูลได้: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'ไม่สามารถอัปเดตการสมัครรับข้อมูลได้: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'อัปเดตการสมัครรับข้อมูลสำเร็จแล้ว';

  @override
  String get subscriptionUrl => 'URL การสมัครรับข้อมูล';

  @override
  String get subscriptionUrlHint => 'ป้อน URL การสมัครรับข้อมูล';

  @override
  String successfullyImportedRules(Object count) {
    return 'นำเข้ากฎ $count รายการสำเร็จแล้ว';
  }

  @override
  String get supportSync => 'รองรับการซิงค์';

  @override
  String get survey => 'สำรวจ';

  @override
  String get syncDevicesButton => 'ซิงค์อุปกรณ์';

  @override
  String get syncFailed => 'การซิงค์ล้มเหลว';

  @override
  String get syncFailedMessage => 'การซิงค์ล้มเหลว';

  @override
  String get syncFolderNameHint =>
      'โปรดป้อนชื่อโฟลเดอร์ซิงค์ (ค่าเริ่มต้น: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'ชื่อโฟลเดอร์ซิงค์';

  @override
  String get synchronized => 'ซิงโครไนซ์แล้ว';

  @override
  String get syncing => 'กำลังซิงค์...';

  @override
  String get syncNow => 'ซิงค์ทันที';

  @override
  String get syncNowButton => 'ซิงค์ตอนนี้';

  @override
  String get syncStatusTitle => 'สถานะการซิงค์';

  @override
  String get syncStatusUpdatedMessage => 'อัปเดตสถานะการซิงค์แล้ว';

  @override
  String get syncSuccessful => 'การซิงค์สำเร็จ';

  @override
  String get syncSuccessMessage => 'การซิงค์สำเร็จ';

  @override
  String get syncWithCloudStorage => 'ซิงค์กับที่เก็บข้อมูลบนคลาวด์';

  @override
  String get syncWithCloudStorageSubtitle => 'ซิงค์กับที่เก็บข้อมูลบนคลาวด์';

  @override
  String get systemFeatures => 'คุณสมบัติของระบบ:';

  @override
  String get systemSettingsTitle => 'การตั้งค่าระบบ';

  @override
  String get tabAll => 'ทั้งหมด';

  @override
  String get tabAnswered => 'ตอบแล้ว';

  @override
  String get tabBlocked => 'บล็อกแล้ว';

  @override
  String get tabMissed => 'พลาดสาย';

  @override
  String get tabOutgoing => 'สายออก';

  @override
  String tagLabel(String tag) {
    return 'แท็ก: $tag';
  }

  @override
  String get tagsUpdated => 'อัปเดตแท็กแล้ว';

  @override
  String get takeaway => 'ซื้อกลับบ้าน';

  @override
  String get telecommunication => 'โทรคมนาคม';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'การตลาดทางโทรศัพท์';

  @override
  String get testButton => 'ทดสอบ';

  @override
  String get testButtonLabel => 'ทดสอบ';

  @override
  String get testConnectionButton => 'ทดสอบการเชื่อมต่อ';

  @override
  String get textColorsSetting => 'สีข้อความและป้ายกำกับ';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'แอปนี้เป็นเครื่องมือระบุเบอร์โทรที่มีประสิทธิภาพที่ช่วยให้คุณระบุและบล็อกสายที่ไม่ต้องการได้';

  @override
  String get thisWeek => 'สัปดาห์นี้';

  @override
  String get timeInterceptor => 'ตัวสกัดกั้นเวลา';

  @override
  String get timeInterceptorDescription =>
      'สกัดกั้น/อนุญาตสายที่อาจเกิดขึ้นโดยอัตโนมัติตามความถี่ในการโทร';

  @override
  String get timeInterceptorExplanation =>
      '• ตัวสกัดกั้นเวลา: สกัดกั้น/อนุญาตสายซ้ำๆ ภายในระยะเวลาสั้นๆ';

  @override
  String get timeInterceptorExplanationContent =>
      'ฟีเจอร์การสกัดกั้นความถี่ในการโทรจะวิเคราะห์ความถี่ในการโทรเพื่อระบุและสกัดกั้น/อนุญาตสายสแปมที่โทรบ่อยโดยอัตโนมัติ';

  @override
  String get timeInterceptorExplanationTitle =>
      'คำอธิบายการสกัดกั้นความถี่ในการโทร';

  @override
  String get timeInterceptorSettingsTitle =>
      'การตั้งค่าการสกัดกั้นความถี่ในการโทร';

  @override
  String get timeInterceptorSubtitle =>
      'สกัดกั้นสายสแปมที่อาจเกิดขึ้นโดยอัตโนมัติตามความถี่ในการโทร';

  @override
  String get timeInterceptorTitle => 'เปิดใช้งานการสกัดกั้นความถี่ในการโทร';

  @override
  String get timeWindowDescription =>
      'กำหนดขนาดหน้าต่างเวลาสำหรับการอนุญาตให้โทรซ้ำๆ สายจากหมายเลขเดียวกันภายในหน้าต่างนี้จะได้รับอนุญาต';

  @override
  String timeWindowLabel(int minutes) {
    return 'หน้าต่างเวลาสกัดกั้น (นาที): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'กำหนดขนาดหน้าต่างเวลาสำหรับการอนุญาตให้โทรซ้ำๆ สายจากหมายเลขเดียวกันภายในหน้าต่างนี้จะได้รับอนุญาต';

  @override
  String get today => 'วันนี้';

  @override
  String get total => 'ทั้งหมด';

  @override
  String get totalBlocked => 'บล็อกทั้งหมด';

  @override
  String get totalFiltered => 'กรองทั้งหมด';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'ถ่ายโอนข้อมูลระหว่างอุปกรณ์หรือแพลตฟอร์ม';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'ถ่ายโอนข้อมูลระหว่างอุปกรณ์หรือแพลตฟอร์ม';

  @override
  String get travelTicketing => 'ตั๋วเดินทาง';

  @override
  String get trend => 'แนวโน้ม';

  @override
  String get trendChart => 'แผนภูมิแนวโน้ม';

  @override
  String get tutorial => 'บทแนะนำ';

  @override
  String get type => 'ประเภท';

  @override
  String get unassignedSIMCard => 'ซิมการ์ดที่ไม่ได้กำหนด';

  @override
  String get unknown => 'ไม่ทราบ';

  @override
  String get unknownLabel => 'ป้ายกำกับที่ไม่ทราบ';

  @override
  String get unknownTag => 'แท็ก: ไม่ทราบ';

  @override
  String get unregisterButton => 'ยกเลิกการลงทะเบียน';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการยกเลิกการลงทะเบียน $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'ยกเลิกการลงทะเบียนอุปกรณ์';

  @override
  String get unsupportedFileFormat => 'รูปแบบไฟล์ไม่รองรับ';

  @override
  String get update => 'อัปเดต';

  @override
  String get updateAllNow => 'อัปเดตทั้งหมดตอนนี้';

  @override
  String get updateCallFilterConfig => 'อัปเดตการกำหนดค่าตัวกรองการโทร';

  @override
  String updateContactFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตผู้ติดต่อ: $error';
  }

  @override
  String get updateFavoriteStatus => 'อัปเดตสถานะรายการโปรด';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตสถานะรายการโปรด: $error';
  }

  @override
  String get updateInterval => 'ช่วงเวลาอัปเดต';

  @override
  String get updateLabelFailed => 'ล้มเหลวในการอัปเดตป้ายกำกับ';

  @override
  String get updateNow => 'อัปเดตตอนนี้';

  @override
  String get updatePlugin => 'อัปเดตปลั๊กอิน';

  @override
  String updatePluginFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตปลั๊กอิน: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตกฎ: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'ล้มเหลวในการอัปเดตการสมัครสมาชิก: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service อัปเดตสำเร็จ ($count กฎ)';
  }

  @override
  String get updateTags => 'อัปเดตแท็ก';

  @override
  String get useCasesPoint1 => '• ระบุสายสแปมที่โทรซ้ำอัตโนมัติ';

  @override
  String get useCasesPoint2 =>
      '• สกัดกั้นสายการตลาดที่โทรหลายครั้งในเวลาอันสั้น';

  @override
  String get useCasesPoint3 => '• ป้องกันการก่อกวนและการคุกคามทางโทรศัพท์';

  @override
  String get useCasesTitle => 'กรณีการใช้งาน:';

  @override
  String get useGlobalSettings => 'ใช้การตั้งค่าส่วนกลาง';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'ชื่อผู้ใช้';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'ใช้ไวยากรณ์ regex มาตรฐานเพื่อกำหนดรูปแบบ ตัวอย่าง:';

  @override
  String get validateRegex => 'ตรวจสอบ Regex';

  @override
  String get verificationFailedText => 'ล้มเหลว';

  @override
  String get verifiedText => 'ยืนยันแล้ว';

  @override
  String get verify => 'ยืนยัน';

  @override
  String version(Object version) {
    return 'เวอร์ชัน: $version';
  }

  @override
  String get vipExchangeDescription =>
      'แลกเปลี่ยนสมาชิก VIP กับจำนวนการทำเครื่องหมายหมายเลขโทรศัพท์';

  @override
  String get vipExchangeTitle => 'แลกเปลี่ยน VIP';

  @override
  String get watchAd => 'ดูโฆษณา';

  @override
  String get watchAdForTemp => 'ดูโฆษณาเพื่อสิทธิ์ชั่วคราว';

  @override
  String get watchAdForTempDescription =>
      'ดูโฆษณาสั้นๆ เพื่อปลดล็อกคุณสมบัติพรีเมียมบางอย่างชั่วคราว';

  @override
  String get webDAVConfigTitle => 'การกำหนดค่า WebDAV';

  @override
  String get webdavConfigurationTitle => 'การกำหนดค่า WebDAV';

  @override
  String get webdavPasswordHint => 'โปรดป้อนรหัสผ่าน WebDAV';

  @override
  String get webdavServerAddressHint => 'โปรดป้อนที่อยู่เซิร์ฟเวอร์ WebDAV';

  @override
  String get webdavUsernameHint => 'โปรดป้อนชื่อผู้ใช้ WebDAV';

  @override
  String get week => 'สัปดาห์';

  @override
  String get weekly => 'รายสัปดาห์';

  @override
  String get weeklyBlockedCallsSummary => 'สรุปสายที่บล็อกรายสัปดาห์';

  @override
  String get weeklyChartTitle => 'สายที่บล็อกรายสัปดาห์';

  @override
  String get weeklyReport => 'รายงานรายสัปดาห์';

  @override
  String get weeklyReportDesc => 'รับรายงานสรุปกิจกรรมการบล็อกสายประจำสัปดาห์';

  @override
  String get welcome => 'ยินดีต้อนรับ';

  @override
  String get whitelist => 'รายการที่อนุญาต';

  @override
  String get whitelistLabel => 'รายการที่อนุญาต';

  @override
  String get width => 'ความกว้าง';

  @override
  String get wildcardMatchingDescription =>
      'ใช้ \'.\' เพื่อจับคู่ตัวอักษรใดๆ (เช่น \'123.456\' จะตรงกับ 123-456)';

  @override
  String get wildcardMatchingTitle => 'การจับคู่ Wildcard:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'รองรับ Wildcard สำหรับการกรองที่ยืดหยุ่น';

  @override
  String get windowSizeSetting => 'ขนาดหน้าต่าง';

  @override
  String get year => 'ปี';

  @override
  String get yearly => 'รายปี';

  @override
  String get yearlyChartTitle => 'การโทรที่ถูกบล็อกรายปี';

  @override
  String get noSimCardsDetected => 'ไม่พบซิมการ์ด';

  @override
  String get filterManagementDescription => 'ตั้งค่าตัวกรองการโทร';

  @override
  String get callerIdCustomizationSubtitle => 'ปรับแต่งเลย์เอาต์ ID ผู้โทร';

  @override
  String get fraudAlerSettingTitle => 'การตั้งค่าการแจ้งเตือนการฉ้อโกง';

  @override
  String get fraudAlerSettingSubtitle => 'เพื่อตั้งค่าการแจ้งเตือนการฉ้อโกง';

  @override
  String get enableFraudAlert => 'เปิดใช้งานการแจ้งเตือนการฉ้อโกง';

  @override
  String get enableFraudAlertDescription =>
      'แจ้งเตือนสำหรับการโทรที่สงสัยว่าเป็นการหลอกลวง';

  @override
  String get enableVibration => 'เปิดใช้งานการสั่น';

  @override
  String get enableVibrationDescription =>
      'สั่นเมื่อการโทรสงสัยว่าเป็นการหลอกลวง';

  @override
  String get notificationSettingsTitle => 'การตั้งค่าการแจ้งเตือน';

  @override
  String get useLocalNotification => 'ใช้การแจ้งเตือนในเครื่อง';

  @override
  String get useLocalNotificationDescription =>
      'เปิดใช้งานการแจ้งเตือนในเครื่องสำหรับการโทรเข้า';

  @override
  String get cancelLocalNotification => 'ปิดการแจ้งเตือนในเครื่อง';

  @override
  String get useStirNotification => 'ใช้การแจ้งเตือนจาก STIR';

  @override
  String get useStirNotificationDescription =>
      'เปิดใช้งานการแจ้งเตือน STIR สำหรับการโทรเข้า';

  @override
  String get cancelLocalNotificationDescription =>
      'ปิดการแจ้งเตือนในเครื่องโดยอัตโนมัติ';

  @override
  String get callerIdSettingsTitle => 'การตั้งค่า ID ผู้โทร';

  @override
  String get callerIdSettingsSubtitle =>
      'เพื่อตั้งค่าการแจ้งเตือนการโทรเข้าและโหมดการแสดงผล';

  @override
  String get purchaseTitle => 'การซื้อ';

  @override
  String get purchaseSubtitle => 'เพื่อซื้อบริการ';

  @override
  String get callerIdNotificationTitle => 'ข้อมูลการโทรเข้า';

  @override
  String callerIdBody(String phoneNumber) {
    return 'หมายเลข: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'การโทรที่ถูกบล็อก';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'การโทรที่ถูกบล็อกจาก $phoneNumber';
  }

  @override
  String get stirVerified => 'ยืนยันแล้ว';

  @override
  String get stirNotVerified => 'ยังไม่ได้รับการยืนยัน';

  @override
  String get stirFailed => 'การยืนยันล้มเหลว';

  @override
  String get stirUnknown => 'สถานะการยืนยันไม่ทราบ';

  @override
  String get stirVerificationTitle => 'การยืนยัน STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage สำหรับหมายเลข $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'การตั้งค่าข้อความรักษาความปลอดภัยแบบเลื่อน';

  @override
  String get messageColor => 'สีข้อความ';

  @override
  String get messageFontSize => 'ขนาดตัวอักษรข้อความ';

  @override
  String get messagePosition => 'ตำแหน่งข้อความ';

  @override
  String get containerWidth => 'ความกว้างคอนเทนเนอร์';

  @override
  String get scrollSpeed => 'ความเร็วในการเลื่อน';

  @override
  String get enableSecurityMessage => 'เปิดใช้งานข้อความรักษาความปลอดภัย';

  @override
  String get fraudAlertTitle => 'การแจ้งเตือนการฉ้อโกง';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'การโทรที่อาจเป็นการฉ้อโกงจาก $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'ไม่สามารถโหลดกฎได้: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'ไม่สามารถโหลดบันทึกการโทรได้: $error';
  }

  @override
  String get noBlockedTypeData => 'ไม่มีข้อมูลประเภทที่ถูกบล็อก';

  @override
  String importEntity(Object entityTypeName) {
    return 'นำเข้า $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return 'นำเข้า $entityTypeName สำเร็จ, รวม $count รายการ';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'ไม่สามารถนำเข้า $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'ส่งออก $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return 'ส่งออก $entityTypeName สำเร็จ';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'ไม่สามารถส่งออก $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'บริการซิงค์คลาวด์';

  @override
  String get membershipCenter => 'ศูนย์สมาชิก';

  @override
  String get redeemVipWithMarks => 'แลก VIP ด้วยคะแนน';

  @override
  String get currentMarkCount => 'จำนวนคะแนนปัจจุบัน';

  @override
  String get markMoreNumbersForMore =>
      'ทำเครื่องหมายหมายเลขเพิ่มเติมเพื่อรับคะแนนเพิ่ม';

  @override
  String get noAds => 'ไม่มีโฆษณา';

  @override
  String get cloudBackup => 'สำรองข้อมูลบนคลาวด์';

  @override
  String get callerIdEnhancement => 'การปรับปรุง ID ผู้โทร';

  @override
  String get voiceRecognition => 'การรู้จำเสียง';

  @override
  String get feature => 'คุณสมบัติ';

  @override
  String get normalUser => 'ผู้ใช้ทั่วไป';

  @override
  String get vipUser => 'ผู้ใช้ VIP';

  @override
  String get temporaryVip => 'VIP ชั่วคราว';

  @override
  String get removeAds => 'ลบโฆษณา';

  @override
  String get unknownAction => 'การดำเนินการไม่ทราบ';

  @override
  String get settingsBackup => 'สำรองข้อมูลการตั้งค่า ';

  @override
  String get allServicesStatusTitle => 'สถานะบริการปัจจุบัน';

  @override
  String get allServicesStatusSubtitle => 'สถานะปัจจุบันของแต่ละบริการคลาวด์';

  @override
  String get redirect => 'เปลี่ยนเส้นทาง';

  @override
  String get notify => 'แจ้ง';

  @override
  String get log => 'บันทึก';

  @override
  String get custom => 'กำหนดเอง';

  @override
  String get allowActionDescription =>
      'การโทรจะได้รับอนุญาต แม้ว่าหมายเลขจะอยู่ในรายการบล็อก';

  @override
  String get blockActionDescription => 'การโทรจะถูกบล็อกและแสดงในบันทึกการโทร';

  @override
  String get silenceActionDescription =>
      'การโทรจะถูกปิดเสียง แต่จะแสดงในบันทึกการโทร';

  @override
  String get noneActionDescription => 'จะไม่มีการดำเนินการพิเศษใดๆ กับการโทร';

  @override
  String get redirectActionDescription =>
      'เปลี่ยนเส้นทางการโทรไปยังหมายเลขที่ระบุ';

  @override
  String get labelActionDescription =>
      'เพิ่มป้ายกำกับให้กับการโทรเพื่อการระบุตัวตนที่ง่าย';

  @override
  String get notifyActionDescription => 'ส่งการแจ้งเตือนเมื่อมีการรับสาย';

  @override
  String get logActionDescription => 'บันทึกข้อมูลการโทรโดยไม่ดำเนินการอื่นใด';

  @override
  String get customActionDescription => 'ดำเนินการตามการดำเนินการที่กำหนดเอง';

  @override
  String get synced => 'ซิงค์แล้ว';

  @override
  String get needVipAccess => 'คุณต้องเข้าถึง VIP เพื่อใช้คุณสมบัตินี้';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'นำเข้าหรือส่งออกข้อมูล $entityTypeName';
  }

  @override
  String get importExportTitle => 'นำเข้า/ส่งออก';

  @override
  String get noPhoneRules => 'ไม่พบกฎหมายเลขโทรศัพท์';

  @override
  String get noRegexRules => 'ไม่พบกฎ regex';

  @override
  String get noAllowedBlockedRules => 'ไม่พบกฎที่อนุญาต/บล็อก';

  @override
  String get importExport => 'นำเข้า/ส่งออก';

  @override
  String get filterByAction => 'กรองตามการดำเนินการ';

  @override
  String get upgradeToVip => 'อัปเกรดเป็น VIP';

  @override
  String get batteryOptimizationPermission => 'การเพิ่มประสิทธิภาพแบตเตอรี่';

  @override
  String get batteryOptimizationPermissionDescription =>
      'อนุญาตให้แอปทำงานในเบื้องหลังเพื่อให้บริการต่างๆ เช่น ID ผู้โทร';

  @override
  String get permissionTitle => 'สิทธิ์พิเศษ';

  @override
  String get permissionSubtitle =>
      'จัดการสิทธิ์การแสดงผลและการเพิ่มประสิทธิภาพแบตเตอรี่';

  @override
  String get themeSettingsTitle => 'การตั้งค่าธีม';

  @override
  String get themeSettingsSubtitle => 'เลือกธีมที่คุณชื่นชอบ';

  @override
  String get databaseSyncTitle => 'การซิงค์ฐานข้อมูล';

  @override
  String get countrySyncSettingsTitle => 'การตั้งค่าการซิงค์ฐานข้อมูลตามประเทศ';

  @override
  String get countrySyncSettingsSubtitle =>
      'เลือกประเทศสำหรับการซิงโครไนซ์ข้อมูล';

  @override
  String get countryDataDisclaimer =>
      'โปรดทราบ: ฐานข้อมูลอาจไม่มีข้อมูลสำหรับทุกประเทศหรือภูมิภาคที่เฉพาะเจาะจง';

  @override
  String get editSubscription => 'แก้ไขการสมัครสมาชิก';

  @override
  String get searchByNameOrPhoneNumber => 'ค้นหาตามชื่อหรือเบอร์โทรศัพท์';

  @override
  String get allowedBlockedRulesInfo =>
      'กฎที่อนุญาต/บล็อกใช้เพื่อจับคู่การโทรกับหมายเลขโทรศัพท์เฉพาะ ซึ่งมีลำดับความสำคัญสูงสุด';

  @override
  String get searchPhoneRulesHint => 'ค้นหากฎโทรศัพท์';

  @override
  String get phoneRulesInfo =>
      'กฎโทรศัพท์ใช้เพื่อจับคู่การโทรกับหมายเลขโทรศัพท์เฉพาะ ซึ่งมีลำดับความสำคัญต่ำกว่า บางส่วนมาจากระบบการสมัครสมาชิก phoneRule';

  @override
  String get searchSubscriptionsHint => 'ค้นหาการสมัครสมาชิก';

  @override
  String get searchPluginsHint => 'ค้นหาปลั๊กอิน';

  @override
  String get searchLabelsHint => 'ค้นหาป้ายกำกับ';

  @override
  String get pluginDescription => 'คำอธิบายปลั๊กอิน';

  @override
  String get enterPluginDescription => 'ป้อนคำอธิบายปลั๊กอิน';

  @override
  String get searchRegexRulesHint => 'ค้นหากฎ regex';

  @override
  String get regexRulesInfo => 'กฎ Regex ใช้เพื่อกรองการโทรตามรูปแบบ Regex';

  @override
  String get searchMarkedPhonesHint => 'ค้นหาโทรศัพท์ที่ทำเครื่องหมายไว้';

  @override
  String get searchContactSubscriptionsHint => 'ค้นหาการสมัครสมาชิกผู้ติดต่อ';

  @override
  String get showAllContacts => 'แสดงผู้ติดต่อทั้งหมด';

  @override
  String get showFavorites => 'แสดงรายการโปรด';

  @override
  String get manualEntry => 'ข้อมูลการป้อนด้วยตนเอง';

  @override
  String get scriptSaved => 'สคริปต์ถูกบันทึกแล้ว';

  @override
  String editScriptFor(String pluginName) {
    return 'แก้ไขสคริปต์สำหรับ $pluginName';
  }

  @override
  String get saveScript => 'บันทึกสคริปต์';

  @override
  String get testPlugin => 'ทดสอบปลั๊กอิน';

  @override
  String get description => 'คำอธิบาย';

  @override
  String get accessTargetUrl => 'เข้าถึง URL เป้าหมาย';

  @override
  String get result => 'ผลลัพธ์';

  @override
  String get editScript => 'แก้ไขสคริปต์';

  @override
  String get numberFormat => 'รูปแบบหมายเลข';

  @override
  String get nationalNumber => 'หมายเลขประจำชาติ';

  @override
  String get e164Number => 'หมายเลข E164';

  @override
  String get pluginRulesInfo =>
      'เพื่อความปลอดภัย โปรดใช้ปลั๊กอินจากแหล่งที่เชื่อถือได้เท่านั้น รู้สึกอิสระที่จะใช้เทมเพลตของเราเพื่อสร้างปลั๊กอินที่กำหนดเองของคุณเอง!';

  @override
  String get advancedMode => 'โหมดขั้นสูง';

  @override
  String get pleaseEnterAtLeastOneNumber => 'โปรดป้อนอย่างน้อยหนึ่งหมายเลข';

  @override
  String get openInWebView => 'เปิดใน WebView';

  @override
  String get pluginLabel => 'ป้ายกำกับปลั๊กอิน';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'สีพื้นหลังข้อความ';

  @override
  String get clearAllCallLogs => 'ล้างประวัติการโทรทั้งหมด';

  @override
  String get clearAllCallLogsConfirmation =>
      'ยืนยันเพื่อล้างประวัติการโทรทั้งหมด';

  @override
  String get allCallLogsCleared => 'ประวัติการโทรทั้งหมดถูกล้างแล้ว';

  @override
  String get unblocked => 'ยกเลิกการบล็อก';

  @override
  String get blockNumber => 'บล็อกหมายเลข';

  @override
  String get blockNumberSuccess => 'บล็อกหมายเลขสำเร็จ';

  @override
  String get blockNumberFailed => 'บล็อกหมายเลขล้มเหลว';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการยกเลิกการบล็อก $phoneNumber';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'กำลังโทรหา $phoneNumber...';
  }

  @override
  String get viewDetails => 'ดูรายละเอียด';

  @override
  String get unblock => 'ยกเลิกการบล็อก';

  @override
  String get unblockNumber => 'ยกเลิกการบล็อกหมายเลข';

  @override
  String get unblockNumberSuccess => 'ยกเลิกการบล็อกหมายเลขสำเร็จ';

  @override
  String get unblockNumberFailed => 'ยกเลิกการบล็อกหมายเลขล้มเหลว';

  @override
  String get serviceNotAvailable => 'บริการไม่พร้อมใช้งาน';

  @override
  String get callingNumberFailed => 'การโทรหาหมายเลขล้มเหลว';

  @override
  String get listView => 'มุมมองรายการ';

  @override
  String get timelineView => 'มุมมองไทม์ไลน์';

  @override
  String get nameCannotBeEmpty => 'ชื่อต้องไม่ว่างเปล่า';

  @override
  String get selectAction => 'เลือกการดำเนินการ';

  @override
  String get selectTargetService => 'เลือกบริการเป้าหมาย';

  @override
  String get callDetails => 'รายละเอียดการโทร';

  @override
  String get callType => 'ประเภทการโทร';

  @override
  String get callTime => 'เวลาโทร';

  @override
  String get numberInvalidFormat => 'รูปแบบหมายเลขไม่ถูกต้อง';

  @override
  String get membershipFeature => 'ฟีเจอร์สมาชิก';

  @override
  String get medium => 'ปานกลาง';

  @override
  String get verificationReport => 'รายงานการตรวจสอบ';

  @override
  String get finalRisk => 'ความเสี่ยงสุดท้าย';

  @override
  String get simState => 'สถานะ SIM';

  @override
  String get ipCountry => 'ประเทศ IP';

  @override
  String get simCountry => 'ประเทศ SIM';

  @override
  String get isRoaming => 'กำลังโรมมิ่ง';

  @override
  String get isNumberMatch => 'ตรงกับหมายเลข';

  @override
  String get support => 'สนับสนุน';

  @override
  String get rewardedAdService => 'บริการโฆษณาที่ได้รับรางวัล';

  @override
  String get hasVipPrivilegeExceptAds =>
      'คุณมีสิทธิ์ VIP อยู่แล้ว (ยกเว้นโฆษณา)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'คุณมีสิทธิ์ชั่วคราวแล้ว หมดอายุ: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'คุณต้องดูโฆษณาอีก $count รายการเพื่อรับสิทธิ์ VIP ชั่วคราว';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'คุณได้รับสิทธิ์การซื้อชั่วคราว $days วัน หมดอายุ: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'สิทธิ์การซื้อชั่วคราวหมดอายุแล้ว';

  @override
  String get loadingAd => 'กำลังโหลดโฆษณา...';

  @override
  String get earnedTempVip => 'ได้รับ VIP ชั่วคราว';

  @override
  String get vipExchangeService => 'บริการแลก VIP';

  @override
  String get marksInsufficient => 'เครื่องหมายไม่เพียงพอสำหรับการแลก';

  @override
  String get invalidExchangeRule => 'กฎการแลกเปลี่ยนไม่ถูกต้อง';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'แลกเปลี่ยนสำเร็จเป็น $description หมดอายุ: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'การแลกเปลี่ยนล้มเหลว: $error';
  }

  @override
  String get vip3DaysWithAds => 'VIP 3 วันพร้อมโฆษณา (ซิงค์เท่านั้น)';

  @override
  String get vip5DaysNoAds => 'VIP 5 วันเต็มรูปแบบไม่มีโฆษณา';

  @override
  String get vip7DaysNoAds => 'VIP 7 วันเต็มรูปแบบไม่มีโฆษณา';

  @override
  String get noNotifications => 'ไม่มีการแจ้งเตือน';

  @override
  String get clearAllNotifications => 'ล้างการแจ้งเตือนทั้งหมด';

  @override
  String get clearAllNotificationsConfirmation =>
      'ยืนยันเพื่อล้างการแจ้งเตือนทั้งหมด';

  @override
  String get allNotificationsCleared => 'ล้างการแจ้งเตือนทั้งหมดแล้ว';

  @override
  String get clearButton => 'ล้าง';

  @override
  String get justNow => 'เมื่อสักครู่';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count นาทีที่แล้ว',
      one: '1 นาทีที่แล้ว',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ชั่วโมงที่แล้ว',
      one: '1 ชั่วโมงที่แล้ว',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count วันที่แล้ว',
      one: '1 วันที่แล้ว',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'เมื่อวานนี้';

  @override
  String get deletionProposal => 'ข้อเสนอการลบ';

  @override
  String get deletionProposals => 'ข้อเสนอการลบ';

  @override
  String get createProposal => 'สร้างข้อเสนอ';

  @override
  String get createProposalTitle => 'สร้างข้อเสนอการลบ';

  @override
  String get reason => 'เหตุผล';

  @override
  String get reasonOutdated => 'หมายเลขที่ล้าสมัย';

  @override
  String get reasonPrivacy => 'ข้อกังวลด้านความเป็นส่วนตัว';

  @override
  String get reasonNotInService => 'ไม่อยู่ในบริการ';

  @override
  String get reasonWronglyIdentified => 'ระบุตัวตนผิด';

  @override
  String get reasonInaccurateInfo => 'ข้อมูลไม่ถูกต้อง';

  @override
  String get reasonWrongMarked => 'ทำเครื่องหมายผิด';

  @override
  String get reasonOther => 'อื่นๆ';

  @override
  String get submit => 'ส่ง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get proposalStatus => 'สถานะ';

  @override
  String get statusPending => 'รอดำเนินการ';

  @override
  String get statusActive => 'ใช้งานอยู่';

  @override
  String get statusCompleted => 'เสร็จสมบูรณ์';

  @override
  String get statusExpired => 'หมดอายุแล้ว';

  @override
  String get riskLevel => 'ระดับความเสี่ยง';

  @override
  String get riskLevelVerified => 'ยืนยันแล้ว';

  @override
  String get riskLevelLow => 'ต่ำ';

  @override
  String get riskLevelHigh => 'สูง';

  @override
  String get riskLevelUnknown => 'ไม่ทราบ';

  @override
  String get votingProgress => 'ความคืบหน้าในการโหวต';

  @override
  String agreeVotes(int count) {
    return 'เห็นด้วย: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'ไม่เห็นด้วย: $count';
  }

  @override
  String totalVotes(int count) {
    return 'ทั้งหมด: $count';
  }

  @override
  String get voteAgree => 'เห็นด้วย';

  @override
  String get voteDisagree => 'ไม่เห็นด้วย';

  @override
  String createdAt(String date) {
    return 'สร้างเมื่อ: $date';
  }

  @override
  String get showReport => 'แสดงรายงาน';

  @override
  String get hideReport => 'ซ่อนรายงาน';

  @override
  String get proposalStatistics => 'สถิติข้อเสนอ';

  @override
  String get totalProposals => 'ข้อเสนอทั้งหมด';

  @override
  String get activeProposals => 'ข้อเสนอที่ใช้งานอยู่';

  @override
  String get completedProposals => 'ข้อเสนอที่เสร็จสมบูรณ์';

  @override
  String get myVotes => 'การโหวตของฉัน';

  @override
  String get proposalCreated => 'สร้างข้อเสนอสำเร็จ';

  @override
  String get proposalCreateFailed => 'สร้างข้อเสนอไม่สำเร็จ';

  @override
  String get voteSubmitted => 'ส่งการโหวตสำเร็จ';

  @override
  String get voteSubmitFailed => 'ส่งการโหวตไม่สำเร็จ';

  @override
  String get noProposalsFound => 'ไม่พบข้อเสนอ';

  @override
  String get loadingProposals => 'กำลังโหลดข้อเสนอ...';

  @override
  String get refreshProposals => 'รีเฟรชข้อเสนอ';

  @override
  String get totalPendingProposals => 'ข้อเสนอที่รอดำเนินการทั้งหมด';

  @override
  String get highRisk => 'ความเสี่ยงสูง';

  @override
  String get mediumRisk => 'ความเสี่ยงปานกลาง';

  @override
  String get lowRisk => 'ความเสี่ยงต่ำ';

  @override
  String get communityImpact => 'ผลกระทบต่อชุมชน';

  @override
  String get criticalIssues => 'ประเด็นวิกฤต';

  @override
  String get communityParticipation => 'การมีส่วนร่วมของชุมชน';

  @override
  String get noActivity => 'ไม่มีกิจกรรม';

  @override
  String get low => 'ต่ำ';

  @override
  String get moderate => 'ปานกลาง';

  @override
  String get high => 'สูง';

  @override
  String get veryHigh => 'สูงมาก';

  @override
  String get voted => 'โหวตแล้ว';

  @override
  String get communityVotes => 'การโหวตของชุมชน';

  @override
  String get waitingForMoreVotes => 'รอการโหวตจากชุมชนเพิ่มเติม';

  @override
  String get proposalProcessed => 'ข้อเสนอนี้ได้รับการประมวลผลแล้ว';

  @override
  String get supported => 'สนับสนุน';

  @override
  String get opposed => 'คัดค้าน';

  @override
  String get approved => 'อนุมัติ';

  @override
  String get rejected => 'ปฏิเสธ';

  @override
  String get completed => 'เสร็จสมบูรณ์';

  @override
  String get pending => 'รอดำเนินการ';

  @override
  String get critical => 'วิกฤต';

  @override
  String get oppose => 'คัดค้าน';

  @override
  String get veryLow => 'ต่ำมาก';

  @override
  String get deletionProposalNotificationDescription =>
      'การแจ้งเตือนเกี่ยวกับผลการโหวตข้อเสนอการลบและการอัปเดต';

  @override
  String get deletionProposalCreated => 'สร้างข้อเสนอการลบแล้ว';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'ข้อเสนอการลบหมายเลข $phoneNumber ของคุณได้รับการส่งเพื่อชุมชนตรวจสอบแล้ว';
  }

  @override
  String get proposalApproved => 'ข้อเสนอได้รับการอนุมัติแล้ว ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'ข้อเสนอการลบหมายเลข $phoneNumber ได้รับการอนุมัติจากชุมชนแล้ว ($supportPercentage% การสนับสนุน, $totalVotes โหวต)';
  }

  @override
  String get proposalRejected => 'ข้อเสนอถูกปฏิเสธแล้ว ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'ข้อเสนอการลบหมายเลข $phoneNumber ถูกปฏิเสธโดยชุมชนแล้ว ($supportPercentage% การสนับสนุน, $totalVotes โหวต)';
  }

  @override
  String get communityVotingStarted => 'เริ่มการโหวตของชุมชนแล้ว';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'ข้อเสนอการลบหมายเลข $phoneNumber ใหม่พร้อมให้ชุมชนโหวตแล้ว';
  }

  @override
  String get votingCompleted => 'การโหวตเสร็จสิ้นแล้ว';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'การโหวตของชุมชนสำหรับหมายเลข $phoneNumber สิ้นสุดลงแล้ว ผลลัพธ์: $result ($supportPercentage% การสนับสนุน)';
  }

  @override
  String get newVoteReceived => 'ได้รับโหวตใหม่แล้ว';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'มีคนโหวต $voteType การลบหมายเลข $phoneNumber แล้ว โหวตปัจจุบัน: $totalVotes';
  }

  @override
  String get loadVoteCountFailed => 'โหลดจำนวนโหวตไม่สำเร็จ';

  @override
  String get voteCount => 'จำนวนโหวต';

  @override
  String get deletionProposalInfo => 'ข้อมูลข้อเสนอการลบ';

  @override
  String get deletionProposalDescription =>
      'เสนอหมายเลขเพื่อลบซึ่งละเมิดแนวทางชุมชน การมีส่วนร่วมของคุณช่วยให้แพลตฟอร์มปลอดภัย';

  @override
  String get voteToEarnVip => 'โหวตข้อเสนอเพื่อรับสิทธิพิเศษ VIP!';

  @override
  String get voteFailed => 'การโหวตล้มเหลว';

  @override
  String get searchProposals => 'ค้นหาข้อเสนอ';

  @override
  String get defaultNotifications => 'การแจ้งเตือนเริ่มต้น';

  @override
  String get defaultNotificationsDescription =>
      'ช่องทางการแจ้งเตือนเริ่มต้นสำหรับแอป';

  @override
  String get blockedCallNotifications => 'การแจ้งเตือนสายที่ถูกบล็อก';

  @override
  String get blockedCallNotificationsDescription =>
      'แสดงข้อมูลเกี่ยวกับสายเรียกเข้าที่ถูกบล็อก';

  @override
  String get stirVerification => 'การยืนยัน STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'แสดงผลการยืนยัน STIR/SHAKEN สำหรับหมายเลข';

  @override
  String get fraudAlerts => 'การแจ้งเตือนการฉ้อโกง';

  @override
  String get fraudAlertsDescription =>
      'แสดงคำเตือนสำหรับสายเรียกเข้าที่อาจเป็นการฉ้อโกง';

  @override
  String get notificationFrequencyDescription =>
      'เลือกว่าคุณต้องการรับการแจ้งเตือนเกี่ยวกับข้อเสนอการลบใหม่บ่อยแค่ไหน คุณสามารถรับทันที เป็นชุด หรือตามช่วงเวลาที่กำหนดเองได้';

  @override
  String get immediateNotifications => 'ทันที';

  @override
  String get immediateNotificationsDescription =>
      'รับการแจ้งเตือนทันทีที่สร้างข้อเสนอ';

  @override
  String get batchNotifications => 'เป็นชุด';

  @override
  String get batchNotificationsDescription => 'รับสรุปการแจ้งเตือนเป็นประจำ';

  @override
  String get customNotifications => 'กำหนดเอง';

  @override
  String get customNotificationsDescription =>
      'กำหนดช่วงเวลาของคุณเองสำหรับการรับการแจ้งเตือน';

  @override
  String get customFrequency => 'ความถี่ที่กำหนดเอง';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes นาที';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ชั่วโมง';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ชั่วโมง $minutes นาที';
  }

  @override
  String get pendingProposals => 'ข้อเสนอที่รอดำเนินการ';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ข้อเสนอที่รอดำเนินการ',
      one: '1 ข้อเสนอที่รอดำเนินการ',
      zero: 'ไม่มีข้อเสนอที่รอดำเนินการ',
    );
    return 'คุณมี $_temp0';
  }

  @override
  String get guidelinesLabel => 'แนวทางปฏิบัติ';

  @override
  String get reportingGuidelines =>
      '• รายงานเฉพาะหมายเลขที่เป็นปัญหาอย่างแท้จริงเท่านั้น\n• ให้เหตุผลที่ถูกต้องและละเอียด\n• เลือกระดับความเสี่ยงที่เหมาะสมตามความรุนแรง\n• การรายงานที่ไม่ถูกต้องอาจส่งผลให้บัญชีถูกจำกัด';

  @override
  String get riskLevelLabel => 'ระดับความเสี่ยง';

  @override
  String get riskLevelDescription => 'ระดับความเสี่ยงของหมายเลข';

  @override
  String get phoneNumberMinDigits => 'หมายเลขโทรศัพท์ต้องมีอย่างน้อย 7 หลัก';

  @override
  String get provideDetailedExplanation =>
      'ให้คำอธิบายโดยละเอียด (อย่างน้อย 10 ตัวอักษร)';

  @override
  String get reasonMinCharacters => 'เหตุผลต้องมีอย่างน้อย 10 ตัวอักษร';

  @override
  String get countryCodeTwoLetters => 'รหัสประเทศ (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'รหัสประเทศ (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'เช่น US, CN, GB';

  @override
  String get countryCodeRequired => 'ต้องระบุรหัสประเทศ';

  @override
  String get countryCodeLengthError => 'รหัสประเทศต้องมี 2 ตัวอักษร';

  @override
  String get phoneNumberLengthError => 'หมายเลขโทรศัพท์ต้องมีอย่างน้อย 7 หลัก';

  @override
  String get reasonHint => 'ให้คำอธิบายโดยละเอียด (อย่างน้อย 10 ตัวอักษร)';

  @override
  String get reasonRequired => 'ต้องระบุเหตุผล';

  @override
  String get reasonLengthError => 'เหตุผลต้องมีอย่างน้อย 10 ตัวอักษร';

  @override
  String get guidelinesTitle => 'แนวทางปฏิบัติ';

  @override
  String get guidelinesText =>
      '• รายงานเฉพาะหมายเลขที่เป็นปัญหาอย่างแท้จริงเท่านั้น\n• ให้เหตุผลที่ถูกต้องและละเอียด\n• เลือกระดับความเสี่ยงที่เหมาะสมตามความรุนแรง\n• การรายงานที่ไม่ถูกต้องอาจส่งผลให้บัญชีถูกจำกัด';

  @override
  String get riskLevelCritical => 'วิกฤต';

  @override
  String get riskLevelMedium => 'ปานกลาง';

  @override
  String get riskLevelVeryLow => 'ต่ำมาก';

  @override
  String get riskDescriptionVeryLow =>
      'ต่ำมาก - สร้างความรำคาญเล็กน้อย, สายเรียกเข้าไม่บ่อย';

  @override
  String get riskDescriptionLow =>
      'ต่ำ - สายเรียกเข้าที่ไม่ต้องการเป็นครั้งคราว';

  @override
  String get riskDescriptionMedium =>
      'ปานกลาง - สแปมหรือการตลาดทางโทรศัพท์เป็นประจำ';

  @override
  String get riskDescriptionHigh =>
      'สูง - การคุกคามหรือความพยายามหลอกลวงอย่างต่อเนื่อง';

  @override
  String get riskDescriptionCritical =>
      'วิกฤต - การหลอกลวงที่เป็นอันตรายหรือการข่มขู่';

  @override
  String get notificationFrequencyTitle => 'ความถี่ในการแจ้งเตือน';

  @override
  String get notificationFrequencyLabel => 'ความถี่ในการแจ้งเตือน (ชั่วโมง)';

  @override
  String errorMessage(String error) {
    return 'ข้อผิดพลาด: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'คะแนนโหวต: $totalVotes ($supportPercentage% การสนับสนุน)';
  }

  @override
  String supportCount(int supportCount) {
    return 'สนับสนุน ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'คัดค้าน ($opposeCount)';
  }

  @override
  String get timeJustNow => 'เมื่อสักครู่';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes นาทีที่แล้ว';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours ชั่วโมงที่แล้ว';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days วันที่แล้ว';
  }

  @override
  String get notificationFrequencyHours => 'ความถี่ในการแจ้งเตือน (ชั่วโมง)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes โหวต ($supportPercentage% การสนับสนุน)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ชั่วโมง',
      one: '1 ชั่วโมง',
      zero: '0 ชั่วโมง',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'ประกาศสำคัญ';

  @override
  String get dataSourceDisclaimer =>
      'หมายเลขถูกดึงมาจากอินเทอร์เน็ตและการส่งของผู้ใช้ เราไม่สามารถรับประกันได้ว่าหมายเลขที่ถูกลบไปแล้วจะไม่ถูกส่งเข้ามาอีกโดยผู้ใช้อื่นหรือแหล่งข้อมูลอื่น โปรดค้นหาและตรวจสอบข้อมูลอย่างแข็งขัน';

  @override
  String get avatar => 'อวาตาร์';

  @override
  String get location => 'สถานที่';

  @override
  String get simCardTitle => 'ซิมการ์ด';

  @override
  String get liveActivitiesSettingsTitle => 'การตั้งค่ากิจกรรมสด';

  @override
  String get elementsSettingsTitle => 'การตั้งค่าองค์ประกอบ';

  @override
  String get liveActivityMode => 'กิจกรรมสด';

  @override
  String get liveActivityModeDescription =>
      'แสดงข้อมูลสายเรียกเข้าเป็นการแจ้งเตือนที่คงอยู่บนหน้าจอล็อกและใน Dynamic Island (iOS)';

  @override
  String get phoneNumberType => 'ประเภทหมายเลขโทรศัพท์';

  @override
  String get liveActivitiesTestEndActivity => 'สิ้นสุดกิจกรรม';

  @override
  String get liveActivitiesTestSendNewActivity => 'ส่งกิจกรรมใหม่';

  @override
  String get liveActivitiesTestUpdateActivity => 'อัปเดตกิจกรรม';

  @override
  String get liveActivityControlsTitle => 'การควบคุมกิจกรรมสด';

  @override
  String get liveActivitiesTestTitle => 'ทดสอบกิจกรรมสด';

  @override
  String get liveActivitiesTestSubtitle => 'ทดสอบการแจ้งเตือนกิจกรรมสด';

  @override
  String get liveNotificationCustomizationTitle => 'การปรับแต่งการแจ้งเตือนสด';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'ปรับแต่งรูปลักษณ์ของการแจ้งเตือนสด';

  @override
  String get notification_instructions =>
      'คำแนะนำ:\n1. แตะ \"ส่ง\" เพื่อสร้างหรืออัปเดตการแจ้งเตือน\n2. ไปที่หน้าจอหลักของคุณหรือดึงถาดการแจ้งเตือนลงเพื่อดูผลลัพธ์\n3. แตะ \"สิ้นสุด\" เพื่อยกเลิกการแจ้งเตือน';

  @override
  String get autoCancelNotification => 'ยกเลิกการแจ้งเตือนอัตโนมัติ';

  @override
  String get autoCancelNotificationDescription =>
      'หากเลือก การแจ้งเตือนจะถูกยกเลิกโดยอัตโนมัติเมื่อผู้ใช้แตะ';

  @override
  String get setDelayTime => 'ตั้งเวลาหน่วง';

  @override
  String get proposalDetails => 'รายละเอียดข้อเสนอ';

  @override
  String get filterByStatus => 'กรองตามสถานะ';

  @override
  String get proposalNotFound => 'ไม่พบข้อเสนอ';

  @override
  String get processed => 'ดำเนินการแล้ว';

  @override
  String get showAll => 'แสดงทั้งหมด';

  @override
  String get filterAndSortTitle => 'กรองและเรียงลำดับ';

  @override
  String get filterVerifiedOwner => 'กรองเจ้าของที่ยืนยันแล้ว';

  @override
  String get filterBy => 'กรองด้วย';

  @override
  String get sortOldest => 'เรียงลำดับเก่าสุด';

  @override
  String get sortNewest => 'เรียงลำดับใหม่สุด';

  @override
  String get sortMostPopular => 'เรียงลำดับยอดนิยมสูงสุด';

  @override
  String get sortLeastPopular => 'เรียงลำดับยอดนิยมน้อยที่สุด';

  @override
  String get sortBy => 'เรียงลำดับด้วย';

  @override
  String get simRulesNotFound => 'ไม่พบกฎ SIM';

  @override
  String get simSlotRules => 'กฎช่อง SIM';

  @override
  String get noSimCardDetected => 'ไม่พบซิมการ์ด';

  @override
  String get invalidSimData => 'ข้อมูล SIM ไม่ถูกต้อง';

  @override
  String get simCardData => 'ข้อมูลซิมการ์ด';

  @override
  String get simSlot => 'ช่อง SIM';

  @override
  String get enableFiltering => 'เปิดใช้งานการกรอง';

  @override
  String get detailedSettingsTitle => 'การตั้งค่าโดยละเอียด';

  @override
  String get entryPointViewTitle => 'หน้าจอจุดเริ่มต้น';

  @override
  String get callTypeRejected => 'ปฏิเสธ';

  @override
  String get callTypeSilenced => 'ปิดเสียง';

  @override
  String get callTypeVoicemail => 'ข้อความเสียง';

  @override
  String get callTypeUnknownIntercept => 'ไม่ทราบว่าถูกดักจับ';

  @override
  String andMoreItems(int count) {
    return 'และอีก $count รายการ';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Cloud Sync Settings';

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
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';
}
