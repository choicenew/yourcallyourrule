/// Car Mode & Non-Interactive Response Guard.
/// Prevents holding calls when the user cannot interact with notifications (e.g. driving / car mode).
class CarModeGuard {
  /// Evaluates whether an outbound call hold is safe to display.
  static bool canShowInteractiveHold({
    required bool isCarModeActive,
    required bool isInteractiveAllowed,
  }) {
    // If driving or interactive responses are refused by Telecom, do NOT hold.
    if (isCarModeActive || !isInteractiveAllowed) {
      return false;
    }
    return true;
  }
}
