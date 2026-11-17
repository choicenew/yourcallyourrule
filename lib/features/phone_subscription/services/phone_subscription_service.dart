import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:yourcallyourrule/features/phone_subscription/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/features/phone_subscription/data/repositories/subscription_repository_impl.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'phone_subscription_service.g.dart';

/// PhoneSubscriptionService Riverpod Provider
@Riverpod(keepAlive: true)
PhoneSubscriptionService phoneSubscriptionService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return PhoneSubscriptionService(
    SubscriptionRepositoryImpl(db),
    RuleRepositoryImpl(db),
  );
}

/// 电话规则订阅服务
class PhoneSubscriptionService {
  final SubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  PhoneSubscriptionService(
    this._repository,
    this._ruleRepository,
  );

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return [];
    }
  }

  Future<List<PhoneSubscriptionPayload>> getEnabledSubscriptions() async {
    final all = await getAll();
    return all.where((s) => s.displayName != null).toList();
  }

  Future<PhoneSubscriptionPayload> addSubscription(String name, String url, {bool isEnabled = true}) async {
    final payloadId = _uuid.v4();
    final subscription = PhoneSubscriptionPayload(
      payloadId: payloadId,
      kind: PhoneSubscriptionKind.phoneRules,
      rawJsonMap: {
        'displayName': name,
        'downloadUrl': url,
        'isEnabled': isEnabled,
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    return await _repository.save(subscription);
  }

  Future<bool> deleteSubscription(String id) async {
    final all = await _ruleRepository.getAll();
    final subRules = all.where((r) => r.subscriptionId == id).toList();
    if (subRules.isNotEmpty) {
      await _ruleRepository.deleteAll(subRules);
    }
    return await _repository.deleteById(id);
  }

  Future<List<PhoneRuleEntity>> updateRulesFromSubscription(PhoneSubscriptionPayload subscription) async {
    final downloadUrl = subscription.downloadUrl;
    if (downloadUrl != null && downloadUrl.isNotEmpty) {
      try {
        final downloadedRules = await _downloadAndParseRules(downloadUrl, subscription.payloadId, subscription.displayName);
        if (downloadedRules.isNotEmpty) {
          final allRules = await _ruleRepository.getAll();
          final oldRules = allRules.where((r) => r.subscriptionId == subscription.payloadId).toList();
          if (oldRules.isNotEmpty) {
            await _ruleRepository.deleteAll(oldRules);
          }
          await _ruleRepository.saveAll(downloadedRules);
          debugPrint('[PhoneSubscriptionService] 已成功解析并入库 ${downloadedRules.length} 条规则 (订阅: ${subscription.displayName})');
        }
      } catch (e) {
        debugPrint('[PhoneSubscriptionService] 下载或保存规则失败: $e');
      }
    }
    await PhoneRulesSubscriptionControlCenter.instance.dispatchPayload(subscription);
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.subscriptionId == subscription.payloadId).toList();
  }

  Future<List<PhoneRuleEntity>> _downloadAndParseRules(String url, String subscriptionId, String? displayName) async {
    String? body;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        body = response.body;
      } else if (response.statusCode == 404 && url.contains('fcc_robocall.json')) {
        final fallbackUrl = url.replaceAll('fcc_robocall.json', 'full_block.json');
        final fbResponse = await http.get(Uri.parse(fallbackUrl)).timeout(const Duration(seconds: 15));
        if (fbResponse.statusCode == 200) {
          body = fbResponse.body;
        }
      }
    } catch (e) {
      debugPrint('[PhoneSubscriptionService] HTTP 获取失败: $e');
    }

    if (body == null || body.trim().isEmpty) return [];

    final decoded = jsonDecode(body);
    List rawList = [];
    if (decoded is List) {
      rawList = decoded;
    } else if (decoded is Map<String, dynamic>) {
      if (decoded['rules'] is List) {
        rawList = decoded['rules'] as List;
      } else if (decoded['rulesets'] is List) {
        rawList = decoded['rulesets'] as List;
      }
    }

    final List<PhoneRuleEntity> result = [];
    for (final item in rawList) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final phone = map['phoneNumber'] ?? map['phone_number'] ?? map['pattern'] ?? map['number'];
      if (phone == null || phone.toString().trim().isEmpty) continue;

      final isEnabledVal = map['isEnabled'] ?? map['is_enabled'];
      final isEnabled = isEnabledVal == true || isEnabledVal == 1 || isEnabledVal == '1' || isEnabledVal == 'true' || isEnabledVal == null;

      final actionStr = (map['action'] ?? map['actionType'] ?? 'block').toString().toLowerCase().trim();
      final actionType = actionStr.contains('allow') ? 'allow' : 'block';

      final entity = PhoneRuleEntity(
        id: map['id']?.toString() ?? _uuid.v4(),
        name: map['name']?.toString() ?? displayName ?? 'Subscribed Rule',
        phoneNumber: phone.toString().trim(),
        labelId: map['labelId']?.toString() ?? map['label_id']?.toString() ?? '',
        avatar: map['avatar']?.toString(),
        subscriptionId: subscriptionId,
        actionType: actionType,
        priority: (map['priority'] is num) ? (map['priority'] as num).toInt() : 100,
        count: (map['count'] is num) ? (map['count'] as num).toInt() : 0,
        isEnabled: isEnabled,
      );
      result.add(entity);
    }
    return result;
  }
}
