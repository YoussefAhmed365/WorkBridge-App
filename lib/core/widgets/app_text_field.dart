import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workbridge/core/theme/app_colors.dart';
import 'package:workbridge/core/theme/theme_extension.dart';

/// WorkBridge System Input Field
///
/// Implements Design.md specifications:
/// - 12px default corner radius (16px for search inputs)
/// - 48–50px touch-ergonomic field height (16h x 14v padding)
/// - Inter typography with high-contrast slate (#0F172A) text
/// - Hairline 1px border (#E2E8F0) with Royal Blue (#2563EB) focus ring
/// - Support for right-aligned header actions (e.g. "Detect My Location")
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isRequired;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final double borderRadius;

  /// Optional right-aligned header action label (e.g., "Detect My Location", "Forgot?")
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onTap,
    this.borderRadius = 12.0,
    this.actionLabel,
    this.onActionTap,
  });

  /// Factory constructor for Global Search Fields (Design.md: 50px height, 16px radius)
  factory AppTextField.search({Key? key, String hint = 'Search jobs, skills or companies...', TextEditingController? controller, ValueChanged<String>? onChanged, ValueChanged<String>? onFieldSubmitted, VoidCallback? onTap, Widget? filterSuffixIcon, bool readOnly = false}) {
    return AppTextField(
      key: key,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      readOnly: readOnly,
      borderRadius: 16.0,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search_rounded, size: 20, color: AppColors.textSecondary),
      suffixIcon: filterSuffixIcon,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<WorkBridgeThemeExtension>()!;
    final effectiveRadius = BorderRadius.circular(widget.borderRadius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------------------------------------------------------------
        // Header Row: Label & Optional Action Label
        // ---------------------------------------------------------------------
        if (widget.label != null || widget.actionLabel != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.label != null)
                RichText(
                  text: TextSpan(
                    text: widget.label!,
                    style: textTheme.labelLarge,
                    children: [
                      if (widget.isRequired)
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: palette.dangerForeground, fontWeight: FontWeight.w700),
                        ),
                    ],
                  ),
                ),
              if (widget.actionLabel != null)
                GestureDetector(
                  onTap: widget.onActionTap,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    widget.actionLabel!,
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600, height: 16 / 12, color: colors.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        // ---------------------------------------------------------------------
        // Text Input Field
        // ---------------------------------------------------------------------
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          cursorColor: colors.primary,
          cursorWidth: 1.5,
          style: textTheme.bodyLarge,
          // style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, height: 20 / 14, color: widget.enabled ? colors.onPrimaryContainer : colors.outline),
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.helperText,
            errorText: widget.errorText,
            filled: true,
            fillColor: widget.enabled ? colors.surface : colors.surfaceContainer,
            hintStyle: TextStyle(fontFamily: 'Inter', color: colors.outline, fontSize: 13, fontWeight: FontWeight.w400, height: 18 / 13),
            helperStyle: TextStyle(fontFamily: 'Inter', color: colors.outline, fontSize: 11, fontWeight: FontWeight.w500),
            errorStyle: TextStyle(fontFamily: 'Inter', color: palette.dangerForeground, fontSize: 11, fontWeight: FontWeight.w500),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(size: 20, color: colors.outline),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20, color: colors.outline),
                    splashRadius: 20,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon != null
                ? IconTheme(
                    data: IconThemeData(size: 20, color: colors.outline),
                    child: widget.suffixIcon!,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: colors.outline, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: colors.outline, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: colors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: palette.dangerForeground, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: palette.dangerForeground, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: effectiveRadius,
              borderSide: BorderSide(color: colors.outline, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
