import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand colors: shared between themes.
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryHover = Color(0xFF3B82F6);
  static const Color primaryActive = Color(0xFF1D4ED8);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);

  static const Color secondary = Color(0xFF0D9488);
  static const Color tertiary = Color(0xFF10B981);

  // Light theme.
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLow = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF8FAFC);
  static const Color lightSurfaceHigh = Color(0xFFF1F5F9);
  static const Color lightSurfaceHighest = Color(0xFFE2E8F0);

  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderStrong = Color(0xFFCBD5E1);

  static const Color lightPrimaryContainer = Color(0xFFEFF6FF);
  static const Color lightOnPrimaryContainer = Color(0xFF1E40AF);

  // Dark theme.
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF161F30);
  static const Color darkSurfaceLow = Color(0xFF111827);
  static const Color darkSurfaceContainer = Color(0xFF161F30);
  static const Color darkSurfaceHigh = Color(0xFF1F2B42);
  static const Color darkSurfaceHighest = Color(0xFF26354D);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  static const Color darkBorder = Color(0xFF26354D);
  static const Color darkBorderStrong = Color(0xFF334155);

  static const Color darkPrimaryContainer = Color(0xFF1E3A8A);
  static const Color darkOnPrimaryContainer = Color(0xFFDBEAFE);

  // Semantic container colors.
  // These are suitable defaults, but component-level colors may vary by theme.
  static const Color lightSuccessBackground = Color(0xFFECFDF5);
  static const Color lightSuccessText = Color(0xFF047857);
  static const Color darkSuccessBackground = Color(0xFF064E3B);
  static const Color darkSuccessText = Color(0xFF6EE7B7);

  static const Color lightWarningBackground = Color(0xFFFFF7ED);
  static const Color lightWarningText = Color(0xFF92400E);
  static const Color darkWarningBackground = Color(0xFF422006);
  static const Color darkWarningText = Color(0xFFFCD34D);

  static const Color lightDangerBackground = Color(0xFFFEF2F2);
  static const Color lightDangerText = Color(0xFFB91C1C);
  static const Color darkDangerBackground = Color(0xFF450A0A);
  static const Color darkDangerText = Color(0xFFFCA5A5);

  // Compatibility aliases for existing widgets.
  // Migrate widgets gradually to Theme.of(context).colorScheme.
  static const Color background = lightBackground;
  static const Color surfaceBg = lightBackground;
  static const Color surface = lightSurface;
  static const Color surfaceCard = lightSurface;

  static const Color surfaceContainerLowest = lightSurfaceLow;
  static const Color surfaceContainerLow = Color(0xFFF1F5F9);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceContainerHigh = Color(0xFFE2E8F0);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  static const Color textPrimary = lightTextPrimary;
  static const Color onSurface = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;
  static const Color textMuted = lightTextMuted;
  static const Color onSurfaceVariant = lightTextSecondary;

  static const Color border = lightBorder;
  static const Color borderSubtle = lightBorder;
  static const Color outline = Color(0xFF64748B);
  static const Color outlineVariant = lightBorder;

  static const Color onPrimary = Colors.white;
  static const Color primaryContainer = lightPrimaryContainer;
  static const Color onPrimaryContainer = lightOnPrimaryContainer;

  static const Color onSecondary = Colors.white;
  static const Color secondaryContainer = Color(0xFFCCFBF1);
  static const Color onSecondaryContainer = Color(0xFF115E59);

  static const Color onTertiary = Colors.white;
  static const Color tertiaryContainer = Color(0xFFD1FAE5);
  static const Color onTertiaryContainer = Color(0xFF065F46);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Colors.white;
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color notificationRed = Color(0xFFEF4444);

  // Legacy component tokens.
  static const Color badgeMatchBg = lightSuccessBackground;
  static const Color badgeMatchText = lightSuccessText;

  static const Color tagBg = lightSurfaceHigh;
  static const Color tagText = lightTextSecondary;

  static const Color activeFilterBg = lightPrimaryContainer;
  static const Color activeFilterBorder = primary;

  static const Color statusWarningBg = Color(0xFFFEF3C7);
  static const Color statusWarningBorder = Color(0xFFFDE68A);
  static const Color statusWarningText = Color(0xFF92400E);

  static const Color graySecondaryContainer = Color(0xFFE5E7EB);
}
