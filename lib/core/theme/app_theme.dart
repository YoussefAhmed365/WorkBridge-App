import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// WorkBridge Application Theme
/// Implements the Corporate/Modern Minimalist aesthetic from Design.md:
/// - 4px/8px modular spacing rhythm
/// - 16px radius for Level 1 cards
/// - 12px radius for 48px touch-ergonomic buttons and form fields
/// - Pill (stadium) contours for status chips and attribute badges
/// - Full Inter typographic scale with tabular figures and negative tracking
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      // -----------------------------------------------------------------------
      // ColorScheme (Material 3 with Design.md exact mappings)
      // -----------------------------------------------------------------------
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surfaceCard,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.outline,
        outlineVariant: AppColors.border,
        surfaceContainerLowest: AppColors.surfaceContainerLowest,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainer: AppColors.surfaceContainer,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
      ),

      // -----------------------------------------------------------------------
      // Typography Scale (Inter with precise font sizes, heights & tracking)
      // -----------------------------------------------------------------------
      textTheme: const TextTheme(
        // headline-xl: 28px / 36px / bold / -0.02em (-0.56px)
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 36 / 28,
          letterSpacing: -0.56,
          color: AppColors.textPrimary,
        ),
        // headline-lg: 22px / 28px / bold / -0.015em (-0.33px)
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 28 / 22,
          letterSpacing: -0.33,
          color: AppColors.textPrimary,
        ),
        // headline-lg-mobile: 20px / 26px / bold / -0.01em (-0.2px)
        headlineSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 26 / 20,
          letterSpacing: -0.20,
          color: AppColors.textPrimary,
        ),
        // title-md: 16px / 22px / semibold / -0.01em (-0.16px)
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 22 / 16,
          letterSpacing: -0.16,
          color: AppColors.textPrimary,
        ),
        // title-sm: 14px / 20px / semibold
        titleSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          color: AppColors.textPrimary,
        ),
        // body-lg: 15px / 22px / regular
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 22 / 15,
          color: AppColors.textPrimary,
        ),
        // body-md: 13px / 18px / regular
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 18 / 13,
          color: AppColors.textSecondary,
        ),
        // body-sm: 12px / 16px / regular
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 16 / 12,
          color: AppColors.textSecondary,
        ),
        // label-lg: 14px / 18px / semibold
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 18 / 14,
          color: AppColors.textPrimary,
        ),
        // label-md: 12px / 16px / medium
        labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          color: AppColors.textSecondary,
        ),
        // label-sm: 11px / 14px / medium
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 14 / 11,
          color: AppColors.textSecondary,
        ),
      ),

      // -----------------------------------------------------------------------
      // Level 2 Sticky AppBar (Pure white, hairline bottom border, slate text)
      // -----------------------------------------------------------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceCard,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 20),
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.18,
        ),
        shape: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // -----------------------------------------------------------------------
      // Level 1 Card Theme (16px radius, pure white, 1px hairline stroke)
      // -----------------------------------------------------------------------
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // -----------------------------------------------------------------------
      // Primary Button (Royal Blue, 48px height, 12px radius, label-lg font)
      // -----------------------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white70,
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 18 / 14,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Secondary / Ghost Button (White card BG, 1px border, 12px radius)
      // -----------------------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceCard,
          foregroundColor: AppColors.textPrimary,
          disabledForegroundColor: AppColors.textSecondary,
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          side: const BorderSide(color: AppColors.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 18 / 14,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Form Input Theme (12px Radius, 1px border, 16h x 14v padding)
      // -----------------------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceCard,
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),

      // -----------------------------------------------------------------------
      // Pill & Filter Chips (Full pill geometry, tag tokens from Design.md)
      // -----------------------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.tagBg,
        selectedColor: AppColors.activeFilterBg,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        elevation: 0,
        pressElevation: 0,
        shape: const StadiumBorder(
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.tagText,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),

      // -----------------------------------------------------------------------
      // Level 2 Bottom Navigation Bar (White, top border, Royal Blue active)
      // -----------------------------------------------------------------------
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceCard,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -----------------------------------------------------------------------
      // Level 3 Bottom Sheet / Drawer (16px top radius, elevated white sheet)
      // -----------------------------------------------------------------------
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceCard,
        elevation: 12,
        modalBackgroundColor: AppColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // -----------------------------------------------------------------------
      // Dividers & Structural Separators
      // -----------------------------------------------------------------------
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}