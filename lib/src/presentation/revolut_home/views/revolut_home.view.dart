import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';
import 'package:prova/src/presentation/revolut_home/widgets/app_bar.revolut_home.widget.dart';

part '../widgets/indicator_item.revolut_home.widget.dart';

class RevolutHomeView extends StatefulWidget {
  const RevolutHomeView({super.key});

  @override
  State<RevolutHomeView> createState() => _RevolutHomeViewState();
}

class _RevolutHomeViewState extends State<RevolutHomeView> {
  late ScrollController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            ListView(
              controller: controller,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: const [
                      ColoredBox(
                        color: Colors.red,
                        child: Center(
                          child: H1('Page 1'),
                        ),
                      ),
                      ColoredBox(
                        color: Colors.green,
                        child: Center(
                          child: H1('Page 2'),
                        ),
                      ),
                      ColoredBox(
                        color: Colors.blue,
                        child: Center(
                          child: H1('Page 3'),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (i) => _IndicatorItem(enabled: i == currentPage),
                  ),
                ),
                Container(
                  height: 1500,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ],
            ),
            CAppBar(controller: controller),
          ],
        ),
      ),
    );
  }
}
