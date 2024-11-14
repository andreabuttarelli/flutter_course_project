import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestionale/src/presentation/views/auth/auth.view.dart';

void main() => tests();

void tests() {
  testWidgets('test AuthView', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthView(
          useAuthCubit: false,
        ),
      ),
    );

    await signIn(tester);

    expect(find.text('Login Success'), findsOneWidget);
  });
}

Future<void> signIn(tester) async {
  expect(find.byType(CupertinoTextField), findsWidgets);

  await tester.enterText(find.byType(CupertinoTextField).first, 'email');
  await tester.enterText(find.byType(CupertinoTextField).last, 'password');

  await tester.pump();

  await tester.tap(find.byType(FilledButton));

  await tester.pumpAndSettle();
}
