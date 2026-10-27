import 'package:flutter/material.dart';

/// WorkBridge Standard Loading Progress Widget
///
/// Displays a smooth linear progress bar with an accompanying status label.
/// Automatically handles normalized (0.0 - 1.0) or percentage (0 - 100) progress inputs.
/// Smoothly animates value transitions using [TweenAnimationBuilder].
class LoadingWidget extends StatelessWidget {
  final double? loadingState;
  final String loadingLabel;

  const LoadingWidget({
    super.key,
    this.loadingState,
    required this.loadingLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Normalize progress value to 0.0 - 1.0 range if supplied as percentage
    final double? progressValue = loadingState != null
        ? (loadingState! > 1.0 ? (loadingState! / 100.0) : loadingState!).clamp(0.0, 1.0)
        : null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 4,
          child: progressValue == null
              ? LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                  backgroundColor: colors.primaryContainer,
                  color: colors.primary,
                )
              : TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: progressValue),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      borderRadius: const BorderRadius.all(Radius.circular(99)),
                      backgroundColor: colors.primaryContainer,
                      color: colors.primary,
                    );
                  },
                ),
        ),
        if (loadingLabel.isNotEmpty) ...[
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              loadingLabel,
              key: ValueKey<String>(loadingLabel),
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}