part of curl_generator;

class Curl {
  Curl._();

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
    Map<String, String> queryParams = const {},
    Map<String, String> header = const {},
    Map<String, dynamic> body = const {},
  }) {
    final isSecure = url.startsWith('https');
    String curl = 'curl \'$url';
    if (queryParams.isNotEmpty) {
      final params =
          queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      curl = '$curl?$params';
    }
    curl = '$curl\' \\\n';
    final headers = header.entries.toList();
    for (int i = 0; i < headers.length; i++) {
      curl = '$curl  -H \'${headers[i].key}: ${headers[i].value}\' \\\n';
    }
    if (body.isNotEmpty) {
      curl = '$curl  --data-raw \'${json.encode(body)}\' \\\n';
    }
    curl = '$curl  --compressed \\';
    if (!isSecure) {
      curl = '$curl\n';
      curl = '$curl  --insecure';
    }
    print(curl);
    return curl;
  }
}
