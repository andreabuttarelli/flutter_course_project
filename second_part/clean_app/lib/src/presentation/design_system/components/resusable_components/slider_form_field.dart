import 'package:clean_app/src/presentation/design_system/components/resusable_components/form_field.dart';
import 'package:clean_app/src/presentation/design_system/components/resusable_components/slider.dart';
import 'package:flutter/cupertino.dart';

class CSliderFormField extends StatelessWidget {
  const CSliderFormField({
    super.key,
    required this.fieldID,
    required this.initialValue,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  final String fieldID;
  final double initialValue;
  final double min;
  final double max;
  final int? divisions;
  final void Function(double)? onChanged;
  final void Function(double?)? onSaved;
  final String? Function(double?)? validator;

  @override
  Widget build(BuildContext context) {
    return CFormField(
      key: ValueKey(fieldID),
      initialValue: initialValue,
      builder: (state) => CSlider(
        context: context,
        value: state.value!,
        max: max,
        min: min,
        divisions: divisions,
        onChanged: (value) {
          state.didChange(value);
          if (onChanged != null) onChanged!(value);
        },
      ),
      onSaved: (value) {
        if (onSaved != null) onSaved!(value);
      },
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
