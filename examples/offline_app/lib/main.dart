import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offline_app/post.model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHiveInitialized = false;

  @override
  void initState() {
    super.initState();
    Hive.openBox('new_post').then((_) {
      setState(() {
        isHiveInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Connectivity Example'),
      ),
      body: isHiveInitialized
          ? const _Body()
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  static const dbKey = 'new_post';

  Box get box => Hive.box(dbKey);

  Future<void> addPost(bool isConnected) async {
    const newPost = PostModel(
      id: '1',
      title: 'Title',
      body: 'Body',
    );
    if (!isConnected) {
      await box.put(dbKey, json.encode(newPost.toJson()));
      print('adding new post');
    } else {
      // Send the post to the server
    }
  }

  void checkPreviouslyCreatedPost() {
    if (box.get(dbKey) != null) {
      final newPost = PostModel.fromJson(json.decode(box.get('new_post')));
      // Send the post to the server
      print('sending post ${newPost.id} to db');
      box.delete(dbKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityBuilder(
      listener: (context, flag) {
        if (flag) {
          checkPreviouslyCreatedPost();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Connected')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Not connected')));
        }
      },
      builder: (context, flag) => Column(
        children: [
          Container(
            child: Text(flag ? 'Connected' : 'Not connected'),
          ),
          FilledButton(
              onPressed: () => addPost(flag), child: const Text('Add Post')),
        ],
      ),
    );
  }
}

class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder({
    super.key,
    this.listener,
    required this.builder,
  });

  final void Function(BuildContext context, bool isConnected)? listener;
  final Widget Function(BuildContext context, bool isConnected) builder;

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  late bool isConnected;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then(checkConnectivityResult);
    subscription =
        Connectivity().onConnectivityChanged.listen(checkConnectivityResult);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void checkConnectivityResult(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile)) {
      setState(() {
        isLoading = false;
        isConnected = true;
      });
    } else if (result.contains(ConnectivityResult.wifi)) {
      setState(() {
        isLoading = false;
        isConnected = true;
      });
    } else if (result.contains(ConnectivityResult.none)) {
      setState(() {
        isLoading = false;
        isConnected = false;
      });
    }
    if (result.isEmpty) {
      setState(() {
        isLoading = false;
        isConnected = false;
      });
    }
    if (widget.listener != null) {
      widget.listener!(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, true);
  }
}
