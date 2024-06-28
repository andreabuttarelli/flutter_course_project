import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova/src/presentation/design_system/custom_theme/custom_theme.dart';
import 'package:prova/src/presentation/design_system/responsive_values.dart';

class PageProva extends StatelessWidget {
  const PageProva({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: responsiveValue(
        context,
        mobile: Colors.black,
        tablet: Colors.red,
        desktop: Colors.yellow,
      ),
      width: responsiveValue(
        context,
        mobile: 100,
        tablet: 150,
        desktop: 200,
      ),
      child: GestureDetector(
        onTap: () {
          print(Scaffold.of(context).hasAppBar);
        },
        child: Text(
          'Hello',
          style: TextStyle(
            color: appTheme.magenta,
          ),
        ),
      ),
    );
  }
}

class _ResponsiveWidget extends StatelessWidget {
  const _ResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return responsiveValue(
      context,
      mobile: const _Mobile(),
      tablet: const _Tablet(),
      desktop: const _Desktop(),
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Tablet extends StatelessWidget {
  const _Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Desktop extends StatelessWidget {
  const _Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Flex extends StatelessWidget {
  const _Flex({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Flex(
      direction:
          screenSize.shortestSide < 600 ? Axis.horizontal : Axis.vertical,
      children: const [
        SizedBox(),
      ],
    );
  }
}

class _PercentValue extends StatelessWidget {
  const _PercentValue({super.key});

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.1,
      heightFactor: 0.1,
    );
  }
}

class _FakeHomepage extends StatelessWidget {
  const _FakeHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return orientationValue(
      context,
      portrait: ListView(
        scrollDirection: Axis.vertical,
      ),
      landscape: ListView(
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
