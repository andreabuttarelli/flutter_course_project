import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale/src/presentation/global_blocs/translations/translations.cubit.dart';
import 'package:test/test.dart';

void main() => tests();

void tests() {
  group('testing TranslationCubit', () {
    test('should replace @name', () {
      final cubit = TranslationsCubit(
          initialValue: const TranslationsState(
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
        locale: Locale('it'),
        fallbackLocale: Locale('en'),
      ));
      final res = cubit.translate('hello', replacements: {'name': 'John'});
      expect(res, 'Ciao John');
    });

    test('shouldn\'t replace @name', () {
      final cubit = TranslationsCubit(
          initialValue: const TranslationsState(
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
        locale: Locale('it'),
        fallbackLocale: Locale('en'),
      ));
      final res = cubit.translate('hello', replacements: {'name': 'John'});
      expect(res, 'Ciao @namecom');
    });
  });
}
