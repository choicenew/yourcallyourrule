import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ContactStorageDriver {
  Future<List<Map<String, dynamic>>> queryAll();
  Future<Map<String, dynamic>?> queryById(String id);
  Future<Map<String, dynamic>?> queryByPhoneNumber(String phoneNumber);
  Future<void> insert(Map<String, dynamic> data);
  Future<void> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
  Future<int> count();
}

final contactStorageDriverProvider = Provider<ContactStorageDriver>((ref) {
  throw UnimplementedError('contactStorageDriverProvider must be overridden or initialized');
});
