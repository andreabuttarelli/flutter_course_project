import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:flutter/material.dart';

class CFormField<T> extends StatelessWidget {
  const CFormField({
    super.key,
    required this.builder,
    required this.validator,
    this.initialValue,
    this.onSaved,
  });

  final T? initialValue;
  final Widget Function(FormFieldState<T>) builder;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;

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
      onSaved: onSaved,
    );
  }
}
