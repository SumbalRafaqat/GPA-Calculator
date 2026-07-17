import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_theme.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/screens/spalsh_screen.dart';
import 'package:gpa_calculator/features/gpa_calculator/view_model/gpa_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GpaViewModel()),
        ],
        child: const MyApp(),
      )   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

