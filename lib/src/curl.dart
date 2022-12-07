part of curl_generator;

class Curl {
  Curl._();

  static String curlOf({
    required String url,
    Map<String, String> queryParams = const {},
    Map<String, String> header = const {},
    Map<String, dynamic> body = const {},
  }) {
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
    curl = '$curl  --compressed \\\n';
    curl = '$curl  --insecure';
    return curl;
  }
}
