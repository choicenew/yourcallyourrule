import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yaml/yaml.dart';

import '../utils/get_default_external_dir.dart';

Database? _database;
Future<Database> get database async {
  if (_database != null) return _database!;

  _database = await _initDatabase();
  return _database!;
}

Future<Database> _initDatabase() async {
  final String path = join(await getDatabasesPath(), 'call_rule_database.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: createDatabase,
  );
}

// 创建数据库表
Future<void> createDatabase(Database database, int version) async {
  // 创建联系人表
  await database.execute('''
    CREATE TABLE IF NOT EXISTS contacts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone_numbers TEXT NOT NULL,
      email TEXT,
      label TEXT,
      avatar TEXT,
      website TEXT,
      group TEXT,
      url TEXT
    )
  ''');
}

class Contact {
  String name;
  List<String> phoneNumbers; // 修改为列表
  String? email;
  String? label;
  String? avatar; // 新增属性
  String? website; // 新增属性，改为可选项
  String? group; // Add the new property
  String? url; // Add the URL property

  Contact({
    required this.name,
    required this.phoneNumbers,
    this.email,
    this.label,
    this.avatar,
    this.website,
    this.group, // Initialize the new property
    this.url, // Initialize the new property
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json['name'],
        phoneNumbers: json['phone_numbers'] != null
            ? (json['phone_numbers'] as String)
                .split(',') // Split comma-separated string into a list
            : [],
        email: json['email'],
        label: json['label'],
        avatar: json['avatar'],
        website: json['website'],
        group: json['group'], // Add this line
        url: json['url'], // Add this line
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_numbers':
            phoneNumbers.join(','), // Convert list to comma-separated string
        'email': email,
        'label': label,
        'avatar': avatar,
        'website': website,
        'group': group, // Add this line
        'url': url, // Add this line
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.name == name &&
        other.phoneNumbers == phoneNumbers &&
        other.email == email &&
        other.label == label &&
        other.avatar == avatar &&
        other.website == website &&
        other.group == group && // Include the new property
        other.url == url; // Include the new property
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumbers.hashCode ^
        email.hashCode ^
        label.hashCode ^
        avatar.hashCode ^
        website.hashCode ^
        group.hashCode ^ // Include the new property
        url.hashCode; // Include the new property
  }
}

class ContactService {
  final Database database;

  ContactService(this.database);
// 获取所有联系人
  Future<List<Contact>> getAllContacts() async {
    // 从数据库中查询所有联系人
    final results = await database.query('contacts');

    // 将查询结果转换为 Contact 对象列表
    final contacts = <Contact>[];
    for (final result in results) {
      contacts.add(Contact.fromJson(result));
    }

    return contacts;
  }

// 编辑联系人
  Future<void> editContact(Contact contact) async {
    // Validate user input
    if (contact.name.isEmpty) {
      throw Exception('Contact name cannot be empty.');
    }

    // ... (其他验证逻辑)

    // Query the contact from the database using phone numbers as the identifier
    final whereClause = contact.phoneNumbers
        .map((phoneNumber) => 'phone_numbers = ?')
        .join(' OR ');
    final results = await database.query(
      'contacts',
      where: whereClause,
      whereArgs: contact.phoneNumbers,
    );

    if (results.isEmpty) {
      throw Exception('Contact not found.');
    }

    // Update the contact information in the database
    await database.update(
      'contacts',
      contact.toJson(),
      where: whereClause, // Use the same whereClause for updating
      whereArgs: contact.phoneNumbers, // Use the same whereArgs for updating
    );
  }

// 删除联系人
  Future<void> deleteContact(String phoneNumber) async {
    // 从数据库中删除联系人
    await database.delete('contacts',
        where: 'phone_numbers = ?', whereArgs: [phoneNumber]);
  }

  // 根据url删除联系人
  Future<void> deleteContactByUrl(String url) async {
    // 从数据库中删除联系人
    await database.delete('contacts', where: 'url = ?', whereArgs: [url]);
  }

