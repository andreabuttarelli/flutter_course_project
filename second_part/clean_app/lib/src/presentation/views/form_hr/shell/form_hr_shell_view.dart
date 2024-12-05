import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/margins.dart';
import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/design_system/typography/label_typo_widget.dart';
import 'package:clean_app/src/presentation/views/form_hr/blocs/form_hr_cubit.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

Set<String> residenzaSectionKeys = {
  'nazione_field',
  'provincia_field',
  'comune_field',
  'via_field',
  'cap_field',
};

Set<String> anagraficaSectionKeys = {
  'nome_field',
  'cognome_field',
  'data_nascita_field',
  'luogo_nascita_field',
  'codice_fiscale_field',
};

Map<FormHRTabs, Set<String>> formKeysByTab = {
  FormHRTabs.residenza: residenzaSectionKeys,
  FormHRTabs.anagrafica: anagraficaSectionKeys,
};

class FormHrShellView extends StatefulWidget {
  const FormHrShellView({
    super.key,
    required this.tab,
    required this.child,
  });

  final FormHRTabs tab;
  final Widget child;

  @override
  State<FormHrShellView> createState() => _FormHrShellViewState();
}

class _FormHrShellViewState extends State<FormHrShellView> {
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormHRCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: Margins.mdAll,
            child: Column(
              children: [
                CupertinoSlidingSegmentedControl<int>(
                  groupValue: widget.tab.index,
                  children: <int, Widget>{
                    ...['Residenza', 'Anagrafica', 'Curriculum'].asMap().map(
                          (key, value) => MapEntry(
                            key,
                            Opacity(
                              opacity: widget.tab.index >= key ? 1 : 0.1,
                              child: LabelTypo(label: value),
                            ),
                          ),
                        ),
                  },
                  onValueChanged: (page) {
                    assert(page != null);
                    if (page == null) return;
                    if (page < widget.tab.index) {
                      context.push('/form_hr/${FormHRTabs.values[page].name}');
                    }
                  },
                ),
                const Gap(Grid.md),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: widget.child,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final unvalidateFields = formKey.currentState!
                        .validateGranularly()
                        .map((e) => (e.widget.key as ValueKey).value)
                        .toSet();
                    final unvalidateTabField = formKeysByTab[widget.tab]!
                        .any((e) => unvalidateFields.contains(e));
                    if (unvalidateTabField) {
                      print('Unvalidate fields: $unvalidateFields');
                      return;
                    }
                    if (widget.tab.index < FormHRTabs.values.length - 1) {
                      context.go(
                          '/form_hr/${FormHRTabs.values[widget.tab.index + 1].name}');
                    }
                  },
                  child: const BodyTypo(label: 'Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
