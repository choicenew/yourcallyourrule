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
