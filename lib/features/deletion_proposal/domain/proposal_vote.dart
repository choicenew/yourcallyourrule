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
      voterId: map['voterId'],
      proposalId: map['proposalId'],
      voteTime: DateTime.parse(map['voteTime']),
      isConsumed: map['isConsumed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'voterId': voterId,
      'proposalId': proposalId,
      'voteTime': voteTime.toIso8601String(),
      'isConsumed': isConsumed ? 1 : 0,
    };
  }
}