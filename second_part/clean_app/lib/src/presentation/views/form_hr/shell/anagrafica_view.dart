import 'package:clean_app/src/presentation/design_system/components/resusable_components/text_form_field.dart';
import 'package:clean_app/src/presentation/views/form_hr/blocs/form_hr_cubit.dart';
import 'package:clean_app/src/presentation/views/form_hr/form_her_view_with_indexstack_with_valuenotifier.dart';
import 'package:clean_app/src/presentation/views/form_hr/shell/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnagraficaView extends StatefulWidget {
  const AnagraficaView({super.key});

  @override
  State<AnagraficaView> createState() => _ResidenzaViewState();
}

class _ResidenzaViewState extends State<AnagraficaView> {
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
        CTextFormField(
          placeholder: 'Nome',
          controller: nomeController,
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          onChanged: (value) => context.read<FormHRCubit>().updateName(value!),
        ),
        const Spacer(),
        const FormSubmitButton(
          currentTab: FormHRTabs.anagrafica,
        ),
      ],
    );
  }
}
