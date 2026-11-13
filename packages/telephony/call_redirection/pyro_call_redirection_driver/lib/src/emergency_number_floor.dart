/// Emergency Number Floor Guard.
/// Ensures 911, 110, 112, 119, 999 and other emergency numbers are NEVER held or blocked.
class EmergencyNumberFloor {
  static const Set<String> _knownEmergencyNumbers = {
    '110', '119', '120', '122', // CN
    '911',                      // US/CA
    '112',                      // EU/UK
    '999',                      // UK
    '000',                      // AU
    '100', '101', '102',        // IN/IL
  };

  /// Checks if a number is a recognized emergency service number.
  static bool isEmergency(String rawNumber) {
    final clean = rawNumber.replaceAll(RegExp(r'\D'), '');
    if (clean.isEmpty) return false;
    if (_knownEmergencyNumbers.contains(clean)) return true;
    // Check short 3-digit emergency patterns
    if (clean.length <= 3 && (clean.startsWith('9') || clean.startsWith('1'))) {
      return true;
    }
    return false;
  }
}
