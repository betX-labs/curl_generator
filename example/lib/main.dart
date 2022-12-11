import 'package:curl_generator/curl_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _value = '';

  @override
  void initState() {
    super.initState();
    _initTest();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(_value),
        ),
      ),
    );
  }

  void _initTest() {
    const url = 'https://some.api.com/some/path';
    const params = {
      'some': 'some',
      'params': 'params',
    };
    const header = {
      'some': 'some',
      'header': 'header',
    };
    const body = {
      'some': 'some',
      'body': 'body',
      'value': 123,
      'innerObject': {
        'some': 'some',
        'inner': false,
        'value': 2.5,
      },
    };
    final curl = Curl.curlOf(
      url: url,
      body: body,
      header: header,
      queryParams: params,
    );

    print(curl);

    setState(() {
      _value = curl;
    });
  }
}
