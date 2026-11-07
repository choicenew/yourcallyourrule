import 'package:pyro_caller_identity_protocol/src/models/caller_profile.dart';

/// 身份画像拉取 Driver 抽象接口契约 (CallerIdentityFetchDriver)
abstract class CallerIdentityFetchDriver {
  Future<CallerProfile?> fetchProfile(String phoneNumber);
}
