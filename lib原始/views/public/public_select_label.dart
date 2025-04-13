import 'package:flutter/material.dart';

import 'label_translation_extension.dart';

import '../../generated/l10n.dart';



// 定义一个通用的 SelectLabelService 接口
abstract class SelectLabelService {
  Future<List<String>> getAllLabels();
  Future<void> insertPredefinedLabelsIfNotExists(dynamic database);
}

// 这是适配器类，它将您现有的 ListService 适配到 SelectLabelService 接口
class ListServiceAdapter implements SelectLabelService {
  final dynamic listService;  // 这里可以是 BlacklistService, WhitelistService 等

  ListServiceAdapter(this.listService);

  @override
  Future<List<String>> getAllLabels() async {
    final labels = await listService.getAllLabels();
    if (labels.isEmpty) {
      await listService.insertPredefinedLabelsIfNotExists(listService.database);
      return await listService.getAllLabels(); // 重新获取标签
    } else {
      return labels;
    }
  }


  @override
  Future<void> insertPredefinedLabelsIfNotExists(dynamic database) {
    // 假设您的 ListService 已经有一个 insertPredefinedLabelsIfNotExists 方法
    return listService.insertPredefinedLabelsIfNotExists(database);
  }
}

// 修改后的 Labels 组件，使用 SelectLabelService 接口
class Labels extends StatefulWidget {
  final String? initialLabel;
  final String? phoneNumber;
  final ValueChanged<String> onLabelChanged;
  final SelectLabelService selectLabelService;

  const Labels({
    super.key,
    this.initialLabel,
    this.phoneNumber,
    required this.onLabelChanged,
    required this.selectLabelService,
  });

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  String? _selectedLabel;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.initialLabel;
    _initLabels();
  }

  Future<void> _initLabels() async {
    final labels = await widget.selectLabelService.getAllLabels();
    setState(() {
      _labels = labels;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).selectALabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _labels.map((label) {
          //  final translatedLabel = label;

          final translatedLabel = label.translate(context);
                  // 打印 label 和 translatedLabel 的值
        //print("Original label: $label");
       // print("Translated label: $translatedLabel");
        
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
              padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 5),
              color: const Color(0xFFFF8DA8),
              child: Text(
                '${S.of(context).selectedLabel}: $_selectedLabel',
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