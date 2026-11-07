import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_novel/pyro_render_novel.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register novel card and route to RenderHub', () {
    NovelRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.novel));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.novelDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.novel,
      const MediaEntity(
        id: 'n1',
        type: MediaType.novel,
        title: 'My Great Novel',
      ),
    );
    expect(card, isA<NovelCard>());
  });

  test('NovelActions respects action provider contract', () async {
    NovelRenderer.register();
    final provider = NovelRenderer.provider;

    final stream1 = provider.watchActions('novel_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.shelf), isTrue);
    expect(actions1.any((a) => a.id == ActionId.push), isTrue);
  });
}
