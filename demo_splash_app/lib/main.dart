import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 路由分支模式枚举
enum SplashBranchMode {
  singleFlag,  // 分支 1：老版单点控制（仅 first_launch 单向门阀）
  threeTier,   // 分支 2：3 步三重逻辑校验（first_launch + onboarding + initial_setup）
  configRepo,  // 分支 3：config_ JSON 字典仓库存储模式（对齐 purchase_state 使用 saveConfig/getConfig）
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DemoSplashApp());
}

class DemoSplashApp extends StatefulWidget {
  const DemoSplashApp({super.key});

  @override
  State<DemoSplashApp> createState() => _DemoSplashAppState();
}

class _DemoSplashAppState extends State<DemoSplashApp> {
  // 全局共享的分支选择模式
  SplashBranchMode _currentMode = SplashBranchMode.singleFlag;

  void _switchMode(SplashBranchMode mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Splash 方案对比测试 App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: DemoSplashScreen(
        mode: _currentMode,
        onModeChanged: _switchMode,
      ),
    );
  }
}

// 1. 开屏页 (DemoSplashScreen)
class DemoSplashScreen extends StatefulWidget {
  final SplashBranchMode mode;
  final ValueChanged<SplashBranchMode> onModeChanged;

  const DemoSplashScreen({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });

  @override
  State<DemoSplashScreen> createState() => _DemoSplashScreenState();
}

class _DemoSplashScreenState extends State<DemoSplashScreen> {
  String _logs = '点击下方【进入开屏判定】按钮执行流程...\n';
  bool _isEvaluating = false;

  void _appendLog(String text) {
    setState(() {
      _logs += '$text\n';
    });
    debugPrint(text);
  }

