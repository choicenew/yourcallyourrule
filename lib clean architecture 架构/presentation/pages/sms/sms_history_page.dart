import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/sms/sms_message.dart';
import '../../state/providers/sms_provider.dart';
import '../../../../lib/presentation/widgets/sms/sms_item.dart';
import '../base_page.dart';
import '../../../../lib/presentation/pages/sms/sms_detail_page.dart';

/// 短信历史页面
/// 用于展示和管理短信记录
class SmsHistoryPage extends BasePage {
  const SmsHistoryPage({Key? key}) : super(key: key);

  @override
  String get title => '短信记录';

  @override
  Widget buildContent(BuildContext context) {
    final smsProvider = Provider.of<SmsProvider>(context);
    final smsMessages = smsProvider.smsMessages;

    return Column(
      children: [
        _buildFilterBar(context),
        Expanded(
          child: smsMessages.isEmpty
              ? _buildEmptyState(context)
              : _buildSmsList(context, smsMessages),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
          tooltip: '搜索',
        ),
        IconButton(
          icon: const Icon(Icons.delete_sweep),
          onPressed: () => _showClearConfirmDialog(context),
          tooltip: '清除记录',
        ),
      ],
    );
  }

  // 构建筛选栏
  Widget _buildFilterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          const Icon(Icons.filter_list, color: Colors.grey),
          const SizedBox(width: 8),
          const Text('筛选：'),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(context, '全部', true),
                  _buildFilterChip(context, '收件箱', false),
                  _buildFilterChip(context, '发件箱', false),
                  _buildFilterChip(context, '已拦截', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建筛选芯片
  Widget _buildFilterChip(BuildContext context, String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (isSelected) {
          // 实现筛选逻辑
        },
      ),
    );
  }

  // 构建短信列表
  Widget _buildSmsList(BuildContext context, List<SmsMessage> smsMessages) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: smsMessages.length,
      itemBuilder: (context, index) {