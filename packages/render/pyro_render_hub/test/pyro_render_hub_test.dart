import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register and build cards successfully', () {
    const cardType = MediaType.novel;
    
    RenderHub.instance.registerCard(cardType, (entity, {isSelected = false}) {
      return Text(entity.title, key: const Key('novel_card'));
    });

    final widget = RenderHub.instance.buildCard(cardType, const MediaEntity(id: '1', type: cardType, title: 'My Novel'));
    expect(widget, isA<Text>());
    expect((widget as Text).data, 'My Novel');
  });

  test('should register and build slots successfully', () {
    const slotName = RouteToken.authorProfile;
    
    RenderHub.instance.registerSlot(slotName, (entity) {
      return Container(key: Key('slot_${entity.id}'));
    });

    final widget = RenderHub.instance.buildSlot(slotName, const MediaEntity(id: '123', type: MediaType.academic, title: ''));
    expect(widget, isA<Container>());
    expect((widget as Container).key, const Key('slot_123'));
  });

  testWidgets('should register and dispatch route actions successfully', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    const routeType = RouteToken.novelDetail;
    var called = false;
    MediaEntity? capturedEntity;

    RenderHub.instance.registerRoute(routeType, (context, entity) {
      called = true;
      capturedEntity = entity;
    });

    late BuildContext buildCtx;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            buildCtx = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    RenderHub.instance.navigate(
      buildCtx,
      routeType,
      const MediaEntity(id: 'novel_456', type: MediaType.novel, title: ''),
    );

    expect(called, isTrue);
    expect(capturedEntity?.id, 'novel_456');
  });
}
