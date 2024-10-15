// Update WildcardPattern class (in models/wildcard_pattern.dart)
class WildcardPattern {
  final String name; // User-friendly name for the pattern
  final String pattern;
  final bool isBlacklisted;
  final bool enabled; // Flag to enable/disable the pattern

  WildcardPattern({
    required this.name,
    required this.pattern,
    required this.isBlacklisted,
    this.enabled = true,
  });

  factory WildcardPattern.fromJson(Map<String, dynamic> json) => WildcardPattern(
    name: json['name'],
    pattern: json['pattern'],
    isBlacklisted: json['is_blacklisted'] == 1,
    enabled: json['enabled'] == 1,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'pattern': pattern,
    'is_blacklisted': isBlacklisted ? 1 : 0,
    'enabled': enabled ? 1 : 0,
  };
}
