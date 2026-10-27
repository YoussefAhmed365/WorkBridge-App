import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workbridge/core/utils/app_assets.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/features/auth/presentation/widgets/signup_step_counter.dart';
import 'package:workbridge/features/auth/presentation/widgets/steps/account_credentials_step.dart';
import 'package:workbridge/generated/l10n.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const int _totalSteps = 3;
  final PageController _pageController = PageController();

  // Form Keys for each step
  final _credentialsFormKey = GlobalKey<FormState>();
  final _roleFormKey = GlobalKey<FormState>();
  final _accountDetailsFormKey = GlobalKey<FormState>();

  int _currentStep = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep >= _totalSteps - 1) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    if (_currentStep <= 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _credentialsFormKey.currentState?.validate() ?? false;
      case 1:
        return _roleFormKey.currentState?.validate() ?? false;
      case 2:
        return _accountDetailsFormKey.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  Future<void> _handleNext() async {
    if (_isSubmitting) return;

    // Validate current step
    if (!_validateCurrentStep()) return;

    if (_currentStep < _totalSteps - 1) {
      _nextStep();
      return;
    }

    await _submitAllData();
  }

  Future<void> _submitAllData() async {
    setState(() => _isSubmitting = true);

    try {
      // Send registration request to backend
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getStepName(S l10n) {
    switch (_currentStep) {
      case 0:
        return l10n.step1;
      case 1:
        return l10n.step2;
      case 2:
        return l10n.step3;
      default:
        return '';
    }
  }

  String _getNextStepName(S l10n) {
    switch (_currentStep + 1) {
      case 1:
        return l10n.step2;
      case 2:
        return l10n.step3;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final l10n = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: Image.asset(
          AppAssets.appIconTransparent,
          semanticLabel: l10n.appName,
        ),
        title: Wrap(
          children: [
            Text(
              "Work",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Bridge",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ),
      body: PopScope(
        canPop: _currentStep == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && _currentStep > 0) {
            _previousStep();
          }
        },
        child: Column(
          children: [
            // 1. Step Indicator
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
              child: SignupStepCounter(
                step: _currentStep,
                stepName: _getStepName(l10n),
              ),
            ),
            const SizedBox(height: 28),

            // 3. Form Steps in PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
                children: [
                  AccountCredentialsStep(
                    formKey: _credentialsFormKey,
                    onSubmitStep: _handleNext,
                  ),
                ],
              ),
            ),

            // 4. Fixed Bottom Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton.primary(
                      isLoading: _isSubmitting,
                      text: _isSubmitting
                          ? ''
                          : _currentStep == _totalSteps - 1
                          ? l10n.signup
                          : "${l10n.next}: ${_getNextStepName(l10n)}",
                      onPressed: _isSubmitting ? null : _handleNext,
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_currentStep == 0) ...[
                    // OR SIGN UP WITH Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: colors.outline)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            l10n.continueSignupWithOptions.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Expanded(child: Divider(color: colors.outline)),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Social Buttons (Google & Facebook)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: colors.outlineVariant),
                              backgroundColor: colors.surface,
                            ),
                            icon: Icon(
                              Icons.g_mobiledata_rounded,
                              size: 24,
                              color: colors.error,
                            ),
                            label: Text(
                              "Google",
                              style: TextStyle(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(
                                0xFF1877F2,
                              ), // Facebook Blue
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.facebook,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Facebook",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Already registered? Log In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.haveLoginAccount, style: textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => context.push('/login'),
                        child: Text(
                          l10n.login,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Terms & Privacy Policy Footer
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "${l10n.signupScreenFooterTerms} ",
                        style: textTheme.bodySmall,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          l10n.termsOfService,
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(" & ", style: textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          l10n.privacyPolicy,
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
