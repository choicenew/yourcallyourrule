import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_news/pyro_render_news.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register news card, reader, and route to RenderHub', () {
    NewsRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.news));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.news));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.newsDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.news,
      const MediaEntity(
        id: 'n1',
        type: MediaType.news,
        title: 'My News Article',
      ),
    );
    expect(card, isA<NewsCard>());
  });

  test('NewsActions respects action provider contract', () async {
    NewsRenderer.register();
    final provider = NewsRenderer.provider;

    final stream1 = provider.watchActions('news_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.read), isTrue);
    expect(actions1.any((a) => a.id == ActionId.share), isTrue);
  });
}
