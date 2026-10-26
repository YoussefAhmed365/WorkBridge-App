import 'package:flutter/material.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';
import 'package:workbridge/core/theme/app_colors.dart';
import 'package:workbridge/generated/l10n.dart';

class AccountCredentialsStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmitStep;

  const AccountCredentialsStep({ super.key, required this.formKey, required this.onSubmitStep });

  @override
  State<AccountCredentialsStep> createState() => _AccountCredentialsStepState();
}

class _AccountCredentialsStepState extends State<AccountCredentialsStep> {
  late final TextEditingController _phoneOrEmailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _hasMinLength = false;
  bool _hasNumberOrSymbol = false;
  bool _hasUpperAndLower = false;

  @override
  void initState() {
    super.initState();
    _phoneOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _passwordController.addListener(_validatePasswordRules);
  }

  void _validatePasswordRules() {
    final text = _passwordController.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasNumberOrSymbol = RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(text);
      _hasUpperAndLower = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(text);
    });
  }

  int get _strengthScore {
    int score = 0;
    if (_passwordController.text.isNotEmpty) score++;
    if (_hasMinLength) score++;
    if (_hasNumberOrSymbol) score++;
    if (_hasUpperAndLower) score++;
    return score;
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePasswordRules);
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePhoneOrEmail(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    final trimmed = value.trim();
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^(01[0125]\d{8}|\+?201[0125]\d{8})$');

    if (!emailRegex.hasMatch(trimmed) && !phoneRegex.hasMatch(trimmed)) {
      return l10n.errorPhoneOrEmailField;
    }
    return null;
  }

  String? _validatePassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    if (value.length < 6) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    if (value != _passwordController.text) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        physics: const FixedExtentScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2. Step Title & Subtitle
            // SizedBox(
            //   width: double.infinity,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(l10n.signupTitle1, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 26)),
            //       const SizedBox(height: 4),
            //       Text(l10n.signupSubtitle1, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary, fontSize: 14)),
            //     ],
            //   ),
            // ),
            //
            // const SizedBox(height: 12),

            // Email Header Label + Required Tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.emailAddress,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                ),
                const Text("Required", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 8),
            AppTextField(
              controller: _phoneOrEmailController,
              hint: l10n.emailExample,
              isRequired: false,
              // Label handled above
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => _validatePhoneOrEmail(value, l10n),
              prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppColors.textSecondary),
            ),

            const SizedBox(height: 16),

            // Password Label
            Text(
              l10n.passwordField,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            AppTextField(
              controller: _passwordController,
              hint: l10n.createSecurePassword,
              isPassword: true,
              isRequired: false,
              textInputAction: TextInputAction.next,
              validator: (value) => _validatePassword(value, l10n),
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
            ),

            const SizedBox(height: 12),

            // Password Strength Section
            _buildPasswordStrengthSection(),

            const SizedBox(height: 16),

            // Confirm Password Label
            Text(
              l10n.confirmPasswordField,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            AppTextField(
              controller: _confirmPasswordController,
              hint: l10n.reEnterPassword,
              isPassword: true,
              isRequired: false,
              textInputAction: TextInputAction.done,
              validator: (value) => _validateConfirmPassword(value, l10n),
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password Strength",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),

        // 4 Strength Bars
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < _strengthScore;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 5,
                margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                decoration: BoxDecoration(color: isFilled ? AppColors.tertiary : AppColors.graySecondaryContainer, borderRadius: BorderRadius.circular(10)),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        // 3 Rule Badges
        Wrap(spacing: 6, runSpacing: 6, children: [_buildRuleBadge("8+ characters", _hasMinLength), _buildRuleBadge("1 number of symbol", _hasNumberOrSymbol), _buildRuleBadge("Upper & lower case", _hasUpperAndLower)]),
      ],
    );
  }

  Widget _buildRuleBadge(String text, bool isMet) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isMet ? AppColors.badgeMatchBg : AppColors.graySecondaryContainer, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, size: 14, color: isMet ? AppColors.badgeMatchText : AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: isMet ? AppColors.badgeMatchText : AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}