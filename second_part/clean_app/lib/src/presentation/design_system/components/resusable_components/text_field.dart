import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/margins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    this.placeholder,
    this.multiline = false,
    this.height = 48,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.onTapOutside,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String? placeholder;
  final bool multiline;
  final double height;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final void Function()? onTapOutside;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surfaceContainer;
    final field = CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      maxLines: multiline ? null : 1,
      textInputAction: textInputAction,
      padding: Margins.mdH,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(Grid.sm),
        ),
      ),
    );
    assert((multiline && height != 48) || !multiline,
        'Height must be null if multiline is true');
    return SizedBox(
      height: height,
      child: field,
    );
  }
}