  Future<void> _runSplashDecision() async {
    if (_isEvaluating) return;

    setState(() {
      _isEvaluating = true;
      _logs = '🚀 开始执行开屏决策评估...\n';
    });

    final prefs = await SharedPreferences.getInstance();

    final rawFirst = prefs.get('first_launch');
    final rawOnb = prefs.get('has_completed_onboarding');
    final rawSetup = prefs.get('has_completed_initial_setup');

    final rawConfigOnb = prefs.get('config_has_completed_onboarding');
    final rawConfigSetup = prefs.get('config_has_completed_initial_setup');

    _appendLog('🔍 磁盘读取原始数据:');
    _appendLog('   • first_launch: $rawFirst (${rawFirst.runtimeType})');
    _appendLog('   • has_completed_onboarding: $rawOnb (${rawOnb.runtimeType})');
    _appendLog('   • has_completed_initial_setup: $rawSetup (${rawSetup.runtimeType})');
    _appendLog('   • config_has_completed_onboarding: $rawConfigOnb (${rawConfigOnb.runtimeType})');
    _appendLog('   • config_has_completed_initial_setup: $rawConfigSetup (${rawConfigSetup.runtimeType})');

    final bool isFirstLaunch = (rawFirst is bool)
        ? rawFirst
        : ((rawFirst is String) ? rawFirst.toLowerCase() != 'false' : true);

    bool isOnboardingCompleted = false;
    bool isInitialSetupCompleted = false;

    if (widget.mode == SplashBranchMode.configRepo) {
      try {
        if (rawConfigOnb is String) {
          final Map<String, dynamic> map = jsonDecode(rawConfigOnb);
          isOnboardingCompleted = map['value'] == true;
        }
        if (rawConfigSetup is String) {
          final Map<String, dynamic> map = jsonDecode(rawConfigSetup);
          isInitialSetupCompleted = map['value'] == true;
        }
      } catch (e) {
        _appendLog('🚨 JSON 解析异常: $e');
      }
    } else {
      isOnboardingCompleted = (rawOnb is bool)
          ? rawOnb
          : ((rawOnb is String) ? rawOnb.toLowerCase() == 'true' : false);

      isInitialSetupCompleted = (rawSetup is bool)
          ? rawSetup
          : ((rawSetup is String) ? rawSetup.toLowerCase() == 'true' : false);
    }

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    if (widget.mode == SplashBranchMode.singleFlag) {
      if (isFirstLaunch) {
        _appendLog('🚀 决策结果: 首次启动 -> 去 Onboarding 页');
        _appendLog('📝 正在执行 prefs.setBool("first_launch", false)...');
        await prefs.setBool('first_launch', false);

        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DemoOnboardingScreen(
              mode: widget.mode,
              onModeChanged: widget.onModeChanged,
            ),
          ),
        );
      } else {
        _appendLog('🚀 决策结果: 非首次启动 -> 直达 Home 主页！');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DemoHomeScreen(
              mode: widget.mode,
              onModeChanged: widget.onModeChanged,
            ),
          ),
        );
      }
    } else {
      _appendLog('📊 评估解析结果:');
      _appendLog('   • isOnboardingCompleted = $isOnboardingCompleted');
      _appendLog('   • isInitialSetupCompleted = $isInitialSetupCompleted');

      if (!isOnboardingCompleted) {
        _appendLog('🚀 决策结果: Onboarding 未完成 -> 去 Onboarding 页');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DemoOnboardingScreen(
              mode: widget.mode,
              onModeChanged: widget.onModeChanged,
            ),
          ),
        );
      } else if (!isInitialSetupCompleted) {
        _appendLog('🚀 决策结果: InitialSetup 未完成 -> 去 InitialSetup 页');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DemoInitialSetupScreen(
              mode: widget.mode,
              onModeChanged: widget.onModeChanged,
            ),
          ),
        );
      } else {
        _appendLog('🚀 决策结果: 全部完成 -> 直达 Home 主页！');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DemoHomeScreen(
              mode: widget.mode,
              onModeChanged: widget.onModeChanged,
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isEvaluating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A237E),
      appBar: AppBar(
        title: const Text('Demo Splash 测试面板', style: TextStyle(fontSize: 16, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 模式选择说明卡片
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text('请在此处自由选择你要测试的分支模式：', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SegmentedButton<SplashBranchMode>(
                        segments: const [
                          ButtonSegment(
                            value: SplashBranchMode.singleFlag,
                            label: Text('分支 1: 老版单点', style: TextStyle(fontSize: 11)),
                          ),
                          ButtonSegment(
                            value: SplashBranchMode.threeTier,
                            label: Text('分支 2: 三重逻辑', style: TextStyle(fontSize: 11)),
                          ),
                          ButtonSegment(
                            value: SplashBranchMode.configRepo,
                            label: Text('分支 3: config_ JSON', style: TextStyle(fontSize: 11)),
                          ),
                        ],
                        selected: {widget.mode},
                        onSelectionChanged: (val) {
                          widget.onModeChanged(val.first);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: _isEvaluating ? null : _runSplashDecision,
                icon: _isEvaluating
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.play_arrow_rounded),
                label: Text(_isEvaluating ? '开屏决策计算中...' : '点击【手动执行开屏决策导航】'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),

              const SizedBox(height: 16),

              // 运行日志输出卡片
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _logs,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Onboarding 引导页
class DemoOnboardingScreen extends StatelessWidget {
  final SplashBranchMode mode;
  final ValueChanged<SplashBranchMode> onModeChanged;

  const DemoOnboardingScreen({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    if (mode == SplashBranchMode.configRepo) {
      await prefs.setString(
        'config_has_completed_onboarding',
        jsonEncode({'value': true}),
      );
    } else {
      await prefs.setBool('has_completed_onboarding', true);
    }

    await prefs.setBool('first_launch', false);

    if (!context.mounted) return;

    final isSetupCompleted = prefs.getBool('has_completed_initial_setup') ?? false;
    if (!isSetupCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DemoInitialSetupScreen(
            mode: mode,
            onModeChanged: onModeChanged,
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DemoHomeScreen(
            mode: mode,
            onModeChanged: onModeChanged,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('【Onboarding 引导页】')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.flight_takeoff_rounded, size: 72, color: Colors.deepOrange),
              const SizedBox(height: 16),
              const Text('欢迎来到 Onboarding 引导界面', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                '当前选择分支: ${mode == SplashBranchMode.singleFlag ? "分支 1 (老版单点)" : (mode == SplashBranchMode.threeTier ? "分支 2 (三重校验)" : "分支 3 (config_ JSON)")}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => _finishOnboarding(context),
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('完成 Onboarding (保存并去 InitialSetup)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. Initial Setup 初始设置页
class DemoInitialSetupScreen extends StatelessWidget {
  final SplashBranchMode mode;
  final ValueChanged<SplashBranchMode> onModeChanged;

  const DemoInitialSetupScreen({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });

  Future<void> _finishInitialSetup(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    if (mode == SplashBranchMode.configRepo) {
      await prefs.setString(
        'config_has_completed_initial_setup',
        jsonEncode({'value': true}),
      );
    } else {
      await prefs.setBool('has_completed_initial_setup', true);
    }

    await prefs.setBool('first_launch', false);

    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DemoHomeScreen(
          mode: mode,
          onModeChanged: onModeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('【Initial Setup 初始设置页】')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings_suggest_rounded, size: 72, color: Colors.purple),
              const SizedBox(height: 16),
              const Text('欢迎来到 Initial Setup 规则设置界面', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => _finishInitialSetup(context),
                icon: const Icon(Icons.rocket_launch_rounded),
                label: const Text('完成 Initial Setup (保存并进入 Home)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 4. Home 主页
class DemoHomeScreen extends StatelessWidget {
  final SplashBranchMode mode;
  final ValueChanged<SplashBranchMode> onModeChanged;

  const DemoHomeScreen({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });

  Future<void> _simulateRestart(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DemoSplashScreen(
          mode: mode,
          onModeChanged: onModeChanged,
        ),
      ),
    );
  }

  Future<void> _clearAllStorage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已成功重置并清空 SharedPreferences 全部存储！')),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DemoSplashScreen(
          mode: mode,
          onModeChanged: onModeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 最终主页 (HOME)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_rounded, size: 80, color: Colors.teal),
              const SizedBox(height: 16),
              const Text('🎉 恭喜！已通关进入 HOME 主页！', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
              const SizedBox(height: 8),
              Text(
                '当前测试判定分支: ${mode == SplashBranchMode.singleFlag ? "【分支 1: 老版单点 first_launch】" : (mode == SplashBranchMode.threeTier ? "【分支 2: 3 步三重逻辑】" : "【分支 3: config_ JSON 仓库】")}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => _simulateRestart(context),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('【模拟冷重启】重新进入 Splash 开屏校验'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _clearAllStorage(context),
                icon: const Icon(Icons.restore_rounded, color: Colors.red),
                label: const Text('【清空存储】数据归零重新测试'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
