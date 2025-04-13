import 'package:flutter/material.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

class SimInfoListWidget extends StatefulWidget {
  const SimInfoListWidget({super.key});

  @override
  State<SimInfoListWidget> createState() => _SimInfoListWidgetState();
}

class _SimInfoListWidgetState extends State<SimInfoListWidget> {
  List<SimInfo> _simInfoList = <SimInfo>[];

  @override
  void initState() {
    super.initState();
    _getSimInfo(); // 初始化时获取 SIM 卡信息
  }

  Future<void> _getSimInfo() async {
    final SimCardInfo simCardInfoPlugin = SimCardInfo();
    final List<SimInfo> simInfoList =
        await simCardInfoPlugin.getSimInfo() ?? <SimInfo>[];
    setState(() {
      _simInfoList = simInfoList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 显示所有 SIM 卡信息
    final List<Widget> simInfoWidgets = _simInfoList
        .map((SimInfo simInfo) => Text(
            'SIM ${simInfo.slotIndex}: ${simInfo.displayName}: ${simInfo.countryIso}',
           // style: const TextStyle(fontFamily: 'monospace')
            )) // 使用 monospace 字体
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // SIM 卡信息部分
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: simInfoWidgets,
          ),
        ],
      ),
    );
  }
}