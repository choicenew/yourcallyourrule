class ProposalSubmission {
  final String id;
  final String proposerId;
  final String phoneNumber;
  final DateTime submissionTime;

  ProposalSubmission({
    required this.id,
    required this.proposerId,
    required this.phoneNumber,
    required this.submissionTime,
  });

  factory ProposalSubmission.fromMap(Map<String, dynamic> map) {
    return ProposalSubmission(
      id: map['id'],
      proposerId: map['proposer_id'],
      phoneNumber: map['phone_number'],
      submissionTime: DateTime.parse(map['submission_time']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proposer_id': proposerId,
      'phone_number': phoneNumber,
      'submission_time': submissionTime.toIso8601String(),
    };
  }
}