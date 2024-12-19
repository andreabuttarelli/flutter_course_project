import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LongFeed extends StatefulWidget {
  const LongFeed({super.key});

  @override
  State<LongFeed> createState() => _LongFeedState();
}

class _LongFeedState extends State<LongFeed> {
  List<String> ids = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initIsolate();
  }

  void initIsolate() async {
    final data = await rootBundle.loadString('assets/long.json');
    final res = await compute(loadAsset, data);
    setState(() {
      isLoading = false;
      ids = res;
    });
  }

  static List<String> loadAsset(String content) {
    final jsonData = jsonDecode(content) as List<Object?>;
    return jsonData.map((e) => e.toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ids.length,
              itemBuilder: (context, index) => Text(ids[index]),
            ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //loadAsset();
      }),
    );
  }
}
