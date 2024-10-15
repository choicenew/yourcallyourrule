import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../screens/appstate_provider.dart';
import '../../services/blacklist_whitelist_service.dart';




class BlacklistLabels extends StatefulWidget {
  final String? initialLabel; // 可选参数
  final String? phoneNumber; // 可选参数
  final ValueChanged<String> onLabelChanged;

  const BlacklistLabels({
    super.key,
    this.initialLabel, // 可选参数
    this.phoneNumber, // 可选参数
    required this.onLabelChanged,
  });

  @override
  State<BlacklistLabels> createState() => _BlacklistLabelsState();
}

class _BlacklistLabelsState extends State<BlacklistLabels> {
  late BlacklistService _blacklistService;
  String? _selectedLabel; 
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _blacklistService = appState.blacklistService;
    _selectedLabel = widget.initialLabel; // 使用传入的 initialLabel 初始化
    _initLabels();
  }

  Future<void> _initLabels() async {
    // 获取所有标签
    final labels = await _blacklistService.getAllLabels();
    if (labels.isEmpty) {
      await _blacklistService
          .insertPredefinedLabelsIfNotExists(_blacklistService.database);
      // 重新获取标签列表
      _labels = await _blacklistService.getAllLabels();
    } else {
      _labels = labels;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Intl.message('Select a label:'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _labels.map((label) {
            final translatedLabel = Intl.message(label); 
            final isSelected = label == _selectedLabel; 
            return ChoiceChip(
              label: Text(translatedLabel),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedLabel = label; 
                  });
                  widget.onLabelChanged(label);
                }
              },
              selectedColor: Colors.green,
              //backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
        if (_selectedLabel != null)
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    padding: const EdgeInsets.only(left:10.0, top:5, right:10, bottom:5), // 添加内边距
    color: const Color(0xFFFF8DA8), // 设置背景色，例如浅灰色
    child: Text(
      '${Intl.message('Selected Label')}: $_selectedLabel',
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
      ],
    );
  }
}