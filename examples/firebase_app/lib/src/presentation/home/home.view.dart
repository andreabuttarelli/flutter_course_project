import 'package:firebase_app/src/presentation/global_blocs/auth.cubit.dart';
import 'package:firebase_app/src/presentation/home/blocs/home.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text(state.error));
          }
          if (state is HomeLoaded) {
            return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) =>
                    Expanded(child: Text(state.posts[index]['text'])));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          context.read<HomeCubit>().addPost(
                'Hello',
                (context.read<AuthCubit>().state as LoggedIn).user,
              );
        },
      ),
    );
  }
}
