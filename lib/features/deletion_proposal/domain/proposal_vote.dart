class ProposalVote {
  final String id;
  final String voterId;
  final String proposalId;
  final DateTime voteTime;
  final bool isConsumed;

  ProposalVote({
    required this.id,
    required this.voterId,
    required this.proposalId,
    required this.voteTime,
    required this.isConsumed,
  });

  factory ProposalVote.fromMap(Map<String, dynamic> map) {
    return ProposalVote(
      id: map['id'],
      voterId: map['voter_id'],
      proposalId: map['proposal_id'],
      voteTime: DateTime.parse(map['vote_time']),
      isConsumed: map['is_consumed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'voter_id': voterId,
      'proposal_id': proposalId,
      'vote_time': voteTime.toIso8601String(),
      'is_consumed': isConsumed ? 1 : 0,
    };
  }
}