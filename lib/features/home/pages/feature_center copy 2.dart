import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class FeatureCenter extends StatefulWidget {
  const FeatureCenter({super.key});

  @override
  State<FeatureCenter> createState() => _FeatureCenterState();
}

class _Feature {
  final String Function(AppLocalizations) title;
  final IconData icon;
  final String route;
  final Color color;

  _Feature(
      {required this.title,
      required this.icon,
      required this.route,
      required this.color});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Feature &&
          runtimeType == other.runtimeType &&
          route == other.route;

  @override
  int get hashCode => route.hashCode;
}

class _FeatureCenterState extends State<FeatureCenter> {
  late List<_Feature> _features;

  Color _randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2);
  }

  @override
  void initState() {
    super.initState();
    _features = [
      _Feature(
        title: (l) => l.markPhoneManagementTitle,
        icon: Icons.label,
        route: '/mark-phone-management-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.pluginManagement,
        icon: Icons.extension,
        route: '/plugin-management-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.allowBlock,
        icon: Icons.block,
        route: '/allowed-blocked-settings-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.blackWhiteList,
        icon: Icons.list,
        route: '/rule-management-settings-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.regexRules,
        icon: Icons.code,
        route: '/regex-rule-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.phoneSubscription,
        icon: Icons.phone_callback,
        route: '/phone-subscription-with-ads',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.callHistory,
        icon: Icons.call,
        route: '/call-history',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.contacts,
        icon: Icons.contacts,
        route: '/contacts-management',
        color: _randomColor(),
      ),
      _Feature(
        title: (l) => l.statistics,
        icon: Icons.bar_chart,
        route: '/call-statistics',
        color: _randomColor(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.featureCenter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: _features.asMap().entries.map((entry) {
                final index = entry.key;
                final feature = entry.value;

                final featureItem = _buildFeatureItem(
                  context: context,
                  title: feature.title(AppLocalizations.of(context)!),
                  icon: feature.icon,
                  color: feature.color,
                  onTap: () => context.push(feature.route),
                );

                return LongPressDraggable<_Feature>(
                  data: feature,
                  feedback: Material(
                    elevation: 4.0,
                    child: featureItem,
                  ),
                  childWhenDragging: Container(),
                  child: DragTarget<_Feature>(
                    onWillAccept: (data) => data != feature,
                    onAccept: (data) {
                      setState(() {
                        final oldIndex = _features.indexOf(data);
                        final newIndex =
                            index > oldIndex ? index - 1 : index;
                        if (oldIndex != -1) {
                          final item = _features.removeAt(oldIndex);
                          _features.insert(newIndex, item);
                        }
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return featureItem;
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}