/// Can be used to inject javascript libraries or code into the current page.
/// All functions in this library throw [UnsupportedError]s if the [dart:html] library is not present.
library inject_js;

export 'src/inject_js_stub.dart' // Stub implementation
    if (dart.library.html) 'src/inject_js_html.dart'; // dart:html implementation