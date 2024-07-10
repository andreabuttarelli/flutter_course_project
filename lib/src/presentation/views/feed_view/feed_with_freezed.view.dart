import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova/src/di/init.dart';
import 'package:prova/src/presentation/design_system/progress_indicator/circular_progress_indicator.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/views/feed_view/freezed_blocs/feed.cubit.dart';

class FeedViewWithState extends StatelessWidget {
  const FeedViewWithState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(getIt()),
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
            icon: const Icon(Icons.replay_outlined),
          ),
        ],
      ),
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) => state.when(
          loading: () => const Center(
            child: CCircularProgressIndicator(),
          ),
          error: (exc) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const H2('Error'),
                P(exc.toString()),
              ],
            ),
          ),
          loaded: (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: H2(posts[index].title),
                  subtitle: P(posts[index].body),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
