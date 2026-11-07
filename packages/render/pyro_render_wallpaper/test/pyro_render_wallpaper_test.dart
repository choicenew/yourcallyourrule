import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_render_wallpaper/pyro_render_wallpaper.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register wallpaper card, reader, and route to RenderHub', () {
    WallpaperRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.wallpaper));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.wallpaper));

    final card = RenderHub.instance.buildCard(
      MediaType.wallpaper,
      const MediaEntity(
        id: 'w1',
        type: MediaType.wallpaper,
        title: 'Cyberpunk Neon',
      ),
    );
    expect(card, isA<WallpaperCard>());
  });

  test('WallpaperActions respects action provider contract', () async {
    WallpaperRenderer.register();
    final provider = WallpaperRenderer.provider;

    final stream1 = provider.watchActions('wp_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.like), isTrue);
  });
}
