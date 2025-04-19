import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'di/injection.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/state/providers/app_provider.dart';
import '../lib/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化依赖注入
  await initDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AppProvider>()),
        // 其他Provider将在依赖注入中注册
      ],
      child: MaterialApp(
        title: 'Your Call Your Rule',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}