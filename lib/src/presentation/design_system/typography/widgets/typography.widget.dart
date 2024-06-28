import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/responsive_values.dart';
import 'package:prova/src/presentation/design_system/typography/styles/styles.typography.dart';

class H1 extends StatelessWidget {
  const H1(
    this.label, {
    super.key,
    this.color,
    this.maxLines,
  });

  final String label;
  final Color? color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.displayLarge!;
    return Text(
      label,
      style: style.copyWith(
        fontSize: responsiveValue(
          context,
          mobile: style.fontSize,
          tablet: style.fontSize! + 2,
          desktop: style.fontSize! + 2,
        ),
        color: color,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class H2 extends StatelessWidget {
  const H2(
    this.label, {
    super.key,
    this.color,
    this.maxLines,
  });

  final String label;
  final Color? color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TypographyStyles.h2.copyWith(
        color: color,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

void main() {
  const H1('Hello');
  const H2('Hello');
}
