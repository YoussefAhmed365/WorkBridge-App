import 'package:flutter/material.dart';
import 'package:workbridge/core/theme/app_colors.dart';

/// Available button visual variants from Design.md
enum AppButtonVariant {
  /// Primary solid Royal Blue (#2563EB) with white label.
  primary,

  /// Secondary white/transparent card with 1px #E2E8F0 hairline border.
  secondary,

  /// Subtle borderless text button (e.g., "Edit Terms", "Clear All").
  ghost,
}

/// WorkBridge System Standard Action Button
///
/// Implements Design.md specifications:
/// - Ergonomic 48px standard touch height
/// - 12px rounded corner radius
/// - Label-LG typography (Inter, 14px, 600 weight, 18px line height)
/// - Subdued active-state color transitions (#1D4ED8)
/// - Zero elevation corporate minimalist aesthetic
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  /// Default constructor (100% backward-compatible with [isOutlined])
  const AppButton({super.key, required this.text, this.onPressed, this.isLoading = false, bool isOutlined = false, AppButtonVariant? variant, this.leadingIcon, this.trailingIcon, this.backgroundColor, this.textColor, this.borderColor, this.height = 48.0, this.width, this.borderRadius}) : variant = variant ?? (isOutlined ? AppButtonVariant.secondary : AppButtonVariant.primary);

  /// Convenience constructor for Primary CTA (Royal Blue #2563EB)
  const AppButton.primary({super.key, required this.text, this.onPressed, this.isLoading = false, this.leadingIcon, this.trailingIcon, this.backgroundColor, this.textColor, this.height = 48.0, this.width, this.borderRadius}) : variant = AppButtonVariant.primary, borderColor = null;

  /// Convenience constructor for Secondary Action (Outlined / Hairline 1px)
  const AppButton.secondary({super.key, required this.text, this.onPressed, this.isLoading = false, this.leadingIcon, this.trailingIcon, this.backgroundColor, this.textColor, this.borderColor, this.height = 48.0, this.width, this.borderRadius}) : variant = AppButtonVariant.secondary;

  /// Convenience constructor for Ghost / Plain Text Action
  const AppButton.ghost({super.key, required this.text, this.onPressed, this.isLoading = false, this.leadingIcon, this.trailingIcon, this.textColor, this.height = 48.0, this.width, this.borderRadius}) : variant = AppButtonVariant.ghost, backgroundColor = Colors.transparent, borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12.0);

    // Label-LG typography spec (Design.md: Inter, 14px, 600 weight, 18px line-height)
    final labelStyle = TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, height: 18 / 14, letterSpacing: -0.1, color: _getTextColor(isDisabled));

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: switch (variant) {
        AppButtonVariant.primary => _buildElevatedButton(isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
        AppButtonVariant.secondary => _buildOutlinedButton(isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
        AppButtonVariant.ghost => _buildGhostButton(isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Variant Builders
  // ---------------------------------------------------------------------------

  Widget _buildElevatedButton({required bool isDisabled, required BorderRadius radius, required TextStyle labelStyle}) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: textColor ?? Colors.white,
        disabledBackgroundColor: (backgroundColor ?? AppColors.primary).withValues(alpha: 0.4),
        disabledForegroundColor: Colors.white70,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: Colors.white, labelStyle: labelStyle),
    );
  }

  Widget _buildOutlinedButton({required bool isDisabled, required BorderRadius radius, required TextStyle labelStyle}) {
    final effectiveBorderColor = isDisabled ? AppColors.border : (borderColor ?? AppColors.border);

    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.surfaceCard,
        foregroundColor: textColor ?? AppColors.textPrimary,
        disabledForegroundColor: AppColors.textSecondary,
        elevation: 0,
        side: BorderSide(color: effectiveBorderColor, width: 1.0),
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: AppColors.primary, labelStyle: labelStyle),
    );
  }

  Widget _buildGhostButton({required bool isDisabled, required BorderRadius radius, required TextStyle labelStyle}) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        disabledForegroundColor: AppColors.textSecondary,
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: AppColors.primary, labelStyle: labelStyle),
    );
  }

  // ---------------------------------------------------------------------------
  // Internal Helpers
  // ---------------------------------------------------------------------------

  Widget _buildChild({required Color progressColor, required TextStyle labelStyle}) {
    if (isLoading) {
      return SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation<Color>(progressColor)));
    }

    if (leadingIcon == null && trailingIcon == null) {
      return Text(text, style: labelStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          IconTheme(
            data: IconThemeData(size: 18, color: labelStyle.color),
            child: leadingIcon!,
          ),
          const SizedBox(width: 8),
        ],
        Text(text, style: labelStyle),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          IconTheme(
            data: IconThemeData(size: 18, color: labelStyle.color),
            child: trailingIcon!,
          ),
        ],
      ],
    );
  }

  Color _getTextColor(bool isDisabled) {
    if (isDisabled) return AppColors.textSecondary;
    if (textColor != null) return textColor!;

    return switch (variant) {
      AppButtonVariant.primary => Colors.white,
      AppButtonVariant.secondary => AppColors.textPrimary,
      AppButtonVariant.ghost => AppColors.primary,
    };
  }
}
