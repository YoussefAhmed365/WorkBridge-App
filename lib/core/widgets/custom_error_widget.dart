import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';

/// WorkBridge System Error Feedback View
///
/// Implements Design.md specifications:
/// - 64x64px soft-tinted status icon container
/// - Typographic split: high-contrast slate title (#0F172A) + muted body (#64748B)
/// - Integrated with AppButton (44-48px height, 12px radius, refresh icon)
/// - Flexible: works as a full-screen view or embedded inside a Level 1 card
class CustomErrorWidget extends StatelessWidget {
  /// Primary error headline (e.g. "حدث خطأ ما" or "Unable to Load Contract")
  final String? title;

  /// Detailed descriptive message or server response
  final String message;

  /// Retry callback action
  final VoidCallback? onRetry;

  /// Localized retry button label
  final String retryText;

  /// Status icon glyph
  final IconData icon;

  /// Wraps the error inside a Level 1 card (16px radius, hairline border)
  final bool isCard;

  /// Compact mode for list items, dialogs, or bottom sheets
  final bool isCompact;

  /// Optional secondary action (e.g. "تواصل مع الدعم" / "Contact Support")
  final Widget? secondaryAction;

  const CustomErrorWidget({super.key, this.title, required this.message, this.onRetry, this.retryText = 'إعادة المحاولة', this.icon = Icons.error_outline_rounded, this.isCard = false, this.isCompact = false, this.secondaryAction});

  /// Factory constructor for network connection issues
  factory CustomErrorWidget.network({Key? key, String? title = 'تعذر الاتصال بالشبكة', String message = 'يرجى التحقق من اتصالك بالإنترنت ثم إعادة المحاولة', VoidCallback? onRetry, String retryText = 'إعادة المحاولة', bool isCard = false}) {
    return CustomErrorWidget(key: key, title: title, message: message, onRetry: onRetry, retryText: retryText, icon: Icons.wifi_off_rounded, isCard: isCard);
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.all(isCompact ? 16.0 : 24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // -----------------------------------------------------------------
            // Error Glyph Container (Soft tinted 64x64 circle)
            // -----------------------------------------------------------------
            Container(
              width: isCompact ? 52 : 64,
              height: isCompact ? 52 : 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2), // Soft Error Tint
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.error.withValues(alpha: 0.12), width: 1.5),
              ),
              child: Icon(icon, color: AppColors.error, size: isCompact ? 26 : 32),
            ),
            SizedBox(height: isCompact ? 12 : 16),

            // -----------------------------------------------------------------
            // Headline (title-md: 16px / semibold / slate #0F172A)
            // -----------------------------------------------------------------
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Inter', fontSize: isCompact ? 15 : 16, fontWeight: FontWeight.w600, height: 22 / 16, letterSpacing: -0.16, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 6),
            ],

            // -----------------------------------------------------------------
            // Detailed Message (body-md: 13px / regular / muted #64748B)
            // -----------------------------------------------------------------
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w400, height: 18 / 13, color: AppColors.textSecondary),
              ),
            ),

            // -----------------------------------------------------------------
            // Primary & Secondary Action CTAs
            // -----------------------------------------------------------------
            if (onRetry != null || secondaryAction != null) ...[
              SizedBox(height: isCompact ? 16 : 24),
              if (onRetry != null) AppButton.primary(text: retryText, leadingIcon: const Icon(Icons.refresh_rounded, size: 18), onPressed: onRetry, width: isCompact ? double.infinity : 170, height: isCompact ? 42 : 46),
              if (secondaryAction != null) ...[const SizedBox(height: 8), secondaryAction!],
            ],
          ],
        ),
      ),
    );

    // If embedded inside a card (Level 1 Surface: pure white, 16px radius)
    if (isCard) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1.0),
        ),
        child: content,
      );
    }

    return content;
  }
}