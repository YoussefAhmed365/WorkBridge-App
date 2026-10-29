import 'package:flutter/material.dart';
import 'package:workbridge/core/theme/theme_extension.dart';
import 'package:workbridge/core/utils/validators.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';
import 'package:workbridge/generated/l10n.dart';

class AccountCredentialsStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmitStep;

  const AccountCredentialsStep({
    super.key,
    required this.formKey,
    required this.onSubmitStep,
  });

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
      _hasMinLength = Validators.hasMinLength(text);
      _hasNumberOrSymbol = Validators.hasNumberOrSymbol(text);
      _hasUpperAndLower = Validators.hasUpperAndLower(text);
    });
  }

  int get _strengthScore {
    return Validators.calculatePasswordStrength(_passwordController.text);
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
    return Validators.validatePhoneOrEmail(value, l10n);
  }

  String? _validatePassword(String? value, S l10n) {
    return Validators.validatePassword(value, l10n);
  }

  String? _validateConfirmPassword(String? value, S l10n) {
    return Validators.validateConfirmPassword(value, _passwordController.text, l10n);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                Text(l10n.emailAddress, style: textTheme.labelLarge),
                Text("Required", style: textTheme.labelMedium),
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
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            // Password Label
            Text(l10n.passwordField, style: textTheme.labelLarge),
            const SizedBox(height: 8),
            AppTextField(
              controller: _passwordController,
              hint: l10n.createSecurePassword,
              isPassword: true,
              isRequired: false,
              textInputAction: TextInputAction.next,
              validator: (value) => _validatePassword(value, l10n),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            // Password Strength Section
            _buildPasswordStrengthSection(),

            const SizedBox(height: 16),

            // Confirm Password Label
            Text(l10n.confirmPasswordField, style: textTheme.labelLarge),
            const SizedBox(height: 8),
            AppTextField(
              controller: _confirmPasswordController,
              hint: l10n.reEnterPassword,
              isPassword: true,
              isRequired: false,
              textInputAction: TextInputAction.done,
              validator: (value) => _validateConfirmPassword(value, l10n),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthSection() {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password Strength", style: textTheme.labelMedium),
        const SizedBox(height: 6),

        // 4 Strength Bars
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < _strengthScore;
            return Expanded(
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 500),
                height: 5,
                margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                decoration: BoxDecoration(
                  color: isFilled ? colors.tertiary : colors.outline,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        // 3 Rule Badges
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _buildRuleBadge("8+ characters", _hasMinLength),
            _buildRuleBadge("contains symbols", _hasNumberOrSymbol),
            _buildRuleBadge("Upper & lower case", _hasUpperAndLower),
          ],
        ),
      ],
    );
  }

  Widget _buildRuleBadge(String text, bool isMet) {
    final colors = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<WorkBridgeThemeExtension>()!;

    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMet ? palette.matchBackground : colors.onInverseSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMet)
            Icon(
              Icons.check,
              size: 14,
              color: isMet ? palette.matchForeground : colors.outline,
            ),
          if (isMet) const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isMet ? palette.matchForeground : colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
