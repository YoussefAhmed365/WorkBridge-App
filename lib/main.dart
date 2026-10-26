import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:workbridge/core/localization/locale_cubit.dart';
import 'package:workbridge/core/routing/app_router.dart';
import 'package:workbridge/core/theme/app_theme.dart';
import 'package:workbridge/core/theme/theme_cubit.dart';
import 'package:workbridge/generated/l10n.dart';
import 'package:workbridge/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await di.init();

  runApp(const WorkBridgeApp());
}

class WorkBridgeApp extends StatelessWidget {
  const WorkBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (_) => di.sl<LocaleCubit>()),
        BlocProvider<ThemeCubit>(create: (_) => di.sl<ThemeCubit>()),
      ],
      child: const _WorkBridgeMaterialApp(),
    );
  }
}

class _WorkBridgeMaterialApp extends StatelessWidget {
  const _WorkBridgeMaterialApp();

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LocaleCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state;

    return MaterialApp.router(
      title: 'WorkBridge',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      locale: currentLocale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],

      builder: (context, child) {
        final brightness = themeMode == ThemeMode.system
            ? MediaQuery.platformBrightnessOf(context)
            : themeMode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark, statusBarBrightness: brightness == Brightness.dark ? Brightness.dark : Brightness.light, systemNavigationBarColor: brightness == Brightness.dark ? const Color(0xFF0B0F19) : const Color(0xFFF8FAFC), systemNavigationBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark),
          child: child ?? const SizedBox.shrink(),
        );
      },

      routerConfig: appRouter,
    );
  }
}