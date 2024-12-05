import 'package:clean_app/src/presentation/design_system/components/resusable_components/slider_form_field.dart';
import 'package:flutter/cupertino.dart';

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
    return const Column(
      children: [
        CSliderFormField(
          fieldID: 'flutter_experience',
          initialValue: 0,
          min: 0,
          max: 7,
          divisions: 7,
        ),
      ],
    );
  }
}
