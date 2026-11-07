import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'src/author_action_provider.dart';
import 'src/author_card.dart';
import 'src/author_profile_screen.dart';

export 'src/author_action_provider.dart';
export 'src/author_card.dart';
export 'src/author_intents.dart';
export 'src/author_profile_screen.dart';

class AuthorRenderer {
  static final AuthorActions provider = AuthorActions();

  static void register() {
    registerCard(MediaTypeToken.author, (entity, {isSelected = false}) {
      return AuthorCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaTypeToken.author, (context, entity) {
      return AuthorProfileScreen(
        authorId: entity.id,
        entity: entity,
      );
    });

    registerDashboard(MediaTypeToken.author, (context, entity) {
      return AuthorProfileScreen(
        authorId: entity.id,
        entity: entity,
      );
    });

    registerRoute(RouteToken.authorProfile, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AuthorProfileScreen(
            authorId: entity.id,
            entity: entity,
          ),
        ),
      );
    });

    registerActionProvider(MediaTypeToken.author, provider);
  }
}
