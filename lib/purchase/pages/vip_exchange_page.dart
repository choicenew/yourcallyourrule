import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/models/vip_exchange_rule_model.dart';
import 'package:yourcallyourrule/purchase/services/vip_exchange_service.dart';
import 'package:yourcallyourrule/purchase/widgets/vip_exchange_card.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

/// VIP兑换页面
/// 用于显示VIP兑换规则和执行兑换操作
class VipExchangePage extends ConsumerStatefulWidget {
  const VipExchangePage({super.key});

  @override
  ConsumerState<VipExchangePage> createState() => _VipExchangePageState();
}

class _VipExchangePageState extends ConsumerState<VipExchangePage> {
  int _currentMarkCount = 0;
  bool _isLoading = true;
  Map<int, bool> _canExchangeMap = {};
  
  @override
  void initState() {
    super.initState();
    _loadMarkCount();
  }
  
  // 加载标记计数
  Future<void> _loadMarkCount() async {
    final vipExchangeService = ref.read(vipExchangeServiceProvider);
    final markCount = await vipExchangeService.getMarkCount();
    
    // 检查每个规则是否可以兑换
    final rules = vipExchangeService.getAvailableExchangeRules();
    final canExchangeMap = <int, bool>{};
    
    for (final rule in rules) {
      canExchangeMap[rule.requiredMarks] = markCount >= rule.requiredMarks;
    }
    
    if (mounted) {
      setState(() {
        _currentMarkCount = markCount;
        _canExchangeMap = canExchangeMap;
        _isLoading = false;
      });
    }
  }
  
  // 执行兑换
  Future<void> _exchangeVip(VipExchangeRule rule) async {
    setState(() {
      _isLoading = true;
    });
    
    final vipExchangeService = ref.read(vipExchangeServiceProvider);
    final result = await vipExchangeService.exchangeVip(rule.requiredMarks);
    
    if (mounted) {
      setState(() {
        _currentMarkCount = result.currentMarks;
        _isLoading = false;
      });
      
      // 显示结果消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.success ? Colors.green : Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(8),
        ),
      );
      
      // 如果兑换成功，更新所有规则的可兑换状态
      if (result.success) {
        await _loadMarkCount();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vipExchangeService = ref.watch(vipExchangeServiceProvider);
    final rules = vipExchangeService.getAvailableExchangeRules();
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.redeemVipWithMarks,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : Column(
              children: [
                _buildMarkCountHeader(context),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: rules.length,
                    itemBuilder: (context, index) {
                      final rule = rules[index];
                      final canExchange = _canExchangeMap[rule.requiredMarks] ?? false;
                      
                      return VipExchangeRuleCard(
                        rule: rule,
                        canExchange: canExchange,
                        onExchange: () => _exchangeVip(rule),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
  
  // 构建标记计数头部
  Widget _buildMarkCountHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFF5E3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9500).withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.currentMarkCount,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            '$_currentMarkCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.markMoreNumbersForMore,
            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}