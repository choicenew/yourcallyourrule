import '../models/shadow_identity.dart';

/// Interface for online synchronization.
/// Reserved for future online system integration.
abstract class IShadowSyncAdapter {
  /// Push local changes to the cloud
  Future<void> syncUp(ShadowIdentity identity);
  
  /// Pull remote changes from the cloud
  Future<ShadowIdentity?> syncDown(String id);
  
  /// Resolve conflicts between local and remote
  Future<ShadowIdentity> resolveConflict(ShadowIdentity local, ShadowIdentity remote);
}
