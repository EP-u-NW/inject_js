import 'package:inject_js/inject_js.dart' as JS;

const String _code = 'alert(\'Hello World!\');';

Future<void> main() async {
  // Wait 5 seconds before doing anything
  await new Future.delayed(const Duration(seconds: 5));
  // Inject the code
  await JS.injectScript(_code);
}
