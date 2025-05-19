import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';

/// 标签过滤芯片组件
/// 显示当前选中的标签文本，并提供删除功能
class LabelFilterChip extends StatelessWidget {
  final String labelId;
  final VoidCallback onDeleted;
  final Color themeColor;

  const LabelFilterChip({
    super.key,
    required this.labelId,
    required this.onDeleted,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<String>(
            future: _getLabelText(context),
            builder: (context, snapshot) {
              final labelText = snapshot.data ?? labelId;
              return Chip(
                label: Text('标签: $labelText'),
                backgroundColor: themeColor.withOpacity(0.1),
                labelStyle: TextStyle(color: themeColor),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: onDeleted,
              );
            },
          ),
        ],
      ),
    );
  }

  /// 根据标签ID获取标签文本
  Future<String> _getLabelText(BuildContext context) async {
    // 使用LabelTextUtils工具类获取标签文本
    final labelText = await LabelTextUtils.getLabelTextById(context, labelId);
    return labelText ?? labelId;
  }
}