  Future<void> deleteContacts(List<String> phoneNumbers) async {
    // 批量删除联系人
    await database.delete('contacts',
        where: 'phone_numbers IN ?', whereArgs: [phoneNumbers]);
  }

// 检查联系人上是否重复
  Future<List<Contact>> checkForDuplicateContacts(
      List<Contact> contacts) async {
    final existingContacts = await getAllContacts();
    final duplicateContacts = <Contact>[];
    for (final contact in contacts) {
      for (final existingContact in existingContacts) {
        if (contact.phoneNumbers.any((phoneNumber) =>
            existingContact.phoneNumbers.contains(phoneNumber))) {
          duplicateContacts.add(contact);
          break;
        }
      }
    }
    return duplicateContacts;
  }

// 更新联系人
  Future<void> updateContact(Contact contact) async {
    // 将 phoneNumbers 列表转换为字符串
    contact.phoneNumbers.join(',');

    // 更新数据库中的联系人信息
    await database.update('contacts', contact.toJson(),
        where: 'name = ?', whereArgs: [contact.name]); // 使用 name 作为更新条件
  }

// 添加联系人
  Future<void> addContact(Contact contact) async {
    // Validate user input
    if (contact.name.isEmpty) {
      throw Exception('Contact name cannot be empty.');
    }

    // Skip email validation if it's null or empty
    if (contact.email != null && contact.email!.isNotEmpty) {
      if (!EmailValidator.validate(contact.email!)) {
        throw Exception('Invalid email address.');
      }
    }

    // Check if any of the phone numbers already exists
    bool contactExists = false;
    for (String phoneNumber in contact.phoneNumbers) {
      final results = await database.query(
        'contacts',
        where: 'phone_numbers = ?',
        whereArgs: [phoneNumber],
      );
      if (results.isNotEmpty) {
        contactExists = true;
        break; // Found a matching phone number, no need to continue checking
      }
    }

    if (contactExists) {
      throw Exception('Contact with one of the phone numbers already exists.');
    }

    // Insert the contact information into the database
    await database.insert('contacts', contact.toJson());
  }

// 添加or更新联系人
  Future<void> addOrUpdateContact(Contact contact) async {
    final whereClause = contact.phoneNumbers
        .map((phoneNumber) => 'phone_numbers = ?')
        .join(' OR ');
    final results = await database.query(
      'contacts',
      where: whereClause,
      whereArgs: contact.phoneNumbers,
    );

    if (results.isNotEmpty) {
      // 更新联系人信息
      await updateContact(contact);
    } else {
      // 添加联系人
      await addContact(contact);
    }
  }

// 添加或更新联系人 (多个 Contact 对象)
  Future<void> addOrUpdateContacts(List<Contact> contacts) async {
    for (final contact in contacts) {
      // 使用循环查询或 OR 连接多个条件的方式查询数据库
      bool contactExists = false;
      for (String phoneNumber in contact.phoneNumbers) {
        final results = await database.query(
          'contacts',
          where: 'phone_numbers = ?',
          whereArgs: [phoneNumber],
        );
        if (results.isNotEmpty) {
          contactExists = true;
          break;
        }
      }

      if (contactExists) {
        // 更新联系人信息
        await updateContact(contact);
      } else {
        // 添加联系人
        await addContact(contact);
      }
    }
  }

  Future<void> updateContactAvatar(String phoneNumber, String avatar) async {
    // 查询联系人
    final contact = await findContactByPhoneNumber(phoneNumber);

    if (contact == null) {
      return;
    }

    // 更新联系人头像
    contact.avatar = avatar;

    // 更新数据库中的联系人信息
    await updateContact(contact);
  }

  Future<Contact?> getContactByPhoneNumber(String phoneNumber) async {
    // 查询联系人
    final List<Map<String, dynamic>> maps = await database.query(
      'contacts',
      where: 'phone_numbers LIKE ?',
      whereArgs: ['%$phoneNumber%'], // 使用模糊查询匹配电话号码
    );

    // 如果查询结果为空，则返回null
    if (maps.isEmpty) {
      return null;
    }

    // 将查询结果转换为 Contact 对象
    return Contact.fromJson(maps.first);
  }

// 根据电话号码查找联系人
  Future<Contact?> findContactByPhoneNumber(String phoneNumber) async {
    // 从数据库中查询联系人
    final results = await database.query('contacts',
        where: 'phone_numbers LIKE ?', whereArgs: ['%$phoneNumber%']);

    if (results.isEmpty) {
      return null;
    }

    // 将查询结果转换为 Contact 对象
    return Contact.fromJson(results.first);
  }

