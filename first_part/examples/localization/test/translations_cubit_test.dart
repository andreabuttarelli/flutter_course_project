import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/src/translations.cubit.dart';

import 'storage_initialization.dart';

void main() => tests();

void tests() {
  group('testing TranslationCubit', () {
    storageInitialization();
    test('should replace @name', () {
      final cubit = TranslationsCubit(
        translations: {
          'en': {
            'hello': 'Hello @name',
            'world': 'World',
          },
          'it': {
            'hello': 'Ciao @name',
            'world': 'Mondo',
          },
        },
        locale: const Locale('it'),
        fallbackLocale: const Locale('en'),
      );
      final res = cubit.translate('hello', replacements: {'name': 'John'});
      expect(res, 'Ciao John');
    });

    test('shouldn\'t replace @name', () {
      final cubit = TranslationsCubit(
        translations: {
          'en': {
            'hello': 'Hello @namecom',
            'world': 'World',
          },
          'it': {
            'hello': 'Ciao @namecom',
            'world': 'Mondo',
          },
        },
        locale: const Locale('it'),
        fallbackLocale: const Locale('en'),
      );
      final res = cubit.translate('hello', replacements: {'name': 'John'});
      expect(res, 'Ciao @namecom');
    });
  });
}
