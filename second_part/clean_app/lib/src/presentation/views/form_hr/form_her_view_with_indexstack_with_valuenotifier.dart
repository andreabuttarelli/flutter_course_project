import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FormHRTabs {
  residenza('residenza'),
  anagrafica('anagrafica'),
  curriculum('curriculum');

  final String name;

  const FormHRTabs(this.name);

  factory FormHRTabs.fromName(String name) {
    return FormHRTabs.values.firstWhere((e) => e.name == name);
  }
}

class FormHRViewWithIndexedStackValueNotifier extends StatelessWidget {
  const FormHRViewWithIndexedStackValueNotifier({super.key});

  static final formKey = GlobalKey<FormState>();
  static ValueNotifier<FormHRTabs> currentTab =
      ValueNotifier<FormHRTabs>(FormHRTabs.residenza);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IgnorePointer(
              child: ValueListenableBuilder(
                  valueListenable: currentTab,
                  builder: (context, tab, _) {
                    return CupertinoSlidingSegmentedControl<FormHRTabs>(
                      groupValue: tab,
                      children: const <FormHRTabs, Widget>{
                        FormHRTabs.residenza: BodyTypo(label: 'Residenza'),
                        FormHRTabs.anagrafica: BodyTypo(label: 'Anagrafia'),
                        FormHRTabs.curriculum: BodyTypo(label: 'Curriculum'),
                      },
                      onValueChanged: (page) {},
                    );
                  }),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: ValueListenableBuilder(
                    valueListenable: currentTab,
                    builder: (context, tab, _) {
                      return _CurrentTab(
                        currentTab: tab,
                        child: IndexedStack(
                          index: tab.index,
                          children: const [
                            _PageTab(
                              tab: FormHRTabs.residenza,
                              child: _Page1(),
                            ),
                            _PageTab(
                              tab: FormHRTabs.anagrafica,
                              child: _Page2(),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            TextButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                currentTab.value =
                    FormHRTabs.values[currentTab.value.index + 1];
                currentTab.notifyListeners();
              },
              child: const BodyTypo(label: 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentTab extends InheritedWidget {
  const _CurrentTab(
      {super.key, required this.currentTab, required super.child});

  final FormHRTabs currentTab;

  static _CurrentTab? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CurrentTab>();
  }

  @override
  bool updateShouldNotify(_CurrentTab oldWidget) {
    return true;
  }
}

class _PageTab extends InheritedWidget {
  const _PageTab({super.key, required this.tab, required super.child});

  final FormHRTabs tab;

  static _PageTab? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_PageTab>();
  }

  @override
  bool updateShouldNotify(_PageTab oldWidget) {
    return true;
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
        _FormField<String>(
          initialValue: '',
          builder: (state) => CupertinoTextField(
            controller: controller,
            onChanged: (value) => state.didChange(value),
          ),
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
        _FormField<String>(
          initialValue: '',
          builder: (state) => CupertinoTextField(
            controller: controller,
            onChanged: (value) => state.didChange(value),
          ),
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

class _FormField<T> extends StatelessWidget {
  const _FormField({
    super.key,
    required this.initialValue,
    required this.builder,
    required this.validator,
  });

  final T initialValue;
  final Widget Function(FormFieldState<T>) builder;
  final String? Function(T?) validator;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      builder: (state) => Column(
        children: [
          builder(state),
          if (state.errorText != null)
            BodyTypo(
              label: state.errorText!,
              color: Colors.red,
            ),
        ],
      ),
      validator: (value) {
        if (_CurrentTab.of(context)!.currentTab != _PageTab.of(context)!.tab) {
          return null;
        }
        return validator(value);
      },
    );
  }
}
