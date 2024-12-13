import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _tag = 'my-container';
const _tag2 = 'text';

class NavigationAnimationPage1 extends StatelessWidget {
  const NavigationAnimationPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: _tag,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Hero(
              tag: _tag2,
              child: Text('Hello World'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/navigation-animation-page-2');
        },
      ),
    );
  }
}

class NavigationAnimationPage2 extends StatelessWidget {
  const NavigationAnimationPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Hero(
              tag: _tag,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: _tag2,
              child: Text('Hello World'),
            ),
          ),
        ],
      ),
    );
  }
}
