import 'dart:async';
import '../models/risk_types.dart';
import '../models/user_risk_profile.dart';
import '../models/user_risk_interaction.dart';
import '../calculators/user_risk_calculator.dart';
import '../storage/risk_profile_storage.dart';

/// 用户风控画像与等级总控管理器
class RiskProfileManager {
  final IRiskProfileStorage _storage;
  final UserRiskCalculator _calculator;
  final void Function(String message)? _onLog;

  String _currentUserId;
  UserRiskProfile? _currentProfile;
  Set<String> _sensitiveKeywords = {};

  final _levelController = StreamController<int>.broadcast();
  final _profileController = StreamController<UserRiskProfile>.broadcast();

  /// 构造函数
  RiskProfileManager({
    IRiskProfileStorage? storage,
    UserRiskCalculator calculator = UserRiskCalculator.defaultCalculator,
    String defaultUserId = 'primary_user',
    Set<String> sensitiveKeywords = const {},
    void Function(String message)? onLog,
  })  : _storage = storage ?? MemoryRiskProfileStorage(),
        _calculator = calculator,
        _currentUserId = defaultUserId,
        _sensitiveKeywords = Set.from(sensitiveKeywords),
        _onLog = onLog;

  /// 等级变更广播流
  Stream<int> get onLevelChanged => _levelController.stream;

  /// 画像完整变更广播流
  Stream<UserRiskProfile> get onProfileChanged => _profileController.stream;

  /// 当前用户 ID
  String get currentUserId => _currentUserId;

  /// 当前同步等级 (0 ~ 5)
  int get currentLevel => _currentProfile?.sensitivityLevel ?? 0;

  /// 当前等级枚举
  UserSensitivityLevel get currentSensitivity =>
      _currentProfile?.sensitivityLevelEnum ?? UserSensitivityLevel.level0_pure;

  /// 当前用户完整画像
  UserRiskProfile? get currentProfile => _currentProfile;

  /// 动态更新敏感词配置 (由远程配置或安全引擎下发)
  void updateSensitiveKeywords(Set<String> newKeywords) {
    _sensitiveKeywords = Set.from(newKeywords);
    _log('[RiskProfileManager] Updated Sensitive Keywords: count=${_sensitiveKeywords.length}');
  }

  /// 初始化当前用户画像
  Future<void> initialize({String? userId}) async {
    if (userId != null) {
      _currentUserId = userId;
    }
    await _loadOrCreateProfile(_currentUserId);
  }

  /// 切换用户/影子身份
  Future<void> switchUser(String newUserId) async {
    if (_currentUserId == newUserId && _currentProfile != null) return;
    _currentUserId = newUserId;
    await _loadOrCreateProfile(newUserId);
  }

  /// 处理单次用户交互行为并进行风控计分
  Future<void> processInteraction(UserRiskInteraction interaction) async {
    if (_currentProfile == null) {
      await initialize();
    }

    // 1. 计算当前单次行为得分
    final score = _calculator.calculateInteractionScore(
      interaction,
      sensitiveKeywords: _sensitiveKeywords,
    );

    if (score <= 0) return; // 忽略无敏感度行为

    // 2. 累加总分并更新
    final profile = _currentProfile!;
    final oldLevel = profile.sensitivityLevel;
    profile.sensitivityScore += score;
    profile.lastLevelUpdate = DateTime.now();

    // 3. 判定是否升降级
    final newLevel = _calculator.determineLevel(
      oldLevel,
      profile.sensitivityScore,
    );

    if (newLevel != oldLevel) {
      _log('[RiskProfileManager] LEVEL CHANGE: $oldLevel -> $newLevel (Score: ${profile.sensitivityScore})');
      profile.sensitivityLevel = newLevel;
      _levelController.add(newLevel);
    }

    // 4. 保存并通知
    await _storage.saveProfile(profile);
    _profileController.add(profile);
  }

  /// 手动调整/重置用户风控等级
  Future<void> manualUpdateLevel(int newLevel, {double? newScore}) async {
    if (_currentProfile == null) await initialize();
    final profile = _currentProfile!;
    final oldLevel = profile.sensitivityLevel;
    profile.sensitivityLevel = newLevel;
    if (newScore != null) {
      profile.sensitivityScore = newScore;
    }
    profile.lastLevelUpdate = DateTime.now();

    if (newLevel != oldLevel) {
      _levelController.add(newLevel);
    }
    await _storage.saveProfile(profile);
    _profileController.add(profile);
  }

  /// 内部加载或创建画像
  Future<void> _loadOrCreateProfile(String userId) async {
    var profile = await _storage.loadProfile(userId);
    if (profile == null) {
      profile = UserRiskProfile(userId: userId);
      await _storage.saveProfile(profile);
      _log('[RiskProfileManager] Created default profile for userId: $userId');
    } else {
      _log('[RiskProfileManager] Loaded profile for userId: $userId, level: ${profile.sensitivityLevel}');
    }
    _currentProfile = profile;
    _levelController.add(profile.sensitivityLevel);
    _profileController.add(profile);
  }

  void _log(String message) {
    _onLog?.call(message);
  }

  /// 释放资源
  void dispose() {
    _levelController.close();
    _profileController.close();
  }
}
