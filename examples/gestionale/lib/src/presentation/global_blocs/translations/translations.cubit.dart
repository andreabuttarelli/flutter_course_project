import 'package:flutter/material.dart';
import 'package:gestionale/src/core/translations/index.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

RegExp _exp(String word) => RegExp("@$word\\b");

const _kTranslationInitialValue = TranslationsState(
  translations: translations,
  locale: fallbackLocale,
  fallbackLocale: fallbackLocale,
);

class TranslationsCubit extends HydratedCubit<TranslationsState> {
  TranslationsCubit({TranslationsState? initialValue})
      : super(initialValue ?? _kTranslationInitialValue);

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }

  String translate(String text, {Map<String, String>? replacements}) {
    final currentState = state;
    String? translation =
        currentState.translations[currentState.locale.languageCode]?[text] ??
            currentState.translations[currentState.fallbackLocale.languageCode]
                ?[text];
    if (translation == null) {
      return text;
    }
    if (replacements == null) return translation;
    for (final replacement in replacements.entries) {
      translation = translation!.replaceAll(
        _exp(replacement.key),
        replacement.value,
      );
    }
    return translation!;
  }

  @override
  TranslationsState? fromJson(Map<String, dynamic> json) {
    return _kTranslationInitialValue.copyWith(
      locale: Locale(
        json['locale'],
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(TranslationsState state) {
    return {
      'locale': state.locale.languageCode,
    };
  }
}

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
    Locale? locale,
  }) =>
      TranslationsState(
        translations: translations,
        locale: locale ?? this.locale,
        fallbackLocale: fallbackLocale,
      );
}
