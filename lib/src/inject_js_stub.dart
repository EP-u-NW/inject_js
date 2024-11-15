/// Injects the library by its [url].
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This works by adding a new script tag to the html page with the src tag set to url.
Future<void> importLibrary(String url, {String? integrity = null}) => throw new UnsupportedError(
    'Injecting js is only possible if the platform supports dart:hmtl!');

/// Injects the javascript code [src] into the page.
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This works by adding a new script tag to the html page with innerText set to src.
Future<void> injectScript(String src) => throw new UnsupportedError(
    'Injecting js is only possible if the platform supports dart:hmtl!');

/// Checks if a library is present in the page.
/// Throws an [UnsupportedError] if the [dart:html] library is not present.
///
/// This happens by checking the src field of all script tags in the html page.
bool isImported(String url) => throw new UnsupportedError(
    'Injecting js is only possible if the platform supports dart:hmtl!');
