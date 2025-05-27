import 'package:flutter/material.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电频率拦截设置页面
/// 用于配置来电频率拦截服务的相关参数
class TimeInterceptorSettingsPage extends StatefulWidget {
  final TimeInterceptorService timeInterceptorService;
  final ConfigRepository configRepository;

  const TimeInterceptorSettingsPage({
    super.key,
    required this.timeInterceptorService,
    required this.configRepository,
  });

  @override
  TimeInterceptorSettingsPageState createState() => TimeInterceptorSettingsPageState();
}

class TimeInterceptorSettingsPageState extends State<TimeInterceptorSettingsPage> {
  // 配置参数
  bool _isEnabled = true;
  int _durationMinutes = 30;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// 加载设置
  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 从服务中加载配置
      await widget.timeInterceptorService.loadConfig();
      final config = widget.timeInterceptorService.config;
      
      setState(() {
        _isEnabled = config.shouldIntercept;
        _durationMinutes = config.duration.inMinutes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsLoadFailed(e))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 更新服务配置
      await widget.timeInterceptorService.updateConfig(
        Duration(minutes: _durationMinutes),
        _isEnabled,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaveFailed(e))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.timeInterceptorSettingsTitle),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
              tooltip: AppLocalizations.of(context)!.saveSettings,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // 使用提取的组件
                TimeInterceptorSettingsWidget(
                  isEnabled: _isEnabled,
                  durationMinutes: _durationMinutes,
                  isLoading: _isLoading,
                  onEnabledChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                  onDurationMinutesChanged: (value) {
                    setState(() {
                      _durationMinutes = value;
                    });
                  },
                ),
              ],
            ),
    );
  }
  }
