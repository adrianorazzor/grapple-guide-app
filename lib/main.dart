import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/logger/logger.dart';

void main() {
  // Ensure Flutter is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the logger
  final logger = AppLogger();
  logger.i('Application starting...');
  
  // Catch Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e('Flutter error', details.exception, details.stack);
  };
  
  // Catch async errors that aren't caught by the Flutter framework
  runZonedGuarded(
    () {
      runApp(
        const ProviderScope(
          child: GrappleGuideApp(),
        ),
      );
    },
    (error, StackTrace stackTrace) {
      logger.e('Uncaught exception', error, stackTrace);
    },
  );
}

class GrappleGuideApp extends StatelessWidget {
  const GrappleGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Grapple Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
