import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/core/constants/fake_data.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';
import 'package:music_app/src/presentation/global_blocs/audio.cubit.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  AudioCubit audioCubit(context) => BlocProvider.of<AudioCubit>(context);

  static final fakeData = FakeData.ready();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: [
        Image.network(
          '',
          width: 150,
          height: 150,
        ).center(),
        BlocBuilder<AudioCubit, AudioState>(
          builder: (context, state) {
            if (state is AudioNoSong) {
              return const Text('No song');
            }
            return Text((state as AudioWithSong).song.name);
          },
        ).center(),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                audioCubit(context).playOrPause(fakeData.songs);
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                audioCubit(context).nextOrPlayFirstSong(fakeData.songs);
              },
            ),
          ],
        ),
      ].column(),
    );
  }
}
