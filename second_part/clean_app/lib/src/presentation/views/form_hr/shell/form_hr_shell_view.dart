import 'package:clean_app/src/di/di.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/margins.dart';
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

class FormHrShellView extends StatelessWidget {
  const FormHrShellView({
    super.key,
    required this.tab,
    required this.child,
  });

  final FormHRTabs tab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormHRCubit(
        getIt(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: Margins.mdAll,
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
                              child: LabelTypo(label: value),
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
                const Gap(Grid.md),
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
