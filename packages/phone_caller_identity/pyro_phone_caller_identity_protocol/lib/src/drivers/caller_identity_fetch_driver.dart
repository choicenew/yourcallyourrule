import 'package:pyro_phone_caller_identity_protocol/src/models/caller_id_data.dart';

/// 身份画像拉取 Driver 抽象接口契约 (CallerIdentityFetchDriver)
abstract class CallerIdentityFetchDriver {
  Future<CallerIdData?> fetchProfile(String phoneNumber);
}