  // 合并 Contact 对象
  Future<void> mergeContacts(List<Contact> contacts) async {
    if (contacts.length < 2) return;

    Contact mergedContact = contacts[0];
    for (int i = 1; i < contacts.length; i++) {
      mergedContact = _mergeContactDetails(mergedContact, contacts[i]);
      await deleteContact(contacts[i].phoneNumbers[0]);
    }
    await updateContact(mergedContact);
  }

  Contact _mergeContactDetails(Contact contact1, Contact contact2) {
    return Contact(
      name: contact1.name.isNotEmpty ? contact1.name : contact2.name,
     // phoneNumbers: [...contact1.phoneNumbers, ...contact2.phoneNumbers].toSet().toList(),
       phoneNumbers: {...contact1.phoneNumbers, ...contact2.phoneNumbers}.toList(),
      email: contact1.email ?? contact2.email,
      label: contact1.label ?? contact2.label,
      avatar: contact1.avatar ?? contact2.avatar,
      website: contact1.website ?? contact2.website,
      group: contact1.group ?? contact2.group,
      url: contact1.url ?? contact2.url,
    );
  }

  Future<String?> pickAndSaveAvatar(String phoneNumber) async {
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
      aspectRatio: const CropAspectRatio(
          ratioX: 1.0, ratioY: 1.0), // 使用 CropAspectRatio 构造函数创建宽高比例实例
      maxWidth: 200, // 最大宽度
      maxHeight: 200, // 最大高度
    );

    // 如果没有裁剪文件，则使用姓氏生成头像 (需要从数据库获取姓氏)
    if (croppedFile == null) {
      // 从数据库获取联系人信息 (你需要实现这个函数)
      final contact = await getContactByPhoneNumber(phoneNumber);
      if (contact == null) {
        // print('Error: Contact not found.');
        return null;
      }

      // 生成默认头像
      String avatarInitial = getAvatarInitial(contact);

      // 更新联系人头像 (你需要实现这个函数)
      await updateContactAvatar(phoneNumber, avatarInitial);

      return avatarInitial;
    }

    // 保存裁剪后的图片作为头像
    final savedFile = await saveAvatar(croppedFile, directory);

    if (savedFile != null) {
      // 更新联系人头像
      await updateContactAvatar(phoneNumber, savedFile);
      return savedFile;
    }

