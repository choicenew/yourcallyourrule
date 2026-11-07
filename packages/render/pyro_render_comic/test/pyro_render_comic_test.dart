import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_comic/pyro_render_comic.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register comic card, reader, and route to RenderHub', () {
    ComicRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.manga));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.manga));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.comicDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.manga,
      const MediaEntity(
        id: 'c1',
        type: MediaType.manga,
        title: 'My Great Comic',
      ),
    );
    expect(card, isA<ComicCard>());
  });

  test('ComicActions respects action provider contract', () async {
    ComicRenderer.register();
    final provider = ComicRenderer.provider;

    final stream1 = provider.watchActions('comic_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.shelf), isTrue);
    expect(actions1.any((a) => a.id == ActionId.push), isTrue);
    expect(actions1.any((a) => a.id == ActionId.share), isTrue);
  });
}
