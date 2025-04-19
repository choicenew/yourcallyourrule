import 'package:sqflite/sqflite.dart';
import '../../../../../domain/entities/contact/contact.dart';
import '../../../../../domain/entities/base/phone_entry.dart';
import '../../../../../domain/value_objects/phone_number.dart';
import 'base_dao.dart';

/// 联系人数据访问对象
/// 负责联系人数据的数据库操作
class ContactDao extends BaseDao<Contact> {
  @override
  String get tableName => 'contacts';

  @override
  Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      phoneNumber: PhoneNumber(map['phone_number'] as String),
      name: map['name'] as String?,
      label: map['label'] as String?,
      avatar: map['avatar'] as String?,
      source: map['source'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap(Contact contact) {
    return {
      'id': contact.id,
      'phone_number': contact.phoneNumber.value,
      'name': contact.name,
      'label': contact.label,
      'avatar': contact.avatar,
      'source': contact.source,
      'created_at': contact.createdAt.millisecondsSinceEpoch,
      'updated_at': contact.updatedAt?.millisecondsSinceEpoch,
    };
  }

  /// 根据电话号码获取联系人
  Future<Contact?> getByPhoneNumber(String phoneNumber) async {
    final contacts = await query(
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
      limit: 1,
    );

    if (contacts.isEmpty) return null;
    return contacts.first;
  }

  /// 根据名称搜索联系人
  Future<List<Contact>> searchByName(String name) async {
    return await query(
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
  }

  /// 根据来源获取联系人
  Future<List<Contact>> getBySource(String source) async {
    return await query(
      where: 'source = ?',
      whereArgs: [source],
    );
  }

  /// 搜索联系人
  Future<List<Contact>> search(String query) async {
    return await this.query(
      where: 'name LIKE ? OR phone_number LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }

  /// 获取收藏的联系人
  Future<List<Contact>> getFavorites() async {
    return await query(
      where: 'is_favorite = ?',
      whereArgs: [1],
    );
  }

  /// 获取联系人总数
  Future<int> getCount() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
