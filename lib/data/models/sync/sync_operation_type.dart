enum SyncOperationType {
  insert,
  update,
  delete,
  increment,
  proposeDeletion,
  voteDeletion,
}

extension SyncOperationTypeX on SyncOperationType {
  String toRawString() {
    switch (this) {
      case SyncOperationType.insert:
        return 'INSERT';
      case SyncOperationType.update:
        return 'UPDATE';
      case SyncOperationType.delete:
        return 'DELETE';
      case SyncOperationType.increment:
        return 'INCREMENT';
      case SyncOperationType.proposeDeletion:
        return 'PROPOSE_DELETION';
      case SyncOperationType.voteDeletion:
        return 'VOTE_DELETION';
    }
  }

  static SyncOperationType fromString(String? raw) {
    if (raw == null) return SyncOperationType.insert;
    switch (raw.toUpperCase()) {
      case 'PROPOSE_DELETION':
        return SyncOperationType.proposeDeletion;
      case 'VOTE_DELETION':
        return SyncOperationType.voteDeletion;
      case 'UPDATE':
        return SyncOperationType.update;
      case 'DELETE':
        return SyncOperationType.delete;
      case 'INCREMENT':
        return SyncOperationType.increment;
      case 'INSERT':
      default:
        return SyncOperationType.insert;
    }
  }
}
