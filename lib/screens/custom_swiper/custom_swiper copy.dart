import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import 'card.dart';

class CustomSwiper extends StatelessWidget {
  final List<CardItem> cards;

  const CustomSwiper({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    final SwiperController swiperController = SwiperController();

    // 在布局完成后启动自动播放
    WidgetsBinding.instance.addPostFrameCallback((_) {
      swiperController.startAutoplay();
    });

    // 使用 Provider 获取 AdState
    final adState = Provider.of<AdState>(context);

    // 计算 itemCount，如果需要显示广告，则每两张卡片后插入一个广告
    final itemCount = cards.length + (adState.isAdEnabled ? cards.length ~/ 2 : 0);
    return Swiper(
      itemBuilder: (context, index) {
        // 每两个卡片后面显示一个广告
        if (adState.isAdEnabled && (index + 1) % 3 == 0) {
          // 使用 adState.isAdEnabled 判断
          return const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd);
            
        } else {
          // 计算卡片索引，每两个卡片后面插入一个广告，所以索引需要进行调整
          final cardIndex = index - index ~/ 3;
          return CardItem(
            title: cards[cardIndex].title,
            content: cards[cardIndex].content,
            imageUrl: cards[cardIndex].imageUrl,
            url: cards[cardIndex].url,
          );
        }
      },
      itemCount: itemCount,
      // -------------------- Swiper 配置参数 --------------------
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          activeColor: Color.fromRGBO(10, 202, 109, 1),
          color: Color.fromRGBO(158, 158, 158, 1),
          size: 10.0,
          activeSize: 15.0,
          space: 8.0,
        ),
      ),
      loop: true,

      autoplayDelay: 3000,
      fade: 0.5,
      curve: Curves.easeInOut,
      scale: 0.8,
      outer: true,
      viewportFraction: 0.8,
      scrollDirection: Axis.horizontal,
      autoplayDisableOnInteraction: true,
      // ----------------------------------------------------------
    );
  }
}

/*

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../utils/ad_manager.dart';
import 'card.dart';

class CustomSwiper extends StatelessWidget {
  final List<CardItem> cards;

  const CustomSwiper({Key? key, required this.cards}) : super(key: key);

  Widget _buildCard(int index) {
    final cardIndex = index ~/ 2;
    return CardItem(
      title: cards[cardIndex].title,
      content: cards[cardIndex].content,
      imageUrl: cards[cardIndex].imageUrl,
      url: cards[cardIndex].url,
    );
  }

  Widget _buildAd() {
    return FutureBuilder<Widget>(
      future: GoogleAdWidget(adInfo: AdManager.bannerAd),或Future.value(GoogleAdWidget(adInfo: AdManager.bannerAd)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return snapshot.data!;
        }
        return const SizedBox(); // 广告加载失败或加载中，不显示任何内容
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (context, index) {
        return index.isEven ? _buildCard(index) : _buildAd();
      },
      itemCount: cards.length * 2 - 1,
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          size: 10.0,
          activeSize: 14.0,
          space: 8.0,
        ),
      ),
      // ... 其他 Swiper 配置 ...
      loop: true,
      autoplay: true,
      autoplayDelay: 3000,
      fade: 0.5,
      curve: Curves.easeInOut,
      scale: 0.8,
      outer: true,
      viewportFraction: 0.8,
      scrollDirection: Axis.horizontal,
      autoplayDisableOnInteraction: true,
    );
  }
}
*/
