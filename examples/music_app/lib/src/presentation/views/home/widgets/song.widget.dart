import 'package:flutter/material.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key, required this.onPlay});

  final Function() onPlay;

  @override
  Widget build(BuildContext context) {
    return [
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ).expanded(),
      const Text('Song'),
    ].column().onTap(onPlay);
  }
}
