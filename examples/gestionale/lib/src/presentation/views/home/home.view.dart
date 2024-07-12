import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/design_system/typography/h1.dart';
import 'package:gestionale/src/presentation/global_blocs/translations/translations.cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const H1('hello'),
            FilledButton(
              onPressed: () {
                context.read<TranslationsCubit>().setLocale(const Locale('it'));
              },
              child: const Text('Change to Italian'),
            ),
            FilledButton(
              onPressed: () {
                context.read<TranslationsCubit>().setLocale(const Locale('en'));
              },
              child: const Text('Change to English'),
            ),
          ],
        ),
      ),
    );
  }
}
