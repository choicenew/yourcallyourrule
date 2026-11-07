import 'dart:async';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';

void main() {
  group('LaunchPipelineController Unit Tests', () {
    test('Standard pipeline transitions to completed automatically when no onboarding needed', () async {
      bool initializerRan = false;
      bool adCallbackRan = false;

      final controller = LaunchPipelineController(
        config: const LaunchConfig(
          enableAppOpenAd: true,
          initTimeout: Duration(milliseconds: 500),
          adTimeout: Duration(milliseconds: 500),
        ),
        initializers: [
          () async {
            initializerRan = true;
          },
        ],
        onShowAppOpenAd: (config) async {
          adCallbackRan = true;
        },
      );

      expect(controller.value, LaunchStage.initializing);

      await controller.startPipeline();

      expect(initializerRan, isTrue);
      expect(adCallbackRan, isTrue);
      expect(controller.value, LaunchStage.completed);
    });

    test('Initializer timeout triggers graceful fallback to next stage', () async {
      final controller = LaunchPipelineController(
        config: const LaunchConfig(
          enableAppOpenAd: false,
          initTimeout: Duration(milliseconds: 100),
        ),
        initializers: [
          () async {
            // Wait longer than timeout
            await Future.delayed(const Duration(milliseconds: 500));
          },
        ],
      );

      await controller.startPipeline();

      // Must complete safely despite timeout
      expect(controller.value, LaunchStage.completed);
    });

    test('Onboarding stage halts until completeOnboarding() is invoked and awaits disk save callback', () async {
      bool needOnboarding = true;
      bool diskSaveRan = false;

      final controller = LaunchPipelineController(
        config: LaunchConfig(
          enableAppOpenAd: false,
          shouldShowOnboardingCheck: () async => needOnboarding,
          onOnboardingCompletedSaveCallback: () async {
            await Future.delayed(const Duration(milliseconds: 10));
            diskSaveRan = true;
          },
        ),
      );

      await controller.startPipeline();

      // Controller should pause at onboarding stage
      expect(controller.value, LaunchStage.onboarding);
      expect(diskSaveRan, isFalse);

      // Now complete onboarding
      await controller.completeOnboarding();

      expect(diskSaveRan, isTrue);
      expect(controller.value, LaunchStage.completed);
    });

    test('skipToComplete forces pipeline to complete immediately', () {
      final controller = LaunchPipelineController();
      expect(controller.value, LaunchStage.initializing);

      controller.skipToComplete();
      expect(controller.value, LaunchStage.completed);
    });

    test('LaunchConfig wrapBoolConfig and unwrapBoolConfig safety helpers work as expected', () {
      final wrapped = LaunchConfig.wrapBoolConfig(true);
      expect(wrapped, equals({'value': true}));

      expect(LaunchConfig.unwrapBoolConfig(wrapped), isTrue);
      expect(LaunchConfig.unwrapBoolConfig(null, defaultValue: false), isFalse);
      expect(LaunchConfig.unwrapBoolConfig({'value': 'true'}), isTrue);
    });
  });

  group('PyroAppLaunchGuard Widget Tests', () {
    testWidgets('Renders splash view then transitions to child widget', (WidgetTester tester) async {
      final controller = LaunchPipelineController(
        config: const LaunchConfig(
          enableAppOpenAd: false,
        ),
        initializers: [
          () async {
            await Future.delayed(const Duration(milliseconds: 50));
          },
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PyroAppLaunchGuard(
            controller: controller,
            splashBuilder: (context) => const Text('Custom Splash Screen'),
            child: const Text('Home Screen Loaded'),
          ),
        ),
      );

      // Initial state displays custom splash
      expect(find.text('Custom Splash Screen'), findsOneWidget);
      expect(find.text('Home Screen Loaded'), findsNothing);

      // Advance time for async initializers to finish
      await tester.pumpAndSettle();

      // Post-initialization displays Home Screen
      expect(find.text('Home Screen Loaded'), findsOneWidget);
      expect(find.text('Custom Splash Screen'), findsNothing);
    });

    testWidgets('Displays onboarding view and navigates to child when completed', (WidgetTester tester) async {
      final controller = LaunchPipelineController(
        config: LaunchConfig(
          enableAppOpenAd: false,
          shouldShowOnboardingCheck: () async => true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(splashFactory: InkRipple.splashFactory),
          home: PyroAppLaunchGuard(
            controller: controller,
            onboardingBuilder: (context, onComplete) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: onComplete,
                  child: const Text('Agree & Continue'),
                ),
              );
            },
            child: const Text('Main App Home'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Onboarding screen should be visible
      expect(find.text('Agree & Continue'), findsOneWidget);
      expect(find.text('Main App Home'), findsNothing);

      // Tap 'Agree & Continue'
      await tester.tap(find.text('Agree & Continue'));
      await tester.pumpAndSettle();

      // Should now render Main App Home
      expect(find.text('Main App Home'), findsOneWidget);
      expect(find.text('Agree & Continue'), findsNothing);
    });

    testWidgets('PyroAppLaunchGuard.builder integrates seamlessly via MaterialApp.builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: PyroAppLaunchGuard.builder(
            config: const LaunchConfig(enableAppOpenAd: false),
          ),
          home: const Text('Zero Invasiveness Home'),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Zero Invasiveness Home'), findsOneWidget);
    });

    testWidgets('PyroAppLaunchGuard.attach() attaches overlay without modifying MaterialApp', (WidgetTester tester) async {
      PyroAppLaunchGuard.attach(
        config: const LaunchConfig(enableAppOpenAd: false),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Text('Untouched Main App'),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Untouched Main App'), findsOneWidget);
    });
  });
}
