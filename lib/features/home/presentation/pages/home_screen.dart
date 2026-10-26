import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbridge/generated/l10n.dart';
import 'package:workbridge/core/localization/locale_cubit.dart';
import 'package:workbridge/core/widgets/app_button.dart';
import 'package:workbridge/core/widgets/app_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded),
            onPressed: () {
              context.read<LocaleCubit>().toggleLanguage();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.welcomeUser('Youssef'), style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            AppTextField.search(hint: l10n.searchJobs),
            const Spacer(),
            AppButton.primary(
              text: l10n.changeLanguage,
              leadingIcon: const Icon(Icons.translate_rounded),
              onPressed: () {
                context.read<LocaleCubit>().toggleLanguage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
