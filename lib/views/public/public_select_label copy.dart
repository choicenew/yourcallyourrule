import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// 定义一个通用的 LabelService 接口
abstract class LabelService {
  Future<List<String>> getAllLabels();
  Future<void> insertPredefinedLabelsIfNotExists(dynamic database);
}

class Labels extends StatefulWidget {
  final String? initialLabel;
  final String? phoneNumber;
  final ValueChanged<String> onLabelChanged;
  final LabelService labelService;

  const Labels({
    super.key,
    this.initialLabel,
    this.phoneNumber,
    required this.onLabelChanged,
    required this.labelService,
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
    final labels = await widget.labelService.getAllLabels();
    if (labels.isEmpty) {
      await widget.labelService.insertPredefinedLabelsIfNotExists(null);
      _labels = await widget.labelService.getAllLabels();
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
              backgroundColor: Colors.grey[300],
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