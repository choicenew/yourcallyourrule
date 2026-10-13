class CountryData {
  final String id;
  final String name;
  final String iconUrl;
  final String description;
  final String manifestUrl;

  CountryData({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.manifestUrl,
  });

  factory CountryData.fromMap(Map<String, dynamic> map) {
    return CountryData(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      iconUrl: map['icon_url']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      manifestUrl: map['manifest_url']?.toString() ?? '',
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
    return SetupConfig(
      version: map['version']?.toString() ?? '1.0',
      countriesData: List<CountryData>.from(
        (map['countries_data'] as List? ?? []).map((x) => CountryData.fromMap(x as Map<String, dynamic>)),
      ),
      pluginsRecommendation: map['plugins_recommendation'] != null
          ? PluginRecommendation.fromMap(map['plugins_recommendation'] as Map<String, dynamic>)
          : null,
    );
  }
}
