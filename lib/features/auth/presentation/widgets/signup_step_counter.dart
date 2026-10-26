import 'package:flutter/material.dart';
import 'package:workbridge/core/theme/app_colors.dart';
import 'package:workbridge/generated/l10n.dart';

class SignupStepCounter extends StatelessWidget {
  final int step;
  final String stepName;

  const SignupStepCounter({super.key, required this.step, required this.stepName});

  static const int _totalSteps = 3;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(100)),
              child: Text(l10n.step(step + 1, _totalSteps), style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primary)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(stepName, style: theme.textTheme.labelMedium, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(_totalSteps, (index) {
            final isActive = index <= step;

            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 6,
                margin: EdgeInsets.only(right: index < _totalSteps - 1 ? 8 : 0),
                decoration: BoxDecoration(color: isActive ? AppColors.primary : AppColors.primaryContainer, borderRadius: BorderRadius.circular(100)),
              ),
            );
          }),
        ),
      ],
    );
  }
}