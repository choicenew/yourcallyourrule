import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/phone/utils/phone_utils.dart';

import 'package:yourcallyourrule/features/deletion_proposal/data/repositories/proposal_repository_impl.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/repositories/proposal_repository.dart';

import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';
import 'package:yourcallyourrule/features/deletion_proposer/models/server_verification_report.dart';

import '../logic/verification_logic.dart';

part 'deletion_proposer_service.g.dart';

@Riverpod(keepAlive: true)
DeletionProposerService deletionProposerService(Ref ref) {
  final proposalRepository = ref.watch(proposalRepositoryProvider);
  final deviceProfileService = ref.watch(deviceProfileServiceProvider);

  return DeletionProposerService(
    proposalRepository: proposalRepository, 
    profileService: deviceProfileService,
  );
}

class DeletionProposerService {
  final ProposalRepository _proposalRepository;
  final DeviceProfileService _profileService;

  DeletionProposerService({
    required ProposalRepository proposalRepository, 
    required DeviceProfileService profileService
  }) : _proposalRepository = proposalRepository, 
       _profileService = profileService;

  Future<VerificationResult> proposeDeletion(String phoneNumberToPropose) async {
    try {
      final rawProfile = await _profileService.getRawProfile();
      final simCountryCode = rawProfile.simInfo?.countryCode;

      final parsedInput = await PhoneUtils.parsePhoneNumberWithIso(phoneNumberToPropose, simCountryCode ?? '');
      final parsedSim = rawProfile.simInfo?.phoneNumber != null
          ? await PhoneUtils.parsePhoneNumberWithIso(rawProfile.simInfo!.phoneNumber!, simCountryCode ?? '')
          : {'e164Number': null};
      
      final verificationInput = VerificationInput(
        rawProfile: rawProfile, 
        inputNumberE164: parsedInput['e164Number'], 
        simNumberE164: parsedSim['e164Number'],
      );
      
      final verificationResult = analyzeProfile(verificationInput);
      
      if (verificationResult.riskLevel == RiskLevel.Verified || verificationResult.riskLevel == RiskLevel.Low) {
        await _proposalRepository.proposeDeletion(
          phoneNumber: phoneNumberToPropose,
          report: verificationResult.reportForServer.toJson(),
        );
        
        return VerificationResult(
          riskLevel: verificationResult.riskLevel, 
          summary: "Proposal submitted successfully!",
          flags: verificationResult.flags, 
          reportForServer: verificationResult.reportForServer,
        );
      }
      
      return verificationResult;

    } catch (e) {
      return VerificationResult(
        riskLevel: RiskLevel.High, 
        summary: "An error occurred: ${e.toString()}",
        flags: ['Error: ${e.toString()}'],
        reportForServer: const ServerVerificationReport(
          simState: 'UNKNOWN',
          finalRisk: 'High',
        ),
      );
    }
  }
}
