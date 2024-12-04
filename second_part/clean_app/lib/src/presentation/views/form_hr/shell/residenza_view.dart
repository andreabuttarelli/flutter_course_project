import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResidenzaView extends StatefulWidget {
  const ResidenzaView({super.key});

  @override
  State<ResidenzaView> createState() => _ResidenzaViewState();
}

class _ResidenzaViewState extends State<ResidenzaView> {
  final TextEditingController viaController = TextEditingController();
  final TextEditingController capController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    viaController.dispose();
    capController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormField<String>(
          key: const ValueKey('nazione_field'),
          builder: (state) => DropdownButton(
            hint: const BodyTypo(label: 'Nazione'),
            value: state.value,
            items: const [
              DropdownMenuItem(
                value: 'Italia',
                child: BodyTypo(label: 'Italia'),
              ),
            ],
            onChanged: (value) => state.didChange(value.toString()),
          ),
          validator: (value) {
            if (value == null) return 'Seleziona una nazione';
            return null;
          },
        ),
        _FormField<String>(
          key: const ValueKey('provincia_field'),
          builder: (state) => DropdownButton(
            hint: const BodyTypo(label: 'Provincia'),
            value: state.value,
            items: const [
              DropdownMenuItem(
                value: 'Roma',
                child: BodyTypo(label: 'Roma'),
              ),
            ],
            onChanged: (value) => state.didChange(value.toString()),
          ),
          validator: (value) {
            if (value == null) return 'Seleziona una provincia';
            return null;
          },
        ),
        _FormField<String>(
          key: const ValueKey('comune_field'),
          builder: (state) => DropdownButton(
            hint: const BodyTypo(label: 'Comune'),
            value: state.value,
            items: const [
              DropdownMenuItem(
                value: 'Roma',
                child: BodyTypo(label: 'Roma'),
              ),
            ],
            onChanged: (value) => state.didChange(value.toString()),
          ),
          validator: (value) {
            if (value == null) return 'Seleziona un comune';
            return null;
          },
        ),
        _FormField<String>(
          key: const ValueKey('via_field'),
          initialValue: '',
          builder: (state) => CupertinoTextField(
            controller: viaController,
            placeholder: 'Via',
            onChanged: (value) => state.didChange(value),
            onSubmitted: (value) => focusNode.requestFocus(),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Inserisci la tua via';
            }
            return null;
          },
        ),
        _FormField<String>(
          key: const ValueKey('cap_field'),
          initialValue: '',
          builder: (state) => CupertinoTextField(
            controller: capController,
            focusNode: focusNode,
            placeholder: 'CAP',
            onChanged: (value) => state.didChange(value),
            onTapOutside: (_) => focusNode.unfocus(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Inserisci il tuo CAP';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _FormField<T> extends StatelessWidget {
  const _FormField({
    super.key,
    required this.builder,
    required this.validator,
    this.initialValue,
  });

  final T? initialValue;
  final Widget Function(FormFieldState<T>) builder;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: key,
      initialValue: initialValue,
      builder: (state) => Column(
        children: [
          builder(state),
          if (state.errorText != null)
            BodyTypo(label: state.errorText!, color: Colors.red),
        ],
      ),
      validator: validator,
    );
  }
}
