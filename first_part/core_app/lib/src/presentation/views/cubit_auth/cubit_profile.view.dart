import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/views/cubit_auth/blocs/auth.cubit.dart';

class CubitProfileView extends StatelessWidget {
  const CubitProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        title: const H2('Profile'),
      ),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is! AuthLogged) return const SizedBox.shrink();
            return H2(state.email);
          },
        ),
      ),
    );
  }
}
