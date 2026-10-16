enum VoteType {
  agreeDelete,
  disagreeDelete,
}

extension VoteTypeX on VoteType {
  String toRawString() {
    switch (this) {
      case VoteType.agreeDelete:
        return 'proposal_agree_delete';
      case VoteType.disagreeDelete:
        return 'proposal_disagree_delete';
    }
  }

  static VoteType fromString(String? raw) {
    if (raw == 'proposal_agree_delete' || raw == 'agree') {
      return VoteType.agreeDelete;
    }
    return VoteType.disagreeDelete;
  }
}
