import 'package:clean_app/src/presentation/design_system/components/atoms/nil.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/margins.dart';
import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:flutter/material.dart';

class CDropDownButton<T> extends StatelessWidget {
  const CDropDownButton({
    super.key,
    required this.hintLabel,
    this.value,
    required this.items,
    required this.onChanged,
  });

  final String hintLabel;
  final T? value;
  final List<MapEntry<T, String>> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    final backgroudColor = Theme.of(context).colorScheme.surfaceContainer;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroudColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(Grid.sm),
        ),
      ),
      child: SizedBox(
        height: 48,
        child: Padding(
          padding: Margins.mdH,
          child: DropdownButton<T>(
            dropdownColor: backgroudColor,
            hint: BodyTypo(label: hintLabel),
            value: value,
            isExpanded: true,
            underline: nil,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e.key,
                    child: BodyTypo(label: e.value),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
