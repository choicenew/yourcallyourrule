/// Outcome action for an outbound call redirection evaluation.
enum RedirectionAction {
  /// Allow the outbound call to proceed normally without modification.
  proceed,

  /// Cancel/hold the outbound call and show a "Call Anyway" notification.
  holdAndNotify,

  /// Block the outbound call entirely.
  block,
}

/// Reason for holding or blocking an outbound call.
enum RedirectionHoldReason {
  /// Matched a known Wangiri / One-ring callback scam number.
  wangiriScam,

  /// Matched a high-cost premium rate number.
  premiumRateNumber,

  /// Explicitly in user blocklist.
  userBlocklist,

  /// Matched community/cloud spam database.
  databaseMatch,

  /// Emergency call floor override (Proceed).
  emergencyOverride,
}

/// Strongly-typed Channel contract constants.
abstract final class RedirectionChannels {
  static const String channelName = 'com.yours.yourcallyourrule/call_redirection';
  static const String methodEvaluateCall = 'evaluateCall';
  static const String methodIsRoleGranted = 'isRoleGranted';
  static const String methodRequestRole = 'requestRole';
}

/// Strongly-typed Map key constants for IPC marshalling.
abstract final class RedirectionMapKeys {
  static const String id = 'id';
  static const String rawPhoneNumber = 'rawPhoneNumber';
  static const String normalizedPhoneNumber = 'normalizedPhoneNumber';
  static const String timestampMs = 'timestampMs';
  static const String isInteractiveAllowed = 'isInteractiveAllowed';
  static const String isCarModeActive = 'isCarModeActive';
  static const String action = 'action';
  static const String reason = 'reason';
  static const String description = 'description';
  static const String evaluationTimeMs = 'evaluationTimeMs';
}
