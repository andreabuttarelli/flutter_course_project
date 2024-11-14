import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionale/src/presentation/global_blocs/auth/auth.cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeHomeView extends StatefulWidget {
  const RealtimeHomeView({super.key});

  @override
  State<RealtimeHomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<RealtimeHomeView> {
  late RealtimeChannel channel;
  final List<dynamic> posts = [];

  SupabaseClient get supabase => Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    channel = supabase.channel('posts');
    channel
        .onBroadcast(
          event: 'new-post',
          callback: retrievePost,
        )
        .subscribe();
  }

  @override
  void dispose() {
    supabase.removeChannel(channel);
    super.dispose();
  }

  Future<void> addPost() async {
    final map = {
      'content': 'Hello, World!',
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    posts.add(map);
    channel.sendBroadcastMessage(
      event: 'new-post',
      payload: map,
    );
    setState(() {});
  }

  Future<void> retrievePost(Map<String, dynamic> map) async {
    posts.add(map);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => addPost(),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(posts[index]['content']),
              subtitle: Text(posts[index]['id']),
            );
          },
        ),
      ),
    );
  }
}
