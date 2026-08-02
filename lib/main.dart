import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gpa_calculator/core/services/notification_service.dart';
import 'package:gpa_calculator/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_theme.dart';
import 'core/services/storage_service.dart';

import 'providers/locale_provider.dart';
import 'providers/onboarding_provider.dart';
import 'providers/gpa_calculator_provider.dart';
import 'providers/cgpa_calculator_provider.dart';
import 'providers/percentage_gpa_provider.dart';
import 'providers/result_provider.dart';
import 'providers/settings_provider.dart';

import 'views/splash/splash_screen.dart';

/// App entry point. Initializes SharedPreferences, wires every
/// provider app-wide via MultiProvider, and boots into SplashScreen
/// which decides onboarding vs Dashboard.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  await NotificationService.instance.init();
  await NotificationService.instance.requestPermission();
  runApp(const GpaPlannerApp());
}

class GpaPlannerApp extends StatelessWidget {
  const GpaPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // Screen-scoped providers below are also registered app-wide
        // for simplicity; each screen still creates its own fresh
        // instance via ChangeNotifierProvider where isolated state is
        // needed (see GpaCalculatorScreen/CgpaCalculatorScreen).
        ChangeNotifierProvider(create: (_) => ResultProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return MaterialApp(
            title: 'GPA Planner',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            locale: localeProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}