import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';

/// 广告列表工具类
/// 提供在列表中插入广告的功能
class AdListUtils {
  /// 在列表中每隔指定数量的项目插入一个广告
  /// [items] 原始列表项
  /// [adBuilder] 广告构建器函数
  /// [itemBuilder] 列表项构建器函数
  /// [adInterval] 广告间隔，默认为3（即每3个项目后插入一个广告）
  /// [ref] Riverpod引用，用于检查广告状态
  /// [adControlServiceProvider] 广告控制服务提供者
  /// 返回包含广告的列表构建器
  static Widget Function(BuildContext, int) buildListWithAds<T>({
    required List<T> items,
    required Widget Function() adBuilder,
    required Widget Function(BuildContext, T) itemBuilder,
    int adInterval = 3,
    required WidgetRef ref,
    required ProviderBase<AdControlService> adControlServiceProvider,
  }) {
    // 检查广告是否应该显示
    final adControlService = ref.read(adControlServiceProvider);
    final shouldShowAds = adControlService.shouldShowAds();
    
    // 如果不应该显示广告，直接返回原始列表构建器
    if (!shouldShowAds) {
      return (context, index) {
        if (index >= items.length) return const SizedBox.shrink();
        return itemBuilder(context, items[index]);
      };
    }
    
    // 计算包含广告的总项目数
    final totalItemsWithAds = items.length + (items.length / adInterval).floor();
    
    // 返回包含广告的列表构建器
    return (context, index) {
      // 如果索引超出范围，返回空组件
      if (index >= totalItemsWithAds) return const SizedBox.shrink();
      
      // 计算广告位置
      final adPosition = adInterval + 1;
      
      // 如果当前位置应该显示广告
      if (index > 0 && (index + 1) % adPosition == 0) {
        return adBuilder();
      }
      
      // 计算原始列表中的实际索引
      final originalIndex = index - (index / adPosition).floor();
      
      // 如果实际索引超出范围，返回空组件
      if (originalIndex >= items.length) return const SizedBox.shrink();
      
      // 返回列表项
      return itemBuilder(context, items[originalIndex]);
    };
  }
  
  /// 在列表视图中插入广告
  /// [items] 原始列表项
  /// [adBuilder] 广告构建器函数
  /// [itemBuilder] 列表项构建器函数
  /// [adInterval] 广告间隔，默认为3（即每3个项目后插入一个广告）
  /// [ref] Riverpod引用，用于检查广告状态
  /// [adControlServiceProvider] 广告控制服务提供者
  /// [scrollDirection] 滚动方向
  /// [shrinkWrap] 是否收缩包装
  /// [physics] 滚动物理效果
  /// [padding] 内边距
  /// 返回包含广告的列表视图
  static Widget buildListViewWithAds<T>({
    required List<T> items,
    required Widget Function() adBuilder,
    required Widget Function(BuildContext, T) itemBuilder,
    int adInterval = 3,
    required WidgetRef ref,
    required ProviderBase<AdControlService> adControlServiceProvider,
    Axis scrollDirection = Axis.vertical,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
  }) {
    // 获取列表构建器
    final builder = buildListWithAds(
      items: items,
      adBuilder: adBuilder,
      itemBuilder: itemBuilder,
      adInterval: adInterval,
      ref: ref,
      adControlServiceProvider: adControlServiceProvider,
    );
    
    // 检查广告是否应该显示
    final adControlService = ref.read(adControlServiceProvider);
    final shouldShowAds = adControlService.shouldShowAds();
    
    // 计算项目数量
    final itemCount = shouldShowAds
        ? items.length + (items.length / adInterval).floor()
        : items.length;
    
    // 返回列表视图
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: builder,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
    );
  }
}