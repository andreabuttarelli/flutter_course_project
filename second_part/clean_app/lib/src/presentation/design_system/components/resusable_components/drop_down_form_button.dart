import 'package:clean_app/src/presentation/design_system/components/resusable_components/drop_down_button.dart';
import 'package:clean_app/src/presentation/design_system/components/resusable_components/form_field.dart';
import 'package:flutter/material.dart';

class CDropDownFormButton<T> extends StatelessWidget {
  const CDropDownFormButton({
    super.key,
    required this.hintLabel,
    required this.items,
    this.initialValue,
    this.isRequired = true,
    this.onChanged,
    this.onSaved,
    this.errorLabelIfEmpty = 'Required field. Please select an option',
    this.validator,
  });

  final String hintLabel;
  final T? initialValue;
  final List<MapEntry<T, String>> items;
  final bool isRequired;
  final String errorLabelIfEmpty;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return CFormField<T>(
      key: ValueKey(hintLabel),
      initialValue: initialValue,
      builder: (state) => CDropDownButton<T>(
        hintLabel: isRequired ? '$hintLabel*' : hintLabel,
        value: state.value,
        items: items,
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
        if (isRequired && value == null) {
          return errorLabelIfEmpty;
        }
        return null;
      },
    );
  }
}
