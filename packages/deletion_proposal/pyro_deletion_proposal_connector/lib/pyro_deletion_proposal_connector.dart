library pyro_deletion_proposal_connector;

import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';
import 'package:pyro_deletion_proposal_hub/pyro_deletion_proposal_hub.dart';
import 'package:pyro_deletion_proposal_driver/pyro_deletion_proposal_driver.dart';

/// 删除提案外观装配线 (Facade Assembly)
class PyroDeletionProposalConnector {
  static void registerAll({ProposalStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryProposalStorageDriver();
    DeletionProposalControlCenter.instance.registerStorageDriver(driver);
  }
}
