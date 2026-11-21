import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_storage_driver.g.dart';

abstract class ContactStorageDriver {
  Future<List<Map<String, dynamic>>> queryAll();
  Future<Map<String, dynamic>?> queryById(String id);
  Future<Map<String, dynamic>?> queryByPhoneNumber(String phoneNumber);
  Future<void> insert(Map<String, dynamic> data);
  Future<void> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
  Future<int> count();
}

@Riverpod(keepAlive: true)
ContactStorageDriver contactStorageDriver(Ref ref) {
  throw UnimplementedError('contactStorageDriver must be overridden or initialized');
}
