import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../screens/appstate_provider.dart';
import '../../services/label_service.dart';

class Labels extends StatefulWidget {
  final String? initialLabel; // 可选参数
  final String? phoneNumber; // 可选参数
  final ValueChanged<String> onLabelChanged;

  const Labels({
    super.key,
    this.initialLabel, // 可选参数
    this.phoneNumber, // 可选参数
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
        const Text(
          'Select a label:',
          style: TextStyle(
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
            return ChoiceChip(
              label: Text(translatedLabel),
              // 根据是否选中设置不同的样式
              selected: isSelected,
              // 点击标签时触发的回调函数
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedLabel = label;
                  });
                  widget.onLabelChanged(label);
                }
              },
              // 选中的标签显示蓝色
              selectedColor: Colors.green,
              backgroundColor: Colors.grey[300], // 未选中的标签显示灰色
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
