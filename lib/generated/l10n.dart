// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WorkBridge`
  String get appName {
    return Intl.message('WorkBridge', name: 'appName', desc: '', args: []);
  }

  /// `WorkBridge Platform`
  String get appTitle {
    return Intl.message(
      'WorkBridge Platform',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Starting WorkBridge`
  String get splashLoadingState1 {
    return Intl.message(
      'Starting WorkBridge',
      name: 'splashLoadingState1',
      desc: '',
      args: [],
    );
  }

  /// `Loading app configuration`
  String get splashLoadingState2 {
    return Intl.message(
      'Loading app configuration',
      name: 'splashLoadingState2',
      desc: '',
      args: [],
    );
  }

  /// `Checking credentials`
  String get splashLoadingState3 {
    return Intl.message(
      'Checking credentials',
      name: 'splashLoadingState3',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get splashLoadingState4 {
    return Intl.message(
      'Ready',
      name: 'splashLoadingState4',
      desc: '',
      args: [],
    );
  }

  /// `Initializing...`
  String get splashLoadingStateDefault {
    return Intl.message(
      'Initializing...',
      name: 'splashLoadingStateDefault',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Sign in to access your jobs, gigs, and services`
  String get loginSubtitle {
    return Intl.message(
      'Welcome back! Sign in to access your jobs, gigs, and services',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Egypt (+20)`
  String get egyptPhoneCode {
    return Intl.message(
      'Egypt (+20)',
      name: 'egyptPhoneCode',
      desc: '',
      args: [],
    );
  }

  /// `Phone number or email`
  String get phoneOrEmailField {
    return Intl.message(
      'Phone number or email',
      name: 'phoneOrEmailField',
      desc: '',
      args: [],
    );
  }

  /// `01● ●●● ●●●● or email`
  String get phoneOrEmailFieldHint {
    return Intl.message(
      '01● ●●● ●●●● or email',
      name: 'phoneOrEmailFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `email@exmaple.com`
  String get emailExample {
    return Intl.message(
      'email@exmaple.com',
      name: 'emailExample',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordField {
    return Intl.message('Password', name: 'passwordField', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPasswordField {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordField',
      desc: '',
      args: [],
    );
  }

  /// `Create a secure password`
  String get createSecurePassword {
    return Intl.message(
      'Create a secure password',
      name: 'createSecurePassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get reEnterPassword {
    return Intl.message(
      'Re-enter your password',
      name: 'reEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number or email`
  String get errorPhoneOrEmailField {
    return Intl.message(
      'Enter a valid phone number or email',
      name: 'errorPhoneOrEmailField',
      desc: '',
      args: [],
    );
  }

  /// `Password must be correct`
  String get errorConfirmPasswordField {
    return Intl.message(
      'Password must be correct',
      name: 'errorConfirmPasswordField',
      desc: '',
      args: [],
    );
  }

  /// `This field can't be empty`
  String get errorFieldIsEmpty {
    return Intl.message(
      'This field can\'t be empty',
      name: 'errorFieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberCheckbox {
    return Intl.message(
      'Remember me',
      name: 'rememberCheckbox',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message('Log in', name: 'login', desc: '', args: []);
  }

  /// `Sign up`
  String get signup {
    return Intl.message('Sign up', name: 'signup', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `OR CONTINUE WITH`
  String get continueLoginWithOptions {
    return Intl.message(
      'OR CONTINUE WITH',
      name: 'continueLoginWithOptions',
      desc: '',
      args: [],
    );
  }

  /// `OR SIGN UP WITH`
  String get continueSignupWithOptions {
    return Intl.message(
      'OR SIGN UP WITH',
      name: 'continueSignupWithOptions',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get haveNoLoginAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'haveNoLoginAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already Registered?`
  String get haveLoginAccount {
    return Intl.message(
      'Already Registered?',
      name: 'haveLoginAccount',
      desc: '',
      args: [],
    );
  }

  /// `By logging in, you agree to WorkBridge’s`
  String get loginScreenFooterTerms {
    return Intl.message(
      'By logging in, you agree to WorkBridge’s',
      name: 'loginScreenFooterTerms',
      desc: '',
      args: [],
    );
  }

  /// `By signing in, you agree to WorkBridge’s`
  String get signupScreenFooterTerms {
    return Intl.message(
      'By signing in, you agree to WorkBridge’s',
      name: 'signupScreenFooterTerms',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back, {userName}!`
  String welcomeUser(String userName) {
    return Intl.message(
      'Welcome back, $userName!',
      name: 'welcomeUser',
      desc: '',
      args: [userName],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message('Jobs', name: 'jobs', desc: '', args: []);
  }

  /// `Search jobs, skills, or companies...`
  String get searchJobs {
    return Intl.message(
      'Search jobs, skills, or companies...',
      name: 'searchJobs',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `A server error occurred`
  String get serverError {
    return Intl.message(
      'A server error occurred',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get networkError {
    return Intl.message(
      'Please check your internet connection',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get changeLanguage {
    return Intl.message(
      'Change language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you got lost!`
  String get notFoundRoute {
    return Intl.message(
      'Looks like you got lost!',
      name: 'notFoundRoute',
      desc: '',
      args: [],
    );
  }

  /// `Step {step} of {finalStep}`
  String step(int step, int finalStep) {
    return Intl.message(
      'Step $step of $finalStep',
      name: 'step',
      desc: '',
      args: [step, finalStep],
    );
  }

  /// `Account Credentials`
  String get step1 {
    return Intl.message(
      'Account Credentials',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Role`
  String get step2 {
    return Intl.message('Select Your Role', name: 'step2', desc: '', args: []);
  }

  /// `Personal Details`
  String get step3 {
    return Intl.message('Personal Details', name: 'step3', desc: '', args: []);
  }

  /// `Create Your Account`
  String get signupTitle1 {
    return Intl.message(
      'Create Your Account',
      name: 'signupTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Enter your credentials to discover gigs and jobs across Egypt.`
  String get signupSubtitle1 {
    return Intl.message(
      'Enter your credentials to discover gigs and jobs across Egypt.',
      name: 'signupSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `How do you plan to use WorkBridge?`
  String get signupTitle2 {
    return Intl.message(
      'How do you plan to use WorkBridge?',
      name: 'signupTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Select your primary role. You can interact with other features later.`
  String get signupSubtitle2 {
    return Intl.message(
      'Select your primary role. You can interact with other features later.',
      name: 'signupSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Complete Your Profile`
  String get signupTitle3 {
    return Intl.message(
      'Complete Your Profile',
      name: 'signupTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Tell us a bit about yourself to unlock matched gigs, full-time jobs, and shifts across Egypt.`
  String get signupSubtitle3 {
    return Intl.message(
      'Tell us a bit about yourself to unlock matched gigs, full-time jobs, and shifts across Egypt.',
      name: 'signupSubtitle3',
      desc: '',
      args: [],
    );
  }

  /// `Set Up Business Profile`
  String get signupTitle3BusinessProfile {
    return Intl.message(
      'Set Up Business Profile',
      name: 'signupTitle3BusinessProfile',
      desc: '',
      args: [],
    );
  }

  /// `Provide your company details to post jobs, discover Egyptian talent, and manage hiring across all governorates.`
  String get signupSubtitle3BusinessProfile {
    return Intl.message(
      'Provide your company details to post jobs, discover Egyptian talent, and manage hiring across all governorates.',
      name: 'signupSubtitle3BusinessProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
