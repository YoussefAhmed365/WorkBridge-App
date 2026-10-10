import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workbridge/core/theme/app_theme.dart';
import 'package:workbridge/injection_container.dart' as di;
import 'package:workbridge/features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Hive Cache
  await Hive.initFlutter();

  // Initialize Dependency Injection
  await di.init();

  runApp(const WorkBridgeApp());
}

class WorkBridgeApp extends StatelessWidget {
  const WorkBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkBridge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}