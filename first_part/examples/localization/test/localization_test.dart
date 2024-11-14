import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';

import 'storage_initialization.dart';

void main() {
  storageInitialization();
  testWidgets('test extensions', (tester) async {
    const locale = Locale('it');
    const fallback = Locale('en');
    final translations = {
      'it': {
        'hello': 'Ciao',
      },
      'en': {
        'hello': 'Hello',
      },
    };
    await tester.pumpWidget(
      MaterialApp(
        home: CustomLocalization(
          translations: translations,
          fallbackLocale: fallback,
          locale: locale,
          builder: (context, locale) => Builder(
            builder: (context) {
              return Text(context.tr('hello'));
            },
          ),
        ),
      ),
    );

    expect(find.text('Ciao'), findsOneWidget);
  });
}
