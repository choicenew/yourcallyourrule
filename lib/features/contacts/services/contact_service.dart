import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';

import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/data/repositories/contact_repository_impl.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

part 'contact_service.g.dart';

/// ContactService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
ContactService contactService(Ref ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return ContactService(contactRepository);
}

/// Top-level Isolate 任务：网络下载/Base64解码/二进制保存头像到磁盘文件
Future<String?> saveAvatarIsolateTask(Map<String, dynamic> params) async {
  try {
    final imageData = params['imageData'];
    final dirPath = params['dirPath'] as String;
    final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
    final filePath = '$dirPath/$fileName';
    final File newFile = File(filePath);

    if (imageData is String) {
      if (imageData.startsWith('http://') || imageData.startsWith('https://')) {
        final response = await http.get(Uri.parse(imageData));
        if (response.statusCode == 200) {
          await newFile.writeAsBytes(response.bodyBytes);
          return filePath;
        }
        return null;
      } else {
        // Base64 decode
        final cleanBase64 = imageData.startsWith('BASE64,')
            ? imageData.substring(7).trim()
            : imageData.trim();
        final bytes = base64.decode(cleanBase64);
        await newFile.writeAsBytes(bytes);
        return filePath;
      }
    } else if (imageData is List<int>) {
      await newFile.writeAsBytes(imageData);
      return filePath;
    }
    return null;
  } catch (e) {
    return null;
  }
}

/// Top-level Isolate 任务：重度 CPU 正则与结构解析 VCF 文本
List<Map<String, dynamic>> parseVcfIsolateTask(String vcfString) {
  final lines = vcfString.split('\n');
  final contactsList = <Map<String, dynamic>>[];
  Map<String, dynamic>? currentContact;

  for (final line in lines) {
    final trimmedLine = line.trim();
    final match = RegExp(r'^([^:]+):(.+)$').firstMatch(trimmedLine);

    if (match != null) {
      final fullProperty = match.group(1)!;
      final value = match.group(2)!.trim();
      final baseProperty = fullProperty.split(';').first;

      switch (baseProperty) {
        case 'BEGIN':
          if (value == 'VCARD') {
            currentContact = {
              'id': const Uuid().v4(),
              'name': '',
              'phoneNumbers': <String>[],
              'avatarBase64': null,
            };
          }
          break;

        case 'END':
          if (value == 'VCARD' && currentContact != null) {
            contactsList.add(currentContact);
            currentContact = null;
          }
          break;

        case 'FN':
          if (currentContact != null) {
            currentContact['name'] = value;
          }
          break;

        case 'N':
          if (currentContact != null) {
            final nameParts = value.split(';');
            if (nameParts.isNotEmpty && (currentContact['name'] as String).isEmpty) {
              final lastName = nameParts[0].trim();
              final firstName = nameParts.length > 1 ? nameParts[1].trim() : '';
              currentContact['name'] = (firstName + lastName).trim();
            }
          }
          break;

        case 'TEL':
          if (currentContact != null) {
            String phoneNumber = value.replaceAll('-', '').trim();
            if (phoneNumber.isNotEmpty) {
              (currentContact['phoneNumbers'] as List<String>).add(phoneNumber);
            }
          }
          break;

        case 'EMAIL':
          if (currentContact != null) {
            currentContact['email'] = value;
          }
          break;

        case 'URL':
          if (currentContact != null) {
            currentContact['website'] = value;
          }
          break;

        case 'GROUP':
          if (currentContact != null) {
            currentContact['group'] = value;
          }
          break;

        case 'PHOTO':
          if (currentContact != null && value.startsWith('BASE64,')) {
            currentContact['avatarBase64'] = value.substring(7).trim();
          }
          break;
      }
    }
  }

  return contactsList;
}

/// Top-level Isolate 任务：CSV 字符串反序列化解析
List<Map<String, dynamic>> parseCsvIsolateTask(String csvString) {
  final csvData = const CsvDecoder().convert(csvString);
  if (csvData.isEmpty) return [];
  final headers = (csvData.first).map((e) => e.toString().toLowerCase()).toList();
  return csvData.skip(1).map((row) {
    final map = <String, dynamic>{};
    for (var i = 0; i < headers.length; i++) {
      final rawKey = headers[i];
      final value = row[i].toString();
      if (rawKey == 'phonenumbers' || rawKey == 'phonenumber' || rawKey == 'phone') {
        map['phoneNumbers'] = value.split(';');
      } else if (rawKey == 'labelids' || rawKey == 'labelid' || rawKey == 'labels') {
        map['labelIds'] = value.split(';');
      } else {
        map[rawKey] = value.isNotEmpty ? value : null;
      }
    }
    return map;
  }).toList();
}

