import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:io';

import 'package:localization/src/translations.state.dart';
import 'package:localization/src/typedefs.dart';

Locale get _getUserLocale {
  final userLocaleString = Platform.localeName;
  return Locale(userLocaleString.split('_').first);
}

RegExp _exp(String word) => RegExp("@$word\\b");

class TranslationsCubit extends HydratedCubit<TranslationsState> {
  TranslationsCubit({
    required Translations translations,
    required Locale fallbackLocale,
    Locale? locale,
  }) : super(
          TranslationsState(
            translations: translations,
            locale: locale ?? _getUserLocale,
            fallbackLocale: fallbackLocale,
          ),
        );

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }

  String translate(String text, {Map<String, String>? replacements}) {
    final currentState = state;
    String? translation =
        currentState.translations[currentState.locale.languageCode]?[text] ??
            currentState.translations[currentState.fallbackLocale.languageCode]
                ?[text] ??
            text;
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
    return TranslationsState(
      translations: state.translations,
      locale: Locale(json['locale']),
      fallbackLocale: state.fallbackLocale,
    );
  }

  @override
  Map<String, dynamic>? toJson(TranslationsState state) {
    return {
      'locale': state.locale.languageCode,
    };
  }
}
