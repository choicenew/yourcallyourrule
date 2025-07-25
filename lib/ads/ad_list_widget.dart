import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/ad_list_utils.dart';

/// 通用广告列表组件
/// 提供在列表中插入广告的通用组件，可用于各种列表页面
class AdListWidget<T> extends ConsumerWidget {
  /// 列表项
  final List<T> items;
  
  /// 广告构建器函数
  final Widget Function() adBuilder;
  
  /// 列表项构建器函数
  final Widget Function(BuildContext, T) itemBuilder;
  
  /// 广告间隔，默认为3（即每3个项目后插入一个广告）
  final int adInterval;
  
  /// 广告控制服务提供者
  final ProviderBase<AdControlService> adControlServiceProvider;
  
  /// 滚动方向
  final Axis scrollDirection;
  
  /// 是否收缩包装
  final bool shrinkWrap;
  
  /// 滚动物理效果
  final ScrollPhysics? physics;
  
  /// 内边距
  final EdgeInsetsGeometry? padding;
  
  /// 空状态组件
  final Widget? emptyWidget;
  
  /// 是否使用ListView.separated
  final bool useSeparated;
  
  /// 分隔符构建器
  final Widget Function(BuildContext, int)? separatorBuilder;
  
  /// 构造函数
  const AdListWidget({
    Key? key,
    required this.items,
    required this.adBuilder,
    required this.itemBuilder,
    this.adInterval = 3,
    required this.adControlServiceProvider,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.emptyWidget,
    this.useSeparated = false,
    this.separatorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 如果列表为空，显示空状态
    if (items.isEmpty) {
      return emptyWidget ?? const SizedBox.shrink();
    }
    
    // 检查广告是否应该显示
    final adControlService = ref.read(adControlServiceProvider);
    final shouldShowAds = adControlService.shouldShowAds();
    
    // 获取列表构建器
    final builder = AdListUtils.buildListWithAds(
      items: items,
      adBuilder: adBuilder,
      itemBuilder: itemBuilder,
      adInterval: adInterval,
      ref: ref,
      adControlServiceProvider: adControlServiceProvider,
    );
    
    // 计算项目数量
    final itemCount = shouldShowAds
        ? items.length + (items.length / adInterval).floor()
        : items.length;
    
    // 根据是否使用separated返回不同的ListView
    if (useSeparated && separatorBuilder != null) {
      return ListView.separated(
        itemCount: itemCount,
        itemBuilder: builder,
        separatorBuilder: separatorBuilder!,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
      );
    } else {
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
}

/// 通用广告网格组件
/// 提供在网格中插入广告的通用组件，可用于各种网格页面
class AdGridWidget<T> extends ConsumerWidget {
  /// 列表项
  final List<T> items;
  
  /// 广告构建器函数
  final Widget Function() adBuilder;
  
  /// 列表项构建器函数
  final Widget Function(BuildContext, T) itemBuilder;
  
  /// 广告间隔，默认为3（即每3个项目后插入一个广告）
  final int adInterval;
  
  /// 广告控制服务提供者
  final ProviderBase<AdControlService> adControlServiceProvider;
  
  /// 滚动方向
  final Axis scrollDirection;
  
  /// 是否收缩包装
  final bool shrinkWrap;
  
  /// 滚动物理效果
  final ScrollPhysics? physics;
  
  /// 内边距
  final EdgeInsetsGeometry? padding;
  
  /// 空状态组件
  final Widget? emptyWidget;
  
  /// 网格代理
  final SliverGridDelegate gridDelegate;
  
  /// 构造函数
  const AdGridWidget({
    Key? key,
    required this.items,
    required this.adBuilder,
    required this.itemBuilder,
    this.adInterval = 3,
    required this.adControlServiceProvider,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.emptyWidget,
    required this.gridDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 如果列表为空，显示空状态
    if (items.isEmpty) {
      return emptyWidget ?? const SizedBox.shrink();
    }
    
    // 检查广告是否应该显示
    final adControlService = ref.read(adControlServiceProvider);
    final shouldShowAds = adControlService.shouldShowAds();
    
    // 获取列表构建器
    final builder = AdListUtils.buildListWithAds(
      items: items,
      adBuilder: adBuilder,
      itemBuilder: itemBuilder,
      adInterval: adInterval,
      ref: ref,
      adControlServiceProvider: adControlServiceProvider,
    );
    
    // 计算项目数量
    final itemCount = shouldShowAds
        ? items.length + (items.length / adInterval).floor()
        : items.length;
    
    // 返回网格视图
    return GridView.builder(
      gridDelegate: gridDelegate,
      itemCount: itemCount,
      itemBuilder: builder,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
    );
  }
}