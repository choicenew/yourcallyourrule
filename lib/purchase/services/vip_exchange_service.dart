// VIP兑换服务类，用于处理VIP兑换的业务逻辑

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/label_mark_statistics_repository.dart';
import '../../data/datasources/local/local_label_mark_statistics_datasource.dart';
import '../../data/database/local/local_database_manager.dart';
import '../models/vip_exchange_rule_model.dart';
import '../purchase_state.dart';

// VIP兑换服务提供者
final vipExchangeServiceProvider = Provider<VipExchangeService>((ref) {
  final purchaseState = ref.watch(purchaseStateProvider.notifier);
  final labelMarkStatisticsRepository = LabelMarkStatisticsRepositoryImpl(
    LocalLabelMarkStatisticsDataSource(LocalDatabaseManagerImpl())
  );
  return VipExchangeService(purchaseState, labelMarkStatisticsRepository);
});

// 标记统计服务提供者
final labelMarkStatisticsRepositoryProvider = Provider<LabelMarkStatisticsRepository>((ref) {
  return LabelMarkStatisticsRepositoryImpl(
    LocalLabelMarkStatisticsDataSource(LocalDatabaseManagerImpl())
  );
});

// VIP兑换服务类
class VipExchangeService {
  final PurchaseState _purchaseState;
  final LabelMarkStatisticsRepository _statisticsRepository;
  
  // 兑换规则
  static final List<VipExchangeRule> _exchangeRules = [
    const VipExchangeRule(
      requiredMarks: 10,
      days: 3,
      hasAds: true,
      hasSync: true,
      description: '3天带广告VIP（仅同步）',
    ),
    const VipExchangeRule(
      requiredMarks: 30,
      days: 5,
      hasAds: false,
      hasSync: true,
      description: '5天全功能无广告VIP',
    ),
    const VipExchangeRule(
      requiredMarks: 40,
      days: 7,
      hasAds: false,
      hasSync: true,
      description: '7天全功能无广告VIP',
    ),
  ];
  
  // 构造函数
  VipExchangeService(this._purchaseState, this._statisticsRepository);
  
  // 获取可用的兑换规则
  List<VipExchangeRule> getAvailableExchangeRules() {
    return _exchangeRules;
  }
  
  // 检查是否可以兑换
  Future<bool> canExchange(int requiredMarks) async {
    final currentMarks = await _statisticsRepository.getMarkCount();
    return currentMarks >= requiredMarks;
  }
  
  // 兑换VIP
  Future<VipExchangeResult> exchangeVip(int requiredMarks) async {
    // 检查是否可以兑换
    final canExchangeVip = await canExchange(requiredMarks);
    if (!canExchangeVip) {
      return VipExchangeResult(
        success: false,
        message: '标记次数不足，无法兑换',
        currentMarks: await _statisticsRepository.getMarkCount(),
      );
    }
    
    // 获取兑换规则
    final rule = _exchangeRules.firstWhere(
      (rule) => rule.requiredMarks == requiredMarks,
      orElse: () => throw Exception('无效的兑换规则'),
    );
    
    try {
      // 计算VIP到期时间
      final expiryDate = DateTime.now().add(Duration(days: rule.days));
      
      // 更新购买状态
      if (!rule.hasAds) {
        // 全功能无广告VIP
        await _purchaseState.updatePurchaseState(true);
        await _purchaseState.updateTempPurchaseState(true, expiryDate);
      } else {
        // 带广告VIP（仅同步）
        await _purchaseState.updatePurchaseState(false);
        await _purchaseState.updateTempPurchaseState(true, expiryDate);
      }
      
      // 重置标记计数
      await _statisticsRepository.resetMarkCount();
      
      return VipExchangeResult(
        success: true,
        message: '成功兑换${rule.description}，到期时间：${_formatDateTime(expiryDate)}',
        currentMarks: 0,
        expiryDate: expiryDate,
      );
    } catch (e) {
      return VipExchangeResult(
        success: false,
        message: '兑换失败：$e',
        currentMarks: await _statisticsRepository.getMarkCount(),
      );
    }
  }
  
  // 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  
  // 获取标记计数流
  Stream<int> get markCountStream => _statisticsRepository.markCountStream;
  
  // 获取当前标记计数
  Future<int> getMarkCount() => _statisticsRepository.getMarkCount();
}