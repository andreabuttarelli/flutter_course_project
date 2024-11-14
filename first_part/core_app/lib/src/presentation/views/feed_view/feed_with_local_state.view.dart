import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:prova/src/presentation/design_system/grid/grid.dart';
import 'package:prova/src/presentation/design_system/progress_indicator/circular_progress_indicator.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/views/feed_view/hydrated_blocs/feed.hydrated.cubit.dart';

class FeedViewWithLocalState extends StatelessWidget {
  const FeedViewWithLocalState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const H2('Feed'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FeedCubit>().undo();
            },
            icon: const Icon(Icons.undo),
          ),
          const Gap(Grid.medium),
          IconButton(
            onPressed: () {
              context.read<FeedCubit>().redo();
            },
            icon: const Icon(Icons.redo),
          ),
          const Gap(Grid.medium),
          IconButton(
            onPressed: () {
              context.read<FeedCubit>().addPost();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) => state.when(
          loading: () => const Center(
            child: CCircularProgressIndicator(),
          ),
          error: (exc) => Text(exc.toString()),
          loaded: (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => Text(
              posts[index].title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
