import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/services/subscription_service_base.dart';
import 'package:yourcallyourrule/features/common/widgets/subscription_management_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用订阅页面组件
/// 用于处理各种类型的订阅管理页面，包括电话、短信、联系人等订阅
/// [T] 是订阅实体类型
/// [ID] 是实体ID类型
/// [S] 是订阅服务类型
class GenericSubscriptionPage<T extends BaseEntity, ID, S extends SubscriptionServiceBase<T, ID>> extends StatefulWidget {
  /// 页面标题
  final String title;
  
  /// 空状态文本
  final String emptyText;
  
  /// 空状态图标
  final IconData emptyIcon;
  
  /// 信息卡片构建函数
  final Widget Function() buildInfoCard;
  
  /// 订阅卡片构建函数
  final Widget Function(T subscription, GenericSubscriptionPageState<T, ID, S> state) buildSubscriptionCard;
  
  /// 添加订阅对话框函数
  final void Function(BuildContext context, S service, Function refreshCallback) showAddDialog;
  
  /// 更新订阅函数
  final Future<void> Function(T subscription, S service) updateSubscription;

  const GenericSubscriptionPage({
    super.key,
    required this.title,
    required this.emptyText,
    this.emptyIcon = Icons.subscriptions_outlined,
    required this.buildInfoCard,
    required this.buildSubscriptionCard,
    required this.showAddDialog,
    required this.updateSubscription,
  });

  @override
  State<GenericSubscriptionPage<T, ID, S>> createState() => GenericSubscriptionPageState<T, ID, S>();
}

class GenericSubscriptionPageState<T extends BaseEntity, ID, S extends SubscriptionServiceBase<T, ID>> extends State<GenericSubscriptionPage<T, ID, S>> {
  List<T> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = Provider.of<S>(context, listen: false);
    try {
      final subscriptions = await subscriptionService.getAll();
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionLoadFailed(e.toString()))),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> toggleSubscriptionStatus(T subscription, bool isEnabled) async {
    final subscriptionService = Provider.of<S>(context, listen: false);
    try {
      if (isEnabled) {
        await subscriptionService.enableSubscription(subscription);
      } else {
        await subscriptionService.disableSubscription(subscription);
      }
      await _loadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionStatusChangeFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> updateSubscription(T subscription) async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = Provider.of<S>(context, listen: false);
    try {
      await widget.updateSubscription(subscription, subscriptionService);
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
      await _loadSubscriptions();
    }
  }

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
      final subscriptionService = Provider.of<S>(context, listen: false);
      try {
        await subscriptionService.deleteSubscription(subscription.id as ID);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleteSuccess)),
          );
        }
        await _loadSubscriptions();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleteFailed(e.toString()))),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<S>(context, listen: false);
    
    return SubscriptionManagementWidget<T, ID>(
      subscriptionService: subscriptionService,
      subscriptions: _subscriptions,
      isLoading: _isLoading,
      onLoadSubscriptions: _loadSubscriptions,
      title: widget.title,
      emptyText: widget.emptyText,
      emptyIcon: widget.emptyIcon,
      onAddSubscription: () => widget.showAddDialog(context, subscriptionService, _loadSubscriptions),
      buildInfoCard: widget.buildInfoCard,
      buildSubscriptionCard: (subscription) => widget.buildSubscriptionCard(subscription, this),
    );
  }
}