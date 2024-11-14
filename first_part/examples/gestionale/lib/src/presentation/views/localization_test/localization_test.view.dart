import 'package:flutter/material.dart';
import 'package:gestionale/src/presentation/design_system/typography/h1.dart';
import 'package:gestionale/src/presentation/views/home/home.view.dart';
import 'package:localization/localization.dart';

class HomeWithLocalizationView extends StatelessWidget {
  const HomeWithLocalizationView({super.key});

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
                context.setLocale(const Locale('it'));
              },
              child: const Text('Change to Italian'),
            ),
            FilledButton(
              onPressed: () {
                context.setLocale(const Locale('en'));
              },
              child: const Text('Change to English'),
            ),
            FilledButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2030),
                );
              },
              child: const Text('Open Date Picker'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              },
              child: const Text('Open a new page'),
            ),
          ],
        ),
      ),
    );
  }
}
