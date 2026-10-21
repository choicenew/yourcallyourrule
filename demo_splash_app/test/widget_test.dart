import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Demo Splash App 3 个分支对比测试（分支 1：老版单点 vs 分支 2：3 步三重校验 vs 分支 3：config_ JSON 仓库）', () {
    testWidgets('分支 1 测试：老版单点 first_launch 控制模式全链路通关与重启判定', (tester) async {
      SharedPreferences.setMockInitialValues({});

      print('\n==================== [分支 1 测试：老版单点 first_launch] ====================');

      // 1. 启动 Demo App
      await tester.pumpWidget(const DemoSplashApp());
      await tester.pumpAndSettle();

      // 点击手动开屏导航按钮
      await tester.tap(find.text('点击【手动执行开屏决策导航】'));
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      // 验证首次启动去 Onboarding
      expect(find.byType(DemoOnboardingScreen), findsOneWidget);
      print('步骤 1: 首次启动成功到达 Onboarding 页面');

      // 2. 点击完成 Onboarding
      await tester.tap(find.text('完成 Onboarding (保存并去 InitialSetup)'));
      await tester.pumpAndSettle();

      // 验证进入 InitialSetup
      expect(find.byType(DemoInitialSetupScreen), findsOneWidget);
      print('步骤 2: Onboarding 点击完成，成功推进到 InitialSetup 页面');

      // 3. 点击完成 InitialSetup
      await tester.tap(find.text('完成 Initial Setup (保存并进入 Home)'));
      await tester.pumpAndSettle();

      // 验证通关进入 Home
      expect(find.byType(DemoHomeScreen), findsOneWidget);
      print('步骤 3: InitialSetup 点击完成，成功通关进入 HOME 主页');

      // 4. 模拟划掉杀进程冷重启
      await tester.tap(find.text('【模拟冷重启】重新进入 Splash 开屏校验'));
      await tester.pumpAndSettle();

      // 点击手动开屏导航按钮
      await tester.tap(find.text('点击【手动执行开屏决策导航】'));
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      // 验证冷重启后 100% 直达 Home 主页，不弹 Onboarding 或 InitialSetup
      expect(find.byType(DemoHomeScreen), findsOneWidget);
      expect(find.byType(DemoOnboardingScreen), findsNothing);
      expect(find.byType(DemoInitialSetupScreen), findsNothing);
      print('步骤 4: 模拟冷重启通过！Splash 读到 first_launch == false，100% 直达 HOME 主页！');
      print('==================== [分支 1 测试通关] ====================\n');
    });

    testWidgets('分支 3 测试：config_ JSON 仓库模式 (对齐 purchase_state) 全链路通关与重启判定', (tester) async {
      SharedPreferences.setMockInitialValues({});

      print('\n==================== [分支 3 测试：config_ JSON 仓库模式] ====================');

      await tester.pumpWidget(
        MaterialApp(
          home: DemoSplashScreen(
            mode: SplashBranchMode.configRepo,
            onModeChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 点击手动开屏导航按钮
      await tester.tap(find.text('点击【手动执行开屏决策导航】'));
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      expect(find.byType(DemoOnboardingScreen), findsOneWidget);
      print('步骤 1: 首次启动（分支 3 config_ JSON）成功到达 Onboarding 页面');

      await tester.tap(find.text('完成 Onboarding (保存并去 InitialSetup)'));
      await tester.pumpAndSettle();

      expect(find.byType(DemoInitialSetupScreen), findsOneWidget);
      print('步骤 2: Onboarding 点击完成，保存 config_has_completed_onboarding: {"value":true}');

      await tester.tap(find.text('完成 Initial Setup (保存并进入 Home)'));
      await tester.pumpAndSettle();

      expect(find.byType(DemoHomeScreen), findsOneWidget);
      print('步骤 3: InitialSetup 点击完成，保存 config_has_completed_initial_setup: {"value":true}');

      await tester.tap(find.text('【模拟冷重启】重新进入 Splash 开屏校验'));
      await tester.pumpAndSettle();

      // 点击手动开屏导航按钮
      await tester.tap(find.text('点击【手动执行开屏决策导航】'));
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      expect(find.byType(DemoHomeScreen), findsOneWidget);
      print('步骤 4: 模拟冷重启通过！Splash 读到 config_ JSON 状态对象解码为 true，100% 直达 HOME 主页！');
      print('==================== [分支 3 测试通关] ====================\n');
    });
  });
}
