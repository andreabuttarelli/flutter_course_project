import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:prova/src/presentation/design_system/buttons/buttons.widget.dart';
import 'package:prova/src/presentation/design_system/grid/grid.dart';
import 'package:prova/src/presentation/design_system/responsive_values.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';

class ChatGPTAuthView extends StatelessWidget {
  const ChatGPTAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: responsiveValue(
        context,
        mobile: const _Mobile(),
        tablet: const _TabletOrDesktop(),
        desktop: const _TabletOrDesktop(),
      ),
    );
  }
}

class _Mobile extends StatefulWidget {
  const _Mobile({super.key});

  @override
  State<_Mobile> createState() => _MobileState();
}

class _MobileState extends State<_Mobile> {
  late PageController controller;
  late Size screenSize;
  double page = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    controller.addListener(() {
      setState(() {
        page = controller.offset / screenSize.height;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenSize = constraints.biggest;
        return Stack(
          children: [
            const _YellowBox(),
            PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: page * 10, sigmaY: page * 10),
                  child: const _WhiteBox(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TabletOrDesktop extends StatelessWidget {
  const _TabletOrDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _YellowBox(),
        ),
        Expanded(
          child: _WhiteBox(),
        ),
      ],
    );
  }
}

class _YellowBox extends StatelessWidget {
  const _YellowBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.yellow.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Align(
              alignment: responsiveValue(
                context,
                mobile: Alignment.bottomLeft,
                tablet: Alignment.centerLeft,
                desktop: Alignment.centerLeft,
              ),
              child: const H1(
                'Title',
                color: Colors.orange,
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: H2(
                'Subtitle',
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteBox extends StatelessWidget {
  const _WhiteBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 800,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const H1('Title'),
                  const Gap(Grid.medium),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Log in',
                          onTap: () async {},
                        ),
                      ),
                      const Gap(Grid.medium),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Log in',
                          onTap: () async {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                H2('Subtitle', color: Colors.grey),
                Gap(Grid.small),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    P(
                      'Terms and Conditions',
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Grid.medium),
                      child: SizedBox(
                        width: 1,
                        height: Grid.medium,
                        child: ColoredBox(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    P(
                      'Privacy Policy',
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
