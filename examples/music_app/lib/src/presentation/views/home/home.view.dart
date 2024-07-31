import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/src/core/constants/fake_data.dart';
import 'package:music_app/src/core/extensions/lists.ext.dart';
import 'package:music_app/src/core/extensions/widgets.ext.dart';
import 'package:music_app/src/presentation/global_blocs/audio.cubit.dart';
import 'package:music_app/src/presentation/views/home/widgets/playlist.widget.dart';
import 'package:music_app/src/presentation/views/home/widgets/song.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioCubit(),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final fakeData = FakeData.ready();

  late final AppLifecycleListener _listener;

  AudioCubit get _cubit => context.read<AudioCubit>();

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onShow: () => {},
      onRestart: () => {},
      onHide: () => {
        _cubit.pause(),
      },
      onInactive: () => {},
      onPause: () => {
        _cubit.pause(),
      },
      onDetach: () => {},
      onResume: () => {},
      onStateChange: (state) {
        print(state);
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          [
            const Text('Playlist').paddingOnly(left: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemCount: fakeData.playlists.length,
                itemBuilder: (context, index) =>
                    const PlaylistWidget().onTap(() {
                  _cubit.playSong(fakeData.playlists[index], 0);
                }),
              ),
            ),
            const Text('Songs').paddingOnly(left: 16),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: fakeData.songs.songs.length,
              itemBuilder: (context, index) => SongWidget(
                onPlay: () {
                  _cubit.playSong(fakeData.songs, index);
                },
              ),
            ),
          ].listView(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: [
              BlocBuilder<AudioCubit, AudioState>(
                builder: (context, state) {
                  if (state is AudioNoSong) {
                    return const Text('Play a song');
                  }
                  return Text((state as AudioWithSong).song.name);
                },
              ),
              IconButton(
                onPressed: () {
                  _cubit.playOrPause(fakeData.songs);
                },
                icon: BlocBuilder<AudioCubit, AudioState>(
                  builder: (context, state) {
                    if (state is AudioPlaying) {
                      return const Icon(CupertinoIcons.pause);
                    }
                    return const Icon(CupertinoIcons.play);
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  _cubit.nextOrPlayFirstSong(fakeData.songs);
                },
                icon: BlocBuilder<AudioCubit, AudioState>(
                  builder: (context, state) {
                    if (state is AudioNoSong) {
                      return const Icon(CupertinoIcons.arrow_left_to_line);
                    }
                    return Icon(
                      CupertinoIcons.arrow_right_to_line,
                      color: (state as AudioWithSong).isLast()
                          ? Colors.white60
                          : Colors.black,
                    );
                  },
                ),
              ),
            ].row(),
          )
              .blur(48)
              .clipRRect(borderRadius: BorderRadius.circular(10))
              .decorated(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 24,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ))
              .onTap(() => context.push('/player', extra: _cubit))
              .paddingAll(16)
              .safeArea()
              .align(Alignment.bottomCenter),
        ],
      ),
    );
  }
}
