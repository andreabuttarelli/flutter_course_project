import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';

class FeedViewWithFutureBuilder extends StatefulWidget {
  const FeedViewWithFutureBuilder({super.key});

  @override
  State<FeedViewWithFutureBuilder> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedViewWithFutureBuilder> {
  late final Future<List<dynamic>> future;

  @override
  void initState() {
    super.initState();
    future = getPosts();
  }

  Future<List<dynamic>> getPosts() async {
    await Future.delayed(const Duration(seconds: 3));
    print('getPosts');
    return [
      {
        'title': 'Title 1',
        'subtitle': 'Subtitle 1',
      },
      {
        'title': 'Title 2',
        'subtitle': 'Subtitle 2',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const H2('Feed'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final posts = snapshot.data ?? [];
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: sizeWidth / 2,
                child: Card(
                  child: ListTile(
                    title: H2(posts[index]['title']),
                    subtitle: P(posts[index]['subtitle']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
