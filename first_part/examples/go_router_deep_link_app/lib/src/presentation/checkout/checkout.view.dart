import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum CheckOutState {
  notStarted,
  finished,
  failed,
}

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Checkout'),
            FilledButton(
              onPressed: () {
                // apri link
                launchUrlString(
                  '...',
                  mode: LaunchMode.inAppBrowserView,
                );
                final appLinks = AppLinks();
                appLinks.stringLinkStream.listen((link) {
                  print('Received link: $link');
                  if (link.contains('fail')) {
                    closeInAppWebView();
                    // fail
                  } else if (link.contains('success')) {
                    closeInAppWebView();
                    // do something
                  }
                });
              },
              child: const Text('Open checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
