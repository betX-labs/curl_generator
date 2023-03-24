part of curl_generator;

/// The [Curl] entry point.
///
/// To get a curl, call [Curl.curlOf]
class Curl {
  /// private constructor
  ///
  Curl._();

  /// final generated curl.
  ///
  static String _curl = '';

  /// Generate curl base on provided data.
  ///
  /// [queryParams], [header] and [body] are optional.
  ///
  /// to add query parameters use [queryParams] or add it manually to the end
  /// of [url] with `?`
  ///
  /// ```dart
  ///  final example1 = Curl.curlOf(url: 'https://some.api.com/some/path?some=some&query=query');
  ///// or
  ///  final example2 = Curl.curlOf(
  ///    url: 'https://some.api.com/some/path',
  ///    queryParams: {
  ///      'some': 'some',
  ///      'query': 'query',
  ///    },
  ///  );
  ///
  /// print(example1);
  /// print(example2);
  ///// curl 'https://some.api.com/some/path?some=some&query=query' \
  /////   --compressed \
  ///
  ///// curl 'https://some.api.com/some/path?some=some&query=query' \
  /////   --compressed \
  /// ```
  static String curlOf({
    required String url,
    String? method,
    Map<String, String> queryParams = const {},
    Map<String, String> header = const {},
    Map<String, dynamic> body = const {},
  }) {
    _curl = '';
    _addMethod(method);
    _addUrl(url);
    _addQueryParams(queryParams);
    _curl = '$_curl\' \\\n';

    final isSecure = url.startsWith('https');
    if (!isSecure) {
      _curl = '$_curl  --insecure \\\n';
    }
    _curl = '$_curl  --compressed \\\n';

    _addHeaders(header);
    if (body.isNotEmpty) _addBody(body);
    return _curl;
  }

  /// intiialize [_curl] with [method] if it is not null.
  static void _addMethod(String? method) {
    if (method == null) return;
    if (method.toUpperCase() == 'GET') return;
    _curl = 'curl --request ${method.toUpperCase()}';
  }

  /// intiialize [_curl] with [url] if [_curl] is empty
  /// else add url to existing [_curl].
  static void _addUrl(String url) {
    if (_curl.isEmpty) {
      _curl = 'curl \'$url';
      return;
    }
    _curl = '$_curl \'$url';
  }

  /// add [queryParams] to [_curl]
  static void _addQueryParams(Map<String, String> queryParams) {
    if (queryParams.isEmpty) return;
    final params =
        queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    _curl = '$_curl?$params';
  }

  /// add [header] to [_curl] if exits.
  static void _addHeaders(Map<String, String> header) {
    final headers = header.entries.toList();
    for (int i = 0; i < headers.length; i++) {
      _curl = '$_curl  -H \'${headers[i].key}: ${headers[i].value}\' \\\n';
    }
  }

  /// add [body] to [_curl] if exits.
  static void _addBody(Map<String, dynamic> body) {
    if (!_curl.toLowerCase().contains('content-type')) {
      _curl = '$_curl  -H \'Content-Type: application/json\' \\\n';
    }
    final encodedBody = JsonEncoder.withIndent('  ').convert(
      body
    );
    _curl = '''$_curl  --data-binary @- << EOF
$encodedBody
EOF
''';

  }
}
