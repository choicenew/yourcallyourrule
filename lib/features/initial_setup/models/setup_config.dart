class CountryData {
  final String id;
  final String countryCode;
  final String name;
  final String iconUrl;
  final String description;
  final String manifestUrl;
  final String cdnManifestUrl;

  CountryData({
    required this.id,
    this.countryCode = '',
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.manifestUrl,
    this.cdnManifestUrl = '',
  });

  String getEffectiveUrl({bool useCdn = false}) {
    if (useCdn && cdnManifestUrl.isNotEmpty) {
      return cdnManifestUrl;
    }
    return manifestUrl;
  }

  factory CountryData.fromMap(Map<String, dynamic> map) {
    // 兼容真实 GitHub 发布的 JSON (rulesets 列表中的 source_id / country_code / full_download_url)
    final effectiveId = map['source_id']?.toString() ??
        map['country_code']?.toString() ??
        map['id']?.toString() ??
        '';

    final countryCode = map['country_code']?.toString() ?? map['id']?.toString() ?? '';

    final effectiveUrl = map['full_download_url']?.toString() ??
        map['manifest_url']?.toString() ??
        '';

    final cdnUrl = map['cdn_manifest_url']?.toString() ?? '';

    return CountryData(
      id: effectiveId,
      countryCode: countryCode,
      name: map['name']?.toString() ?? '',
      iconUrl: map['icon_url']?.toString() ?? '',
      description: map['description']?.toString() ??
          (map['rule_type'] != null ? '规则类型: ${map['rule_type']}' : ''),
      manifestUrl: effectiveUrl,
      cdnManifestUrl: cdnUrl,
    );
  }
}

class PluginRecommendation {
  final String title;
  final String description;
  final String webPortalUrl;

  PluginRecommendation({
    required this.title,
    required this.description,
    required this.webPortalUrl,
  });

  factory PluginRecommendation.fromMap(Map<String, dynamic> map) {
    return PluginRecommendation(
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      webPortalUrl: map['web_portal_url']?.toString() ?? '',
    );
  }
}

class SetupConfig {
  final String version;
  final List<CountryData> countriesData;
  final PluginRecommendation? pluginsRecommendation;

  SetupConfig({
    required this.version,
    required this.countriesData,
    this.pluginsRecommendation,
  });

  factory SetupConfig.fromMap(Map<String, dynamic> map) {
    // 兼容真实 GitHub 发布的 JSON 中的 rulesets 根数组与 config_version
    final rawList = map['rulesets'] as List? ??
        map['countries_data'] as List? ??
        [];

    return SetupConfig(
      version: map['config_version']?.toString() ??
          map['version']?.toString() ??
          '1.0',
      countriesData: List<CountryData>.from(
        rawList.map((x) => CountryData.fromMap(x as Map<String, dynamic>)),
      ),
      pluginsRecommendation: map['plugins_recommendation'] != null
          ? PluginRecommendation.fromMap(
              map['plugins_recommendation'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
