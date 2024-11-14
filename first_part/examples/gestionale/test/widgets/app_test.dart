import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestionale/src/app.dart';
import 'package:gestionale/src/presentation/views/localization_test/localization_test.view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_test.dart';
import 'home_test.dart';

void main() => tests();

void tests() {
  testWidgets('test App', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    await tester.pumpWidget(const App());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    expect(find.byType(MaterialApp), findsOneWidget);

    expect(find.text('Splash'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    await signIn(tester);

    expect(find.byType(HomeView), findsOneWidget);
  });
}
