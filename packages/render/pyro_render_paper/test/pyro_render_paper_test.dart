import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_hub/pyro_render_hub.dart';
import 'package:pyro_render_paper/pyro_render_paper.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

void main() {
  setUp(() {
    RenderHub.instance.clear();
  });

  test('should register paper card, reader, and route to RenderHub', () {
    PaperRenderer.register();

    expect(RenderHub.instance.registeredCardTypes, contains(MediaType.academic));
    expect(RenderHub.instance.registeredReaderTypes, contains(MediaType.academic));
    expect(RenderHub.instance.registeredRouteTypes, contains(RouteToken.paperDetail));

    final card = RenderHub.instance.buildCard(
      MediaType.academic,
      const MediaEntity(
        id: 'p1',
        type: MediaType.academic,
        title: 'Research Paper Title',
      ),
    );
    expect(card, isA<PaperCard>());
  });

  test('PaperActions respects action provider contract', () async {
    PaperRenderer.register();
    final provider = PaperRenderer.provider;

    final stream1 = provider.watchActions('test_paper_001');
    final actions1 = await stream1.first;
    expect(actions1.any((a) => a.id == ActionId.push), isTrue);
    expect(actions1.any((a) => a.id == ActionId.favorite), isTrue);
    expect(actions1.any((a) => a.id == ActionId.translate), isTrue);
  });

  testWidgets('PaperDetailHeaderCard renders fallback cover when coverUrl is empty', (tester) async {
    final testWidget = MaterialApp(
      home: Scaffold(
        body: PaperDetailHeaderCard(
          title: 'Benefit Transfer of Environmental',
          venue: 'BOOK',
          doi: '10.1007/978-94-017-9935-5',
          year: '2026',
          coverUrl: '',
        ),
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.text('Benefit Transfer of Environmental'), findsOneWidget);
    expect(find.text('BOOK'), findsOneWidget);
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
  });

  testWidgets('PaperDetailHeaderCard renders correctly with local cover path', (tester) async {
    final testWidget = MaterialApp(
      home: Scaffold(
        body: PaperDetailHeaderCard(
          title: 'Benefit Transfer of Environmental',
          venue: 'ACADEMIC',
          doi: '',
          year: '2026',
          coverUrl: '/data/user/0/com.pyro/pdf_covers/test_cover.png',
        ),
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.text('Benefit Transfer of Environmental'), findsOneWidget);
    expect(find.text('ACADEMIC'), findsOneWidget);
  });
}
