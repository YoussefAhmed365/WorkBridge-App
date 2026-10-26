import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workbridge/core/localization/locale_cubit.dart';
import 'package:workbridge/core/routing/app_router.dart';
import 'package:workbridge/core/theme/app_theme.dart';
import 'package:workbridge/injection_container.dart' as di;
import 'package:workbridge/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Make the status bar transparent and adjust icon colors
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent (Android)
      statusBarIconBrightness: Brightness.dark, // Dark icons (black) for light backgrounds
      statusBarBrightness: Brightness.light, // iOS: light status bar background typography
  ));

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
    return BlocProvider<LocaleCubit>(
      create: (_) => di.sl<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, currentLocale) {
          return MaterialApp.router(
            title: 'WorkBridge',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: currentLocale,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}