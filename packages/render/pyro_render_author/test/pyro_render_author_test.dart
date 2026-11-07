import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_author/pyro_render_author.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
    ActionHub.instance.clear();
  });

  test('should register author card, routes to RenderHub and provider to ActionHub', () {
    AuthorRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaTypeToken.author));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.authorProfile));
    expect(ActionHub.instance.registeredContentTypes, contains(MediaTypeToken.author));

    final card = RenderHub.instance.buildCard(
      MediaTypeToken.author,
      const MediaEntity(
        id: 'author_001',
        type: MediaType.academic,
        title: 'Test Author',
      ),
    );
    expect(card, isA<AuthorCard>());
  });

  test('AuthorActions respects action provider contract', () async {
    AuthorRenderer.register();
    final provider = AuthorRenderer.provider;

    final stream1 = provider.watchActions('author_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.follow), isTrue);
    expect(actions1.any((a) => a.id == ActionId.like), isTrue);
  });
}
