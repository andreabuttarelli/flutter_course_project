import 'package:clean_app/src/presentation/design_system/components/resusable_components/form_field.dart';
import 'package:clean_app/src/presentation/design_system/components/resusable_components/text_field.dart';
import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  const CTextFormField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.focusNode,
    this.initialValue = '',
    this.isRequired = true,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.errorLabelIfEmpty = 'Required field. Please select an option',
    this.validator,
    this.textInputAction,
    this.multiline = false,
    this.height = 48,
  });

  final String placeholder;
  final String initialValue;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isRequired;
  final String errorLabelIfEmpty;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool multiline;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CFormField(
      key: ValueKey(placeholder),
      initialValue: initialValue,
      builder: (state) => CTextField(
        placeholder: isRequired ? '$placeholder*' : placeholder,
        controller: controller,
        focusNode: focusNode,
        multiline: multiline,
        height: height,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
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
        if (isRequired && value!.isEmpty) {
          return errorLabelIfEmpty;
        }
        return null;
      },
    );
  }
}
