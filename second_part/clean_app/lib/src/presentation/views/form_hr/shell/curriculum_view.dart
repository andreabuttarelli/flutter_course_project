import 'package:clean_app/src/presentation/design_system/components/resusable_components/slider_form_field.dart';
import 'package:clean_app/src/presentation/views/form_hr/blocs/form_hr_cubit.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurriculumView extends StatefulWidget {
  const CurriculumView({super.key});

  @override
  State<CurriculumView> createState() => _CurriculumViewState();
}

class _CurriculumViewState extends State<CurriculumView> {
  final TextEditingController nomeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CSliderFormField(
          fieldID: 'flutter_experience',
          initialValue: 0,
          min: 0,
          max: 7,
          divisions: 7,
          onChanged: (value) =>
              context.read<FormHRCubit>().updateExperience(value),
        ),
        const Spacer(),
        const FormSubmitButton(
          currentTab: FormHRTabs.curriculum,
        ),
      ],
    );
  }
}
