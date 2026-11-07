import '../models/shadow_identity.dart';

/// Interface for local storage. 
/// Implement this in your app using SharedPreferences, Isar, or Hive.
abstract class IShadowStorage {
  /// Save the list of identities
  Future<void> saveIdentities(List<ShadowIdentity> identities);
  
  /// Load the list of identities
  Future<List<ShadowIdentity>> loadIdentities();
  
  /// Save the active identity ID
  Future<void> saveActiveId(String? id);
  
  /// Load the active identity ID
  Future<String?> loadActiveId();
}

/// Simple in-memory storage implementation for testing or default use.
class MemoryShadowStorage implements IShadowStorage {
  List<ShadowIdentity> _identities = [];
  String? _activeId;

  @override
  Future<List<ShadowIdentity>> loadIdentities() async => _identities;

  @override
  Future<void> saveIdentities(List<ShadowIdentity> identities) async {
    _identities = List.from(identities);
  }

  @override
  Future<String?> loadActiveId() async => _activeId;

  @override
  Future<void> saveActiveId(String? id) async {
    _activeId = id;
  }
}
