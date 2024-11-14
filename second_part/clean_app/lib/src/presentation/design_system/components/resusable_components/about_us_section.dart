import 'dart:ui';

import 'package:clean_app/src/presentation/design_system/components/atoms/primary_button.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/typography/display_typo_widget.dart';
import 'package:flutter/material.dart';

class AboutUsComponent extends StatelessWidget {
  const AboutUsComponent(
      {super.key,
      required this.title,
      required this.ctaLabel,
      required this.onPressed});

  final String title;
  final String ctaLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DisplayTypo(label: title),
        const SizedBox(height: Grid.md),
        PrimaryButton(
          label: ctaLabel,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
