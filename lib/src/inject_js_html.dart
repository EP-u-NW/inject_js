import 'dart:html' as html;

/// Injects the library by its [url].
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This works by adding a new script tag to the html page with the src tag set to url.
Future<void> importLibrary(String url, {String? integrity = null}) {
  return _importJsLibraries([_Library(url: url, integrity: integrity)]);
}

/// Injects the javascript code [src] into the page.
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This works by adding a new script tag to the html page with innerText set to src.
Future<void> injectScript(String src) {
  return _injectJsSource([src]);
}

/// Checks if a library is present in the page.
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This happens by checking the src field of all script tags in the html page.
bool isImported(String url) {
  return _isLoaded(_htmlHead(), url);
}

class _Library {
  final String url;
  final String? integrity;

  _Library({required this.url, this.integrity});
}

html.ScriptElement _createScriptTagFromUrl(_Library library) {
  var scriptElement = html.ScriptElement()
      ..type = "text/javascript"
      ..charset = "utf-8"
      ..async = true
      //..defer = true
      ..src = library.url;
  if (library.integrity != null) {
    scriptElement..integrity = library.integrity
      ..crossOrigin = "anonymous";
  }
  return scriptElement;
}

html.ScriptElement _createScriptTagFromSrc(String src) => html.ScriptElement()
  ..type = "text/javascript"
  ..charset = "utf-8"
  ..async = false
  //..defer = true
  ..innerText = src;

Future<void> _importJsLibraries(List<_Library> libraries) {
  List<Future<void>> loading = <Future<void>>[];
  html.Element head = _htmlHead();
  libraries.forEach((_Library library) {
    if (!isImported(library.url)) {
      final scriptTag = _createScriptTagFromUrl(library);
      head.children.add(scriptTag);
      loading.add(scriptTag.onLoad.first);
    }
  });
  return Future.wait(loading);
}

Future<void> _injectJsSource(List<String> src) {
  List<Future<void>> loading = <Future<void>>[];
  html.Element head = _htmlHead();
  src.forEach((String script) {
    final scriptTag = _createScriptTagFromSrc(script);
    head.children.add(scriptTag);
    loading.add(scriptTag.onLoad.first);
  });
  return Future.wait(loading);
}

html.Element _htmlHead() {
  html.Element? head = html.querySelector('head');
  if (head != null) {
    return head;
  } else {
    throw new StateError('Could not fetch html head element!');
  }
}

bool _isLoaded(html.Element head, String url) {
  if (url.startsWith("./")) {
    url = url.replaceFirst("./", "");
  }
  for (var element in head.children) {
    if (element is html.ScriptElement) {
      if (element.src.endsWith(url)) {
        return true;
      }
    }
  }
  return false;
}
