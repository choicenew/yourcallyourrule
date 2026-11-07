import 'package:material_ui/material_ui.dart';
import 'launch_stage.dart';
import 'launch_config.dart';
import 'launch_pipeline_controller.dart';

typedef OnboardingWidgetBuilder = Widget Function(BuildContext context, VoidCallback onComplete);

/// 极简启动门禁装配 Widget (Pyro App Launch Guard)
class PyroAppLaunchGuard extends StatefulWidget {
  /// 主 App 入口 Widget (可选，配合组件包裹模式)
  final Widget? child;

  /// 初始化任务队列
  final List<Future<void> Function()> initializers;

  /// 引导页 / 隐私政策构建器
  final OnboardingWidgetBuilder? onboardingBuilder;

  /// 启动 Splash 图标 / 占位 Screen 构建器
  final WidgetBuilder? splashBuilder;

  /// 配置参数
  final LaunchConfig config;

  /// 外部注入 Controller (选填)
  final LaunchPipelineController? controller;

  /// 自定义开屏广告处理函数 (选填)
  final Future<void> Function(LaunchConfig config)? onShowAppOpenAd;

  /// 管线完成回调 (Overlay 模式内部解挂使用)
  final VoidCallback? onComplete;

  const PyroAppLaunchGuard({
    super.key,
    this.child,
    this.initializers = const [],
    this.onboardingBuilder,
    this.splashBuilder,
    this.config = const LaunchConfig(),
    this.controller,
    this.onShowAppOpenAd,
    this.onComplete,
  });

  static OverlayEntry? _activeOverlayEntry;

  /// 【终极零侵入横插模式】(Zero-Impact Hook Method)
  /// 在 main() 方法里只需【横插这一句】，前面无前缀，后面无后缀，对 MyApp / MaterialApp 零修改！
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   PyroAppLaunchGuard.attach(); // 就是这一句！
  ///
  ///   runApp(const MyApp());
  /// }
  /// ```
  static void attach({
    List<Future<void> Function()>? initializers,
    OnboardingWidgetBuilder? onboardingBuilder,
    WidgetBuilder? splashBuilder,
    LaunchConfig config = const LaunchConfig(),
    Future<void> Function(LaunchConfig config)? onShowAppOpenAd,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insertOverlay(
        initializers: initializers,
        onboardingBuilder: onboardingBuilder,
        splashBuilder: splashBuilder,
        config: config,
        onShowAppOpenAd: onShowAppOpenAd,
      );
    });
  }

  static void _insertOverlay({
    List<Future<void> Function()>? initializers,
    OnboardingWidgetBuilder? onboardingBuilder,
    WidgetBuilder? splashBuilder,
    LaunchConfig config = const LaunchConfig(),
    Future<void> Function(LaunchConfig config)? onShowAppOpenAd,
  }) {
    final rootElement = WidgetsBinding.instance.rootElement;
    if (rootElement == null) return;

    OverlayState? overlay;
    void findOverlay(Element element) {
      if (element.widget is Overlay) {
        overlay = (element as StatefulElement).state as OverlayState;
        return;
      }
      element.visitChildren(findOverlay);
    }

    rootElement.visitChildren(findOverlay);

    if (overlay == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _insertOverlay(
          initializers: initializers,
          onboardingBuilder: onboardingBuilder,
          splashBuilder: splashBuilder,
          config: config,
          onShowAppOpenAd: onShowAppOpenAd,
        );
      });
      return;
    }

    final controller = LaunchPipelineController(
      config: config,
      initializers: initializers ?? const [],
      onShowAppOpenAd: onShowAppOpenAd,
    );

    _activeOverlayEntry = OverlayEntry(
      builder: (context) {
        return PyroAppLaunchGuard(
          controller: controller,
          onboardingBuilder: onboardingBuilder,
          splashBuilder: splashBuilder,
          onComplete: () {
            _activeOverlayEntry?.remove();
            _activeOverlayEntry = null;
          },
        );
      },
    );

    overlay!.insert(_activeOverlayEntry!);
  }

  /// 顺应 MaterialApp.builder 的零侵入全局门禁
  static TransitionBuilder builder({
    List<Future<void> Function()>? initializers,
    OnboardingWidgetBuilder? onboardingBuilder,
    WidgetBuilder? splashBuilder,
    LaunchConfig config = const LaunchConfig(),
    Future<void> Function(LaunchConfig config)? onShowAppOpenAd,
  }) {
    return (BuildContext context, Widget? navigatorChild) {
      return PyroAppLaunchGuard(
        initializers: initializers ?? const [],
        onboardingBuilder: onboardingBuilder,
        splashBuilder: splashBuilder,
        config: config,
        onShowAppOpenAd: onShowAppOpenAd,
        child: navigatorChild ?? const SizedBox.shrink(),
      );
    };
  }

  @override
  State<PyroAppLaunchGuard> createState() => _PyroAppLaunchGuardState();
}

class _PyroAppLaunchGuardState extends State<PyroAppLaunchGuard> {
  late final LaunchPipelineController _controller;
  bool _createdOwnController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _createdOwnController = true;
      _controller = LaunchPipelineController(
        config: widget.config,
        initializers: widget.initializers,
        onShowAppOpenAd: widget.onShowAppOpenAd,
      );
    }

    _controller.addListener(_handleStageChange);
    _controller.startPipeline();
  }

  void _handleStageChange() {
    if (_controller.value == LaunchStage.completed) {
      widget.onComplete?.call();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleStageChange);
    if (_createdOwnController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LaunchStage>(
      valueListenable: _controller,
      builder: (context, stage, child) {
        switch (stage) {
          case LaunchStage.initializing:
          case LaunchStage.appOpenAd:
            return widget.splashBuilder?.call(context) ?? _defaultSplashView(context);

          case LaunchStage.onboarding:
            if (widget.onboardingBuilder != null) {
              return widget.onboardingBuilder!(context, () {
                _controller.completeOnboarding();
              });
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controller.completeOnboarding();
            });
            return widget.splashBuilder?.call(context) ?? _defaultSplashView(context);

          case LaunchStage.completed:
            return widget.child ?? const SizedBox.shrink();
        }
      },
    );
  }

  Widget _defaultSplashView(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
