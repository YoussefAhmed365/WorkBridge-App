import 'package:flutter/material.dart';

@immutable
class WorkBridgeThemeExtension extends ThemeExtension<WorkBridgeThemeExtension> {
  const WorkBridgeThemeExtension({required this.tagBackground, required this.tagForeground, required this.matchBackground, required this.matchForeground, required this.activeFilterBackground, required this.activeFilterBorder, required this.warningBackground, required this.warningForeground, required this.warningBorder, required this.successBackground, required this.successForeground, required this.dangerBackground, required this.dangerForeground});

  final Color tagBackground;
  final Color tagForeground;

  final Color matchBackground;
  final Color matchForeground;

  final Color activeFilterBackground;
  final Color activeFilterBorder;

  final Color warningBackground;
  final Color warningForeground;
  final Color warningBorder;

  final Color successBackground;
  final Color successForeground;

  final Color dangerBackground;
  final Color dangerForeground;

  static const light = WorkBridgeThemeExtension(
    tagBackground: Color(0xFFF1F5F9),
    tagForeground: Color(0xFF475569),
    matchBackground: Color(0xFFECFDF5),
    matchForeground: Color(0xFF047857),
    activeFilterBackground: Color(0xFFEFF6FF),
    activeFilterBorder: Color(0xFF2563EB),
    warningBackground: Color(0xFFFFF7ED),
    warningForeground: Color(0xFF92400E),
    warningBorder: Color(0xFFFDE68A),
    successBackground: Color(0xFFECFDF5),
    successForeground: Color(0xFF047857),
    dangerBackground: Color(0xFFFEF2F2),
    dangerForeground: Color(0xFFB91C1C),
  );

  static const dark = WorkBridgeThemeExtension(
    tagBackground: Color(0xFF1F2B42),
    tagForeground: Color(0xFFCBD5E1),
    matchBackground: Color(0xFF064E3B),
    matchForeground: Color(0xFF6EE7B7),
    activeFilterBackground: Color(0xFF1E3A8A),
    activeFilterBorder: Color(0xFF60A5FA),
    warningBackground: Color(0xFF422006),
    warningForeground: Color(0xFFFCD34D),
    warningBorder: Color(0xFF854D0E),
    successBackground: Color(0xFF064E3B),
    successForeground: Color(0xFF6EE7B7),
    dangerBackground: Color(0xFF450A0A),
    dangerForeground: Color(0xFFFCA5A5),
  );

  @override
  WorkBridgeThemeExtension copyWith({Color? tagBackground, Color? tagForeground, Color? matchBackground, Color? matchForeground, Color? activeFilterBackground, Color? activeFilterBorder, Color? warningBackground, Color? warningForeground, Color? warningBorder, Color? successBackground, Color? successForeground, Color? dangerBackground, Color? dangerForeground}) {
    return WorkBridgeThemeExtension(
      tagBackground: tagBackground ?? this.tagBackground,
      tagForeground: tagForeground ?? this.tagForeground,
      matchBackground: matchBackground ?? this.matchBackground,
      matchForeground: matchForeground ?? this.matchForeground,
      activeFilterBackground: activeFilterBackground ?? this.activeFilterBackground,
      activeFilterBorder: activeFilterBorder ?? this.activeFilterBorder,
      warningBackground: warningBackground ?? this.warningBackground,
      warningForeground: warningForeground ?? this.warningForeground,
      warningBorder: warningBorder ?? this.warningBorder,
      successBackground: successBackground ?? this.successBackground,
      successForeground: successForeground ?? this.successForeground,
      dangerBackground: dangerBackground ?? this.dangerBackground,
      dangerForeground: dangerForeground ?? this.dangerForeground,
    );
  }

  @override
  WorkBridgeThemeExtension lerp(covariant WorkBridgeThemeExtension? other, double t) {
    if (other == null) return this;

    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;

    return WorkBridgeThemeExtension(
      tagBackground: mix(tagBackground, other.tagBackground),
      tagForeground: mix(tagForeground, other.tagForeground),
      matchBackground: mix(matchBackground, other.matchBackground),
      matchForeground: mix(matchForeground, other.matchForeground),
      activeFilterBackground: mix(activeFilterBackground, other.activeFilterBackground),
      activeFilterBorder: mix(activeFilterBorder, other.activeFilterBorder),
      warningBackground: mix(warningBackground, other.warningBackground),
      warningForeground: mix(warningForeground, other.warningForeground),
      warningBorder: mix(warningBorder, other.warningBorder),
      successBackground: mix(successBackground, other.successBackground),
      successForeground: mix(successForeground, other.successForeground),
      dangerBackground: mix(dangerBackground, other.dangerBackground),
      dangerForeground: mix(dangerForeground, other.dangerForeground),
    );
  }
}
