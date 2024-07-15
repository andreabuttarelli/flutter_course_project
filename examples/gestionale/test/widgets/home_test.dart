import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestionale/src/core/translations/index.dart';
import 'package:gestionale/src/presentation/global_blocs/translations/translations.cubit.dart';
import 'package:gestionale/src/presentation/views/home/home.view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

void main() => tests();

class MockStorage extends Mock implements Storage {}

void tests() {
  testWidgets('test HomeView', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => TranslationsCubit(
            initialValue: const TranslationsState(
              locale: Locale('en'),
              fallbackLocale: Locale('it'),
              translations: translations,
            ),
          ),
          child: const HomeView(),
        ),
      ),
    );

    expect(find.text('Hello @name'), findsWidgets);

    await tester.pump();

    await tester.tap(find.text('Change to Italian'));

    await tester.pump();

    expect(find.text('Ciao @name'), findsOneWidget);
  });
}
