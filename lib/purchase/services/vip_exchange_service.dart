// VIP兑换服务类，用于处理VIP兑换的业务逻辑

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import '../../data/repositories/label_mark_statistics_repository.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/label_mark_statistics_repository_provider.dart';
import '../models/vip_exchange_rule_model.dart';
import '../purchase_state.dart';

// VIP兑换服务提供者
final vipExchangeServiceProvider = Provider<VipExchangeService>((ref) {
  final purchaseState = ref.watch(purchaseStateProvider.notifier);
  final labelMarkStatisticsRepository = ref.watch(labelMarkStatisticsRepositoryProvider);
  return VipExchangeService(purchaseState, labelMarkStatisticsRepository);
});



// VIP兑换服务类
class VipExchangeService {
  final PurchaseState _purchaseState;
  final LabelMarkStatisticsRepository _statisticsRepository;

  // 兑换规则
  // 为了在静态列表中使用国际化，我们将其改为一个getter，这样可以在调用时获取上下文。
  // 这完全遵循了您在`MembershipFeatureService`中展示的模式。
  List<VipExchangeRule> get _exchangeRules {
    final context = AppRouter.navigatorKey.currentContext!;
    return [
      VipExchangeRule(
        requiredMarks: 10,
        days: 3,
        hasAds: true,
        hasSync: true,
        description: AppLocalizations.of(context)!.vip3DaysWithAds,
      ),
      VipExchangeRule(
        requiredMarks: 30,
        days: 5,
        hasAds: false,
        hasSync: true,
        description: AppLocalizations.of(context)!.vip5DaysNoAds,
      ),
      VipExchangeRule(
        requiredMarks: 40,
        days: 7,
        hasAds: false,
        hasSync: true,
        description: AppLocalizations.of(context)!.vip7DaysNoAds,
      ),
    ];
  }

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
    final context = AppRouter.navigatorKey.currentContext!;
    // 检查是否可以兑换
    final canExchangeVip = await canExchange(requiredMarks);
    if (!canExchangeVip) {
      return VipExchangeResult(
        success: false,
        message: AppLocalizations.of(context)!.marksInsufficient,
        currentMarks: await _statisticsRepository.getMarkCount(),
      );
    }

    // 获取兑换规则
    final rule = _exchangeRules.firstWhere(
      (rule) => rule.requiredMarks == requiredMarks,
      orElse:
          () =>
              throw Exception(
                AppLocalizations.of(context)!.invalidExchangeRule,
              ),
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
        message: AppLocalizations.of(
          context,
        )!.exchangeSuccess(rule.description, _formatDateTime(expiryDate)),
        currentMarks: 0,
        expiryDate: expiryDate,
      );
    } catch (e) {
      return VipExchangeResult(
        success: false,
        message: AppLocalizations.of(context)!.exchangeFailed(e.toString()),
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
