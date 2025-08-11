import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 可复用的VIP权限检查组件
/// 用于检查用户是否有VIP或临时权限，如果没有则显示提示并提供升级选项
class VipAccessChecker {
  /// 检查用户是否有VIP或临时权限
  /// 
  /// [ref] - Riverpod引用
  /// [context] - 构建上下文
  /// [onAccessGranted] - 当用户有权限时执行的回调
  /// [showUpgradeButton] - 是否显示升级按钮
  /// 
  /// 返回值：如果用户有权限返回true，否则返回false
  static bool checkVipAccess({
    required WidgetRef ref,
    required BuildContext context,
    required VoidCallback onAccessGranted,
    bool showUpgradeButton = true,
  }) {
    final purchaseState = ref.read(purchaseStateProvider);
    
    if (purchaseState.isPurchasedOrHasTempAccess()) {
      // 用户有VIP或临时权限，执行回调
      onAccessGranted();
      return true;
    } else {
      // 用户没有权限，显示提示
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.needVipAccess),
        action: showUpgradeButton ? SnackBarAction(
          label: AppLocalizations.of(context)!.upgradeToVip,
          onPressed: () {
            // 导航到购买页面
            context.goNamed('purchase');
          },
        ) : null,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
  
  /// 构建一个包含VIP检查的按钮
  /// 
  /// [ref] - Riverpod引用
  /// [context] - 构建上下文
  /// [onPressed] - 当用户有权限时按钮的点击回调
  /// [child] - 按钮的子组件
  /// [buttonStyle] - 按钮样式
  static Widget buildVipButton({
    required WidgetRef ref,
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
    ButtonStyle? buttonStyle,
  }) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: () {
        checkVipAccess(
          ref: ref,
          context: context,
          onAccessGranted: onPressed,
        );
      },
      child: child,
    );
  }
}