import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/purchase/models/vip_exchange_rule_model.dart';
import 'package:yourcallyourrule/purchase/services/vip_exchange_service.dart';
import 'package:yourcallyourrule/purchase/widgets/vip_exchange_card.dart';

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
      appBar: AppBar(
        title: const Text('标记兑换VIP'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildMarkCountHeader(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: rules.length,
                    itemBuilder: (context, index) {
                      final rule = rules[index];
                      final canExchange = _canExchangeMap[rule.requiredMarks] ?? false;
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: VipExchangeRuleCard(
                          rule: rule,
                          canExchange: canExchange,
                          onExchange: () => _exchangeVip(rule),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
  
  // 构建标记计数头部
  Widget _buildMarkCountHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '当前标记次数',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '$_currentMarkCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '标记更多电话号码以获取更多次数',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}