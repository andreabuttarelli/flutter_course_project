import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterState();
}

class _CounterState extends State<CounterView> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$counter'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
      ),
    );
  }
}

class CounterViewValueNotifier extends StatefulWidget {
  const CounterViewValueNotifier({super.key});

  @override
  State<CounterViewValueNotifier> createState() =>
      _CounterViewValueNotifierState();
}

class _CounterViewValueNotifierState extends State<CounterViewValueNotifier> {
  final ValueNotifier<int> counter = ValueNotifier(0);

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: counter,
          builder: (context, value, _) {
            return Text('$value');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          counter.value++;
        },
      ),
    );
  }
}

class _CounterNotifier with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class CounterViewChangeNotifier extends StatefulWidget {
  const CounterViewChangeNotifier({super.key});

  @override
  State<CounterViewChangeNotifier> createState() =>
      _CounterViewChangeNotifierState();
}

class _CounterViewChangeNotifierState extends State<CounterViewChangeNotifier> {
  final _CounterNotifier counterNotifier = _CounterNotifier();

  @override
  void dispose() {
    counterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: counterNotifier,
          builder: (context, _) {
            return Text('${counterNotifier.counter}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          counterNotifier.increment();
        },
      ),
    );
  }
}

class CounterViewProvider extends StatelessWidget {
  const CounterViewProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _CounterNotifier(),
      child: const Scaffold(
        body: Center(
          child: _CounterText(),
        ),
        floatingActionButton: _FloatingActionButton(),
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<_CounterNotifier>().counter;
    // final counter = context.select<_CounterNotifier, int>((counterNotifier) => counterNotifier.counter);
    return Text('$counter');
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final counterNotifier = context.read<_CounterNotifier>();
        counterNotifier.increment();
      },
    );
  }
}
