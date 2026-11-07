import 'package:json_annotation/json_annotation.dart';

part 'shadow_identity.g.dart';

/// 影子身份性别固定枚举 (0 字符串魔数)
enum ShadowGender {
  unspecified('unspecified'),
  male('male'),
  female('female');

  final String value;
  const ShadowGender(this.value);

  static ShadowGender fromValue(String? val) {
    if (val == 'male') return ShadowGender.male;
    if (val == 'female') return ShadowGender.female;
    return ShadowGender.unspecified;
  }
}

/// 影子身份通用配置键 Token (0 字符串硬编码)
abstract final class ShadowConfigKey {
  static const String gender = 'gender';
  static const String age = 'age';
  static const String interestKeywords = 'interest_keywords';
  static const String persona = 'persona';

  /// 归一化强类型词库解析方法 (下沉于 pyro_shadow_identity 微包)
  static List<String> parseKeywordList(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const [];
    return raw
        .split(RegExp(r'[,，、画;；·・•|/\n\r\t]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}

@JsonSerializable()
class ShadowIdentity {
  /// Unique identifier (Shadow ID)
  final String id;
  
  /// Display name for the identity
  final String name;

  /// 是否为人格化媒体账户 (强类型 0 字符串 Map 提取)
  final bool isPersonaAccount;

  /// 账号私有兴趣关键词词库 (强类型 0 字符串 Map 提取)
  final List<String> interestKeywords;
  
  /// Custom metadata (avatar, gender, age etc.)
  final Map<String, dynamic> metadata;
  
  /// When this identity was created
  final DateTime createdAt;
  
  /// Last time this identity was accessed
  final DateTime lastAccessedAt;

  ShadowIdentity({
    required this.id,
    required this.name,
    this.isPersonaAccount = false,
    this.interestKeywords = const [],
    this.metadata = const {},
    required this.createdAt,
    required this.lastAccessedAt,
  });

  factory ShadowIdentity.fromJson(Map<String, dynamic> json) => _$ShadowIdentityFromJson(json);
  Map<String, dynamic> toJson() => _$ShadowIdentityToJson(this);

  bool get isPersona => isPersonaAccount;

  ShadowIdentity copyWith({
    String? name,
    bool? isPersonaAccount,
    List<String>? interestKeywords,
    Map<String, dynamic>? metadata,
    DateTime? lastAccessedAt,
  }) {
    return ShadowIdentity(
      id: id,
      name: name ?? this.name,
      isPersonaAccount: isPersonaAccount ?? this.isPersonaAccount,
      interestKeywords: interestKeywords ?? this.interestKeywords,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
    );
  }
}