    return null;
  }

// 获取默认头像的 initials (包含判断拉丁字母和汉字的逻辑)
  String getAvatarInitial(Contact contact) {
    // 获取姓氏
    final nameParts = contact.name.split(' ');
    String lastName = nameParts.length > 1 ? nameParts.last : '';
    String firstName = nameParts.first;
    // 1. 尝试匹配汉字 (优先级更高)
    RegExp chineseRegExp = RegExp(r'[\u4e00-\u9fa5]');
    Match? chineseMatch =
        chineseRegExp.firstMatch(firstName); // Use firstName first
    if (chineseMatch != null) {
      return chineseMatch.group(0)!;
    }

    // 2. 如果没有匹配到汉字，再判断是否为拉丁字母
    if (isLatin(lastName)) {
      // Use lastName as a fallback
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

  Future<String?> saveAvatar(dynamic imageData, Directory directory) async {
    try {
      String fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
      String filePath = '${directory.path}/$fileName';

      if (imageData is String) {
        if (imageData.startsWith('http')) {
          // If it's a URL, download the image
          final response = await http.get(Uri.parse(imageData));
          final File newFile = File(filePath);
          await newFile.writeAsBytes(response.bodyBytes);
        } else {
          // If it's a base64 string, decode and save
          final File newFile = File(filePath);
          await newFile.writeAsBytes(base64.decode(imageData));
        }
      } else if (imageData is File) {
        await imageData.copy(filePath);
      } else {
        throw Exception('Unsupported image data type');
      }

      return filePath;
    } catch (e) {
      //print('Error saving avatar: $e');
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
      final match = RegExp(r'^(.+?):\s*(.+)$').firstMatch(trimmedLine);

      if (match != null) {
        final property = match.group(1);
        final value = match.group(2);

        switch (property) {
          case 'BEGIN':
            if (value == 'VCARD') {
              // 创建新的 Contact 对象
              currentContact = Contact(
                name: '',
                phoneNumbers: [],
              );
            }
            break;
          case 'END':
            if (value == 'VCARD' && currentContact != null) {
              // 将当前 Contact 添加到联系人列表
              contacts.add(currentContact);
            }
            break;
          case 'FN':
            // 设置联系人的名称
            if (currentContact != null) {
              currentContact.name = value!;
            }
            break;
          case 'TEL':
            // 处理电话号码
            if (currentContact != null) {
              final type = value!.split(';').first.trim(); // 获取电话号码类型
              final phoneNumber =
                  value.substring(type.length + 1).trim(); // 获取电话号码
              currentContact.phoneNumbers.add(phoneNumber);
            }
            break;
          case 'EMAIL':
            // 处理电子邮件
            if (currentContact != null) {
              currentContact.email = value;
            }
            break;
          case 'URL':
            // 处理网址
            if (currentContact != null) {
              currentContact.website = value;
            }
            break;
          case 'GROUP':
            // 处理分组信息
            if (currentContact != null) {
              currentContact.group = value;
            }
            break;
          case 'PHOTO':
            // 处理头像信息（如果有）
            if (currentContact != null) {
              final base64Data = value!.substring(7).trim();
              currentContact.avatar = await saveAvatar(base64Data, directory);
            }
            break;
          default:
            // 记录或忽略未知属性
            // print('Unknown property: $line');
            break;
        }
      } else {
        // 处理未知属性
        // print('Unknown property: $line');
      }
    }

    // 保存联系人到数据库
    await addOrUpdateContacts(contacts);
  }

// 从CSV文件导入联系人
  Future<void> importContactsFromCsv(String csvString) async {
    final lines = csvString.split('\n');
    final contacts = <Contact>[];

    for (final line in lines) {
      final fields = line.split(',');
      if (fields.length < 2) {
        // 忽略格式错误的行
        continue;
      }

      final name = fields[0];
      final phoneNumbers = fields[1].split(';');
      final email = fields.length >= 3 ? fields[2] : null;
      final label = fields.length >= 4 ? fields[3] : null;
      final avatar = fields.length >= 5 ? fields[4] : null;
      final website = fields.length >= 6 ? fields[5] : null;
      final group = fields.length >= 7 ? fields[6] : null;

      final contact = Contact(
        name: name,
        phoneNumbers: phoneNumbers,
        email: email,
        label: label,
        avatar: avatar,
        website: website,
        group: group,
      );

      contacts.add(contact);
    }

    // 保存联系人到数据库
    await addOrUpdateContacts(contacts);
  }

// 从JSON文件导入联系人
  Future<void> importContactsFromJson(List<dynamic> jsonData) async {
    final contacts = <Contact>[];

    for (final json in jsonData) {
      final name = json['name'] as String;
      final phoneNumbers =
          (json['phone_numbers'] as List<dynamic>).cast<String>();
      final email = json['email'] as String?;
      final label = json['label'] as String?;
      final avatar = json['avatar'] as String?;
      final website = json['website'] as String?;
      final group = json['group'] as String?;

      final contact = Contact(
        name: name,
        phoneNumbers: phoneNumbers,
        email: email,
        label: label,
        avatar: avatar,
        website: website,
        group: group,
      );

      contacts.add(contact);
    }

    // 保存联系人到数据库
    await addOrUpdateContacts(contacts);
  }

// 从yaml 导入From YAML file import contacts
  Future<void> importContactsFromYaml(String yamlString) async {
    final yaml = loadYaml(yamlString);

    // Handle potential errors during YAML parsing
    if (yaml is! Map) {
      throw Exception('Invalid YAML format. Top level should be a map.');
    }

    final contacts = <Contact>[];

    // Iterate through each contact entry in the YAML data
    for (final contactData in yaml.entries) {
      final name = contactData.key == 'name' ? contactData.value : null;
      final phoneNumbers =
          contactData.key == 'phone_numbers' && contactData.value is List
              ? List<String>.from(contactData.value)
              : <String>[]; // Ensure the list is dynamic
      final email = contactData.key == 'email' ? contactData.value : null;
      final label = contactData.key == 'label' ? contactData.value : null;
      final avatar = contactData.key == 'avatar' ? contactData.value : null;
      final website = contactData.key == 'website' ? contactData.value : null;
      final group = contactData.key == 'group' ? contactData.value : null;

      final contact = Contact(
        name: name,
        phoneNumbers: phoneNumbers,
        email: email,
        label: label,
        avatar: avatar,
        website: website,
        group: group,
      );

      contacts.add(contact);
    }

    // Save contacts to database
    await addOrUpdateContacts(contacts);
  }

// 从URL导入联系人
  Future<void> importContactsFromUrl(String url) async {
    final database = await _initDatabase();
    try {
      // 获取URL数据
      final response = await http.get(Uri.parse(url));

      // 检查响应状态码
      if (response.statusCode == 200) {
        // 根据URL后缀名判断文件类型
        final extension = url.split('.').last;
        switch (extension) {
          case 'vcf':
            final String vcfString = response.body;
            final defaultDirectory = await getExternalStorageDirectory();

            // 创建头像目录
            final directory = Directory('${defaultDirectory!.path}/avatar');
            if (!directory.existsSync()) {
              directory.createSync();
            }
            await importContactsFromVcf(vcfString, directory);
            // 将 URL 插入到数据库中
            await database.insert('contacts', {'url': url});
            break;
          case 'csv':
            final String csvString = response.body;
            await importContactsFromCsv(csvString);
            // 将 URL 插入到数据库中
            await database.insert('contacts', {'url': url});
            break;
          case 'json':
            final List<dynamic> jsonData = json.decode(response.body);
            await importContactsFromJson(jsonData);
            // 将 URL 插入到数据库中
            await database.insert('contacts', {'url': url});
            break;
          case 'yaml':
            final String yamlString = response.body;
            await importContactsFromYaml(yamlString);
            // 将 URL 插入到数据库中
            await database.insert('contacts', {'url': url});
            break;
          default:
            // 处理无法识别的文件类型
            throw Exception('Error: Unrecognized file format.');
        }
      } else {
        // 处理错误响应
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      // 记录错误信息
    }
  }

// 从本地导入联系人
  Future<void> importContactsFromLocalFile(File file) async {
    // 判断文件是否存在
    if (!file.existsSync()) {
      return; // 文件不存在，直接返回
    }

    // 读取文件内容
    final fileContent = await file.readAsString();

    // 获取文件扩展名
    final extension = file.path.split('.').last;

    // 导入联系人（统一调用定义好的函数）
    await importContacts(fileContent, extension);
  }

// 导入联系人
  Future<void> importContacts(String fileContent, String extension) async {
    switch (extension) {
      case 'vcf':
        final defaultDirectory = await getDefaultExternalStorageDirectory();

        // 创建头像目录
        final directory = Directory('${defaultDirectory}/avatar');
        if (!directory.existsSync()) {
          directory.createSync();
        }
        await importContactsFromVcf(fileContent, directory); // 直接调用定义好的函数
        break;
      case 'csv':
        await importContactsFromCsv(fileContent); // 直接调用定义好的函数
        break;
      case 'json':
        final List<dynamic> jsonData = json.decode(fileContent);
        await importContactsFromJson(jsonData); // 直接调用定义好的函数
        break;
      case 'yaml':
        await importContactsFromYaml(fileContent); // 直接调用定义好的函数
        break;
      default:
        // 处理不支持的文件类型
        break;
    }
  }

  Future<void> exportContacts(String format, String path) async {
    final contacts = await getAllContacts();

    switch (format) {
      case 'vcf':
        await exportContactsToVcf(contacts, path);
        break;
      case 'csv':
        await exportContactsToCsv(contacts, path);
        break;
      case 'yaml':
        await exportContactsToYaml(contacts, path);
        break;
      case 'json':
        await exportContactsToJson(contacts, path);
        break;
      default:
        throw Exception('Unsupported format: $format');
    }
  }

  Future<void> exportContactsToVcf(List<Contact> contacts, String path) async {
    final vcfString = generateVcfString(contacts);
    await File(path).writeAsString(vcfString);
  }

  Future<File> generateVCFFile(Contact contact) async {
    String vCardData = _buildVCard(contact);

    Directory tempDir = await getTemporaryDirectory();
    File vcfFile = File('${tempDir.path}/${contact.name}.vcf');
    await vcfFile.writeAsString(vCardData);

    return vcfFile;
  }

  String _buildVCard(Contact contact) {
    // Build the VCard string based on contact information
    String vCard = 'BEGIN:VCARD\nVERSION:3.0\n';
    vCard += 'FN:${contact.name}\n';
    for (String phoneNumber in contact.phoneNumbers) {
      vCard += 'TEL:$phoneNumber\n';
    }
    if (contact.email != null) {
      vCard += 'EMAIL:${contact.email}\n';
    }
    if (contact.label != null) {
      vCard += 'LABEL:${contact.label}\n';
    }
    if (contact.avatar != null) {
      vCard += 'PHOTO;VALUE=URL;TYPE=JPEG:${contact.avatar}\n';
    }
    if (contact.website != null) {
      vCard += 'URL:${contact.website}\n';
    }
    if (contact.group != null) {
      vCard += 'GROUP:${contact.group}\n';
    }
    vCard += 'END:VCARD';

    return vCard;
  }

  Future<void> exportContactsToCsv(List<Contact> contacts, String path) async {
    final csvString = generateCsvString(contacts);
    await File(path).writeAsString(csvString);
  }

  Future<void> exportContactsToYaml(List<Contact> contacts, String path) async {
    final yamlString = generateYamlString(contacts);
    await File(path).writeAsString(yamlString);
  }

  Future<void> exportContactsToJson(List<Contact> contacts, String path) async {
    final jsonString = generateJsonString(contacts);
    await File(path).writeAsString(jsonString);
  }

  String generateVcfString(List<Contact> contacts) {
    final sb = StringBuffer();
    for (final contact in contacts) {
      sb.writeln('BEGIN:VCARD');
      sb.writeln('VERSION:3.0');
      sb.writeln('N:${contact.name}');
      for (final phoneNumber in contact.phoneNumbers) {
        sb.writeln(
            'TEL;TYPE=CELL:${phoneNumber}'); // 手动指定类型为 CELL，并将 phoneNumber 作为字符串插入
      }
      if (contact.email != null) {
        sb.writeln('EMAIL:${contact.email}');
      }
      if (contact.label != null) {
        sb.writeln('LABEL:${contact.label}');
      }
      if (contact.avatar != null) {
        if (contact.avatar!.startsWith('http')) {
          // For network images, save the URL
          sb.writeln('PHOTO;VALUE=URL:${contact.avatar}');
        } else {
          // For local images, embed the base64 encoded data
          final File avatarFile = File(contact.avatar!);
          if (avatarFile.existsSync()) {
            final bytes = avatarFile.readAsBytesSync();
            final base64Image = base64Encode(bytes);
            sb.writeln('PHOTO;ENCODING=BASE64:$base64Image');
          }
        }
      }
      if (contact.website != null) {
        sb.writeln('URL:${contact.website}');
      }
      if (contact.group != null) {
        sb.writeln('GROUP:${contact.group}');
      }
      sb.writeln('END:VCARD');
    }
    return sb.toString();
  }

  String generateCsvString(List<Contact> contacts) {
    final sb = StringBuffer();
    sb.writeln('Name,Phone Numbers,Email,Label,Avatar,Website,Group');
    for (final contact in contacts) {
      final csvRow = [
        _escapeCSVField(contact.name),
        _escapeCSVField(contact.phoneNumbers.join('|')),
        _escapeCSVField(contact.email ?? ''),
        _escapeCSVField(contact.label ?? ''),
        _escapeCSVField(contact.avatar ?? ''),
        _escapeCSVField(contact.website ?? ''),
        _escapeCSVField(contact.group ?? ''),
      ];
      sb.writeln(csvRow.join(','));
    }
    return sb.toString();
  }

  String _escapeCSVField(String field) {
    if (field.contains('"') || field.contains(',') || field.contains('\n')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }

  String generateYamlString(List<Contact> contacts) {
    final yaml = {
      'contacts': contacts
          .map((contact) => {
                'name': contact.name,
                'phone_numbers': contact.phoneNumbers,
                'email': contact.email,
                'label': contact.label,
                'avatar': contact.avatar,
                'website': contact.website,
                'group': contact.group,
              })
          .toList(),
    };
    return yaml.toString();
  }

  String generateJsonString(List<Contact> contacts) {
    final json = {
      'contacts': contacts
          .map((contact) => {
                'name': contact.name,
                'phone_numbers': contact.phoneNumbers,
                'email': contact.email,
                'label': contact.label,
                'avatar': contact.avatar,
                'website': contact.website,
                'group': contact.group,
              })
          .toList(),
    };
    return jsonEncode(json);
  }
}
