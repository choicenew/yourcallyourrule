import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../screens/appstate_provider.dart';

import '../../services/label_service.dart';


class Labels extends StatefulWidget {
  final String initialLabel;
  final String phoneNumber;
  final ValueChanged<String> onLabelChanged; // 简洁的回调函数名称

  const Labels({
    super.key,
    required this.initialLabel,
    required this.phoneNumber,
    required this.onLabelChanged,
  });

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  late LabelService _labelService;
  String? _selectedLabel;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _labelService = appState.labelService;
        _selectedLabel = widget.initialLabel;
    _initLabels();
  }

  Future<void> _initLabels() async {
    // 获取所有标签
    final labels = await _labelService.getAllLabels();
    if (labels.isEmpty) {
      await _labelService
          .insertPredefinedLabelsIfNotExists(_labelService.database);
      // 重新获取标签列表
      _labels = await _labelService.getAllLabels();
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
            // 判断当前标签是否为选中状态
            final translatedLabel = Intl.message(label); // 翻译标签
            final isSelected = label == _selectedLabel; // 判断是否选中
            // final isSelected = label == _selectedLabel;
            return ChoiceChip(
              label: Text(translatedLabel),
              // 根据是否选中设置不同的样式
              selected: isSelected,
              // 点击标签时触发的回调函数
              onSelected: (_) async {
                setState(() {
                  // 更新选中的标签
                  _selectedLabel = label;
                });
                // 更新黑名单条目的标签
                widget.onLabelChanged(label);
              },
              // 选中的标签显示蓝色
              selectedColor: Colors.green,
              // 未选中的标签显示灰色
              backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
        // 如果有选中的标签,显示选中的标签
        if (_selectedLabel != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${Intl.message('Selected Label')}: $_selectedLabel',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
      ],
    );
  }
}