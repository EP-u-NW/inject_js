# inject_js

This package can be used on `dart2js` and `flutter web` to inject javascript libraries or code into the page.
It is based on [flutter_web_import_js_library](https://github.com/florent37/flutter_web_import_js_library), but stripped down to work without flutter and extended to inject javascript code directly.

On `dart:vm` platforms, the functions in this package throw [`UnsupportedError`](https://api.dart.dev/stable/2.12.0/dart-core/UnsupportedError-class.html)s.

For an example without flutter see [`example`](./example), for an example with flutter see [`example_flutter`](./example_flutter).