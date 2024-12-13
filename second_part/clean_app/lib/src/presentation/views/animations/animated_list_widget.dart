import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({super.key});

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  final listViewKey = GlobalKey<AnimatedListState>();
  List<int> items = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animatedInitialList(150);
    });
  }

  Future<void> animatedInitialList(int delayInMilliseconds) async {
    for (final e in items) {
      listViewKey.currentState!.insertItem(0);
      await Future.delayed(Duration(milliseconds: delayInMilliseconds));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: listViewKey,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: Text(
                      '${items[index]}',
                      style: const TextStyle(
                        fontSize: 48,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    items.insert(0, items.length + 1);
                    listViewKey.currentState!.insertItem(0);
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.plus,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (items.isEmpty) return;
                    items.removeAt(0);
                    listViewKey.currentState!.removeItem(0,
                        (context, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.3, 0),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: Text(
                            '${items[0]}',
                            style: const TextStyle(
                              fontSize: 48,
                            ),
                          ),
                        ),
                      );
                    });
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.minus,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
