import 'package:flutter_test/flutter_test.dart';

import 'package:curl_generator/curl_generator.dart';

void main() {
  test('test GET method with no query params and headers', () {
    const url = 'https://some.api.com/some/api';
    const expectedReturn = 'curl \'https://some.api.com/some/api\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(url: url);
    expect(expectedReturn, result);
  });

  test('test GET method with query params in url and no headers', () {
    const url = 'https://some.aoi.com/some/api?some=some&param=param';
    const expectedReturn =
        'curl \'https://some.aoi.com/some/api?some=some&param=param\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(url: url);
    expect(expectedReturn, result);
  });

  test('test GET method with query params seperated and no headers', () {
    const url = 'https://some.aoi.com/some/api';
    const expectedReturn =
        'curl \'https://some.aoi.com/some/api?some=some&param=param\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    const params = {
      'some': 'some',
      'param': 'param',
    };
    final result = Curl.curlOf(url: url, queryParams: params);
    expect(expectedReturn, result);
  });

  test('test GET method with headers and no query params', () {
    const url = 'https://some.api.com/some/api';
    const header = {
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
      'Connection': 'keep-alive',
    };
    const expectedReturn = 'curl \'https://some.api.com/some/api\' \\\n'
        '  -H \'Accept: application/json\' \\\n'
        '  -H \'Accept-Language: en-US,en;q=0.9\' \\\n'
        '  -H \'Connection: keep-alive\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(url: url, header: header);
    expect(expectedReturn, result);
  });

  test('test GET method with headers and query params', () {
    const url = 'https://some.api.com/some/api';
    const params = {
      'some': 'some',
      'param': 'param',
    };
    const header = {
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
      'Connection': 'keep-alive',
    };
    const expectedReturn =
        'curl \'https://some.api.com/some/api?some=some&param=param\' \\\n'
        '  -H \'Accept: application/json\' \\\n'
        '  -H \'Accept-Language: en-US,en;q=0.9\' \\\n'
        '  -H \'Connection: keep-alive\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(url: url, header: header, queryParams: params);
    expect(expectedReturn, result);
  });

  test('test POST method with has only body', () {
    const url = 'https://some.aoi.com/some/api';
    const body = {
      'some': 'some',
      'value': 'value',
      'intValue': 1234,
    };
    const expectedReturn = 'curl \'https://some.aoi.com/some/api\' \\\n'
        '  --data-raw \'{"some":"some","value":"value","intValue":1234}\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(url: url, body: body);
    expect(expectedReturn, result);
  });

  test('test POST method with all headers and query params and body', () {
    const url = 'https://some.aoi.com/some/api';
    const params = {
      'some': 'some',
      'param': 'param',
    };
    const header = {
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
      'Connection': 'keep-alive',
    };
    const body = {
      'some': 'some',
      'value': 'value',
      'intValue': 1234,
    };
    const expectedReturn =
        'curl \'https://some.aoi.com/some/api?some=some&param=param\' \\\n'
        '  -H \'Accept: application/json\' \\\n'
        '  -H \'Accept-Language: en-US,en;q=0.9\' \\\n'
        '  -H \'Connection: keep-alive\' \\\n'
        '  --data-raw \'{"some":"some","value":"value","intValue":1234}\' \\\n'
        '  --compressed \\\n'
        '  --insecure';
    final result = Curl.curlOf(
      url: url,
      header: header,
      queryParams: params,
      body: body,
    );
    expect(expectedReturn, result);
  });
}
