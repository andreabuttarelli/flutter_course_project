import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/global_blocs/translations/translations.cubit.dart';

extension TranslateExtension on BuildContext {
  String tr(String text) {
    try {
      return watch<TranslationsCubit>().translate(text);
    } catch (_) {
      return read<TranslationsCubit>().translate(text);
    }
  }

  Locale locale() => read<TranslationsCubit>().state.locale;

  void setLocale(Locale locale) => read<TranslationsCubit>().setLocale(locale);
}

void prova(BuildContext context) {
  context.read<TranslationsCubit>().stream.listen((state) {
    // qualcosa
  });
  context.watch<TranslationsCubit>().state;
}

class _Prova extends StatefulWidget {
  const _Prova({super.key});

  @override
  State<_Prova> createState() => __ProvaState();
}

class __ProvaState extends State<_Prova> {
  @override
  void initState() {
    super.initState();
    context.read<TranslationsCubit>().translate('Ciao');
    context.read<TranslationsCubit>().stream.listen((state) {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TranslationsCubit>();
    return GestureDetector(
      onTap: () async {
        context.read<TranslationsCubit>().translate('Ciao');
      },
      child: Container(),
    );
  }
}

class _Prova2 extends StatefulWidget {
  const _Prova2({super.key});

  @override
  State<_Prova2> createState() => __Prova2State();
}

class __Prova2State extends State<_Prova2> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TranslationsCubit>(context).translate('Ciao');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TranslationsCubit, TranslationsState>(
      listener: (context, state) {
        // fai qualcosa
      },
      child: BlocBuilder<TranslationsCubit, TranslationsState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              BlocProvider.of<TranslationsCubit>(context).translate('Ciao');
            },
            child: Container(),
          );
        },
      ),
    );
  }
}
