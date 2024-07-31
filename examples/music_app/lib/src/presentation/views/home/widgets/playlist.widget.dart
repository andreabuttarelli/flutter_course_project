import 'package:flutter/material.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: [
        const CircleAvatar(
          radius: 40,
        ),
        const Text('Playlist'),
      ].column(),
    );
  }
}
