// 保持原有页面逻辑不变，更新依赖路径
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call_history/domain/repositories/blocked_call_repository.dart';

import 'package:yourcallyourrule/features/call_history/presentation/widgets/blocked_calls_chart.dart';


class BlockedCallsPage extends StatefulWidget {
  final BlockedCallRepository repository;

  const BlockedCallsPage({super.key, required this.repository});

  @override
  BlockedCallsPageState createState() => BlockedCallsPageState();
}

class BlockedCallsPageState extends State<BlockedCallsPage> {
  List<BlockedCall> _blockedCalls = [];

  @override
  void initState() {
    super.initState();
    _loadBlockedCalls();
  }

  Future<void> _loadBlockedCalls() async {
    final calls = await widget.repository.getBlockedCalls();
    setState(() {
      _blockedCalls = calls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocked Calls'),
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
                  title: Text(call.phoneNumber),
                  subtitle: Text(call.timestamp.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
