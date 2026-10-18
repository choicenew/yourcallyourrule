import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';

/// 内存级别的 Mock 联系人 Repository
class MockContactRepository implements ContactRepository {
  final Map<String, Contact> _store = {};

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<void> addContact(Contact contact) async {
    _store[contact.id] = contact;
  }

  @override
  Future<void> updateContact(Contact contact) async {
    _store[contact.id] = contact;
  }

  @override
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    _store.removeWhere((id, contact) =>
        contact.phoneNumbers.contains(phoneNumber.value));
  }

  @override
  Future<void> deleteContactByUrl(String url) async {
    _store.removeWhere((id, contact) => contact.url == url);
  }

  @override
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    final values = phoneNumbers.map((p) => p.value).toSet();
    _store.removeWhere((id, contact) =>
        contact.phoneNumbers.any((p) => values.contains(p)));
  }

  @override
  Future<bool> deleteAll(List<Contact> entities) async {
    final ids = entities.map((e) => e.id).toSet();
    _store.removeWhere((id, contact) => ids.contains(id));
    return true;
  }

  @override
  Future<bool> contactExists(PhoneNumber phoneNumber) async {
    return _store.values
        .any((c) => c.phoneNumbers.contains(phoneNumber.value));
  }

  @override
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers) async {
    final values = phoneNumbers.map((p) => p.value).toSet();
    return _store.values
        .any((c) => c.phoneNumbers.any((p) => values.contains(p)));
  }

  @override
  Future<Contact?> getContactByPhone(PhoneNumber phoneNumber) async {
    for (final c in _store.values) {
      if (c.phoneNumbers.contains(phoneNumber.value)) {
        return c;
      }
    }
    return null;
  }

  @override
  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return getContactByPhone(phoneNumber);
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    return _store.values.toList();
  }

  @override
  Future<List<Contact>> getAll() async {
    return getAllContacts();
  }

  @override
  Future<Contact?> getById(String id) async {
    return _store[id];
  }

  @override
  Future<bool> deleteById(String id) async {
    _store.remove(id);
    return true;
  }

  @override
  Future<Contact> save(Contact entity) async {
    _store[entity.id] = entity;
    return entity;
  }

  @override
  Future<List<Contact>> saveAll(List<Contact> entities) async {
    for (final e in entities) {
      _store[e.id] = e;
    }
    return entities;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockContactRepository repository;
  late ContactService service;

  setUp(() {
    repository = MockContactRepository();
    service = ContactService(repository);
  });

  group('📖 1. Contact 实体类序列化与 Getter 测试', () {
    test('Contact.toMap 与 Contact.fromMap 双向无损转换', () {
      final contact = Contact(
        id: 'c101',
        name: '张三',
        phoneNumbers: ['+8613800138000', '13900139000'],
        email: 'zhangsan@example.com',
        labelIds: ['family', 'work'],
        avatar: '/path/to/avatar.png',
        website: 'https://example.com',
        group: 'VIP',
        url: 'url-101',
      );

      final map = contact.toMap();
      expect(map['id'], equals('c101'));
      expect(map['name'], equals('张三'));
      expect(map['email'], equals('zhangsan@example.com'));

      final reconstructed = Contact.fromMap(map);
      expect(reconstructed.id, equals(contact.id));
      expect(reconstructed.name, equals(contact.name));
      expect(reconstructed.phoneNumbers, equals(contact.phoneNumbers));
      expect(reconstructed.email, equals(contact.email));
      expect(reconstructed.labelIds, equals(contact.labelIds));
    });

    test('getAvatarInitial 动态首字母推导逻辑', () {
      final cnContact = Contact(id: '1', name: '李四', phoneNumbers: ['100']);
      expect(service.getAvatarInitial(cnContact), equals('李'));

      final enContact = Contact(id: '2', name: 'John Doe', phoneNumbers: ['101']);
      expect(service.getAvatarInitial(enContact), equals('D'));

      final symbolContact = Contact(id: '3', name: '***', phoneNumbers: ['102']);
      expect(service.getAvatarInitial(symbolContact), equals('?'));
    });
  });

  group('⚡ 2. ContactService Isolate 纯函数算法与格式解析测试', () {
    test('parseVcfIsolateTask 成功在后台 Isolate 格式解构 VCF 文本', () {
      const vcfData = '''
BEGIN:VCARD
VERSION:3.0
FN:王五
N:五;王;;;
TEL;TYPE=CELL:13800138005
EMAIL:wangwu@example.com
GROUP:Friends
PHOTO;BASE64:BASE64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==
END:VCARD
''';

      final parsedList = parseVcfIsolateTask(vcfData);
      expect(parsedList.length, equals(1));
      final map = parsedList.first;
      expect(map['name'], equals('王五'));
      expect(map['phoneNumbers'], contains('13800138005'));
      expect(map['email'], equals('wangwu@example.com'));
      expect(map['group'], equals('Friends'));
      expect(map['avatarBase64'], isNotNull);
    });

    test('parseCsvIsolateTask 成功解析 CSV 联系人表', () {
      const csvData = '''id,name,phoneNumbers,email
c201,赵六,13800001111;13800002222,zhao@example.com''';

      final parsedList = parseCsvIsolateTask(csvData);
      expect(parsedList.length, equals(1));
      final map = parsedList.first;
      expect(map['id'], equals('c201'));
      expect(map['name'], equals('赵六'));
      expect(map['phoneNumbers'], equals(['13800001111', '13800002222']));
      expect(map['email'], equals('zhao@example.com'));
    });

    test('parseYamlIsolateTask 成功解析 YAML 文本', () {
      const yamlData = '''
- id: "c301"
  name: "孙七"
  phoneNumbers: ["13700000000"]
  email: "sun@example.com"
''';

      final parsedList = parseYamlIsolateTask(yamlData);
      expect(parsedList.length, equals(1));
      expect(parsedList.first['name'], equals('孙七'));
    });

    test('exportJsonIsolateTask 与 exportCsvIsolateTask 编码器测试', () {
      final maps = [
        {
          'id': 'e1',
          'name': '周八',
          'phoneNumbers': ['13600000000'],
        }
      ];

      final jsonResult = exportJsonIsolateTask(maps);
      expect(jsonResult, contains('周八'));

      final csvResult = exportCsvIsolateTask(maps);
      expect(csvResult, contains('e1'));
      expect(csvResult, contains('周八'));
    });
  });

  group('🚀 3. ContactService 异步管理与合并逻辑测试', () {
    test('addContact 成功添加新联系人，重名/非法邮箱防护抛出异常', () async {
      final contact = Contact(
        id: 'c501',
        name: '钱九',
        phoneNumbers: ['13500000000'],
        email: 'qian@example.com',
      );

      await service.addContact(contact);
      final fetched = await service.getContactByPhoneNumber(PhoneNumber('13500000000'));
      expect(fetched, isNotNull);
      expect(fetched!.name, equals('钱九'));

      // 验证重复电话号码添加报错
      expect(
        () async => await service.addContact(contact),
        throwsA(isA<Exception>()),
      );
    });

    test('mergeContacts 成功合并联系人字段', () async {
      final c1 = Contact(id: 'm1', name: '合并人1', phoneNumbers: ['13100000001'], email: 'm1@test.com');
      final c2 = Contact(id: 'm2', name: '合并人2', phoneNumbers: ['13100000002'], group: 'MergedGroup');

      await service.addContact(c1);
      await service.addContact(c2);

      await service.mergeContacts([c1, c2]);

      final remaining = await repository.getAllContacts();
      expect(remaining.length, equals(1));
      expect(remaining.first.phoneNumbers, containsAll(['13100000001', '13100000002']));
      expect(remaining.first.group, equals('MergedGroup'));
    });

    test('saveAvatarIsolateTask 解码保存 Base64 头像数据', () async {
      final tempDir = Directory.systemTemp.createTempSync('avatar_test_');
      const sampleBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';

      final avatarPath = await saveAvatarIsolateTask({
        'imageData': sampleBase64,
        'dirPath': tempDir.path,
      });

      expect(avatarPath, isNotNull);
      final avatarFile = File(avatarPath!);
      expect(avatarFile.existsSync(), isTrue);
      expect(avatarFile.lengthSync(), greaterThan(0));

      tempDir.deleteSync(recursive: true);
    });
  });
}
