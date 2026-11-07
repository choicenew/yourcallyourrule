import 'dart:async';
import 'package:uuid/uuid.dart';
import 'models/shadow_identity.dart';
import 'interfaces/storage_interface.dart';
import 'interfaces/sync_interface.dart';

/// The core manager for the Shadow Identity system.
class ShadowIdentityManager {
  final IShadowStorage _storage;
  final IShadowSyncAdapter? _syncAdapter;
  final _uuid = const Uuid();

  List<ShadowIdentity> _identities = [];
  String? _activeId;

  /// Stream to notify listeners of identity changes (switches, additions, deletions)
  final _controller = StreamController<void>.broadcast();
  Stream<void> get onChanges => _controller.stream;

  ShadowIdentityManager({
    required IShadowStorage storage,
    IShadowSyncAdapter? syncAdapter,
  })  : _storage = storage,
        _syncAdapter = syncAdapter;

  /// Initialize the manager by loading data from storage
  Future<void> initialize() async {
    _identities = await _storage.loadIdentities();
    _activeId = await _storage.loadActiveId();

    if (_identities.isEmpty) {
      // Create initial default identity if none exists
      await createIdentity('Default Observer');
    } else if (_activeId == null) {
      _activeId = _identities.first.id;
      await _storage.saveActiveId(_activeId);
    }
    _controller.add(null);
  }

  /// Get the list of all local identities
  List<ShadowIdentity> get identities => List.unmodifiable(_identities);

  /// Get the currently active identity
  ShadowIdentity? get activeIdentity {
    if (_activeId == null || _identities.isEmpty) return null;
    return _identities.firstWhere(
      (i) => i.id == _activeId,
      orElse: () => _identities.first,
    );
  }

  /// Switch to a different identity by ID
  Future<void> switchIdentity(String id) async {
    if (!_identities.any((i) => i.id == id)) {
      throw Exception('Identity NOT found: $id');
    }

    _activeId = id;
    
    // Update last accessed time
    final index = _identities.indexWhere((i) => i.id == id);
    _identities[index] = _identities[index].copyWith(lastAccessedAt: DateTime.now());
    
    await _storage.saveActiveId(_activeId);
    await _storage.saveIdentities(_identities);
    
    _controller.add(null);
  }

  /// Create a new local identity
  Future<ShadowIdentity> createIdentity(String name, {Map<String, dynamic> metadata = const {}}) async {
    final newIdentity = ShadowIdentity(
      id: _uuid.v4().substring(0, 8).toUpperCase(),
      name: name,
      metadata: metadata,
      createdAt: DateTime.now(),
      lastAccessedAt: DateTime.now(),
    );

    _identities.add(newIdentity);
    _activeId = newIdentity.id;

    await _storage.saveIdentities(_identities);
    await _storage.saveActiveId(_activeId);
    
    _controller.add(null);
    return newIdentity;
  }

  /// Delete an identity. Cannot delete the only existing identity.
  Future<void> deleteIdentity(String id) async {
    if (_identities.length <= 1) {
      throw Exception('Cannot delete the last identity.');
    }

    _identities.removeWhere((i) => i.id == id);
    
    if (_activeId == id) {
      _activeId = _identities.first.id;
      await _storage.saveActiveId(_activeId);
    }

    await _storage.saveIdentities(_identities);
    _controller.add(null);
  }

  /// Update an existing identity name
  Future<void> updateIdentityName(String id, String newName) async {
    final index = _identities.indexWhere((i) => i.id == id);
    if (index == -1) {
      throw Exception('Identity NOT found: $id');
    }

    _identities[index] = _identities[index].copyWith(name: newName);
    await _storage.saveIdentities(_identities);
    _controller.add(null);
  }

  /// Trigger a sync for the active identity if an adapter is provided
  Future<void> syncActiveIdentity() async {
    final active = activeIdentity;
    if (active != null && _syncAdapter != null) {
      await _syncAdapter.syncUp(active);
      // Logic for syncDown and conflict resolution could be added here
    }
  }

  void dispose() {
    _controller.close();
  }
}
