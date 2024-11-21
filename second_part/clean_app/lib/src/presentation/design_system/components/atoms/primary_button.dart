import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/design_system/typography/display_typo_widget.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary,
        ),
      ),
      child: BodyTypo(label: label),
    );
  }
}
