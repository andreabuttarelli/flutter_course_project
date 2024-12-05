import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormHrShellView2 extends StatelessWidget {
  const FormHrShellView2({
    super.key,
    required this.tab,
    required this.child,
  });

  final FormHRTabs tab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: GlobalKey<FormState>(),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl<int>(
              groupValue: tab.index,
              children: <int, Widget>{
                ...['Residenza', 'Anagrafica', 'Curriculum'].asMap().map(
                      (key, value) => MapEntry(
                        key,
                        Opacity(
                          opacity: tab.index >= key ? 1 : 0.1,
                          child: BodyTypo(label: value),
                        ),
                      ),
                    ),
              },
              onValueChanged: (page) {
                assert(page != null);
                if (page == null) return;
                if (page < tab.index) {
                  context.push('/form_hr/${FormHRTabs.values[page].name}');
                }
              },
            ),
            Expanded(
              child: child,
            ),
            Builder(builder: (context) {
              return TextButton(
                onPressed: () {
                  print(Form.of(context)
                      .validateGranularly()
                      .map((e) => e.widget.key));
                  if (!Form.of(context).validate()) return;
                  if (tab.index < FormHRTabs.values.length - 1) {
                    context.go(
                        '/form_hr/${FormHRTabs.values[tab.index + 1].name}');
                  }
                },
                child: const BodyTypo(label: 'Continue'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
