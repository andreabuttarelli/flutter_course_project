// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clean_app/src/presentation/design_system/components/atoms/nil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Form with dynamic fields test',
    (WidgetTester tester) async {
      final fields = ValueNotifier(<FormField>[
        FormField(
          key: const ValueKey('field_1'),
          builder: (state) => nil,
          validator: (value) => 'e',
        ),
      ]);
      final key = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Form(
            key: key,
            child: ValueListenableBuilder(
              valueListenable: fields,
              builder: (context, fields, _) {
                return Column(
                  children: fields,
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(FormField), findsOneWidget);

      final fieldsUnvalidated = key.currentState!.validateGranularly();
      expect(fieldsUnvalidated, hasLength(1));

      fields.value = [
        FormField(
          key: const ValueKey('field_2'),
          builder: (state) => nil,
          validator: (value) => 'e',
        ),
        FormField(
          key: const ValueKey('field_3'),
          builder: (state) => nil,
          validator: (value) => 'e',
        ),
      ];
      fields.notifyListeners();
      await tester.pump();
      expect(find.byType(FormField), findsExactly(2));
      final fieldsUnvalidated2 = key.currentState!.validateGranularly();
      expect(fieldsUnvalidated2, hasLength(2));
    },
  );
}
