import 'package:clean_app/src/presentation/design_system/components/resusable_components/drop_down_form_button.dart';
import 'package:clean_app/src/presentation/design_system/components/resusable_components/text_form_field.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/views/form_hr/blocs/form_hr_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ResidenzaView extends StatefulWidget {
  const ResidenzaView({super.key});

  @override
  State<ResidenzaView> createState() => _ResidenzaViewState();
}

class _ResidenzaViewState extends State<ResidenzaView> {
  final TextEditingController viaController = TextEditingController();
  final FocusNode viaFocusNode = FocusNode();
  final TextEditingController capController = TextEditingController();
  final FocusNode capFocusNode = FocusNode();

  @override
  void dispose() {
    viaController.dispose();
    viaFocusNode.dispose();
    capController.dispose();
    capFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CDropDownFormButton<String>(
          hintLabel: 'Nazione',
          errorLabelIfEmpty: 'Seleziona una nazione',
          items: const [
            MapEntry('Italia', 'Italia'),
          ],
          onChanged: (value) =>
              context.read<FormHRCubit>().updateCountry(value!),
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: viaController,
          focusNode: viaFocusNode,
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: capController,
          focusNode: capFocusNode,
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: TextEditingController(),
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: TextEditingController(),
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: TextEditingController(),
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: TextEditingController(),
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
        const Gap(Grid.md),
        CTextFormField(
          placeholder: 'Via',
          controller: TextEditingController(),
          isRequired: true,
          errorLabelIfEmpty: 'Inserisci la tua via',
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
