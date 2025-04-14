import 'dart:convert';
import '../../../../../domain/entities/rule/rule_base.dart';
import '../../../../../domain/entities/rule/allowed_rule.dart';
import '../../../../../domain/entities/rule/blocked_rule.dart';
import '../../../../../domain/entities/rule/whitelist_rule.dart';
import '../../../../../domain/entities/rule/blacklist_rule.dart';
import '../../../../../domain/entities/rule/regex_rule.dart';
import '../../../../../domain/value_objects/rule_priority.dart';
import '../../../../../domain/value_objects/rule_action.dart';
import '../../../../../domain/value_objects/phone_number.dart';
import 'base_dao.dart';

/// 规则数据访问对象
/// 负责规则数据的数据库操作
class RuleDao extends BaseDao<RuleBase> {
  @override
  String get tableName => 'rules';
  
  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    final type = map['type'] as String;
    final id = map['id'] as String;
    final name = map['name'] as String;
    final description = map['description'] as String? ?? '';
    final isEnabled = (map['is_enabled'] as int) == 1;
    final createdAt = DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int);
    final updatedAt = map['updated_at'] != null
        ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
        : null;
    final priority = RulePriority.fromValue(map['priority'] as int);
    final action = RuleAction.fromValue(map['action'] as String);
    final source = map['source'] as String;
    
    switch (type) {
      case 'ALLOWED':
        final phoneNumber = PhoneNumber(map['phone_number'] as String);
        return AllowedRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          source: source,
          phoneNumber: phoneNumber,
        );
      
      // 其他 case 也需要移除 priority 和 action 参数
      case 'BLOCKED':
        final phoneNumber = PhoneNumber(map['phone_number'] as String);
        return BlockedRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          source: source,
          phoneNumber: phoneNumber,
        );
      
      case 'WHITELIST':
        final phoneNumber = PhoneNumber(map['phone_number'] as String);
        return WhitelistRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          source: source,
          phoneNumber: phoneNumber,
        );
      
      case 'BLACKLIST':
        final phoneNumber = PhoneNumber(map['phone_number'] as String);
        return BlacklistRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          source: source,
          phoneNumber: phoneNumber,
        );
      
      case 'REGEX':
        final pattern = map['pattern'] as String;
        return RegexRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          action: action,
          source: source,
          pattern: pattern,
        );
      
      default:
        throw Exception('未知的规则类型: $type');
    }
  }
  
  @override
  Map<String, dynamic> toMap(RuleBase rule) {
    final map = <String, dynamic>{
      'id': rule.id,
      'name': rule.name,
      'description': rule.description,
      'is_enabled': rule.isEnabled ? 1 : 0,
      'created_at': rule.createdAt.millisecondsSinceEpoch,
      'updated_at': rule.updatedAt?.millisecondsSinceEpoch,
      'priority': rule.priority.value,
      'action': rule.action.value,
      'source': rule.source,
    };
    
    if (rule is AllowedRule) {
      map['type'] = 'ALLOWED';
      map['phone_number'] = rule.phoneNumber.value;
    } else if (rule is BlockedRule) {
      map['type'] = 'BLOCKED';
      map['phone_number'] = rule.phoneNumber.value;
    } else if (rule is WhitelistRule) {
      map['type'] = 'WHITELIST';
      map['phone_number'] = rule.phoneNumber.value;
    } else if (rule is BlacklistRule) {
      map['type'] = 'BLACKLIST';
      map['phone_number'] = rule.phoneNumber.value;
    } else if (rule is RegexRule) {
      map['type'] = 'REGEX';
      map['pattern'] = rule.pattern;
    } else {
      throw Exception('未知的规则类型: ${rule.runtimeType}');
    }
    
    return map;
  }
  
  /// 根据规则类型获取规则
  Future<List<RuleBase>> getByType(String type) async {
    return await query(
      where: 'type = ?',
      whereArgs: [type],
    );
  }
  
  /// 获取所有启用的规则
  Future<List<RuleBase>> getAllEnabled() async {
    return await query(
      where: 'is_enabled = ?',
      whereArgs: [1],
    );
  }
  
  /// 根据优先级获取规则
  Future<List<RuleBase>> getByPriority(RulePriority priority) async {
    return await query(
      where: 'priority = ?',
      whereArgs: [priority.value],
    );
  }
  
  /// 根据电话号码获取规则
  Future<List<RuleBase>> getByPhoneNumber(String phoneNumber) async {
    return await query(
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );
  }
}