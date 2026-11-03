/// Action types available when executing a call interception decision.
enum CallActionType {
  /// Allow call to ring through without intervention.
  allow,

  /// Immediately reject/hangup the incoming call at system level.
  reject,

  /// Silence the incoming call ringer without hanging up.
  silence,

  /// Answer call immediately, hold for configured duration (e.g. 1s), then hangup.
  /// Used to disrupt autodialer bots and charge spam callers.
  answerThenHangup,

  /// Redirect or send caller directly to voicemail.
  voicemail;

  /// Parse action type from String representation.
  static CallActionType fromString(String raw) {
    switch (raw.trim().toLowerCase()) {
      case 'reject':
      case 'block':
      case 'disallow':
        return CallActionType.reject;
      case 'silence':
        return CallActionType.silence;
      case 'answerthenhangup':
      case 'answer_then_hangup':
        return CallActionType.answerThenHangup;
      case 'voicemail':
        return CallActionType.voicemail;
      case 'allow':
      default:
        return CallActionType.allow;
    }
  }

  /// Convert action type to standard string code.
  String toCode() {
    switch (this) {
      case CallActionType.allow:
        return 'allow';
      case CallActionType.reject:
        return 'reject';
      case CallActionType.silence:
        return 'silence';
      case CallActionType.answerThenHangup:
        return 'answerThenHangup';
      case CallActionType.voicemail:
        return 'voicemail';
    }
  }
}
