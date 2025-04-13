import '../../../../common/error/exceptions.dart';
import './api_client.dart';

/// 规则API
/// 负责与远程服务器进行规则相关的通信
class RuleApi {
  final ApiClient _apiClient;
  
  RuleApi({required ApiClient apiClient}) : _apiClient = apiClient;
  
  /// 获取白名单规则
  Future<List<Map<String, dynamic>>> getWhitelistRules() async {
    try {
      final response = await _apiClient.get('rules/whitelist');
      return List<Map<String, dynamic>>.from(response['data'] ?? []);
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('获取白名单规则失败: $e');
    }
  }
  
  /// 获取黑名单规则
  Future<List<Map<String, dynamic>>> getBlacklistRules() async {
    try {
      final response = await _apiClient.get('rules/blacklist');
      return List<Map<String, dynamic>>.from(response['data'] ?? []);
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('获取黑名单规则失败: $e');
    }
  }
  
  /// 获取正则表达式规则
  Future<List<Map<String, dynamic>>> getRegexRules() async {
    try {
      final response = await _apiClient.get('rules/regex');
      return List<Map<String, dynamic>>.from(response['data'] ?? []);
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('获取正则表达式规则失败: $e');
    }
  }
  
  /// 订阅规则
  Future<bool> subscribeRules(String subscriptionUrl) async {
    try {
      final response = await _apiClient.post('rules/subscribe', body: {
        'subscription_url': subscriptionUrl,
      });
      return response['success'] ?? false;
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('订阅规则失败: $e');
    }
  }
  
  /// 取消订阅规则
  Future<bool> unsubscribeRules(String subscriptionId) async {
    try {
      final response = await _apiClient.delete('rules/subscribe/$subscriptionId');
      return response['success'] ?? false;
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('取消订阅规则失败: $e');
    }
  }
  
  /// 获取规则订阅列表
  Future<List<Map<String, dynamic>>> getRuleSubscriptions() async {
    try {
      final response = await _apiClient.get('rules/subscriptions');
      return List<Map<String, dynamic>>.from(response['data'] ?? []);
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('获取规则订阅列表失败: $e');
    }
  }
  
  /// 同步规则
  Future<Map<String, dynamic>> syncRules() async {
    try {
      final response = await _apiClient.post('rules/sync');
      return Map<String, dynamic>.from(response);
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('同步规则失败: $e');
    }
  }
  
  /// 报告垃圾号码
  Future<bool> reportSpamNumber(String phoneNumber, String description) async {
    try {
      final response = await _apiClient.post('rules/report', body: {
        'phone_number': phoneNumber,
        'description': description,
      });
      return response['success'] ?? false;
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException('报告垃圾号码失败: $e');
    }
  }
}