mixin UrlMixin {
  final String _scheme = 'https';
  final String _host = 'rickandmortyapi.com';

  Uri getUri(String url) {
    return Uri.parse(url);
  }

  Uri getUriWithPath(
    String path, [
    String? query,
    Map<String, dynamic>? queryParameters,
  ]) {
    Uri uri = Uri(
        scheme: _scheme,
        host: _host,
        path: path,
        query: query,
        queryParameters: queryParameters);
    print(uri);
    return uri;
  }
}
