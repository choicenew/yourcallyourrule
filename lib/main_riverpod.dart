import 'package:material_ui/material_ui.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/common/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_entry.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/services/firebase_service.dart';
import 'package:yourcallyourrule/features/common/error/logger.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    final firebaseService = FirebaseService();
    await firebaseService.initialize();
    
    AppLogger.initialize();
    
    await MobileAds.instance.initialize();
    
    firebaseService.logAppOpen();

    runApp(const ProviderScope(
      child: MyRiverpodApp(),
    ));
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e');
    debugPrint('Stack trace: $stackTrace');
    
    try {
      FirebaseService().recordError(e, stackTrace);
    } catch (_) {}
  } finally {
    FlutterNativeSplash.remove();
  }
}

bool isOverlayMode = false;

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();

  isOverlayMode = true;

  runApp(const ProviderScope(
    child: MaterialApp(
      title: 'Caller ID Overlay',
      home: CallOverlayEntry(),
    ),
  ));
}

class MyRiverpodApp extends ConsumerWidget {
  const MyRiverpodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'Your Call Your Rule',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF9800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: appRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
