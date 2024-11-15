import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/buttons/buttons.widget.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/inherited_widgets/theme.inherited.dart';

class BottombarPageWithSubNavigatorsView extends StatefulWidget {
  const BottombarPageWithSubNavigatorsView({
    super.key,
  });

  @override
  State<BottombarPageWithSubNavigatorsView> createState() =>
      _BottombarPageWithSubNavigatorsViewState();
}

class _BottombarPageWithSubNavigatorsViewState
    extends State<BottombarPageWithSubNavigatorsView> {
  int currentIndex = 0;

  bool isLightMode(ThemeMode currentValue) => currentValue == ThemeMode.light;

  T getThemedValues<T>(ThemeMode currentValue, T light, T dark) =>
      isLightMode(currentValue) ? light : dark;

  @override
  Widget build(BuildContext context) {
    final themeModeNotifier = InheritedAppTheme.of(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('Bottombar Page With Sub Navigators'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: themeModeNotifier,
              builder: (context, mode, _) {
                return Icon(
                  getThemedValues(
                    mode,
                    Icons.sunny,
                    Icons.stars,
                  ),
                );
              },
            ),
            onPressed: () {
              themeModeNotifier.value = getThemedValues(
                themeModeNotifier.value,
                ThemeMode.light,
                ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          _A(),
          _B(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'B',
          ),
        ],
      ),
    );
  }
}

class _A extends StatelessWidget {
  const _A({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (context) => Center(
          child: Column(
            children: [
              const H1('A'),
              PrimaryButton(
                label: 'Navigate',
                onTap: () async {
                  /*Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => const _C(),
                    ),
                  );*/
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: false,
                    builder: (context) => BottomSheet(
                      onClosing: () {},
                      builder: (context) => const _C(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _B extends StatelessWidget {
  const _B({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: H1('B'),
    );
  }
}

class _C extends StatelessWidget {
  const _C({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: H1('C'),
      ),
    );
  }
}
