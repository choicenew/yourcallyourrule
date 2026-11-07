/// 广告数据源标量配置与插槽契约模型 (Ad Source Model)
class AdSourceModel {
  final String id;
  final String placementId;
  final String format;
  final Map<String, dynamic> extras;

  const AdSourceModel({
    required this.id,
    required this.placementId,
    this.format = 'banner',
    this.extras = const {},
  });

  factory AdSourceModel.fromMap(Map<String, dynamic> map) {
    return AdSourceModel(
      id: map['id']?.toString() ?? '',
      placementId: map['placementId']?.toString() ?? '',
      format: map['format']?.toString() ?? 'banner',
      extras: map['extras'] is Map<String, dynamic>
          ? map['extras'] as Map<String, dynamic>
          : const {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'placementId': placementId,
      'format': format,
      'extras': extras,
    };
  }
}
