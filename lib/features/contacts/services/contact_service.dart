import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';

import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';

import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

/// 联系人服务类，提供联系人的管理功能
/// 包括添加、删除、查询联系人等操作
class ContactService extends ListService<Contact, String> {
  final ContactRepository _contactRepository;
  // 移除未使用的 _ruleImportExportService 字段

  ContactService(
    this._contactRepository,

  ) : super(_contactRepository);

  Future<void> editContact(Contact contact) async {
    if (contact.name.isEmpty) {
      throw Exception('Contact name cannot be empty'); // L95
    }

    if (contact.email != null && contact.email!.isNotEmpty) {
      if (!EmailValidator.validate(contact.email!)) {
        throw Exception('Invalid email address'); // L101
      }
    }

    final exists = await _contactRepository
        .contactExists(PhoneNumber(contact.phoneNumbers.first));
    if (!exists) {
      throw Exception('Contact does not exist');
    }

    // 更新联系人
    await _contactRepository.updateContact(contact);
  }

  // 删除联系人
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    await _contactRepository.deleteContact(phoneNumber);
  }

  // 根据URL删除联系人
  Future<void> deleteContactByUrl(String url) async {
    await _contactRepository.deleteContactByUrl(url);
  }

  // 批量删除联系人
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    final phoneNumberStrings = phoneNumbers.map((p) => p.value).toList();
    await _contactRepository.deleteContacts(phoneNumbers); // 修正参数类型
  }
  
  // 批量删除联系人实体

  @override
  Future<bool> deleteAll(List<Contact> entities) async {
    await _contactRepository.deleteAll(entities);
    return true;
  }

  Future<List<Contact>> checkForDuplicateContacts(
      List<Contact> contacts) async {
    final existingContacts =
        await _contactRepository.getAllContacts(); // 添加repository调用
    final duplicateContacts = <Contact>[];

    for (final contact in contacts) {
      for (final existingContact in existingContacts) {
        if (contact.phoneNumbers.any((phoneNumber) =>
            existingContact.phoneNumbers.contains(phoneNumber))) {
          // 移除.value
          duplicateContacts.add(contact);
          break;
        }
      }
    }

    return duplicateContacts;
  }

  // 更新联系人
  Future<void> updateContact(Contact contact) async {
    await _contactRepository.updateContact(contact);
  }

  // 添加联系人
  Future<void> addContact(Contact contact) async {
    if (contact.name.isEmpty) {
      throw Exception('Contact name cannot be empty');
    }

    if (contact.email != null && contact.email!.isNotEmpty) {
      if (!EmailValidator.validate(contact.email!)) {
        throw Exception('Invalid email address');
      }
    }

    for (final phoneNumber in contact.phoneNumbers) {
      final exists =
          await _contactRepository.contactExists(PhoneNumber(phoneNumber));
      if (exists) {
        throw Exception('Contact with this phone number already exists');
      }
    }

    // 添加联系人
    await _contactRepository.addContact(contact);
  }

  // 添加或更新联系人
  Future<void> addOrUpdateContact(Contact contact) async {
    final exists = await _contactRepository.contactExistsAny(
        contact.phoneNumbers.map((p) => PhoneNumber(p)).toList());

    if (exists) {
      await updateContact(contact);
    } else {
      await addContact(contact);
    }
  }

  // 批量添加或更新联系人
  Future<void> addOrUpdateContacts(List<Contact> contacts) async {
    for (final contact in contacts) {
      await addOrUpdateContact(contact);
    }
  }

  // 更新联系人头像
  Future<void> updateContactAvatar(
      PhoneNumber phoneNumber, String avatar) async {
    final contact = await findContactByPhoneNumber(phoneNumber);

    if (contact == null) {
      return;
    }

    contact.avatar = avatar;
    await updateContact(contact);
  }

  // 根据电话号码获取联系人
  Future<Contact?> getContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.getContactByPhone(phoneNumber); // 修正方法名
  }

  // 根据电话号码查找联系人
  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.findContactByPhoneNumber(phoneNumber);
  }

  // 合并联系人
  Future<void> mergeContacts(List<Contact> contacts) async {
    if (contacts.length < 2) return;

    Contact mergedContact = contacts[0];
    for (int i = 1; i < contacts.length; i++) {
      mergedContact = _mergeContactDetails(mergedContact, contacts[i]);
      await deleteContact(PhoneNumber(contacts[i].phoneNumbers[0]));
    }

    await updateContact(mergedContact);
  }

  // 合并联系人详情
  Contact _mergeContactDetails(Contact contact1, Contact contact2) {
    return Contact(
      id: contact1.id,
      name: contact1.name.isNotEmpty ? contact1.name : contact2.name,
      phoneNumbers:
          {...contact1.phoneNumbers, ...contact2.phoneNumbers}.toList(),
      email: contact1.email ?? contact2.email,
      labelId: contact1.labelId ?? contact2.labelId,
      avatar: contact1.avatar ?? contact2.avatar,
      website: contact1.website ?? contact2.website,
      group: contact1.group ?? contact2.group,
      url: contact1.url ?? contact2.url,
    );
  }

  // 选择并保存头像
  Future<String?> pickAndSaveAvatar(PhoneNumber phoneNumber) async {
    // 获取默认目录
    final defaultDirectory = await getExternalStorageDirectory();

    // 创建头像目录
    final directory = Directory('${defaultDirectory!.path}/avatar');
    if (!directory.existsSync()) {
      directory.createSync();
    }

    // 选择图片
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }

    // 裁剪图片
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 200,
      maxHeight: 200,
    );

    // 如果没有裁剪文件，则使用姓氏生成头像
    if (croppedFile == null) {
      final contact = await getContactByPhoneNumber(phoneNumber);
      if (contact == null) {
        return null;
      }

      // 生成默认头像
      String avatarInitial = getAvatarInitial(contact);
      await updateContactAvatar(phoneNumber, avatarInitial);
      return avatarInitial;
    }

    // 保存裁剪后的图片作为头像
    final savedFile = await saveAvatar(croppedFile, directory);
    if (savedFile != null) {
      await updateContactAvatar(phoneNumber, savedFile);
      return savedFile;
    }

    return null;
  }

  // 获取默认头像的首字母
  String getAvatarInitial(Contact contact) {
    // 获取姓氏
    final nameParts = contact.name.split(' ');
    String lastName = nameParts.length > 1 ? nameParts.last : '';
    String firstName = nameParts.first;

    // 1. 尝试匹配汉字 (优先级更高)
    RegExp chineseRegExp = RegExp(r'[\u4e00-\u9fa5]');
    Match? chineseMatch = chineseRegExp.firstMatch(firstName);
    if (chineseMatch != null) {
      return chineseMatch.group(0)!;
    }

    // 2. 如果没有匹配到汉字，再判断是否为拉丁字母
    if (isLatin(lastName)) {
      return lastName[0].toUpperCase();
    }

    // 如果没有匹配到汉字或拉丁字母，则返回默认值
    return '?';
  }

  // 判断是否为拉丁文
  bool isLatin(String name) {
    RegExp regExp = RegExp(r'^[a-zA-Z]+$');
    return regExp.hasMatch(name);
  }

  // 保存头像
  Future<String?> saveAvatar(dynamic imageData, Directory directory) async {
    try {
      String fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
      String filePath = '${directory.path}/$fileName';

      if (imageData is String) {
        if (imageData.startsWith('http')) {
          // 如果是URL，下载图片
          final response = await http.get(Uri.parse(imageData));
          final File newFile = File(filePath);
          await newFile.writeAsBytes(response.bodyBytes);
        } else {
          // 如果是base64字符串，解码并保存
          final File newFile = File(filePath);
          await newFile.writeAsBytes(base64.decode(imageData));
        }
      } else if (imageData is File) {
        await imageData.copy(filePath);
      } else {
        throw Exception('Unsupported image data type'); // L282
      }

      return filePath;
    } catch (e) {
      return null;
    }
  }

  // 从VCF文件导入联系人
  Future<void> importContactsFromVcf(
      String vcfString, Directory directory) async {
    final lines = vcfString.split('\n');
    final contacts = <Contact>[];
    Contact? currentContact;

    for (final line in lines) {
      final trimmedLine = line.trim();

      // 修改正则表达式以处理属性中的分号和TYPE
      final match = RegExp(r'^([^:]+):(.+)$').firstMatch(trimmedLine);

      if (match != null) {
        final fullProperty = match.group(1)!; // 完整的属性部分（包含TYPE等）
        final value = match.group(2)!.trim();

        // 获取基本属性名（去除TYPE等修饰符）
        final baseProperty = fullProperty.split(';').first;

        switch (baseProperty) {
          case 'BEGIN':
            if (value == 'VCARD') {
              currentContact = Contact(
                id: const Uuid().v4(),
                name: '',
                phoneNumbers: [],
              );
            }
            break;

          case 'END':
            if (value == 'VCARD' && currentContact != null) {
              contacts.add(currentContact);
            }
            break;

          case 'FN':
            if (currentContact != null) {
              currentContact.name = value;
            }
            break;

          case 'N':
            if (currentContact != null) {
              // 处理格式如 "N:迟;娇娇;;;"
              final nameParts = value.split(';');
              if (nameParts.isNotEmpty) {
                // 如果 FN 还没有设置，使用 N 中的姓名
                if (currentContact.name.isEmpty) {
                  // 组合姓和名
                  final lastName = nameParts[0].trim();
                  final firstName =
                      nameParts.length > 1 ? nameParts[1].trim() : '';
                  currentContact.name = (firstName + lastName).trim();
                }
              }
            }
            break;

          case 'TEL':
            if (currentContact != null) {
              // 直接获取冒号后面的电话号码部分
              String phoneNumber = value.replaceAll('-', '').trim();
              if (phoneNumber.isNotEmpty) {
                currentContact.phoneNumbers.add(phoneNumber);
              }
            }
            break;

          case 'EMAIL':
            if (currentContact != null) {
              currentContact.email = value;
            }
            break;

          case 'URL':
            if (currentContact != null) {
              currentContact.website = value;
            }
            break;

          case 'GROUP':
            if (currentContact != null) {
              currentContact.group = value;
            }
            break;

          case 'PHOTO':
            if (currentContact != null && value.startsWith('BASE64,')) {
              final base64Data = value.substring(7).trim();
              currentContact.avatar = await saveAvatar(base64Data, directory);
            }
            break;
        }
      }
    }

    await addOrUpdateContacts(contacts);
  }

  // 从CSV文件导入联系人
  Future<void> importContactsFromCsv(String csvString) async {
    final csvData = const CsvToListConverter().convert(csvString);
    final headers = (csvData.first).map((e) => e.toString().toLowerCase()).toList();
    final contacts = csvData.skip(1).map((row) {
      final map = <String, dynamic>{};
      for (var i = 0; i < headers.length; i++) {
        final key = headers[i];
        final value = row[i].toString();
        
        // 自动处理List类型字段
        if (Contact.listFields.contains(key)) {
          map[key] = value.split(';');
        } else {
          map[key] = value.isNotEmpty ? value : null;
        }
      }
      return Contact.fromMap(map);
    }).toList();
    
    await addOrUpdateContacts(contacts);
  }
  
  // 修改YAML导入方法
  Future<void> importContactsFromYaml(String yamlString) async {
    final yamlData = loadYaml(yamlString) as List;
    final contacts = yamlData.map((item) => Contact.fromMap(Map<String,dynamic>.from(item))).toList();
    await addOrUpdateContacts(contacts);
  }
  
  // 修改JSON导入方法
  Future<void> importContactsFromJson(List<dynamic> jsonData) async {
    final contacts = jsonData.map((item) => Contact.fromMap(Map<String,dynamic>.from(item))).toList();
    await addOrUpdateContacts(contacts);
  }
  
  // 修改CSV导出方法
  Future<String> exportContactsToCsv() async {
    final contacts = await _contactRepository.getAll();
    return const ListToCsvConverter().convert(
      contacts.map((c) => [c.id, c.name, c.phoneNumbers.join(';')]).toList()
    );
  }
  
  // 修改JSON导出方法
  Future<String> exportContactsToJson() async {
    final contacts = await _contactRepository.getAll();
    return jsonEncode(contacts.map((c) => c.toMap()).toList());
  }
}
