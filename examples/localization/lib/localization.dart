library localization;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/src/translations.cubit.dart';
import 'package:localization/src/translations.state.dart';
import 'package:localization/src/typedefs.dart';

export './src/extensions.dart';

class CustomLocalization extends StatelessWidget {
  const CustomLocalization({
    super.key,
    required this.translations,
    required this.fallbackLocale,
    this.locale,
    required this.builder,
  });

  final Translations translations;
  final Locale fallbackLocale;
  final Locale? locale;
  final Widget Function(BuildContext context, Locale currentLocale) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslationsCubit(
        translations: translations,
        fallbackLocale: fallbackLocale,
        locale: locale,
      ),
      child: BlocBuilder<TranslationsCubit, TranslationsState>(
        builder: (context, state) {
          return builder(
            context,
            state.locale,
          );
        },
      ),
    );
  }
}
