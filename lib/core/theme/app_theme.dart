import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'theme_extension.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = _buildTheme(brightness: Brightness.light, scheme: _lightScheme, palette: WorkBridgeThemeExtension.light);

  static final ThemeData darkTheme = _buildTheme(brightness: Brightness.dark, scheme: _darkScheme, palette: WorkBridgeThemeExtension.dark);

  static const ColorScheme _lightScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.lightPrimaryContainer,
    onPrimaryContainer: AppColors.lightOnPrimaryContainer,
    secondary: Color(0xFF0D9488),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFCCFBF1),
    onSecondaryContainer: Color(0xFF115E59),
    tertiary: AppColors.success,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD1FAE5),
    onTertiaryContainer: Color(0xFF065F46),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,
    onSurfaceVariant: AppColors.lightTextSecondary,
    outline: Color(0xFF64748B),
    outlineVariant: AppColors.lightBorder,
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF8FAFC),
    surfaceContainer: Color(0xFFF1F5F9),
    surfaceContainerHigh: Color(0xFFF1F5F9),
    surfaceContainerHighest: Color(0xFFE2E8F0),
  );

  static const ColorScheme _darkScheme = ColorScheme.dark(
    primary: Color(0xFF3B82F6),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF1E3A8A),
    onPrimaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFF2DD4BF),
    onSecondary: Color(0xFF042F2E),
    secondaryContainer: Color(0xFF134E4A),
    onSecondaryContainer: Color(0xFFCCFBF1),
    tertiary: Color(0xFF34D399),
    onTertiary: Color(0xFF052E16),
    tertiaryContainer: Color(0xFF065F46),
    onTertiaryContainer: Color(0xFFD1FAE5),
    error: Color(0xFFF87171),
    onError: Color(0xFF450A0A),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: Color(0xFF94A3B8),
    outlineVariant: AppColors.darkBorder,
    surfaceContainerLowest: Color(0xFF0B0F19),
    surfaceContainerLow: Color(0xFF111827),
    surfaceContainer: Color(0xFF161F30),
    surfaceContainerHigh: Color(0xFF1F2B42),
    surfaceContainerHighest: Color(0xFF26354D),
  );

  static ThemeData _buildTheme({required Brightness brightness, required ColorScheme scheme, required WorkBridgeThemeExtension palette}) {
    final isDark = brightness == Brightness.dark;

    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;
    final borderColor = scheme.outlineVariant;
    final surfaceColor = scheme.surface;

    OutlineInputBorder inputBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Inter',
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      primaryColor: AppColors.primary,
      extensions: <ThemeExtension<dynamic>>[palette],

      textTheme: TextTheme(
        headlineLarge: TextStyle(fontFamily: 'Inter', fontSize: 28, fontWeight: FontWeight.w700, height: 36 / 28, letterSpacing: -0.56, color: textPrimary),
        headlineMedium: TextStyle(fontFamily: 'Inter', fontSize: 22, fontWeight: FontWeight.w700, height: 28 / 22, letterSpacing: -0.33, color: textPrimary),
        headlineSmall: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, height: 26 / 20, letterSpacing: -0.20, color: textPrimary),
        titleLarge: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        titleMedium: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600, height: 22 / 16, letterSpacing: -0.16, color: textPrimary),
        titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, height: 20 / 14, color: textPrimary),
        bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w400, height: 22 / 15, color: textPrimary),
        bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w400, height: 18 / 13, color: textSecondary),
        bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400, height: 16 / 12, color: textSecondary),
        labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, height: 18 / 14, color: textPrimary),
        labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500, height: 16 / 12, color: textSecondary),
        labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500, height: 14 / 11, color: textSecondary),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: textPrimary, size: 20),
        titleTextStyle: TextStyle(fontFamily: 'Inter', color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.18),
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),

      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.4),
          disabledForegroundColor: scheme.onPrimary.withValues(alpha: 0.7),
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, height: 18 / 14),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: surfaceColor,
          foregroundColor: textPrimary,
          disabledForegroundColor: textSecondary,
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          side: BorderSide(color: borderColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, height: 18 / 14),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurfaceHigh : AppColors.lightSurfaceHigh,
        hintStyle: TextStyle(fontFamily: 'Inter', color: textSecondary, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: inputBorder(borderColor),
        enabledBorder: inputBorder(borderColor),
        focusedBorder: inputBorder(scheme.primary, width: 1.5),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, width: 1.5),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: palette.tagBackground,
        selectedColor: palette.activeFilterBackground,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        elevation: 0,
        pressElevation: 0,
        shape: StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
        labelStyle: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500, color: palette.tagForeground),
        secondaryLabelStyle: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600, color: scheme.primary),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        elevation: 0,
        selectedItemColor: scheme.primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(TextStyle(fontFamily: 'Inter', fontSize: 11, color: textPrimary)),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        modalBackgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 12,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAlias,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        contentTextStyle: TextStyle(fontFamily: 'Inter', fontSize: 14, color: textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      dividerTheme: DividerThemeData(color: borderColor, thickness: 1, space: 1),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.onPrimary;
          }
          return scheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.surfaceContainerHighest;
        }),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary, linearTrackColor: scheme.surfaceContainerHighest, circularTrackColor: scheme.surfaceContainerHighest),
    );
  }
}
