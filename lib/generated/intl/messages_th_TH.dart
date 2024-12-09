// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a th_TH locale. All the
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
  String get localeName => 'th_TH';

  static String m0(permissionName) => "ไม่ได้รับอนุญาต ${permissionName}";

  static String m1(listType) => "เพิ่มใน ${listType}";

  static String m2(listType) => "เพิ่มใน ${listType}";

  static String m3(permissionName) =>
      "คุณต้องปิดใช้งานการอนุญาต ${permissionName} ด้วยตนเองในการตั้งค่าแอป";

  static String m4(listType) => "ลบ ${listType}";

  static String m5(listType) => "ลบ ${listType}";

  static String m6(permissionName) =>
      "คุณต้องปิดใช้งานการอนุญาต ${permissionName} ด้วยตนเองในการตั้งค่าแอป";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("เกี่ยวกับ"),
        "accept": MessageLookupByLibrary.simpleMessage("ยอมรับ"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("เปิดใช้งานโฆษณา:"),
        "add": MessageLookupByLibrary.simpleMessage("เพิ่ม"),
        "addAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้ารายการที่อนุญาต"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้ารายการที่ถูกบล็อก"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้าที่ถูกบล็อก"),
        "addContact": MessageLookupByLibrary.simpleMessage("เพิ่มผู้ติดต่อ"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "เพิ่มหน้าการสมัครสมาชิกผู้ติดต่อ"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้าป้ายกำกับ"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้าปลั๊กอิน"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้านิพจน์ทั่วไป"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "เพิ่มหน้ารายการ SMS ที่ถูกบล็อก"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้าการสมัครสมาชิก SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "เพิ่มหน้ารายการข้อความ SMS ที่ถูกบล็อก"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "เพิ่มหน้ารายการข้อความ SMS ที่อนุญาต"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "เพิ่มหน้ารายการ SMS ที่อนุญาต"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้าการสมัครสมาชิก"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("เพิ่มในรายการที่อนุญาต"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("เพิ่มในรายการที่ถูกบล็อก"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("เพิ่มในป้ายกำกับ"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("เพิ่มหน้ารายการที่อนุญาต"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("เพิ่มสำเร็จแล้ว"),
        "all": MessageLookupByLibrary.simpleMessage("ทั้งหมด"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "อนุญาตหมายเลขที่อนุญาตทั้งหมด"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "อนุญาตหมายเลขในรายการที่ถูกบล็อกทั้งหมด"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "อนุญาตหมายเลขในรายการที่อนุญาตทั้งหมด"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("อนุญาตหมายเลขที่ถูกบล็อก"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "อนุญาตรูปแบบรายการที่ถูกบล็อกแบบนิพจน์ทั่วไป"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "อนุญาตรูปแบบรายการที่อนุญาตแบบนิพจน์ทั่วไป"),
        "allowRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("อนุญาตสายเรียกเข้าซ้ำ"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "อนุญาตให้แอปนี้แสดง ID ผู้โทร"),
        "allowed": MessageLookupByLibrary.simpleMessage("อนุญาต"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("หน้ารายการที่อนุญาต"),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้าที่อนุญาต"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("รับสายแล้ววางสาย"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "คุณแน่ใจหรือไม่ว่าต้องการลบรายการ"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "คุณแน่ใจหรือไม่ว่าต้องการลบผู้ติดต่อนี้"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "ปิดการแจ้งเตือนท้องถิ่นอัตโนมัติ"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("ปิดใช้งานการอัปเดตอัตโนมัติ"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "เปิดใช้งานการอัปเดตอัตโนมัติ"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("ขนาดรูปประจำตัวและไอคอน"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("สีเส้นขอบรูปประจำตัว"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("ขนาดเส้นขอบรูปประจำตัว"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งรูปประจำตัว"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("ขนาดรูปประจำตัว"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("URL หรือเส้นทางรูปประจำตัว"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("การไล่ระดับสีพื้นหลัง"),
        "backup": MessageLookupByLibrary.simpleMessage("สำรองข้อมูล"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("สำรองและกู้คืนข้อมูล"),
        "bank": MessageLookupByLibrary.simpleMessage("ธนาคาร"),
        "batteryOptimization": MessageLookupByLibrary.simpleMessage(
            "การเพิ่มประสิทธิภาพแบตเตอรี่"),
        "blacklist": MessageLookupByLibrary.simpleMessage("รายการที่ถูกบล็อก"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("หน้ารายการที่ถูกบล็อก"),
        "blacklistingAndWhitelisting": MessageLookupByLibrary.simpleMessage(
            "การขึ้นบัญชีดำและการขึ้นบัญชีขาว"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้ารายการที่ถูกบล็อก"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "บล็อกการโทรจากรหัสพื้นที่เฉพาะ:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "บล็อกสายโทรศัพท์ระหว่างประเทศ:"),
        "blocked": MessageLookupByLibrary.simpleMessage("ถูกบล็อก"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("การดำเนินการโทรที่ถูกบล็อก"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "การแจ้งเตือนการโทรที่ถูกบล็อก"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("สถิติการโทรที่ถูกบล็อก"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("หน้าที่ถูกบล็อก"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้าที่ถูกบล็อก"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "ทั้งแอปโทรต้นฉบับและการแจ้งเตือนท้องถิ่น"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "ทั้ง SMS ต้นฉบับและการแจ้งเตือนท้องถิ่น"),
        "call": MessageLookupByLibrary.simpleMessage("โทร"),
        "callHistory": MessageLookupByLibrary.simpleMessage("ประวัติการโทร"),
        "callLog": MessageLookupByLibrary.simpleMessage("บันทึกการโทร"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("ปฏิเสธการอนุญาตบันทึกการโทร"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "การร้องขอบทบาทการคัดกรองการโทรล้มเหลว!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "การร้องขอบทบาทการคัดกรองการโทรสำเร็จ!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("แอป ID ผู้โทร"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("รูปแบบ ID ผู้โทร"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("เนื้อหารูปแบบ ID ผู้โทร"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("สีไอคอนประเภทการโทร"),
        "cancel": MessageLookupByLibrary.simpleMessage("ยกเลิก"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("ผู้ให้บริการ:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("สีผู้ให้บริการ"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรผู้ให้บริการ"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งผู้ให้บริการ"),
        "charity": MessageLookupByLibrary.simpleMessage("การกุศล"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "เลือกรูปประจำตัว (ท้องถิ่นหรือเครือข่าย):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("เลือกจากแกลเลอรี"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("เลือกลิงก์หรือไฟล์เท่านั้น"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "เลือกการดำเนินการสกัดกั้นเริ่มต้น"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("เลือกภาษาของคุณ"),
        "clientId": MessageLookupByLibrary.simpleMessage("รหัสไคลเอ็นต์"),
        "close": MessageLookupByLibrary.simpleMessage("ปิด"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "ชื่อไดเรกทอรีการสำรองข้อมูลบนคลาวด์"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "การสำรองข้อมูลบนคลาวด์ต้องใช้การสำรองข้อมูลอัตโนมัติ"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("บริการคลาวด์"),
        "collection": MessageLookupByLibrary.simpleMessage("การเรียกเก็บเงิน"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "ส่งออกการกำหนดค่าไปยังไฟล์แล้ว!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("นำเข้าการกำหนดค่าแล้ว"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("นำเข้าการกำหนดค่าสำเร็จแล้ว"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("บันทึกการกำหนดค่าแล้ว!"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("ยืนยันการลบ"),
        "contactFile": MessageLookupByLibrary.simpleMessage("ไฟล์ผู้ติดต่อ"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("หน้าการสมัครสมาชิกผู้ติดต่อ"),
        "contactUs": MessageLookupByLibrary.simpleMessage("ติดต่อเรา"),
        "contacts": MessageLookupByLibrary.simpleMessage("ผู้ติดต่อ"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("ส่งออกผู้ติดต่อสำเร็จแล้ว"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("นำเข้าผู้ติดต่อสำเร็จแล้ว"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("หน้าผู้ติดต่อ"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("ผู้ติดต่อที่มีหมายเลข"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "มุมมองรายการการสมัครสมาชิกผู้ติดต่อ"),
        "countColor": MessageLookupByLibrary.simpleMessage("สีจำนวน"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรจำนวน"),
        "countPosition": MessageLookupByLibrary.simpleMessage("ตำแหน่งจำนวน"),
        "country": MessageLookupByLibrary.simpleMessage("ประเทศ:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("สีชื่อประเทศ"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรชื่อประเทศ"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งชื่อประเทศ"),
        "cropAvatar":
            MessageLookupByLibrary.simpleMessage("ครอบตัดรูปประจำตัว"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("ฝ่ายบริการลูกค้า"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("กำหนด ID ผู้โทรเอง"),
        "dark": MessageLookupByLibrary.simpleMessage("มืด"),
        "darkMode": MessageLookupByLibrary.simpleMessage("โหมดมืด"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("ลบ"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("ลบผู้ติดต่อ"),
        "deleted": MessageLookupByLibrary.simpleMessage("ลบแล้ว"),
        "delivery": MessageLookupByLibrary.simpleMessage("การจัดส่ง"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "คุณได้ปฏิเสธการอนุญาต คุณสามารถเปิดใช้งานการอนุญาตด้วยตนเองได้ในการตั้งค่า"),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "ปิดใช้งานการแจ้งเตือนการโทรที่ถูกบล็อก"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("ปิดใช้งานการอนุญาต"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "ปิดใช้งานการแจ้งเตือน SMS ท้องถิ่น"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "ปิดใช้งานแอปนี้ไม่ให้แสดง ID ผู้โทร"),
        "disabled": MessageLookupByLibrary.simpleMessage("ปิดใช้งาน"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("อีคอมเมิร์ซ"),
        "edit": MessageLookupByLibrary.simpleMessage("แก้ไข"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("แก้ไขรูปประจำตัว"),
        "editCode": MessageLookupByLibrary.simpleMessage("แก้ไขรหัส"),
        "editContact": MessageLookupByLibrary.simpleMessage("แก้ไขผู้ติดต่อ"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("แก้ไขรหัสปลั๊กอิน"),
        "education": MessageLookupByLibrary.simpleMessage("การศึกษา"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งองค์ประกอบ"),
        "email": MessageLookupByLibrary.simpleMessage("อีเมล"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "เปิดใช้งานการแจ้งเตือนการโทรที่ถูกบล็อก"),
        "enableDarkModeBasedOnTime":
            MessageLookupByLibrary.simpleMessage("เปิดใช้งานโหมดมืดตามเวลา"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "เปิดใช้งานการอนุญาตการซ้อนทับ"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "เปิดใช้งานการแจ้งเตือน SMS ท้องถิ่น"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("เปิดใช้งานเพื่อลบโฆษณา"),
        "enabled": MessageLookupByLibrary.simpleMessage("เปิดใช้งาน"),
        "endColor": MessageLookupByLibrary.simpleMessage("สีสิ้นสุด"),
        "endcall": MessageLookupByLibrary.simpleMessage("วางสาย"),
        "enterImageUrl": MessageLookupByLibrary.simpleMessage("ป้อน URL ภาพ"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("ป้อนรหัสปลั๊กอินที่นี่"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("ป้อน URL"),
        "entry": MessageLookupByLibrary.simpleMessage("รายการ"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("เพิ่มรายการสำเร็จแล้ว"),
        "error": MessageLookupByLibrary.simpleMessage("ข้อผิดพลาด"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "ข้อผิดพลาดในการส่งออกผู้ติดต่อ:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "ข้อผิดพลาดในการรับสถานะการอนุญาต"),
        "errorImporting":
            MessageLookupByLibrary.simpleMessage("ข้อผิดพลาดในการนำเข้า"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "ข้อผิดพลาดในการร้องขอบทบาทการคัดกรองการโทร:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("ส่งออก"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้ารายการที่อนุญาต"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("ส่งออกเป็น CSV"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("ส่งออกเป็น JSON"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("ส่งออกเป็น VCF"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("ส่งออกเป็น YAML"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้ารายการที่ถูกบล็อก"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้าที่ถูกบล็อก"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้าการสมัครสมาชิกผู้ติดต่อ"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("ส่งออกผู้ติดต่อ"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("ส่งออกล้มเหลว"),
        "exportFormat":
            MessageLookupByLibrary.simpleMessage("รูปแบบการส่งออก:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้าป้ายกำกับ"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้าปลั๊กอิน"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้านิพจน์ทั่วไป"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้ารายการ SMS ที่ถูกบล็อก"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้าการสมัครสมาชิก SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้ารายการข้อความ SMS ที่ถูกบล็อก"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้ารายการข้อความ SMS ที่อนุญาต"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "ส่งออกหน้ารายการ SMS ที่อนุญาต"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้าการสมัครสมาชิก"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("ส่งออกสำเร็จ"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("ส่งออกหน้ารายการที่อนุญาต"),
        "failed": MessageLookupByLibrary.simpleMessage("ล้มเหลว"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("เพิ่มล้มเหลว:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("เพิ่มรายการล้มเหลว:"),
        "feature": MessageLookupByLibrary.simpleMessage("คุณสมบัติ"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("คำอธิบายคุณสมบัติ"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("กรองข้อความ SMS ขาเข้า"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("กรองสายเรียกเข้าซ้ำ"),
        "financial": MessageLookupByLibrary.simpleMessage("การเงิน"),
        "firstName": MessageLookupByLibrary.simpleMessage("ชื่อ"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("อาจเป็นการฉ้อโกงหลอกลวง"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("เริ่มต้นใช้งาน"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "การเข้าสู่ระบบ Google Drive ล้มเหลว"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "การเข้าสู่ระบบ Google Drive สำเร็จ"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("การตั้งค่า Google Drive"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("ให้สิทธิ์"),
        "group": MessageLookupByLibrary.simpleMessage("กลุ่ม"),
        "height": MessageLookupByLibrary.simpleMessage("ความสูง"),
        "history": MessageLookupByLibrary.simpleMessage("ประวัติ"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("ขนาดไอคอน"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("นำเข้า"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้ารายการที่อนุญาต"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้ารายการที่ถูกบล็อก"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้ารายการที่ถูกบล็อก"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("นำเข้าการกำหนดค่า"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("นำเข้าผู้ติดต่อ"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("นำเข้าจาก CSV"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("นำเข้าจากไฟล์"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("นำเข้าจาก JSON"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("นำเข้าจาก URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("นำเข้าจาก VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("นำเข้าจาก YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้าป้ายกำกับ"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้าปลั๊กอิน"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("นำเข้านิพจน์ทั่วไป"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "นำเข้าหน้าการสมัครสมาชิก SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "นำเข้าหน้ารายการข้อความ SMS ที่ถูกบล็อก"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "นำเข้าหน้ารายการข้อความ SMS ที่อนุญาต"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้าการสมัครสมาชิก"),
        "importWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("นำเข้าหน้ารายการที่อนุญาต"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("นำเข้าจาก URL สำเร็จแล้ว"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("เปิดใช้งานการซื้อในแอป"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "การดำเนินการสกัดกั้นสายเรียกเข้า"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("กำลังเริ่มต้น..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("กำลังเริ่มต้นฐานข้อมูล..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials":
            MessageLookupByLibrary.simpleMessage("ป้อนข้อมูลประจำตัว OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("ประกันภัย"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "สกัดกั้นสายเรียกเข้าซ้ำภายในช่วงเวลา"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("รูปแบบ JSON ไม่ถูกต้อง"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("ยังไม่ได้สมัครสมาชิก"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("สมัครสมาชิกแล้ว"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "เข้าร่วมช่องและกลุ่ม Telegram สำหรับข้อมูลเพิ่มเติม"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "เก็บเฉพาะการสำรองข้อมูลล่าสุด"),
        "keyword": MessageLookupByLibrary.simpleMessage("คำหลัก"),
        "label": MessageLookupByLibrary.simpleMessage("ป้ายกำกับ"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("สีไอคอนป้ายกำกับ"),
        "labelPage": MessageLookupByLibrary.simpleMessage("หน้าป้ายกำกับ"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้าป้ายกำกับ"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("สีป้ายกำกับ"),
        "labelsFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรป้ายกำกับ"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งป้ายกำกับ"),
        "lastName": MessageLookupByLibrary.simpleMessage("นามสกุล"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("สว่าง"),
        "link": MessageLookupByLibrary.simpleMessage("ลิงก์"),
        "loading": MessageLookupByLibrary.simpleMessage("กำลังโหลด..."),
        "loan": MessageLookupByLibrary.simpleMessage("สินเชื่อ"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "ไดเรกทอรีการสำรองข้อมูลท้องถิ่นเฉพาะภายใต้โฟลเดอร์ดาวน์โหลด"),
        "localCard1": MessageLookupByLibrary.simpleMessage("การ์ดท้องถิ่น 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("เนื้อหาการ์ดท้องถิ่น 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("สีตำแหน่งที่ตั้ง"),
        "locationFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรตำแหน่งที่ตั้ง"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("สีไอคอนตำแหน่งที่ตั้ง"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งตำแหน่งที่ตั้ง"),
        "login": MessageLookupByLibrary.simpleMessage("เข้าสู่ระบบ"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("การเข้าสู่ระบบล้มเหลว"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("เข้าสู่ระบบ Google Drive"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "เข้าสู่ระบบ/ออกจากระบบ Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("ออกจากระบบ Google Drive"),
        "manageRules": MessageLookupByLibrary.simpleMessage("จัดการกฎ"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("สำรองข้อมูลด้วยตนเอง"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("ทำเครื่องหมายโดย"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("จับคู่อักขระใดๆ:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "จับคู่หมายเลขโทรศัพท์ที่มีตัวเลขเฉพาะ:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "จับคู่หมายเลขโทรศัพท์ที่มีอักขระเฉพาะอยู่ตรงกลาง:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("การแพทย์"),
        "merge": MessageLookupByLibrary.simpleMessage("รวม"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("รวมผู้ติดต่อ"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("รวมที่เลือก"),
        "message": MessageLookupByLibrary.simpleMessage("ข้อความ"),
        "mins": MessageLookupByLibrary.simpleMessage("นาที"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("ชื่อ"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("ชื่อต้องไม่ว่างเปล่า"),
        "nameColor": MessageLookupByLibrary.simpleMessage("สีชื่อ"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรชื่อ"),
        "namePosition": MessageLookupByLibrary.simpleMessage("ตำแหน่งชื่อ"),
        "next": MessageLookupByLibrary.simpleMessage("ถัดไป"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("ไม่ได้เลือกภาพ"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "ไม่มีตัวกรองข้อความ SMS ขาเข้า"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified":
            MessageLookupByLibrary.simpleMessage("ยังไม่ได้รับการยืนยัน"),
        "notifications": MessageLookupByLibrary.simpleMessage("การแจ้งเตือน"),
        "numberColor": MessageLookupByLibrary.simpleMessage("สีหมายเลข"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรหมายเลข"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งหมายเลข"),
        "numberType": MessageLookupByLibrary.simpleMessage("ประเภทหมายเลข"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("สีประเภทหมายเลข"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรประเภทหมายเลข"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งประเภทหมายเลข"),
        "ok": MessageLookupByLibrary.simpleMessage("ตกลง"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("การตั้งค่า OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "การสมัครสมาชิก ID ผู้โทรออนไลน์"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "เฉพาะการแจ้งเตือนแอปโทรต้นฉบับ"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("เฉพาะการแจ้งเตือนท้องถิ่น"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "ใช้เฉพาะการแจ้งเตือน SMS ต้นฉบับ"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("เปิดโฟลเดอร์ท้องถิ่น"),
        "other": MessageLookupByLibrary.simpleMessage("อื่นๆ"),
        "overlay": MessageLookupByLibrary.simpleMessage("การซ้อนทับ"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "ไม่ได้รับอนุญาตการซ้อนทับ ซึ่งอาจส่งผลต่อฟังก์ชันการแสดง ID ผู้โทร คุณสามารถเปิดใช้งานการอนุญาตได้ในการตั้งค่าแอป"),
        "page": MessageLookupByLibrary.simpleMessage("หน้า"),
        "password": MessageLookupByLibrary.simpleMessage("รหัสผ่าน"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("วาง JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("วางการกำหนดค่า JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("วาง JSON ที่นี่"),
        "pattern": MessageLookupByLibrary.simpleMessage("รูปแบบ"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("ปฏิเสธการอนุญาต"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("ได้รับอนุญาตแล้ว"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":คุณต้องปิดใช้งานการอนุญาตในการตั้งค่าแอป"),
        "permissionInTheAppSettings":
            MessageLookupByLibrary.simpleMessage("การอนุญาตในการตั้งค่าแอป"),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("ไม่ได้รับอนุญาต"),
        "permissions": MessageLookupByLibrary.simpleMessage("การอนุญาต"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("ต้องได้รับอนุญาต"),
        "phone": MessageLookupByLibrary.simpleMessage("โทรศัพท์"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("โทรศัพท์พื้นฐาน"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage(
                "โทรศัพท์พื้นฐาน,โทรศัพท์มือถือ"),
        "phoneNumberTypeMobile":
            MessageLookupByLibrary.simpleMessage("โทรศัพท์มือถือ"),
        "phoneNumberTypePager":
            MessageLookupByLibrary.simpleMessage("เพจเจอร์"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("หมายเลขส่วนบุคคล"),
        "phoneNumberTypePremiumRate": MessageLookupByLibrary.simpleMessage(
            "โทรศัพท์แบบคิดค่าบริการพิเศษ"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("โทรศัพท์แบบแบ่งต้นทุน"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("โทรฟรี"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("ไม่ทราบ"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("ข้อความเสียง"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("หมายเลขโทรศัพท์"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("โปรดป้อน"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("โปรดป้อนหมายเลขโทรศัพท์"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("โปรดป้อนรูปแบบ"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("โปรดป้อน URL"),
        "pleaseSelectAFileOrInputAUrl":
            MessageLookupByLibrary.simpleMessage("โปรดเลือกไฟล์หรือป้อน URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("โปรดเลือกป้ายกำกับ"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("โปรดเลือกโฟลเดอร์ส่งออก"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("โปรดเลือกไฟล์เอาต์พุต:"),
        "pleaseSelectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("โปรดเลือกรายการที่จะส่งออก"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "โปรดแตะ \"ให้สิทธิ์\" และอนุญาตการอนุญาตในหน้าจอถัดไป"),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "โปรดแตะ \"ตั้งค่าเริ่มต้น\" และอนุญาตการอนุญาตในหน้าจอถัดไป"),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "โปรดรอให้การเริ่มต้นฐานข้อมูลเสร็จสมบูรณ์"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("หน้าปลั๊กอิน"),
        "plugins": MessageLookupByLibrary.simpleMessage("ปลั๊กอิน"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้าปลั๊กอิน"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("การเมือง"),
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
        "regex": MessageLookupByLibrary.simpleMessage("นิพจน์ทั่วไป"),
        "regexPage": MessageLookupByLibrary.simpleMessage("หน้านิพจน์ทั่วไป"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("คำอธิบายรูปแบบนิพจน์ทั่วไป"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "รูปแบบนิพจน์ทั่วไปคือนิพจน์ทั่วไปที่ใช้เพื่อจับคู่หมายเลขโทรศัพท์"),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้านิพจน์ทั่วไป"),
        "region": MessageLookupByLibrary.simpleMessage("ภูมิภาค:"),
        "reject": MessageLookupByLibrary.simpleMessage("ปฏิเสธ"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("ปฏิเสธหมายเลขทั้งหมด"),
        "remove": MessageLookupByLibrary.simpleMessage("ลบ"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "ลบโฆษณาและเปิดใช้งานการสำรองข้อมูลออนไลน์"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("ลบออกจากรายการที่อนุญาต"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("ลบออกจากรายการที่ถูกบล็อก"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("การโทรที่ถูกบล็อกซ้ำใน"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("การโทรซ้ำ"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("กู้คืนจาก Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("กู้คืนจากท้องถิ่น"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("กู้คืนจาก OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("กู้คืนจาก WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("การแชร์รถ"),
        "risk": MessageLookupByLibrary.simpleMessage("ความเสี่ยง"),
        "robocall": MessageLookupByLibrary.simpleMessage("Robocall"),
        "save": MessageLookupByLibrary.simpleMessage("บันทึก"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("ค้นหาผู้ติดต่อ"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("ค้นหารายการ"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("เลือกป้ายกำกับ:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("เลือกทั้งหมด"),
        "selectColor": MessageLookupByLibrary.simpleMessage("เลือกสี"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("เลือกรหัสประเทศ (ไม่บังคับ)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("เลือกรายการ"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("เลือกรายการที่จะส่งออก"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "รวมผู้ติดต่อที่เลือกสำเร็จแล้ว"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("ป้ายกำกับที่เลือก"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("กำลังเลือกโฟลเดอร์ส่งออก"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "ช่วงเวลาการอัปเดตบริการ (วัน)"),
        "settings": MessageLookupByLibrary.simpleMessage("การตั้งค่า"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("บันทึกการตั้งค่าแล้ว"),
        "setupDefault": MessageLookupByLibrary.simpleMessage("ตั้งค่าเริ่มต้น"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "ตั้งค่าแอป ID ผู้โทรเริ่มต้น"),
        "sharing": MessageLookupByLibrary.simpleMessage("การแชร์"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("แสดงปุ่มผู้ติดต่อ"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("แสดงปุ่มไอคอนผู้ติดต่อ"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("แสดง Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("แสดง WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("แสดงผลลัพธ์สำหรับ"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("เงียบไม่รับสาย"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("สีซิมการ์ด"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษรซิมการ์ด"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("ตำแหน่งซิมการ์ด"),
        "skip": MessageLookupByLibrary.simpleMessage("ข้าม"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("หน้ารายการ SMS ที่ถูกบล็อก"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("การกรอง SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "การกรอง SMS ต้องได้รับอนุญาต SMS การแจ้งเตือน และโทรศัพท์ โปรดอนุญาตการอนุญาตเหล่านี้เพื่อเปิดใช้งานคุณสมบัตินี้"),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("การแจ้งเตือน SMS ท้องถิ่น"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("การแจ้งเตือน SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("หน้าการสมัครสมาชิก SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "หน้ารายการข้อความ SMS ที่อนุญาต"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "มุมมองหน้ารายการ SMS ที่ถูกบล็อก"),
        "smssubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "มุมมองรายการการสมัครสมาชิก SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "มุมมองหน้ารายการข้อความ SMS ที่ถูกบล็อก"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "มุมมองหน้ารายการข้อความ SMS ที่อนุญาต"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "มุมมองหน้ารายการ SMS ที่อนุญาต"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("อาจเป็นสแปม"),
        "startColor": MessageLookupByLibrary.simpleMessage("สีเริ่มต้น"),
        "statisticsTimeRangeMinutes":
            MessageLookupByLibrary.simpleMessage("ช่วงเวลาสถิติ (นาที):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("สี Stir"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("ขนาดตัวอักษร Stir"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("ตำแหน่ง Stir"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("ที่เก็บข้อมูล"),
        "subscribe": MessageLookupByLibrary.simpleMessage("สมัครสมาชิก"),
        "subscribed": MessageLookupByLibrary.simpleMessage("สมัครสมาชิกแล้ว"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("ลิงก์ที่สมัครสมาชิกแล้ว"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("หน้ารายการการสมัครสมาชิก"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("มุมมองรายการการสมัครสมาชิก"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("สำเร็จ"),
        "survey": MessageLookupByLibrary.simpleMessage("แบบสำรวจ"),
        "sync": MessageLookupByLibrary.simpleMessage("ซิงค์"),
        "system": MessageLookupByLibrary.simpleMessage("ระบบ"),
        "takeaway": MessageLookupByLibrary.simpleMessage("อาหารกลับบ้าน"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing":
            MessageLookupByLibrary.simpleMessage("การตลาดทางโทรศัพท์"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("ทดสอบ"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("สีข้อความและป้ายกำกับ"),
        "textType": MessageLookupByLibrary.simpleMessage("ประเภทข้อความ"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "แอปนี้เป็นเครื่องมือ ID ผู้โทรที่มีประสิทธิภาพซึ่งช่วยให้คุณสามารถระบุผู้โทรที่ไม่รู้จักและบล็อกสายที่ไม่ต้องการได้ ซึ่งมีคุณสมบัติดังนี้:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "แอปนี้ต้องเข้าถึงข้อมูลบันทึกการโทรของคุณเพื่อให้ทำงานได้อย่างถูกต้อง โปรดให้สิทธิ์"),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "การอนุญาตนี้จำเป็นสำหรับแอปของเราในการเป็นแอป ID ผู้โทรเริ่มต้น"),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "การอนุญาตนี้จำเป็นสำหรับแอปของเราในการแสดงข้อมูลสำคัญ поверх інших додатків.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("บทช่วยสอน"),
        "unknown": MessageLookupByLibrary.simpleMessage("ไม่ทราบ"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed":
            MessageLookupByLibrary.simpleMessage("ยกเลิกการสมัครสมาชิกแล้ว"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("รูปแบบ URL ไม่ถูกต้อง"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("ใช้ภาพเครือข่าย"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "ใช้อักขระ \'.\' เพื่อจับคู่อักขระเดี่ยวใดๆ ตัวอย่างเช่น รูปแบบ \'123.456\' จะตรงกับ \'123-456\', \'123.456\', \'123a456\' เป็นต้น"),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "ใช้รูปแบบ \'^0[0-9]{2,3}\' เพื่อจับคู่หมายเลขโทรศัพท์ที่ขึ้นต้นด้วย \'0\' ตามด้วยตัวเลข 2 หรือ 3 ตัว ซึ่งโดยทั่วไปหมายถึงรหัสพื้นที่\nใช้รูปแบบ \'^010\' เพื่อบล็อกการโทรจากรหัสพื้นที่ปักกิ่ง (010)\nใช้รูปแบบ \'^202\' เพื่อบล็อกการโทรจากรหัสพื้นที่วอชิงตัน (202)\nแทนที่รหัสพื้นที่ \'^0[0-9]{2,3}\' ด้วยรหัสพื้นที่เฉพาะที่คุณต้องการบล็อก"),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "ใช้รูปแบบ \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' เพื่อจับคู่หมายเลขโทรศัพท์ในรูปแบบ \'XXX-XXXX-XXXX\' แทนที่ \'X\' ด้วยตัวเลขเฉพาะที่คุณต้องการจับคู่"),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "ใช้รูปแบบ \'^\\+\' เพื่อจับคู่หมายเลขโทรศัพท์ทั้งหมดที่ขึ้นต้นด้วยเครื่องหมายบวก ซึ่งโดยทั่วไปหมายถึงหมายเลขระหว่างประเทศ"),
        "userName": MessageLookupByLibrary.simpleMessage("ชื่อผู้ใช้"),
        "verified": MessageLookupByLibrary.simpleMessage("ยืนยันแล้ว"),
        "video": MessageLookupByLibrary.simpleMessage("วิดีโอ"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("การตั้งค่า WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL ของ WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("เว็บไซต์"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("รายการที่อนุญาต"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("หน้ารายการที่อนุญาต"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("มุมมองหน้ารายการที่อนุญาต"),
        "width": MessageLookupByLibrary.simpleMessage("ความกว้าง"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "รองรับอักขระตัวแทนสำหรับการกรองที่ยืดหยุ่น"),
        "windowSize": MessageLookupByLibrary.simpleMessage("ขนาดหน้าต่าง"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "คุณสามารถใช้ไวยากรณ์นิพจน์ทั่วไปมาตรฐานเพื่อก ําหนดรูปแบบ หรือขอให้ AI สร้างรูปแบบสําหรับ Flutter sqflite ได้"),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "คุณได้ปฏิเสธการอนุญาต คุณสามารถเปิดใช้งานการอนุญาตด้วยตนเองได้ในการตั้งค่า"),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "คุณได้เปิดใช้งานการอนุญาตแล้ว"),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("คุณต้องปิดใช้งาน"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
