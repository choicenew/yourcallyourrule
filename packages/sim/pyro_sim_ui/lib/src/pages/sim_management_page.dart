import 'package:flutter/material.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';
import '../widgets/sim_card_badge.dart';

/// SIM card management and dual-SIM rule preference page.
class SimManagementPage extends StatefulWidget {
  const SimManagementPage({super.key});

  @override
  State<SimManagementPage> createState() => _SimManagementPageState();
}

class _SimManagementPageState extends State<SimManagementPage> {
  List<SimCardEntity> _simCards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSimInfo();
  }

  Future<void> _loadSimInfo() async {
    final cards = await SimHub.instance.getActiveSimCards();
    if (mounted) {
      setState(() {
        _simCards = cards;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('双卡管理与卡槽设置 (SIM Suite)'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  '检测到的双卡 SIM 状态',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (_simCards.isEmpty)
                  Card(
                    color: colorScheme.surfaceContainerHighest.withAlpha(80),
                    child: const ListTile(
                      leading: Icon(Icons.sim_card_alert),
                      title: Text('未检测到插入的 SIM 卡'),
                      subtitle: Text('请确认设备权限或 SIM 卡物理插入状态'),
                    ),
                  )
                else
                  ..._simCards.map((card) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: SimCardBadge(
                          slot: card.slotIndex,
                          carrierName: card.carrier.carrierName,
                        ),
                        title: Text(card.carrier.displayName.isNotEmpty ? card.carrier.displayName : 'SIM Subscription ${card.subscriptionId}'),
                        subtitle: Text('号码: ${card.phoneNumber.isNotEmpty ? card.phoneNumber : "未暴露"} | MCC/MNC: ${card.carrier.mcc}/${card.carrier.mnc}'),
                      ),
                    );
                  }),
              ],
            ),
    );
  }
}
