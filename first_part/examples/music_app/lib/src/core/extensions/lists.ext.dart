import 'package:flutter/widgets.dart';

extension ListsUtils on List<Widget> {
  Column column({MainAxisSize size = MainAxisSize.min}) =>
      Column(mainAxisSize: size, children: this);
  Row row() => Row(children: this);
  Stack stack() => Stack(children: this);
  ListView listView() => ListView(children: this);
}
