import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 音乐影子账户专用 Dashboard 拼装实现 (下沉至音频包)
class AudioDashboard extends StatelessWidget {
  final Map<String, dynamic> params;
  const AudioDashboard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final controller = params['controller'] as IFeedDataController?;
    if (controller == null) return const SizedBox.shrink();

    final items = controller.items;
    final firstCover =
        items.isNotEmpty ? items.first.data['coverUrl'] as String? : null;

    final history = items.where((e) => e.category == ActionId.play.name).toList();
    final trending = items.where((e) => e.category == ActionId.like.name).toList();
    final mood = items.where((e) => e.category == ActionId.favorite.name).toList();
    final other =
        items.where((e) => e.category == null).toList();

    return DashboardScaffold(
      backdropUrl: firstCover,
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 60)),

        if (history.isNotEmpty)
          DashboardShelf(
            title: ActionId.play.name,
            items: history,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
            isCircle: true,
          ),

        if (mood.isNotEmpty)
          SliverToBoxAdapter(child: _AudioMoodChips(items: mood)),

        if (trending.isNotEmpty)
          DashboardShelf(
            title: ActionId.like.name,
            items: trending,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
          ),

        if (other.isNotEmpty)
          DashboardShelf(
            title: ActionId.push.name,
            items: other,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildItem(BuildContext context, FeedItem item) {
    final entity = item.entity ?? MediaEntityMapper.fromMap(item.data);
    return RenderProtocolRegistry.getCard(item.type)?.call(entity) ?? const SizedBox.shrink();
  }
}

class _AudioMoodChips extends StatelessWidget {
  final List<FeedItem> items;
  const _AudioMoodChips({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withAlpha(30)),
            ),
            alignment: Alignment.center,
            child: Text(
              items[index].data['title'] ?? ActionId.like.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
