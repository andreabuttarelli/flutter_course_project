// ! Wrong
// Tried to validate the form granularly, but the validation is not working as expected
// because there is no way to remove error texts in fields not visible yet.

import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormHRViewWithIndexedStackValidateGranularity extends StatefulWidget {
  const FormHRViewWithIndexedStackValidateGranularity({super.key});

  @override
  State<FormHRViewWithIndexedStackValidateGranularity> createState() =>
      _FormHRViewWithIndexedStackValidateGranularityState();
}

class _FormHRViewWithIndexedStackValidateGranularityState
    extends State<FormHRViewWithIndexedStackValidateGranularity> {
  final formKey = GlobalKey<FormState>();
  FormHRTabs currentTab = FormHRTabs.residenza;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IgnorePointer(
              child: CupertinoSlidingSegmentedControl<FormHRTabs>(
                groupValue: currentTab,
                children: const <FormHRTabs, Widget>{
                  FormHRTabs.residenza: BodyTypo(label: 'Residenza'),
                  FormHRTabs.anagrafica: BodyTypo(label: 'Anagrafia'),
                  FormHRTabs.curriculum: BodyTypo(label: 'Curriculum'),
                },
                onValueChanged: (page) {},
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: IndexedStack(
                  index: currentTab.index,
                  children: const [
                    _Page1(),
                    _Page2(),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final failedFields = formKey.currentState!
                    .validateGranularly()
                    .map((e) => (e.widget.key as ValueKey).value.toString());
                if (failedFields
                    .any((e) => e.contains('${currentTab.name}_'))) {
                  return;
                }
                setState(() {
                  currentTab = FormHRTabs.values[currentTab.index + 1];
                });
              },
              child: const BodyTypo(label: 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Page1 extends StatefulWidget {
  const _Page1({super.key});

  @override
  State<_Page1> createState() => _Page1State();
}

class _Page1State extends State<_Page1> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: ValueKey('${FormHRTabs.residenza.name}_text_form_field'),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _Page2 extends StatefulWidget {
  const _Page2({
    super.key,
  });

  @override
  State<_Page2> createState() => _Page2State();
}

class _Page2State extends State<_Page2> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> load5seconds() async {
    Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: ValueKey('${FormHRTabs.anagrafica.name}_text_form_field'),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        FutureBuilder(
          future: load5seconds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
