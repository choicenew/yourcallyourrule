import 'package:flutter/material.dart';

import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/services/subscription_service_base.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用订阅管理组件
/// 用于处理各种类型的订阅管理，包括加载、启用/禁用、更新、删除订阅等功能
/// [T] 是订阅实体类型
/// [ID] 是实体ID类型
class SubscriptionManagementWidget<T extends BaseEntity, ID> extends StatefulWidget {
  /// 订阅服务
  final SubscriptionServiceBase<T, ID> subscriptionService;
  
  /// 订阅列表
  final List<T> subscriptions;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 加载订阅的回调
  final Future<void> Function() onLoadSubscriptions;
  
  /// 构建订阅卡片的回调
  final Widget Function(T subscription) buildSubscriptionCard;
  
  /// 构建信息卡片的回调
  final Widget Function() buildInfoCard;
  
  /// 添加订阅的回调
  final void Function() onAddSubscription;
  
  /// 页面标题
  final String title;
  
  /// 空状态图标
  final IconData emptyIcon;
  
  /// 空状态文本
  final String emptyText;

  const SubscriptionManagementWidget({
    super.key,
    required this.subscriptionService,
    required this.subscriptions,
    required this.isLoading,
    required this.onLoadSubscriptions,
    required this.buildSubscriptionCard,
    required this.buildInfoCard,
    required this.onAddSubscription,
    required this.title,
    this.emptyIcon = Icons.subscriptions_outlined,
    required this.emptyText,
  });

  @override
  State<SubscriptionManagementWidget<T, ID>> createState() => SubscriptionManagementWidgetState<T, ID>();
}

class SubscriptionManagementWidgetState<T extends BaseEntity, ID> extends State<SubscriptionManagementWidget<T, ID>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: widget.onAddSubscription,
            tooltip: AppLocalizations.of(context)!.addSubscriptionTooltip,
          ),
        ],
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.subscriptions.isEmpty
              ? _buildEmptyState()
              : _buildSubscriptionList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.emptyIcon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(widget.emptyText, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context)!.addSubscriptionButton),
            onPressed: widget.onAddSubscription,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        widget.buildInfoCard(),
        const SizedBox(height: 16),
        ...widget.subscriptions.map(widget.buildSubscriptionCard),
      ],
    );
  }

  /// 切换订阅状态（启用/禁用）
  Future<void> toggleSubscriptionStatus(T subscription, bool isEnabled) async {
    try {
      if (isEnabled) {
        await widget.subscriptionService.enableSubscription(subscription);
      } else {
        await widget.subscriptionService.disableSubscription(subscription);
      }
      await widget.onLoadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionStatusChangeFailed(e.toString()))),
        );
      }
    }
  }

  /// 更新订阅
  Future<void> updateSubscription(T subscription, Future<void> Function(T) updateFunction) async {
    try {
      await updateFunction(subscription);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateFailed(e.toString()))),
        );
      }
    } finally {
      await widget.onLoadSubscriptions();
    }
  }

  /// 删除订阅
  Future<void> deleteSubscription(T subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.subscriptionDeleteConfirmTitle),
        content: Text(AppLocalizations.of(context)!.subscriptionDeleteConfirmContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await widget.subscriptionService.deleteSubscription(subscription.id as ID);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleteSuccess)),
          );
        }
        await widget.onLoadSubscriptions();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleteFailed(e.toString()))),
          );
        }
      }
    }
  }
}