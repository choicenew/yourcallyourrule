import '../models/user_risk_profile.dart';

/// 用户风控画像持久化抽象接口
abstract class IRiskProfileStorage {
  /// 加载指定用户的画像
  Future<UserRiskProfile?> loadProfile(String userId);

  /// 保存或更新画像
  Future<void> saveProfile(UserRiskProfile profile);

  /// 获取全部用户画像列表
  Future<List<UserRiskProfile>> getAllProfiles();

  /// 删除指定用户画像
  Future<void> deleteProfile(String userId);
}

/// 默认内存存储实现 (用于测试或无持久化环境)
class MemoryRiskProfileStorage implements IRiskProfileStorage {
  final Map<String, UserRiskProfile> _storage = {};

  @override
  Future<UserRiskProfile?> loadProfile(String userId) async {
    return _storage[userId]?.copyWith();
  }

  @override
  Future<void> saveProfile(UserRiskProfile profile) async {
    _storage[profile.userId] = profile.copyWith();
  }

  @override
  Future<List<UserRiskProfile>> getAllProfiles() async {
    return _storage.values.map((e) => e.copyWith()).toList();
  }

  @override
  Future<void> deleteProfile(String userId) async {
    _storage.remove(userId);
  }
}
