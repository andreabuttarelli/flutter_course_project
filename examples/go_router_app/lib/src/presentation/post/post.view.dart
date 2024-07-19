import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Post: $id'),
      ),
    );
  }
}
