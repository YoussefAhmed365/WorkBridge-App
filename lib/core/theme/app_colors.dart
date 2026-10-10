import 'package:flutter/material.dart';

/// WorkBridge Design System Color Palette (Egypt Employment & Gig Platform)
/// Strictly aligned with Design.md specifications.
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Brand & Accent Colors
  // ---------------------------------------------------------------------------
  /// Primary Royal Blue anchors primary actions, verification, and active tabs.
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryActive = Color(0xFF1D4ED8); // Active/pressed state
  static const Color primaryM3 = Color(0xFF004AC6);     // M3 deep tonal base
  static const Color primaryContainer = Color(0xFFEFF6FF); // Soft blue chip/tint
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF00174B);

  /// Secondary Emerald Teal for gig services & high-value trade tags.
  static const Color secondary = Color(0xFF0D9488);
  static const Color secondaryContainer = Color(0xFF86F2E4);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF006F66);

  /// Tertiary / Success for escrow protection, match pills, and verified marks.
  static const Color tertiary = Color(0xFF10B981);
  static const Color tertiaryContainer = Color(0xFF007D55);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFBDFFDB);

  // ---------------------------------------------------------------------------
  // Surfaces & Backgrounds
  // ---------------------------------------------------------------------------
  /// Level 0 Base Background: Cool near-white canvas preventing eye fatigue.
  static const Color background = Color(0xFFF8FAFC);
  static const Color surfaceBg = Color(0xFFF8FAFC);

  /// Level 1 Card & Elevated Containers: Pure white.
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceCard = Color(0xFFFFFFFF);

  /// Material 3 Surface Containers (from Design.md YAML)
  static const Color surfaceDim = Color(0xFFD2D9F4);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  // ---------------------------------------------------------------------------
  // Neutrals & Typography
  // ---------------------------------------------------------------------------
  /// Dark slate for high typographic contrast without harshness.
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onSurfaceM3 = Color(0xFF131B2E);

  /// Muted slate for metadata, timeframes, and secondary labels.
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color onSurfaceVariant = Color(0xFF434655);

  // ---------------------------------------------------------------------------
  // Borders & Structural Strokes
  // ---------------------------------------------------------------------------
  /// 1px Hairline structural border across cards, inputs, and dividers.
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFE2E8F0);
  static const Color outline = Color(0xFF737686);
  static const Color outlineVariant = Color(0xFFC3C6D7);

  // ---------------------------------------------------------------------------
  // Status, Escrow & Component Pills
  // ---------------------------------------------------------------------------
  /// Match percentage pill (e.g. "82% Match" or "Escrow Protected").
  static const Color badgeMatchBg = Color(0xFFECFDF5);
  static const Color badgeMatchText = Color(0xFF059669);

  /// Keyword, trade, & skill tags (e.g. "UX/UI", "Figma").
  static const Color tagBg = Color(0xFFF1F5F9);
  static const Color tagText = Color(0xFF475569);

  /// Filter active selection state.
  static const Color activeFilterBg = Color(0xFFEFF6FF);
  static const Color activeFilterBorder = Color(0xFF2563EB);

  /// Status alerts (e.g. "Pending Acceptance").
  static const Color statusWarningBg = Color(0xFFFEF3C7);   // Amber-100
  static const Color statusWarningBorder = Color(0xFFFDE68A); // Amber-200
  static const Color statusWarningText = Color(0xFF92400E); // Amber-800

  /// Errors & critical notifications.
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color notificationRed = Color(0xFFEF4444);
}