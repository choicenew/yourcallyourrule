import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_render_video/pyro_render_video.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register video card, reader, and route to RenderHub', () {
    VideoRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.video));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.video));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.videoDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.video,
      const MediaEntity(
        id: 'v1',
        type: MediaType.video,
        title: 'My Movie',
      ),
    );
    expect(card, isA<VideoCard>());
  });

  test('VideoActions respects action provider contract', () async {
    VideoRenderer.register();
    final provider = VideoRenderer.provider;

    final stream1 = provider.watchActions('video_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.play), isTrue);
    expect(actions1.any((a) => a.id == ActionId.like), isTrue);
  });
}
