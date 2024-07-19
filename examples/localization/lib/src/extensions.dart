import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/src/translations.cubit.dart';

extension TranslateExtension on BuildContext {
  String tr(String text) {
    try {
      return watch<TranslationsCubit>().translate(text);
    } catch (_) {
      return read<TranslationsCubit>().translate(text);
    }
  }

  Locale get locale => read<TranslationsCubit>().state.locale;

  Locale get fallbackLocale => read<TranslationsCubit>().state.fallbackLocale;

  void setLocale(Locale locale) => read<TranslationsCubit>().setLocale(locale);
}
