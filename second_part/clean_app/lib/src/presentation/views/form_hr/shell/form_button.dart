import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/views/form_hr/blocs/form_hr_cubit.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    super.key,
    required this.currentTab,
  });

  final FormHRTabs currentTab;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'cta',
      child: TextButton(
        onPressed: () {
          if (!Form.of(context).validate()) return;
          if (currentTab == FormHRTabs.curriculum) {
            context.read<FormHRCubit>().submit();
            return;
          }
          context
              .go('/form_hr/${FormHRTabs.values[currentTab.index + 1].name}');
        },
        child: const BodyTypo(label: 'Continue'),
      ),
    );
  }
}
