
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import 'card.dart';

import 'dart:async'; // 导入 Timer

class CustomSwiper extends StatefulWidget {
  final List<CardItem?> cards; // cards 列表现在包含可空的 CardItem
  final double width; // 外部传入的宽度
  final double height; // 外部传入的高度

  const CustomSwiper({
    super.key,
    required this.cards,
    required this.width,
    required this.height,
  });

  @override
  State<CustomSwiper> createState() => _CustomSwiperState();
}

class _CustomSwiperState extends State<CustomSwiper> {
  final CarouselController _carouselController = CarouselController();
  int _currentCardIndex = 0; // 使用 _currentCardIndex 跟踪当前卡片索引
  Timer? _timer; // 用于自动播放的 Timer

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoplay();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 在组件销毁时取消 Timer

    super.dispose();
  }

  int getCardIndexFromItemIndex(
      int itemIndex, bool isAdEnabled, int cardCount) {
    return itemIndex; // 直接返回 itemIndex
  }

// 自动播放方法
  void _startAutoplay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final adState =
          Provider.of<AdState>(context, listen: false); // 获取 adState

      // 计算 itemCount，考虑 adState.isAdEnabled
      final itemCount = widget.cards.length +
          (adState.isAdEnabled ? widget.cards.length ~/ 2 : 0);

      // 计算下一个 item 的索引，考虑循环和广告
      int nextItemIndex =
          (_carouselController.offset ~/ (widget.width * 0.9) + 1).toInt();
      nextItemIndex %= itemCount;

      // 计算目标偏移量
      double targetOffset = nextItemIndex * widget.width * 0.9;

      // 使用 animateTo 方法滚动到目标偏移量
      _carouselController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

// 独立的函数，用于处理卡片点击事件
  void _handleCardTap(BuildContext context, int index) {
    final cardIndex = index - index ~/ 3; // 计算卡片索引
    final cardItem = widget.cards[cardIndex];
    if (cardItem?.onTap != null) {
      cardItem!.onTap!(context); // 调用 CardItem 的 onTap 回调函数
    } else if (cardItem?.url != null) {
      launchUrlString(cardItem!.url!); // 如果有 url，则打开链接
    }
  }

  @override
  Widget build(BuildContext context) {
    // 使用 Provider 获取 AdState
    final adState = Provider.of<AdState>(context);

    // 计算 itemCount，如果需要显示广告，则每两张卡片后插入一个广告
    final itemCount = widget.cards.length +
        (adState.isAdEnabled ? widget.cards.length ~/ 2 : 0);

    // 构建 CarouselView 的 children 列表
    final children = List<Widget>.generate(itemCount, (index) {
      // 每两个卡片后面显示一个广告
      if (adState.isAdEnabled && (index + 1) % 3 == 0) {
        return const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd);
      } else {
        // 计算卡片索引，每两个卡片后面插入一个广告，所以索引需要进行调整
        final cardIndex = index - index ~/ 3;
        return Center(
          // 将 CardItemWidget 包裹在 Center 组件中
          child: CardItemWidget(
            cardItem: widget.cards[cardIndex],
          ),
        );
      }
    });

    return Column(
      children: [
        SizedBox(
          width: widget.width * 0.9, // 使用外部传入的宽度
          height: widget.height * 0.9, // 使用外部传入的高度
          // 使用 NotificationListener 监听页面切换事件
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                // 计算当前 item 的索引
                int currentItemIndex =
                    (_carouselController.offset / (widget.width * 0.9)).round();

                // 使用辅助函数计算卡片索引
                setState(() {
                  _currentCardIndex = getCardIndexFromItemIndex(
                      currentItemIndex,
                      adState.isAdEnabled,
                      widget.cards.length);
                });
              }
              return true;
            },
            child: CarouselView(
              controller: _carouselController,
              // 将 itemExtent 设置为 widget.width * 0.9，与 SizedBox 宽度一致
              itemExtent: widget.width * 0.9,
              shrinkExtent: 200, // 设置卡片压缩后的最小宽度

              // CarouselView 的 onTap 回调函数
              onTap: (index) {
                _handleCardTap(context, index); // 调用独立的函数
              },
              children: children, // 传递 children 参数
            ),
          ),
        ),
        CustomIndicator(
          cardCount: itemCount,
          currentIndex: _currentCardIndex,
          dotWidth: 10,
          dotHeight: 10,
          spacing: 10,
          expansionFactor: 3,
          activeDotColor: const Color.fromRGBO(10, 202, 109, 1),
          dotColor: const Color.fromRGBO(158, 158, 158, 1),
        ),
      ],
    );
  }
}

// 自定义指示器组件

class CustomIndicator extends StatefulWidget {
  final int cardCount;
  final int currentIndex;
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final double expansionFactor;
  final Color activeDotColor;
  final Color dotColor;
  final Duration animationDuration;

  const CustomIndicator({
    super.key,
    required this.cardCount,
    required this.currentIndex,
    this.dotWidth = 16.0,
    this.dotHeight = 16.0,
    this.spacing = 8.0,
    this.expansionFactor = 3,
    this.activeDotColor = const Color.fromRGBO(10, 202, 109, 1),
    this.dotColor = const Color.fromRGBO(158, 158, 158, 1),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<CustomIndicator> createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.cardCount, (index) {
        return AnimatedContainer(
          duration: widget.animationDuration,
          width: index == widget.currentIndex
              ? widget.dotWidth * widget.expansionFactor
              : widget.dotWidth,
          height: widget.dotHeight,
          margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.dotWidth), // 使用圆角矩形
            color: index == widget.currentIndex
                ? widget.activeDotColor
                : widget.dotColor,
          ),
        );
      }),
    );
  }
}

// 用于显示 CardItem 的 Widget
// 用于显示 CardItem 的 Widget
class CardItemWidget extends StatelessWidget {
  final CardItem? cardItem; // cardItem 属性现在是可空的

  const CardItemWidget({super.key, required this.cardItem});

  @override
  Widget build(BuildContext context) {
    // 如果 cardItem 为空，则显示一个空的 Container
    if (cardItem == null) {
      return Container();
    }

    return cardItem!; // 直接返回 CardItem 组件，不再使用 GestureDetector
  }
}
