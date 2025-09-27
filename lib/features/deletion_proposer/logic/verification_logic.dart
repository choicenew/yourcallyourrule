// lib/features/deletion_proposer/logic/verification_logic.dart

import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';

enum RiskLevel { Verified, Low, Medium, High }

class VerificationResult {
  final RiskLevel riskLevel;
  final String summary;
  final List<String> flags;
  final Map<String, dynamic> reportForServer;
  VerificationResult({required this.riskLevel, required this.summary, this.flags = const [], this.reportForServer = const {}});
}

class VerificationInput {
  final RawDeviceProfile rawProfile;
  final String? inputNumberE164, simNumberE164;
  VerificationInput({required this.rawProfile, this.inputNumberE164, this.simNumberE164});
}

VerificationResult analyzeProfile(VerificationInput input) {
  final List<String> flags = [];
  int riskScore = 0;
  final profile = input.rawProfile;
  final simState = profile.simState?.toUpperCase() ?? 'UNKNOWN';
  final isRoaming = profile.simInfo?.isNetworkRoaming ?? false;
  final simCountryCode = profile.simInfo?.countryCode?.toUpperCase();
  final ipCountryCode = profile.ipInfo?.countryCode?.toUpperCase();

  if (simState != 'READY') {
    flags.add("High Risk: SIM State is '$simState'.");
    return VerificationResult(
      riskLevel: RiskLevel.High, summary: "Verification failed: SIM card is not active.", flags: flags,
      reportForServer: {'simState': simState, 'finalRisk': 'High', 'deviceId': profile.hashedDeviceId}
    );
  } else {
    flags.add("SIM State: READY (✓)");
  }

  bool hasLocationData = simCountryCode != null && ipCountryCode != null;
  if (hasLocationData) {
      bool countriesMatch = simCountryCode == ipCountryCode;
      if (isRoaming) {
        if (countriesMatch) { riskScore += 8; flags.add("High Risk: Roaming with matching IP country."); } 
        else { riskScore += 3; flags.add("Medium Risk: Roaming internationally."); }
      } else {
        if (!countriesMatch) { riskScore += 7; flags.add("High Risk: Not roaming but IP country differs."); } 
        else { flags.add("Location Consistent (✓)"); }
      }
  } else {
      riskScore += 2; flags.add("Medium Risk: Location data incomplete.");
  }
  
  bool isNumberMatch = input.simNumberE164 != null && input.simNumberE164!.isNotEmpty && input.simNumberE164 == input.inputNumberE164;
  
  final serverReport = {
    'simState': simState, 'isRoaming': isRoaming, 'simCountry': simCountryCode,
    'ipCountry': ipCountryCode, 'isNumberMatch': isNumberMatch, 'deviceId': profile.hashedDeviceId,
  };

  if (isNumberMatch) {
    flags.add("OWNERSHIP VERIFIED (✓)");
    return VerificationResult(
      riskLevel: RiskLevel.Verified, summary: "Ownership Verified: The entered number matches the device's SIM.",
      flags: flags, reportForServer: {...serverReport, 'finalRisk': 'Verified'},
    );
  } else {
    flags.add("Ownership Not Verified.");
    riskScore += 5; 
    RiskLevel finalRisk; String summary;
    if (riskScore >= 9) { finalRisk = RiskLevel.High; summary = "High risk profile and ownership not verified."; } 
    else if (riskScore >= 4) { finalRisk = RiskLevel.Medium; summary = "Medium risk profile and ownership not verified."; } 
    else { finalRisk = RiskLevel.Low; summary = "Low risk profile, but ownership not verified."; }
    return VerificationResult(
      riskLevel: finalRisk, summary: summary, flags: flags,
      reportForServer: {...serverReport, 'finalRisk': finalRisk.toString().split('.').last, 'riskScore': riskScore },
    );
  }
}