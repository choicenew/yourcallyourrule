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
      proposerId: map['proposerId'],
      phoneNumber: map['phoneNumber'],
      submissionTime: DateTime.parse(map['submissionTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proposerId': proposerId,
      'phoneNumber': phoneNumber,
      'submissionTime': submissionTime.toIso8601String(),
    };
  }
}