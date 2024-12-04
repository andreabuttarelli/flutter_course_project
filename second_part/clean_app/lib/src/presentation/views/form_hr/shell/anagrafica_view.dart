import 'package:flutter/cupertino.dart';

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
        FormField<String>(
          key: const ValueKey('nome_field'),
          initialValue: '',
          builder: (state) => CupertinoTextField(
            controller: nomeController,
            placeholder: 'Nome',
            onChanged: (value) => state.didChange(value),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Inserisci la tua via';
            }
            return null;
          },
        ),
      ],
    );
  }
}
