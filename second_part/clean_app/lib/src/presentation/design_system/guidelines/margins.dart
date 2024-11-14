import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:flutter/material.dart';

class Margins {
  const Margins();

  static const smAll = EdgeInsets.all(Grid.sm);
  static const mdAll = EdgeInsets.all(Grid.md);
  static const lgAll = EdgeInsets.all(Grid.lg);

  static const smH = EdgeInsets.symmetric(horizontal: Grid.sm);
  static const mdH = EdgeInsets.symmetric(horizontal: Grid.md);
  static const lgH = EdgeInsets.symmetric(horizontal: Grid.lg);

  static const smV = EdgeInsets.symmetric(vertical: Grid.sm);
  static const mdV = EdgeInsets.symmetric(vertical: Grid.md);
  static const lgV = EdgeInsets.symmetric(vertical: Grid.lg);
}
