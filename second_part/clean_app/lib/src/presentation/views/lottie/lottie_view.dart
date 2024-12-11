import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatefulWidget {
  const LottieAnimationView({super.key});

  @override
  State<LottieAnimationView> createState() => _LottieAnimationViewState();
}

class _LottieAnimationViewState extends State<LottieAnimationView> {
  late LottieComposition composition;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLottie();
  }

  Future<void> getLottie() async {
    final res = await NetworkLottie(
            'https://lottie.host/efd264ea-ae58-4a9d-9dd8-139ce30e6cbe/Nk5szZjEfb.json')
        .load();
    setState(() {
      composition = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Lottie(
                composition: composition,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
