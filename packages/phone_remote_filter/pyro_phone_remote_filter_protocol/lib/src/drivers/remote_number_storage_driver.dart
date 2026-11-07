import 'package:pyro_phone_remote_filter_protocol/src/models/remote_number_entry.dart';

/// 远程号码持久化 Driver 抽象接口契约 (RemoteNumberStorageDriver)
abstract class RemoteNumberStorageDriver {
  Future<RemoteNumberEntry?> getByPhoneNumber(String phoneNumber);
  Future<void> saveRemoteNumber(RemoteNumberEntry entry);
  Future<List<RemoteNumberEntry>> getAllRemoteNumbers();
}
