import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_crowdsourcing_arbiter/pyro_crowdsourcing_arbiter.dart';
import '../app_coordinator.dart';

final crowdsourcingArbiterProvider = Provider<CrowdsourcingArbiterService>((ref) => CrowdsourcingArbiterService());

class CrowdsourcingExchangeConnector {
  final AppCoordinator coordinator;
  final CrowdsourcingArbiterService arbiter;

  const CrowdsourcingExchangeConnector({
    required this.coordinator,
    required this.arbiter,
  });

  void initialize() {
    coordinator.on('crowdsourcing_propose_item', (payload) async {
      try {
        final domain = payload['domain'] as String? ?? 'system_rule';
        final entityKey = payload['entityKey'] as String? ?? '';
        final data = payload['payload'] as Map<String, dynamic>? ?? {};
        final deviceId = payload['deviceId'] as String? ?? '';
        final result = await arbiter.proposeItem(
          domain: domain,
          entityKey: entityKey,
          payload: data,
          deviceId: deviceId,
        );
        coordinator.emit('crowdsourcing_item_proposed', {
          'compositeKey': result?.compositeKey,
          'status': result?.status,
        });
      } catch (e) {
        debugPrint('[CrowdsourcingConnector] Error proposing crowdsourced item: $e');
      }
    });

    coordinator.on('crowdsourcing_vote_item', (payload) async {
      try {
        final domain = payload['domain'] as String? ?? 'system_rule';
        final entityKey = payload['entityKey'] as String? ?? '';
        final support = payload['support'] as bool? ?? true;
        final deviceId = payload['deviceId'] as String? ?? '';
        final updated = await arbiter.voteItem(
          domain: domain,
          entityKey: entityKey,
          support: support,
          deviceId: deviceId,
        );
        coordinator.emit('crowdsourcing_item_voted', {
          'compositeKey': updated?.compositeKey,
          'confidence': updated?.confidence,
          'status': updated?.status,
        });
      } catch (e) {
        debugPrint('[CrowdsourcingConnector] Error voting on crowdsourced item: $e');
      }
    });
  }
}

