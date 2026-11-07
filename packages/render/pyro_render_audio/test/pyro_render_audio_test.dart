import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_audio/pyro_render_audio.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register audio card, reader, and route to RenderHub', () {
    AudioRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.audio));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.audio));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.audioDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.audio,
      const MediaEntity(
        id: 'a1',
        type: MediaType.audio,
        title: 'My Symphony',
      ),
    );
    expect(card, isA<AudioCard>());
  });

  test('AudioActions respects action provider contract', () async {
    AudioRenderer.register();
    final provider = AudioRenderer.provider;

    final stream1 = provider.watchActions('track_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.play), isTrue);
    expect(actions1.any((a) => a.id == ActionId.like), isTrue);
  });
}
