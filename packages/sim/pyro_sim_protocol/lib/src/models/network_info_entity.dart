/// Network cellular generation (2G–5G) derived from sim_reader & sim_card_code.
enum NetworkGeneration { g2, g3, g4, g5, unknown }

extension NetworkGenerationExtension on NetworkGeneration {
  String get label {
    switch (this) {
      case NetworkGeneration.g2:
        return '2G';
      case NetworkGeneration.g3:
        return '3G';
      case NetworkGeneration.g4:
        return '4G';
      case NetworkGeneration.g5:
        return '5G';
      case NetworkGeneration.unknown:
        return 'Unknown';
    }
  }
}

/// Network info entity incorporating sim_reader and sim_card_code fields.
class NetworkInfoEntity {
  final String networkOperatorName;
  final String networkOperator;
  final String networkType;
  final bool isNetworkAvailable;
  final bool isRoaming;
  final int? signalStrength;

  const NetworkInfoEntity({
    required this.networkOperatorName,
    required this.networkOperator,
    required this.networkType,
    this.isNetworkAvailable = false,
    this.isRoaming = false,
    this.signalStrength,
  });

  NetworkGeneration get generation {
    final type = networkType.toUpperCase();
    if (type.contains('5G') || type.contains('NR')) return NetworkGeneration.g5;
    if (type.contains('LTE')) return NetworkGeneration.g4;
    if (type.contains('UMTS') || type.contains('HSPA') || type.contains('EVDO') || type.contains('3G')) return NetworkGeneration.g3;
    if (type.contains('GPRS') || type.contains('EDGE') || type.contains('2G')) return NetworkGeneration.g2;
    return NetworkGeneration.unknown;
  }

  Map<String, dynamic> toMap() {
    return {
      'networkOperatorName': networkOperatorName,
      'networkOperator': networkOperator,
      'networkType': networkType,
      'isNetworkAvailable': isNetworkAvailable,
      'isRoaming': isRoaming,
      'signalStrength': signalStrength,
    };
  }

  factory NetworkInfoEntity.fromMap(Map<dynamic, dynamic> map) {
    return NetworkInfoEntity(
      networkOperatorName: (map['networkOperatorName'] ?? map['operatorName'] ?? '').toString(),
      networkOperator: (map['networkOperator'] ?? '').toString(),
      networkType: (map['networkType'] ?? '').toString(),
      isNetworkAvailable: map['isNetworkAvailable'] as bool? ?? true,
      isRoaming: map['isRoaming'] as bool? ?? map['isNetworkRoaming'] as bool? ?? false,
      signalStrength: map['signalStrength'] is int ? map['signalStrength'] as int : null,
    );
  }
}
