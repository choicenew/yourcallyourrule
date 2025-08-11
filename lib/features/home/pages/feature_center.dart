import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/home/services/feature_center_config_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final featureCenterConfigServiceProvider = Provider((ref) {
  // This assumes you have a provider for your config repository
  final configRepository = ref.watch(configRepositoryProvider);
  return FeatureCenterConfigService(configRepository);
});

// A placeholder for your actual config repository provider
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  // Replace with your actual implementation, e.g.:
  return SharedPreferencesConfigRepository();
});

class FeatureCenter extends ConsumerStatefulWidget {
  const FeatureCenter({super.key});

  @override
  ConsumerState<FeatureCenter> createState() => _FeatureCenterState();
}

class _Feature {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  Color color;

  _Feature({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    this.color = Colors.blue,
  });
}

class _FeatureCenterState extends ConsumerState<FeatureCenter> {
  final List<_Feature> _features = [];
  final _random = Random();
  bool _isDragging = false;

  Color _randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2);
  }

  @override
  void initState() {
    super.initState();
    _initializeFeatures();
  }

  Future<void> _initializeFeatures() async {
    final l10n = AppLocalizations.of(context)!;
    final service = ref.read(featureCenterConfigServiceProvider);
    final featureOrder = await service.getFeatureOrder();

    final defaultFeatures = [
      _Feature(
          id: 'call_filter',
          title: l10n.callFilter,
          icon: Icons.filter_list,
          route: '/call-filter',
          color: _randomColor()),
      _Feature(
          id: 'call_statistics',
          title: l10n.statistics,
          icon: Icons.bar_chart,
          route: '/call-statistics',
          color: _randomColor()),
      _Feature(
          id: 'plugin_management',
          title: l10n.pluginManagement,
          icon: Icons.extension,
          route: '/plugin-management',
          color: _randomColor()),
      _Feature(
          id: 'mark_phone_management',
          title: l10n.markPhoneManagementTitle,
          icon: Icons.label,
          route: '/mark-phone-management-with-ads',
          color: _randomColor()),
      _Feature(
          id: 'contacts_management',
          title: l10n.contacts,
          icon: Icons.contacts,
          route: '/contacts-management',
          color: _randomColor()),
      _Feature(
          id: 'rules_management',
          title: l10n.rules,
          icon: Icons.rule,
          route: '/rules-management',
          color: _randomColor()),
      _Feature(
          id: 'caller_id',
          title: l10n.callerId,
          icon: Icons.perm_contact_calendar,
          route: '/caller-id',
          color: _randomColor()),
      _Feature(
          id: 'language_settings',
          title: l10n.language,
          icon: Icons.language,
          route: '/language-settings',
          color: _randomColor()),
    ];

    if (featureOrder.isEmpty) {
      _features.addAll(defaultFeatures);
    } else {
      final featureMap = {for (var f in defaultFeatures) f.id: f};
      for (var id in featureOrder) {
        if (featureMap.containsKey(id)) {
          _features.add(featureMap[id]!);
          featureMap.remove(id);
        }
      }
      _features.addAll(featureMap.values); // Add any new features
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _saveFeatureOrder() {
    final service = ref.read(featureCenterConfigServiceProvider);
    final featureOrder = _features.map((f) => f.id).toList();
    service.saveFeatureOrder(featureOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.featureCenter),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (context, index) {
          final feature = _features[index];
          return LongPressDraggable<_Feature>(
            data: feature,
            feedback: _buildFeedbackWidget(feature),
            childWhenDragging: _buildDraggingWidget(feature),
            onDragStarted: () {
              setState(() {
                _isDragging = true;
              });
            },
            onDragEnd: (details) {
              setState(() {
                _isDragging = false;
              });
            },
            child: DragTarget<_Feature>(
              onWillAcceptWithDetails: (details) {
                return details.data != feature;
              },
              onAcceptWithDetails: (details) {
                setState(() {
                  final oldIndex = _features.indexOf(details.data);
                  final newIndex = _features.indexOf(feature);
                  final item = _features.removeAt(oldIndex);
                  _features.insert(newIndex, item);
                  _saveFeatureOrder();
                });
              },
              builder: (context, candidateData, rejectedData) {
                return _buildFeatureItem(
                  context: context,
                  feature: feature,
                  isBeingDragged: candidateData.isNotEmpty,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackWidget(_Feature feature) {
    return Material(
      elevation: 4.0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: feature.color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(feature.icon, size: 40.0, color: Colors.white),
            const SizedBox(height: 8.0),
            Text(
              feature.title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggingWidget(_Feature feature) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Opacity(
        opacity: 0.5,
        child: _buildFeatureItem(context: context, feature: feature),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required _Feature feature,
    bool isBeingDragged = false,
  }) {
    return GestureDetector(
      onTap: () => context.push(feature.route),
      child: Container(
        decoration: BoxDecoration(
          color: isBeingDragged ? Colors.blue.withOpacity(0.2) : feature.color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(feature.icon, size: 40.0, color: Colors.white),
            const SizedBox(height: 8.0),
            Text(
              feature.title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}