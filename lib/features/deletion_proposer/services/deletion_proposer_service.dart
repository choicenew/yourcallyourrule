import 'package:flutter_riverpod/flutter_riverpod.dart'; // 为了使用 Provider
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

// 【MODIFIED】: 引入了新的、统一的 Repository Provider。
// REASON: Service 层现在依赖于抽象，而不是具体的数据源实现，实现了依赖倒置。
import 'package:yourcallyourrule/features/deletion_proposal/providers/proposal_repository_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/repositories/proposal_repository.dart';
import 'package:yourcallyourrule/features/device_profile/provider/device_profile_service_provider.dart';

// 【MODIFIED】: 引入了 DeviceProfileService 的 Provider。
// REASON: 遵循 Riverpod 的依赖注入模式，不再通过构造函数传递。
import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';

import '../logic/verification_logic.dart'; // 保持不变

// =======================================================================
// 【MODIFIED】: 创建一个新的 Provider 来提供 DeletionProposerService 的实例。
// REASON: 这是 Riverpod 的标准做法，使得该 Service 可以在应用的任何地方被轻松访问和测试。
// =======================================================================
final deletionProposerServiceProvider = Provider<DeletionProposerService>((ref) {
  // 1. 从各自的 Provider 中获取依赖项。
  final proposalRepository = ref.watch(proposalRepositoryProvider);
  final deviceProfileService = ref.watch(deviceProfileServiceProvider); // 假设您有一个 `deviceProfileServiceProvider`

  // 2. 创建并返回 Service 实例。
  return DeletionProposerService(
    proposalRepository: proposalRepository, 
    profileService: deviceProfileService,
  );
});


/// 提议创建服务。
///
/// 它的唯一职责是：
/// 1. 对用户设备进行安全验证。
/// 2. 如果验证通过，则创建一个“提议删除”操作并将其记录到待同步队列。
class DeletionProposerService {
  // 【MODIFIED】: 依赖项从具体的数据源改为了 Repository 抽象。
  final ProposalRepository _proposalRepository;
  final DeviceProfileService _profileService;

  // 【MODIFIED】: 构造函数现在接收 Repository。
  DeletionProposerService({
    required ProposalRepository proposalRepository, 
    required DeviceProfileService profileService
  }) : _proposalRepository = proposalRepository, 
       _profileService = profileService;

  /// 提议删除一个号码。
  ///
  /// 此方法执行完整的设备验证流程，如果风险等级足够低，
  /// 它会调用 Repository 将提议操作记录到 `pending_operations` 表。
  ///
  /// [phoneNumberToPropose] 用户想要提议删除的电话号码。
  ///
  /// 返回一个 `VerificationResult` 对象，其中包含了验证的结果和状态。
  Future<VerificationResult> proposeDeletion(String phoneNumberToPropose) async {
    try {
      // 1. 获取设备原始信息
      final rawProfile = await _profileService.getRawProfile();
      final simCountryCode = rawProfile.simInfo?.countryCode;

      // 2. 解析电话号码
      final parsedInput = await PhoneUtils.parsePhoneNumberWithIso(phoneNumberToPropose, simCountryCode ?? '');
      final parsedSim = rawProfile.simInfo?.phoneNumber != null
          ? await PhoneUtils.parsePhoneNumberWithIso(rawProfile.simInfo!.phoneNumber!, simCountryCode ?? '')
          : {'e164Number': null};
      
      // 3. 准备验证输入
      final verificationInput = VerificationInput(
        rawProfile: rawProfile, 
        inputNumberE164: parsedInput['e164Number'], 
        simNumberE164: parsedSim['e164Number'],
      );
      
      // 4. 分析设备画像，得出验证结果
      final verificationResult = analyzeProfile(verificationInput);
      
      // 5. 如果风险等级足够低（已验证或低风险），则记录操作
      if (verificationResult.riskLevel == RiskLevel.Verified || verificationResult.riskLevel == RiskLevel.Low) {
        
        // 【MODIFIED】: 调用了 `ProposalRepository` 中正确的、职责清晰的方法。
        // REASON: `proposeDeletion` 方法（旧的 logCustomOperation）现在被正确地封装在 `ProposalRepository` 中。
        await _proposalRepository.proposeDeletion(
          phoneNumber: phoneNumberToPropose,
          report: verificationResult.reportForServer,
        );
        
        // 返回一个表示成功提交的结果
        return VerificationResult(
          riskLevel: verificationResult.riskLevel, 
          summary: "Proposal submitted successfully!",
          flags: verificationResult.flags, 
          reportForServer: verificationResult.reportForServer,
        );
      }
      
      // 6. 如果风险等级过高，直接返回验证失败的结果，不记录任何操作
      return verificationResult;

    } catch (e) {
      // 捕获任何潜在的异常，并返回一个表示错误的结果
      return VerificationResult(
        riskLevel: RiskLevel.High, 
        summary: "An error occurred: ${e.toString()}",
        flags: ['Error: ${e.toString()}'],
      );
    }
  }
  
  // =======================================================================
  // 【MODIFIED】: `voteOnProposal` 方法已被移除。
  // REASON: 根据职责分离原则，`DeletionProposerService` 只负责“创建”提议。
  //         “投票”是另一个独立的业务逻辑，它应该由我们之前重构的
  //         `DeletionProposalService` 来处理。将两个职责混在一个类中
  //         会导致逻辑混乱。
  // =======================================================================
  //
  // REMOVED: Future<bool> voteOnProposal(...)
  //
}