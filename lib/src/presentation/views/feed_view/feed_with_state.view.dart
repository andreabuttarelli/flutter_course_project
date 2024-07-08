import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova/src/di/init.dart';
import 'package:prova/src/presentation/design_system/progress_indicator/circular_progress_indicator.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/views/feed_view/blocs/feed.cubit.dart';

class FeedViewWithState extends StatelessWidget {
  const FeedViewWithState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(
        getIt(),
        getIt(),
      ),
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
  @override
  void initState() {
    super.initState();
    context.read<FeedCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const H2('Feed'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<FeedCubit>().load();
              },
              icon: const Icon(Icons.replay_outlined)),
        ],
      ),
      body: BlocBuilder<FeedCubit, FeedState>(builder: (context, state) {
        if (state is FeedLoading) {
          return const Center(
            child: CCircularProgressIndicator(),
          );
        }
        if (state is FeedError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const H2('Error'),
                P(state.error.toString()),
              ],
            ),
          );
        }
        if (state is FeedLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: H2(state.posts[index].title),
                  subtitle: P(state.posts[index].body),
                ),
              );
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
