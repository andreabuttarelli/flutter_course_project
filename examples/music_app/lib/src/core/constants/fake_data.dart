import 'package:music_app/src/data/models/playlist.dart';
import 'package:music_app/src/data/models/song.dart';

const _branoUrl1 =
    'https://qajkaikssfpmvcqdfkgy.supabase.co/storage/v1/object/public/da_eliminare/village-background-music-village-music-no-copyright-203060.mp3';
const _branoUrl2 =
    'https://qajkaikssfpmvcqdfkgy.supabase.co/storage/v1/object/public/da_eliminare/copyright-free-background-music-no-copyright-music-216517.mp3';

class FakeData {
  const FakeData({
    required this.songs,
    required this.playlists,
  });

  final Playlist songs;
  final List<Playlist> playlists;

  factory FakeData.ready() {
    final Playlist songs = Playlist(
      id: 'a',
      songs: [
        Song(
          id: 'a',
          name: 'Brano 1',
          url: _branoUrl1,
        ),
        Song(
          id: 'b',
          name: 'Brano 2',
          url: _branoUrl2,
        ),
        Song(
          id: 'c',
          name: 'Brano 3',
          url: _branoUrl1,
        ),
        Song(
          id: 'd',
          name: 'Brano 4',
          url: _branoUrl2,
        ),
      ],
    );
    final List<Playlist> playlists = [
      Playlist(
        id: 'a',
        songs: [
          Song(
            id: 'a',
            name: 'Brano 1',
            url: _branoUrl1,
          ),
          Song(
            id: 'b',
            name: 'Brano 2',
            url: _branoUrl2,
          ),
          Song(
            id: 'c',
            name: 'Brano 3',
            url: _branoUrl1,
          ),
          Song(
            id: 'd',
            name: 'Brano 4',
            url: _branoUrl2,
          ),
        ],
      ),
      Playlist(
        id: 'b',
        songs: [
          Song(
            id: 'a',
            name: 'Brano 1',
            url: _branoUrl1,
          ),
          Song(
            id: 'b',
            name: 'Brano 2',
            url: _branoUrl2,
          ),
          Song(
            id: 'c',
            name: 'Brano 3',
            url: _branoUrl1,
          ),
          Song(
            id: 'd',
            name: 'Brano 4',
            url: _branoUrl2,
          ),
        ],
      ),
      Playlist(
        id: 'c',
        songs: [
          Song(
            id: 'a',
            name: 'Brano 1',
            url: _branoUrl1,
          ),
          Song(
            id: 'b',
            name: 'Brano 2',
            url: _branoUrl2,
          ),
          Song(
            id: 'c',
            name: 'Brano 3',
            url: _branoUrl1,
          ),
          Song(
            id: 'd',
            name: 'Brano 4',
            url: _branoUrl2,
          ),
        ],
      ),
      Playlist(
        id: 'd',
        songs: [
          Song(
            id: 'a',
            name: 'Brano 1',
            url: _branoUrl1,
          ),
          Song(
            id: 'b',
            name: 'Brano 2',
            url: _branoUrl2,
          ),
          Song(
            id: 'c',
            name: 'Brano 3',
            url: _branoUrl1,
          ),
          Song(
            id: 'd',
            name: 'Brano 4',
            url: _branoUrl2,
          ),
        ],
      ),
    ];
    return FakeData(
      songs: songs,
      playlists: playlists,
    );
  }
}
