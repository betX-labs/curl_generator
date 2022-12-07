part of curl_generator;

// curl 'https://www.google.com/complete/search?q&cp=0&client=gws-wiz&xssi=t&hl=en-DE&authuser=0&psi=7GuQY9y5G_r-7_UP64S5-A4.1670409199524&nolsbt=1&dpr=4' \
//   -H 'sec-ch-ua: "Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108"' \
//   -H 'sec-ch-ua-mobile: ?1' \
//   -H 'User-Agent: Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36' \
//   -H 'sec-ch-ua-arch;' \
//   -H 'sec-ch-ua-full-version: "108.0.5359.73"' \
//   -H 'sec-ch-ua-platform-version: "8.0.0"' \
//   -H 'Referer: https://www.google.com/' \
//   -H 'sec-ch-ua-full-version-list: "Not?A_Brand";v="8.0.0.0", "Chromium";v="108.0.5359.73", "Google Chrome";v="108.0.5359.73"' \
//   -H 'sec-ch-ua-bitness: "64"' \
//   -H 'sec-ch-ua-model: "SM-G955U"' \
//   -H 'sec-ch-ua-wow64: ?0' \
//   -H 'sec-ch-ua-platform: "Android"' \
//   --compressed
class Curl {
  Curl._();

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
    return curl;
  }
}
