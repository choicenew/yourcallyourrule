// lib/features/deletion_proposer/services/deletion_proposer_service.dart

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';
import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';
import '../logic/verification_logic.dart';

class DeletionProposerService {
  final RemoteNumberDataSource _dataSource;
  final DeviceProfileService _profileService;
  static const String proposeDeletionOperation = 'PROPOSE_DELETION';
  static const String agreeToDeleteLabel = 'proposal_agree_delete';
  static const String disagreeToDeleteLabel = 'proposal_disagree_delete';

  DeletionProposerService({required RemoteNumberDataSource dataSource, required DeviceProfileService profileService})
      : _dataSource = dataSource, _profileService = profileService;

  Future<VerificationResult> proposeDeletion(String phoneNumberToPropose) async {
    try {
      final rawProfile = await _profileService.getRawProfile();
      final simCountryCode = rawProfile.simInfo?.countryCode;
      final parsedInput = await PhoneUtils.parsePhoneNumberWithIso(phoneNumberToPropose, simCountryCode ?? '');
      final parsedSim = rawProfile.simInfo?.phoneNumber != null
          ? await PhoneUtils.parsePhoneNumberWithIso(rawProfile.simInfo!.phoneNumber!, simCountryCode ?? '')
          : {'e164Number': null};
      final verificationInput = VerificationInput(
        rawProfile: rawProfile, inputNumberE164: parsedInput['e164Number'], simNumberE164: parsedSim['e164Number'],
      );
      final verificationResult = analyzeProfile(verificationInput);
      if (verificationResult.riskLevel == RiskLevel.Verified || verificationResult.riskLevel == RiskLevel.Low) {
        await _dataSource.logCustomOperation(
          proposeDeletionOperation,
          phoneNumberToPropose,
          { 'report': verificationResult.reportForServer },
        );
        return VerificationResult(
          riskLevel: verificationResult.riskLevel, summary: "Proposal submitted successfully!",
          flags: verificationResult.flags, reportForServer: verificationResult.reportForServer,
        );
      }
      return verificationResult;
    } catch (e) {
      return VerificationResult(
        riskLevel: RiskLevel.High, summary: "An error occurred: ${e.toString()}",
        flags: ['Error: ${e.toString()}'],
      );
    }
  }
  
  Future<bool> voteOnProposal(String phoneNumber, bool userAgrees) async {
    try {
      final voteLabel = userAgrees ? agreeToDeleteLabel : disagreeToDeleteLabel;
      return await _dataSource.atomicVote(phoneNumber, voteLabel);
    } catch (e) {
      print("Error voting on proposal for $phoneNumber: $e");
      return false;
    }
  }
}