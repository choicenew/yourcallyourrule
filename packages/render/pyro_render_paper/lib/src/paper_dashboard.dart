import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 学术文献影子账户专用 Dashboard (下沉至论文包)
class PaperDashboard extends StatelessWidget {
  final Map<String, dynamic> params;
  const PaperDashboard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final controller = params['controller'] as IFeedDataController?;
    if (controller == null) return const SizedBox.shrink();

    final items = controller.items;

    final history = items.where((e) => e.category == ActionId.read.name).toList();
    final trending = items.where((e) => e.category == ActionId.like.name).toList();
    final all = items.where((e) => e.category == null).toList();

    return DashboardScaffold(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 60)),

        if (history.isNotEmpty)
          DashboardShelf(
            title: ActionId.read.name,
            items: history,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
          ),

        if (trending.isNotEmpty)
          DashboardShelf(
            title: ActionId.like.name,
            items: trending,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
          ),

        if (all.isNotEmpty)
          DashboardShelf(
            title: ActionId.push.name,
            items: all,
            itemBuilder: (ctx, item) => _buildItem(ctx, item as FeedItem),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildItem(BuildContext context, FeedItem item) {
    final entity = item.entity ?? MediaEntityMapper.fromMap(item.data);
    final cardBuilder = RenderProtocolRegistry.getCard(item.type);
    if (cardBuilder != null) return cardBuilder(entity);
    return const SizedBox.shrink();
  }
}
