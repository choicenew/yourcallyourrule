import 'package:pyro_shadow_identity/pyro_shadow_identity.dart';

class InMemoryShadowStorage implements IShadowStorage {
  final List<ShadowIdentity> _identities = [];
  String? _activeId;

  @override
  Future<List<ShadowIdentity>> loadIdentities() async => _identities;

  @override
  Future<String?> loadActiveId() async => _activeId;

  @override
  Future<void> saveIdentities(List<ShadowIdentity> identities) async {
    _identities.clear();
    _identities.addAll(identities);
  }

  @override
  Future<void> saveActiveId(String? id) async {
    _activeId = id;
  }
}

void main() async {
  final storage = InMemoryShadowStorage();
  final manager = ShadowIdentityManager(storage: storage);
  await manager.initialize();
  
  // ignore: avoid_print
  print('Active Identity: ${manager.activeIdentity?.name}');
}
