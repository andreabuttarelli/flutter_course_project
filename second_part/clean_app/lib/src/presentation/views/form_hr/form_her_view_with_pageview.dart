import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormHRView extends StatefulWidget {
  const FormHRView({super.key});

  @override
  State<FormHRView> createState() => _FormHRViewState();
}

class _FormHRViewState extends State<FormHRView> {
  FormHRTabs currentTab = FormHRTabs.residenza;
  Map<FormHRTabs, GlobalKey<FormState>> keys = {
    FormHRTabs.residenza: GlobalKey<FormState>(),
    FormHRTabs.anagrafica: GlobalKey<FormState>(),
    FormHRTabs.curriculum: GlobalKey<FormState>(),
  };
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Page1(
                    formKey: keys[FormHRTabs.residenza]!,
                  ),
                  _Page2(
                    formKey: keys[FormHRTabs.anagrafica]!,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (!keys[currentTab]!.currentState!.validate()) return;
                pageController.animateToPage(
                  currentTab.index + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                if (currentTab.index == 0) {
                  setState(() {
                    currentTab = FormHRTabs.anagrafica;
                  });
                }
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
  const _Page1({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

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
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class _Page2 extends StatefulWidget {
  const _Page2({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
