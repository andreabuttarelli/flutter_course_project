import 'package:clean_app/src/di/di.dart';
import 'package:clean_app/src/presentation/design_system/components/atoms/nil.dart';
import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:clean_app/src/presentation/views/homepage/blocs/homepage_cubit.dart';
import 'package:clean_app/src/presentation/views/homepage/blocs/homepage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(getIt()),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BodyTypo(label: 'Home Page'),
          BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state is HomePageStateInitial) {
                return const BodyTypo(label: 'Initial State');
              } else if (state is HomePageStateLoading) {
                return const Row(children: [
                  SizedBox(
                    width: Grid.lg,
                    height: Grid.lg,
                    child: CircularProgressIndicator(),
                  ),
                  Gap(Grid.md),
                  BodyTypo(label: 'Loading...'),
                ]);
              } else if (state is HomePageStateError) {
                return BodyTypo(
                  label: state.error.toString(),
                );
              } else if (state is HomePageStateLoaded) {
                return BodyTypo(label: 'User ID: ${state.userID}');
              }
              return nil;
            },
          ),
          TextButton(
            onPressed: context.read<HomePageCubit>().retrieveUserID,
            child: const BodyTypo(label: 'Load User ID'),
          ),
        ],
      ),
    );
  }
}
