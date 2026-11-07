import 'dart:ui';

import 'package:material_ui/material_ui.dart';

import 'feed_models.dart';

/// 顶级审美：通用 Dashboard 原子组件库 (Slot-Based)
/// 提供氛围底色、吸顶货架与高级横移容器，供各业务包（Render Packages）拼装专属大厅。
class DashboardScaffold extends StatelessWidget {
  final List<Widget> slivers;
  final String? backdropUrl;

  const DashboardScaffold({
    super.key,
    required this.slivers,
    this.backdropUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (backdropUrl != null)
            Positioned.fill(
              child: RepaintBoundary(
                child: AtmosphericBackdrop(imageUrl: backdropUrl!),
              ),
            ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: slivers,
          ),
        ],
      ),
    );
  }
}

/// 氛围光场背景层
class AtmosphericBackdrop extends StatelessWidget {
  final String imageUrl;
  const AtmosphericBackdrop({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Container(
        key: ValueKey(imageUrl),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.5),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(50),
                  Colors.black.withAlpha(180),
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 顶级审美货架组件
class DashboardShelf extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final bool isCircle;

  const DashboardShelf({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 16, 12),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withAlpha(100),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: isCircle ? 170 : 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final double width = isCircle ? 115 : 155;
                return Container(
                  width: width,
                  margin: const EdgeInsets.only(right: 14),
                  child: Column(
                    crossAxisAlignment: isCircle
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            isCircle ? 100 : 20,
                          ),
                          child: itemBuilder(context, items[index]),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildItemTitle(items[index]),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemTitle(dynamic item) {
    String title = '';
    if (item is FeedItem) {
      title = item.data['title']?.toString() ?? '';
    } else if (item is Map) {
      title = item['title']?.toString() ?? '';
    }

    return Text(
      title,
      maxLines: 1,
      textAlign: isCircle ? TextAlign.center : TextAlign.start,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
