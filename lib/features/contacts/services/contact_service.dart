import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';

import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_repository.dart';
import 'package:yourcallyourrule/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:yourcallyourrule/features/common/services/list_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'contact_service.g.dart';

/// ContactService Riverpod Provider
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

/// Top-level Isolate 任务：解析 VCF 文本
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
              'displayName': '',
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
            currentContact['displayName'] = value;
          }
          break;

        case 'N':
          if (currentContact != null) {
            final nameParts = value.split(';');
            if (nameParts.isNotEmpty && (currentContact['displayName'] as String).isEmpty) {
              final lastName = nameParts[0].trim();
              final firstName = nameParts.length > 1 ? nameParts[1].trim() : '';
              currentContact['displayName'] = (firstName + lastName).trim();
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
    csvRows.add([map['id'], map['displayName'], (map['phoneNumbers'] as List).join(';')]);
  }
  return const CsvEncoder().convert(csvRows);
}

/// 联系人服务类，全量基于 PhoneContactEntry 强实体运作
class ContactService extends ListService<PhoneContactEntry, String> {
  final ContactRepository _contactRepository;

  ContactService(this._contactRepository) : super();

  Future<void> editContact(PhoneContactEntry contact) async {
    if (contact.displayName.isEmpty) {
      throw Exception('Contact name cannot be empty');
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
  Future<bool> deleteAll(List<PhoneContactEntry> entities) async {
    await _contactRepository.deleteAll(entities);
    return true;
  }

  Future<List<PhoneContactEntry>> checkForDuplicateContacts(
    List<PhoneContactEntry> contacts,
  ) async {
    final existingContacts = await _contactRepository.getAllContacts();
    final duplicateContacts = <PhoneContactEntry>[];

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

  Future<void> updateContact(PhoneContactEntry contact) async {
    await _contactRepository.updateContact(contact);
  }

  Future<void> addContact(PhoneContactEntry contact) async {
    if (contact.displayName.isEmpty) {
      throw Exception('Contact name cannot be empty');
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

  Future<void> addOrUpdateContact(PhoneContactEntry contact) async {
    final exists = await _contactRepository.contactExistsAny(
      contact.phoneNumbers.map((p) => PhoneNumber(p)).toList(),
    );

    if (exists) {
      await updateContact(contact);
    } else {
      await addContact(contact);
    }
  }

  Future<void> addOrUpdateContacts(List<PhoneContactEntry> contacts) async {
    for (final contact in contacts) {
      await addOrUpdateContact(contact);
    }
  }

  Future<PhoneContactEntry?> getContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.getContactByPhone(phoneNumber);
  }

  Future<PhoneContactEntry?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _contactRepository.findContactByPhoneNumber(phoneNumber);
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

  /// 从 VCF 文本导入联系人
  Future<void> importContactsFromVcf(
    String vcfString,
    Directory directory,
  ) async {
    final rawMaps = await compute(parseVcfIsolateTask, vcfString);
    final contacts = <PhoneContactEntry>[];

    for (final map in rawMaps) {
      String? avatarPath;
      final base64Photo = map['avatarBase64'] as String?;
      if (base64Photo != null && base64Photo.isNotEmpty) {
        avatarPath = await saveAvatar(base64Photo, directory);
      }

      contacts.add(PhoneContactEntry(
        id: map['id'] as String,
        displayName: map['displayName'] as String,
        phoneNumbers: List<String>.from(map['phoneNumbers'] as List),
        photoUrl: avatarPath,
      ));
    }

    await addOrUpdateContacts(contacts);
  }

  /// 从 CSV 文本导入联系人
  Future<void> importContactsFromCsv(String csvString) async {
    final rawMaps = await compute(parseCsvIsolateTask, csvString);
    final contacts = rawMaps.map((map) => PhoneContactEntry.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 YAML 文本导入联系人
  Future<void> importContactsFromYaml(String yamlString) async {
    final rawMaps = await compute(parseYamlIsolateTask, yamlString);
    final contacts = rawMaps.map((map) => PhoneContactEntry.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 JSON 数组导入联系人
  Future<void> importContactsFromJson(List<dynamic> jsonData) async {
    final contacts = jsonData
        .map((item) => PhoneContactEntry.fromMap(Map<String, dynamic>.from(item)))
        .toList();
    await addOrUpdateContacts(contacts);
  }

  /// 从 JSON 字符串导入联系人
  Future<void> importContactsFromJsonString(String jsonString) async {
    final rawMaps = await compute((String str) {
      final List decoded = jsonDecode(str);
      return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }, jsonString);
    final contacts = rawMaps.map((map) => PhoneContactEntry.fromMap(map)).toList();
    await addOrUpdateContacts(contacts);
  }

  /// CSV 导出联系人
  Future<String> exportContactsToCsv() async {
    final contacts = await _contactRepository.getAll();
    final maps = contacts.map((c) => {
      'id': c.id,
      'displayName': c.displayName,
      'phoneNumbers': c.phoneNumbers,
    }).toList();
    return await compute(exportCsvIsolateTask, maps);
  }

  /// JSON 导出联系人
  Future<String> exportContactsToJson() async {
    final contacts = await _contactRepository.getAll();
    final maps = contacts.map((c) => c.toMap()).toList();
    return await compute(exportJsonIsolateTask, maps);
  }
}