import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LabelDialog extends StatefulWidget {
  final CallLog log;

  const LabelDialog({super.key, required this.log});

  @override
  State<LabelDialog> createState() => _LabelDialogState();
}

class _LabelDialogState extends State<LabelDialog> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.addLabelToCall,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          // 电话号码信息
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  widget.log.number,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // 当前标签信息（如果有）
          if (widget.log.labelIds?.isNotEmpty == true)
            _buildCurrentLabels(),
          // 展开/折叠按钮
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isExpanded ? AppLocalizations.of(context)!.collapseLabelSelector : AppLocalizations.of(context)!.expandLabelSelector,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          // 标签选择器（可展开/折叠）
          if (_isExpanded) _buildLabelSelector(),
          // 底部按钮
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.close),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLabels() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.currentLabels, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          FutureBuilder<List<String?>>(
            future: LabelTextUtils.getMultipleLabelTexts(context, widget.log.labelIds!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
              }
              
              final labelTexts = snapshot.data ?? List.filled(widget.log.labelIds!.length, null);
              
              return Wrap(
                spacing: 8,
                children: List.generate(widget.log.labelIds!.length, (index) {
                  final labelId = widget.log.labelIds![index];
                  final labelText = labelTexts[index] ?? labelId;
                  
                  return Chip(
                    label: Text(labelText),
                    backgroundColor: const Color(0xFFF5A623).withValues(alpha:0.1),
                    labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => _removeLabel(labelId),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabelSelector() {
    return Expanded(
      child: PublicSelectLabel(
        initialLabelId: widget.log.labelIds?.isNotEmpty == true ? widget.log.labelIds!.first : null,
        phoneNumber: widget.log.number,
        onLabelIdChanged: _addLabel,
        themeColor: const Color(0xFFF5A623),
      ),
    );
  }

  Future<void> _removeLabel(String labelId) async {
    try {
      final callLogService = Provider.of<CallLogService>(context, listen: false);
      // 创建一个新的标签列表，排除要删除的标签
      final newLabelIds = List<String>.from(widget.log.labelIds ?? [])
        ..remove(labelId);
      
      // 创建更新后的通话记录
      final updatedLog = CallLog(
        id: widget.log.id,
        number: widget.log.number,
        timestamp: widget.log.timestamp,
        simDisplayName: widget.log.simDisplayName,
        callType: widget.log.callType,
        simSlotIndex: widget.log.simSlotIndex,
        carrierName: widget.log.carrierName,
        countryIso: widget.log.countryIso,
        subscriptionId: widget.log.subscriptionId,
        labelIds: newLabelIds,
      );
      
      // 更新通话记录
      await callLogService.updateLog(updatedLog);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelRemoved)),
        );
        // 刷新状态
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelRemoveFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> _addLabel(String labelId) async {
    try {
      // 获取标签服务和通话记录服务
      final callLogService = Provider.of<CallLogService>(context, listen: false);
      
      // 为通话记录添加标签
      await callLogService.addLabelToLog(widget.log, labelId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelUpdated)),
        );
        // 刷新状态
        setState(() {});
        // 关闭对话框
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelUpdateFailed(e.toString()))),
        );
      }
    }
  }
}