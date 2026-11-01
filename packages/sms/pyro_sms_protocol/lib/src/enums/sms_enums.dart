/// Strategy action for SMS screening
enum SmsFilterAction {
  inherit,
  allow,
  muteNotification,
  cancelNotification,
  blockAndEvidence,
}

/// Risk level of an SMS message
enum SmsRiskLevel {
  safe,
  low,
  medium,
  high,
  critical,
}

/// Category classification of SMS content
enum SmsCategory {
  scam,
  phishing,
  debtCollector,
  marketing,
  verificationCode,
  personal,
  unknown,
}

/// Detection mechanism that flagged the SMS
enum SmsDetectionMechanism {
  googleSafeBrowsing,
  phishTank,
  openPhish,
  virusTotal,
  linkResolver,
  reDosSafetyGuard,
  mlClassifier,
  naiveBayes,
  burstProtection,
  notificationListener,
  regexRules,
  userBlacklist,
}
