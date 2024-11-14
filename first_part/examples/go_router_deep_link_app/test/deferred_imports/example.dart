import 'page1.dart' deferred as page1;

void main() async {
  await page1.loadLibrary();
  page1.Page1();
}
