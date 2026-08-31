import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// [重构]: 转换为自包含的 ConsumerWidget。
class RemoteFilterSettingsWidget extends ConsumerWidget {
  // [重构]: 移除所有构造函数参数。
  const RemoteFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [修正]: 使用 .select 只监听数据，避免UI闪烁。
    final config = ref.watch(remoteNumberFilterConfigProvider.select((v) => v.value));
    
    // [修正]: 初始加载时显示加载指示器。
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final notifier = ref.read(remoteNumberFilterConfigProvider.notifier);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.enableRemoteNumberFilterDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.enableRemoteNumberFilter,
                onChanged: (value) => notifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0ECE3)),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.rejectExceededNumbers, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.rejectExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0ECE3)),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.prioritizeRemoteActionDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.prioritizeRemoteAction,
                onChanged: (value) => notifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0ECE3)),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.logAllRemoteQueries, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.logAllRemoteQueriesDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.logAllRemoteQueries,
                onChanged: (value) => notifier.updateConfig(config.copyWith(logAllRemoteQueries: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.countThresholdLabel,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${config.countThreshold}',
                      style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFFF9500), fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: config.countThreshold.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: const Color(0xFFFF9500),
                inactiveColor: const Color(0xFFEDE8DF),
                label: config.countThreshold.toString(),
                onChanged: (value) => notifier.updateConfig(config.copyWith(countThreshold: value.round())),
              ),
              Text(
                AppLocalizations.of(context)!.countThresholdDescription,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}