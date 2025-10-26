import 'dart:convert';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';



/// 代表一个从数据库或服务器获取的、完整的删除提议领域模型。
///
/// 此模型直接映射到本地 `active_deletion_proposals` 表和服务器 `deletion_proposals` 表的核心字段。
/// 它通过 `verificationReportJson` 字段承载了包括 `reason` 在内的详细报告信息。
class Proposal {
  /// 提议的电话号码 (主键)。
  final String phoneNumber;

  /// 提议的起始时间。
  final DateTime proposalStartTime;

  /// 提议的当前状态 (pending, approved, rejected, etc.)。
  final ProposalStatus status;

  /// 在所有提交的验证报告中记录到的最高风险等级 (e.g., 'Verified', 'Low')。
  final String highestRiskLevel;

  /// 此号码被提议删除的总次数。
  final int proposalCount;

  /// 提议者被验证为号码所有者的次数。
  final int verifiedOwnerCount;

  /// 此记录在数据库中最后一次被更新的时间。
  final DateTime lastUpdated;

  /// 包含详细验证报告的原始JSON字符串。
  /// `reason` 字段被封装在此JSON中。
  final String? verificationReportJson;
// 【MODIFIED】: 新增了 `labels_json` 字段，以匹配从服务器同步回来的数据。
  final String? labelsJson;
  /// 标准的公共构造函数。
  Proposal({
    required this.phoneNumber,
    required this.proposalStartTime,
    required this.status,
    required this.highestRiskLevel,
    required this.proposalCount,
    required this.verifiedOwnerCount,
    required this.lastUpdated,
    this.verificationReportJson,
      this.labelsJson, // 【MODIFIED】
  });

  /// 工厂方法：从 Map (通常来自数据库) 安全地创建 `Proposal` 实例。
  ///
  /// 负责验证和解析所有字段，并在数据格式不正确时抛出异常。
  factory Proposal.fromMap(Map<String, dynamic> map) {
    try {
      return Proposal(
        phoneNumber: map['phoneNumber'] as String,
        proposalStartTime: DateTime.parse(map['proposal_start_time'] as String),
        status: ProposalStatus.fromString(map['status'] as String),
        highestRiskLevel: map['highest_risk_level'] as String,
        proposalCount: map['proposal_count'] as int,
        verifiedOwnerCount: map['verified_owner_count'] as int,
        lastUpdated: DateTime.parse(map['last_updated'] as String),
        verificationReportJson: map['verificationReportJson'] as String?,
           // 【MODIFIED】: 从 map 中读取 `labels_json`
        labelsJson: map['labels_json'] as String?,
      );
    } catch (e, stackTrace) {
      // 抛出一个更详细的异常，便于调试。
      throw FormatException(
        'Failed to parse Proposal from map. \nMap data: $map \nError: $e',
        stackTrace,
      );
    }
  }

  /// 将 `Proposal` 实例转换为 Map，用于写入数据库。
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'proposal_start_time': proposalStartTime.toIso8601String(),
      'status': status.name,
      'highest_risk_level': highestRiskLevel,
      'proposal_count': proposalCount,
      'verified_owner_count': verifiedOwnerCount,
      'last_updated': lastUpdated.toIso8601String(),
      'verificationReportJson': verificationReportJson,
    };
  }
  
  // =======================================================================
  // SECTION: 业务逻辑 Getters
  // =======================================================================

  /// 一个私有的、带缓存的辅助 getter，用于安全地解析 `verificationReportJson`。
  /// 它只在第一次被调用时解析JSON，之后会返回缓存的结果，以提高性能。
  Map<String, dynamic>? __verificationReport;
  Map<String, dynamic>? get _verificationReport {
    // 如果已经解析过，直接返回缓存的结果
    if (__verificationReport != null) return __verificationReport;

    final jsonString = verificationReportJson;
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      
      // 检查服务器返回的数据结构，它可能将 report 嵌套在另一个 'report' 键下。
      // 这个 getter 能够处理 `{"report":{...}}` 和 `{{...}}` 两种情况。
      final reportData = (decoded.containsKey('report') && decoded['report'] is Map)
          ? decoded['report']
          : decoded;
          
      // 缓存解析结果
      __verificationReport = reportData as Map<String, dynamic>;
      return __verificationReport;
    } catch (_) {
      // 如果JSON解析失败，返回null，防止应用崩溃
      return null;
    }
  }
  
  /// 【核心】: 提供一个公开、方便的 getter 来直接访问提议的 `reason`。
  ///
  /// UI层可以直接调用 `proposal.reason`，无需关心底层的JSON解析。
  String get reason {
    // 从已解析的 `_verificationReport` 中安全地读取 'reason' 字段。
    // 如果 report 不存在或其中没有 'reason'，则返回一个清晰的默认值。
    return _verificationReport?['reason'] as String? ?? 'No reason provided.';
  }

  // =======================================================================
  // 【核心修正】: 完整地、正确地添加了 `verificationReport` getter。
  // REASON: 这是我之前承诺但遗漏的关键功能，用于 UI 层方便地访问报告内容。
  // =======================================================================
  Map<String, dynamic>? get verificationReport {
    return _verificationReport;
  }

  // =======================================================================
  // 【核心修正】: 提供直接访问支持票和反对票的 Getters
  // =======================================================================

  /// 一个私有的、带缓存的辅助 getter，用于解析 `labels_json`。
  Map<String, int>? __votes;
  Map<String, int> get _votes {
    if (__votes != null) return __votes!;
    
    final jsonString = labelsJson;
    if (jsonString == null || jsonString.isEmpty) {
      return __votes = {};
    }
    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      // 确保 value 是 int 类型
      return __votes = decoded.map((key, value) => MapEntry(key, value as int));
    } catch (_) {
      return __votes = {};
    }
  }
  
  /// 获取支持删除的票数。
  int get supportVotes {
    return _votes['proposal_agree_delete'] ?? 0;
  }
  
  /// 获取反对删除的票数。
  int get opposeVotes {
    return _votes['proposal_disagree_delete'] ?? 0;
  }
  
  /// 获取总的投票数（支持+反对+其他）。
  int get totalVotes {
    if (_votes.isEmpty) return 0;
    return _votes.values.reduce((sum, count) => sum + count);
  }


  /// 判断此提议是否还处于可投票/可操作的状态。
  bool get isActionable => status == ProposalStatus.pending;

  /// 判断此提议是否已结束（无论是被批准、被拒绝还是已过期）。
  bool get isFinished => status != ProposalStatus.pending;
}