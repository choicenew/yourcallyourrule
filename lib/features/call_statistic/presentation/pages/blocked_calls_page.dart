// 保持原有页面逻辑不变，更新依赖路径
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';

import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/blocked_calls_chart.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


class BlockedCallsPage extends StatefulWidget {
  final BlockedCallRepository repository;

  const BlockedCallsPage({super.key, required this.repository});

  @override
  BlockedCallsPageState createState() => BlockedCallsPageState();
}

class BlockedCallsPageState extends State<BlockedCallsPage> with SingleTickerProviderStateMixin {
  List<BlockedCall> _blockedCalls = [];
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadBlockedCalls();
    
    // 监听标签变化，重新加载数据
    _tabController.addListener(_handleTabChange);
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
  
  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _loadBlockedCalls();
    }
  }

  Future<void> _loadBlockedCalls() async {
    List<BlockedCall> calls;
    
    // 根据当前标签加载不同类型的拦截记录
    switch (_tabController.index) {
      case 1: // 仅电话
        calls = await widget.repository.getBlockedCallsOnly();
        break;
      case 2: // 仅短信
        calls = await widget.repository.getBlockedSmsOnly();
        break;
      case 0: // 全部
      default:
        calls = await widget.repository.getBlockedCalls();
        break;
    }
    
    setState(() {
      _blockedCalls = calls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.blockedCallsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '全部'),
            Tab(text: '电话'),
            Tab(text: '短信'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlockedCallsChart(repository: widget.repository),
            ),
          ),
          const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: _blockedCalls.length,
              itemBuilder: (context, index) {
                final call = _blockedCalls[index];
                return ListTile(
                  leading: Icon(
                    call.type == BlockedType.call ? Icons.phone : Icons.sms,
                    color: call.type == BlockedType.call ? Colors.red : Colors.orange,
                  ),
                  title: Text(call.phoneNumber),
                  subtitle: Text(
                    '${call.timestamp.toString().substring(0, 16)} · ${call.type == BlockedType.call ? "电话" : "短信"}'
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
