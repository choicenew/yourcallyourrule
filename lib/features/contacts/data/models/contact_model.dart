import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

/// 全局统一使用 Protocol 提供的标准强实体 PhoneContactEntry
typedef Contact = PhoneContactEntry;

/// 实体兼容扩展，平滑适配主 App 历史代码中的属性访问
extension ContactEntityCompatibility on PhoneContactEntry {
  String get name => displayName;
  String? get avatar => photoUrl;
  bool get isFavorite => isStarred;
  List<String>? get labelIds => null;
  String? get email => null;
  String? get website => null;
  String? get group => null;
  String? get url => null;

  PhoneContactEntry copyWithFields({
    String? id,
    String? name,
    List<String>? phoneNumbers,
    String? avatar,
    bool? isFavorite,
  }) {
    return PhoneContactEntry(
      id: id ?? this.id,
      displayName: name ?? displayName,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      photoUrl: avatar ?? photoUrl,
      isStarred: isFavorite ?? isStarred,
    );
  }
}

/// 联系人数据模型，处理 LocalDatabase <-> PhoneContactEntry 转换
class ContactModel {
  final PhoneContactEntry entry;

  const ContactModel(this.entry);

  String get id => entry.id;
  String get name => entry.displayName;
  List<String> get phoneNumbers => entry.phoneNumbers;
  String? get avatar => entry.photoUrl;
  bool get isFavorite => entry.isStarred;
  List<String>? get labelIds => null;
  String? get url => null;

  PhoneContactEntry toEntity() => entry;

  factory ContactModel.fromEntity(PhoneContactEntry entity) => ContactModel(entity);

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    final rawPhones = map['phoneNumbers'];
    final phonesList = rawPhones is List
        ? List<String>.from(rawPhones)
        : (map['phoneNumber'] != null ? [map['phoneNumber'].toString()] : <String>[]);

    return ContactModel(
      PhoneContactEntry(
        id: (map['id'] as String?) ?? '',
        displayName: (map['displayName'] ?? map['name'] ?? '') as String,
        phoneNumbers: phonesList,
        photoUrl: (map['photoUrl'] ?? map['avatar']) as String?,
        isStarred: (map['isStarred'] ?? map['isFavorite'] ?? false) as bool,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': entry.id,
      'name': entry.displayName,
      'displayName': entry.displayName,
      'phoneNumbers': entry.phoneNumbers,
      'avatar': entry.photoUrl,
      'photoUrl': entry.photoUrl,
      'isFavorite': entry.isStarred,
      'isStarred': entry.isStarred,
    };
  }

  ContactModel copyWith({
    String? id,
    String? name,
    List<String>? phoneNumbers,
    String? avatar,
    bool? isFavorite,
    List<String>? labelIds,
    String? url,
  }) {
    return ContactModel(
      PhoneContactEntry(
        id: id ?? entry.id,
        displayName: name ?? entry.displayName,
        phoneNumbers: phoneNumbers ?? entry.phoneNumbers,
        photoUrl: avatar ?? entry.photoUrl,
        isStarred: isFavorite ?? entry.isStarred,
      ),
    );
  }
}