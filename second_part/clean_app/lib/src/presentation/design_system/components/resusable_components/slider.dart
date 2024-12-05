import 'package:clean_app/src/core/extensions/context_ext.dart';
import 'package:flutter/cupertino.dart';

class CSlider extends CupertinoSlider {
  CSlider({
    super.key,
    required BuildContext context,
    required super.value,
    super.min,
    super.max,
    super.divisions,
    super.onChanged,
  }) : super(
          activeColor: context.colors.primary,
          thumbColor: context.colors.inverseSurface,
        );
}
