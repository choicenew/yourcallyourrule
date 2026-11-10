import 'package:flutter/material.dart';

/// 全局列表广告工具类 (AdListUtils)
class AdListUtils {
  static Widget Function(BuildContext, int) buildListWithAds<T>({
    required List<T> items,
    required Widget Function() adBuilder,
    required Widget Function(BuildContext, T) itemBuilder,
    int adInterval = 3,
    bool shouldShowAds = true,
  }) {
    if (!shouldShowAds || items.isEmpty) {
      return (context, index) {
        if (index >= items.length) return const SizedBox.shrink();
        return itemBuilder(context, items[index]);
      };
    }

    final totalItemsWithAds = items.length + (items.length / adInterval).floor();
    final Map<int, Widget> adWidgetCache = {};

    return (context, index) {
      if (index >= totalItemsWithAds) return const SizedBox.shrink();

      final adPosition = adInterval + 1;

      if (index > 0 && (index + 1) % adPosition == 0) {
        return adWidgetCache.putIfAbsent(
          index,
          () => KeyedSubtree(
            key: ValueKey('ad_list_item_$index'),
            child: adBuilder(),
          ),
        );
      }

      final originalIndex = index - (index / adPosition).floor();
      if (originalIndex >= items.length) return const SizedBox.shrink();

      return itemBuilder(context, items[originalIndex]);
    };
  }
}

/// 通用列表广告组件 (AdListWidget)
class AdListWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function() adBuilder;
  final Widget Function(BuildContext, T) itemBuilder;
  final int adInterval;
  final bool shouldShowAds;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget? emptyWidget;
  final dynamic adControlServiceProvider;

  const AdListWidget({
    super.key,
    required this.items,
    required this.adBuilder,
    required this.itemBuilder,
    this.adInterval = 3,
    this.shouldShowAds = true,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.emptyWidget,
    this.adControlServiceProvider,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return emptyWidget ?? const SizedBox.shrink();

    final builder = AdListUtils.buildListWithAds(
      items: items,
      adBuilder: adBuilder,
      itemBuilder: itemBuilder,
      adInterval: adInterval,
      shouldShowAds: shouldShowAds,
    );

    final itemCount = shouldShowAds
        ? items.length + (items.length / adInterval).floor()
        : items.length;

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

/// 通用网格广告组件 (AdGridWidget)
class AdGridWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function() adBuilder;
  final Widget Function(BuildContext, T) itemBuilder;
  final int adInterval;
  final bool shouldShowAds;
  final SliverGridDelegate gridDelegate;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const AdGridWidget({
    super.key,
    required this.items,
    required this.adBuilder,
    required this.itemBuilder,
    required this.gridDelegate,
    this.adInterval = 3,
    this.shouldShowAds = true,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final builder = AdListUtils.buildListWithAds(
      items: items,
      adBuilder: adBuilder,
      itemBuilder: itemBuilder,
      adInterval: adInterval,
      shouldShowAds: shouldShowAds,
    );

    final itemCount = shouldShowAds
        ? items.length + (items.length / adInterval).floor()
        : items.length;

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
