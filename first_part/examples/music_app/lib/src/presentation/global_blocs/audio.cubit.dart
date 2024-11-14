import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/src/data/models/playlist.dart';
import 'package:music_app/src/data/models/song.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(const AudioNoSong()) {
    _audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        final currentState = state;
        if (currentState is! AudioPlaying || currentState is! AudioPaused) {
          return;
        }
        currentState.isLast()
            ? playSong(currentState.playlist, currentState.songIndex + 1)
            : emit(AudioEnded(currentState.playlist, currentState.songIndex));
      }
    });
  }

  final _audioPlayer = AudioPlayer();

  bool canContinuePlaying() {
    final currentState = state;
    if (currentState is! AudioWithSong) return false;
    return currentState.playlist.songs.length > currentState.songIndex + 1;
  }

  void playSong(Playlist playlist, int songIndex) async {
    _audioPlayer.stop();
    final playlist0 = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: [
        for (final e in playlist.songs) AudioSource.uri(Uri.parse(e.url)),
      ],
    );

    await _audioPlayer.setAudioSource(playlist0,
        initialIndex: 0, initialPosition: Duration.zero);
    _audioPlayer.play();
    emit(AudioPlaying(playlist, songIndex));
  }

  void playCurrentSong() async {
    final currentState = state;
    if (currentState is! AudioWithSong) return;
    _audioPlayer.play();
    emit(AudioPlaying(currentState.playlist, currentState.songIndex));
  }

  void pause() {
    final currentState = state;
    if (currentState is! AudioPlaying) return;
    _audioPlayer.pause();
    emit(AudioPaused(currentState.playlist, currentState.songIndex));
  }

  void next() {
    final currentState = state;
    if (currentState is! AudioPlaying && currentState is! AudioPaused) return;
    if ((currentState as AudioWithSong).isLast()) return;
    _audioPlayer.seekToNext();
    emit(AudioPlaying(currentState.playlist, currentState.songIndex + 1));
  }

  void playOrPause(Playlist playlist, {int initialIndex = 0}) {
    final currentState = state;
    if (currentState is AudioNoSong) {
      playSong(playlist, initialIndex);
    } else if (currentState is AudioPlaying) {
      pause();
    } else {
      playCurrentSong();
    }
  }

  void nextOrPlayFirstSong(Playlist playlist, {int initialIndex = 0}) {
    final currentState = state;
    if (currentState is AudioNoSong) {
      playSong(playlist, initialIndex);
      return;
    }
    next();
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}

abstract class AudioState {
  const AudioState();
}

class AudioNoSong extends AudioState {
  const AudioNoSong();
}

abstract class AudioWithSong extends AudioState {
  final Playlist playlist;
  final int songIndex;

  Song get song => playlist.songs[songIndex];

  isLast() => playlist.songs.length == songIndex + 1;

  const AudioWithSong(this.playlist, this.songIndex);
}

class AudioPlaying extends AudioWithSong {
  const AudioPlaying(super.playlist, super.songIndex);
}

class AudioPaused extends AudioWithSong {
  const AudioPaused(super.playlist, super.songIndex);
}

class AudioEnded extends AudioWithSong {
  const AudioEnded(super.playlist, super.songIndex);
}
