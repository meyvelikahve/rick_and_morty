mixin UrlMixin {
  final String _scheme = 'https';
  final String _host = 'rickandmortyapi.com';
  Uri getUri(
    String path, [
    String? query,
    Map<String, dynamic>? queryParameters,
  ]) {
    return Uri(
        scheme: _scheme,
        host: _host,
        path: path,
        query: query,
        queryParameters: queryParameters);
  }
}
