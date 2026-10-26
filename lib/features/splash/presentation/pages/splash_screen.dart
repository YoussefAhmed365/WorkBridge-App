import 'package:flutter/material.dart';
import 'package:workbridge/core/utils/app_assets.dart';
import 'package:workbridge/features/auth/presentation/pages/login_screen.dart';
import 'package:workbridge/features/splash/presentation/widgets/loading_widget.dart';
import 'package:workbridge/generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  int _loadingState = 1;
  String _loadingLabel = "Starting WorkBridge";

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Step 1: Initialize local storage & app configurations
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _progress = 0.30;
      _loadingState = 2;
    });

    // Step 2: Verify user authentication session
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _progress = 0.70;
      _loadingState = 3;
    });

    // Step 3: Sync user profile & data
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _progress = 1.0;
      _loadingState = 4;
    });

    // Brief delay at 100% for smooth visual transition
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    switch(_loadingState) {
      case 1:
        _loadingLabel = l10n.splashLoadingState1;
        break;
      case 2:
        _loadingLabel = l10n.splashLoadingState2;
        break;
      case 3:
        _loadingLabel = l10n.splashLoadingState3;
        break;
      case 4:
        _loadingLabel = l10n.splashLoadingState4;
        break;
      default:
        _loadingLabel = l10n.splashLoadingStateDefault;
        break;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 250),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppAssets.appIcon,
                  height: 128,
                  width: 128,
                  fit: BoxFit.contain,
                  semanticLabel: l10n.appName,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.appName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              LoadingWidget(
                loadingState: _progress,
                loadingLabel: _loadingLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