/// Top-level Isolate 任务：YAML 字符串反序列化解析
List<Map<String, dynamic>> parseYamlIsolateTask(String yamlString) {
  final yamlData = loadYaml(yamlString) as List;
  return yamlData
      .map((item) => Map<String, dynamic>.from(item as Map))
      .toList();
}

/// Top-level Isolate 任务：JSON 导出编码
String exportJsonIsolateTask(List<Map<String, dynamic>> maps) {
  return jsonEncode(maps);
}

/// Top-level Isolate 任务：CSV 导出编码
String exportCsvIsolateTask(List<Map<String, dynamic>> rowsData) {
  final csvRows = <List<dynamic>>[];
  for (final map in rowsData) {
    csvRows.add([map['id'], map['name'], (map['phoneNumbers'] as List).join(';')]);
  }
  return const CsvEncoder().convert(csvRows);
}

/// 联系人服务类，提供联系人的管理功能
/// 包括添加、删除、查询联系人、头像后台下载保存及 VCF/CSV/YAML/JSON Isolate 多线程导入导出
class ContactService extends ListService<Contact, String> {
  final ContactRepository _contactRepository;

  ContactService(this._contactRepository) : super(_contactRepository);

  Future<void> editContact(Contact contact) async {
    if (contact.name.isEmpty) {
      throw Exception('Contact name cannot be empty');
    }

    if (contact.email != null && contact.email!.isNotEmpty) {
      if (!EmailValidator.validate(contact.email!)) {
        throw Exception('Invalid email address');
      }
    }

    final exists = await _contactRepository.contactExists(
      PhoneNumber(contact.phoneNumbers.first),
    );
    if (!exists) {
      throw Exception('Contact does not exist');
    }

    await _contactRepository.updateContact(contact);
  }

  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    await _contactRepository.deleteContact(phoneNumber);
  }

  Future<void> deleteContactByUrl(String url) async {
    await _contactRepository.deleteContactByUrl(url);
  }

  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    await _contactRepository.deleteContacts(phoneNumbers);
  }

  @override
  Future<bool> deleteAll(List<Contact> entities) async {
    await _contactRepository.deleteAll(entities);
    return true;
  }

  Future<List<Contact>> checkForDuplicateContacts(
    List<Contact> contacts,
  ) async {
    final existingContacts = await _contactRepository.getAllContacts();
    final duplicateContacts = <Contact>[];

    for (final contact in contacts) {
      for (final existingContact in existingContacts) {
        if (contact.phoneNumbers.any(
          (phoneNumber) => existingContact.phoneNumbers.contains(phoneNumber),
        )) {
          duplicateContacts.add(contact);
          break;
        }
      }
    }

    return duplicateContacts;
  }

  Future<void> updateContact(Contact contact) async {
    await _contactRepository.updateContact(contact);
  }

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
      final exists = await _contactRepository.contactExists(
        PhoneNumber(phoneNumber),
      );
      if (exists) {
        throw Exception('Contact with this phone number already exists');
      }
    }

    await _contactRepository.addContact(contact);
  }

  Future<void> addOrUpdateContact(Contact contact) async {
    final exists = await _contactRepository.contactExistsAny(
      contact.phoneNumbers.map((p) => PhoneNumber(p)).toList(),
    );

    if (exists) {
      await updateContact(contact);
    } else {
      await addContact(contact);
    }
  }

  Future<void> addOrUpdateContacts(List<Contact> contacts) async {
    for (final contact in contacts) {
      await addOrUpdateContact(contact);
    }
  }

  Future<void> updateContactAvatar(
    PhoneNumber phoneNumber,
    String avatar,
  ) async {
    final contact = await findContactByPhoneNumber(phoneNumber);

    if (contact == null) {
      return;
    }

    contact.avatar = avatar;
    await updateContact(contact);
  }

  Future<Contact?> getContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.getContactByPhone(phoneNumber);
  }

  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.findContactByPhoneNumber(phoneNumber);
  }

  Future<void> mergeContacts(List<Contact> contacts) async {
    if (contacts.length < 2) return;

    Contact mergedContact = contacts[0];
    for (int i = 1; i < contacts.length; i++) {
      mergedContact = _mergeContactDetails(mergedContact, contacts[i]);
      await deleteContact(PhoneNumber(contacts[i].phoneNumbers[0]));
    }

    await updateContact(mergedContact);
  }

  Contact _mergeContactDetails(Contact contact1, Contact contact2) {
    return Contact(
      id: contact1.id,
      name: contact1.name.isNotEmpty ? contact1.name : contact2.name,
      phoneNumbers:
          {...contact1.phoneNumbers, ...contact2.phoneNumbers}.toList(),
      email: contact1.email ?? contact2.email,
      labelIds: {...?contact1.labelIds, ...?contact2.labelIds}.toList(),
      avatar: contact1.avatar ?? contact2.avatar,
      website: contact1.website ?? contact2.website,
      group: contact1.group ?? contact2.group,
      url: contact1.url ?? contact2.url,
    );
  }

  String getAvatarInitial(Contact contact) {
    final nameParts = contact.name.split(' ');
    String lastName = nameParts.length > 1 ? nameParts.last : '';
    String firstName = nameParts.first;

    RegExp chineseRegExp = RegExp(r'[\u4e00-\u9fa5]');
    Match? chineseMatch = chineseRegExp.firstMatch(firstName);
    if (chineseMatch != null) {
      return chineseMatch.group(0)!;
    }

    if (isLatin(lastName)) {
      return lastName[0].toUpperCase();
    }

    return '?';
  }

  bool isLatin(String name) {
    RegExp regExp = RegExp(r'^[a-zA-Z]+$');
    return regExp.hasMatch(name);
  }

  /// 保存头像 - 剥离至 Isolate 后台副线程计算与 I/O 执行
  Future<String?> saveAvatar(dynamic imageData, Directory directory) async {
    try {
      if (imageData is File) {
        final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
        final filePath = '${directory.path}/$fileName';
        await imageData.copy(filePath);
        return filePath;
      }

      return await compute(saveAvatarIsolateTask, {
        'imageData': imageData,
        'dirPath': directory.path,
      });
    } catch (e) {
      return null;
    }
  }

  /// 从 VCF 文本导入联系人 - 使用 Isolate 解构计算
  Future<void> importContactsFromVcf(
    String vcfString,
    Directory directory,
  ) async {
    final rawMaps = await compute(parseVcfIsolateTask, vcfString);
    final contacts = <Contact>[];

    for (final map in rawMaps) {
      String? avatarPath;
      final base64Photo = map['avatarBase64'] as String?;
      if (base64Photo != null && base64Photo.isNotEmpty) {
        avatarPath = await saveAvatar(base64Photo, directory);
      }

      contacts.add(Contact(
        id: map['id'] as String,
        name: map['name'] as String,
        phoneNumbers: List<String>.from(map['phoneNumbers'] as List),
        email: map['email'] as String?,
        website: map['website'] as String?,
        group: map['group'] as String?,
        avatar: avatarPath,
      ));
    }

    await addOrUpdateContacts(contacts);
  }

  /// 从 CSV 文本导入联系人 - 使用 Isolate 解构计算
  Future<void> importContactsFromCsv(String csvString) async {
    final rawMaps = await compute(parseCsvIsolateTask, csvString);
    final contacts = rawMaps.map((map) => Contact.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 YAML 文本导入联系人 - 使用 Isolate 解构计算
  Future<void> importContactsFromYaml(String yamlString) async {
    final rawMaps = await compute(parseYamlIsolateTask, yamlString);
    final contacts = rawMaps.map((map) => Contact.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 JSON 数组导入联系人 - 使用 Isolate 解构计算
  Future<void> importContactsFromJson(List<dynamic> jsonData) async {
    final contacts = jsonData
        .map((item) => Contact.fromMap(Map<String, dynamic>.from(item)))
        .toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 JSON 字符串导入联系人 - 使用 Isolate 解构计算
  Future<void> importContactsFromJsonString(String jsonString) async {
    final rawMaps = await compute((String str) {
      final List decoded = jsonDecode(str);
      return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }, jsonString);
    final contacts = rawMaps.map((map) => Contact.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// CSV 导出联系人 - 使用 Isolate 编码
  Future<String> exportContactsToCsv() async {
    final contacts = await _contactRepository.getAll();
    final maps = contacts.map((c) => {
      'id': c.id,
      'name': c.name,
      'phoneNumbers': c.phoneNumbers,
    }).toList();
    return await compute(exportCsvIsolateTask, maps);
  }

  /// JSON 导出联系人 - 使用 Isolate 编码
  Future<String> exportContactsToJson() async {
    final contacts = await _contactRepository.getAll();
    final maps = contacts.map((c) => c.toMap()).toList();
    return await compute(exportJsonIsolateTask, maps);
  }
}
