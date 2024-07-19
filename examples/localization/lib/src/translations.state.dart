import 'package:flutter/material.dart';

class TranslationsState {
  final Map<String, Map<String, String>> translations;
  final Locale locale;
  final Locale fallbackLocale;

  const TranslationsState({
    required this.translations,
    required this.locale,
    required this.fallbackLocale,
  });

  TranslationsState copyWith({
    Map<String, Map<String, String>>? translations,
    Locale? locale,
    Locale? fallbackLocale,
  }) =>
      TranslationsState(
        translations: translations ?? this.translations,
        locale: locale ?? this.locale,
        fallbackLocale: fallbackLocale ?? this.fallbackLocale,
      );
}
