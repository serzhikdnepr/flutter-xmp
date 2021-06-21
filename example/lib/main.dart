import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xmp/flutter_xmp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _xmpData = "Click the button!";
  final url = "https://firebasestorage.googleapis.com/v0/b/constructin-15d0f.appspot.com/o/projects%2Fcaptures%2Fd7f2a7f4-a5b3-48f9-bfeb-69747f874d23.jpeg?alt=media&token=5fddf914-8a06-49a1-be67-350bb4ec98c5";

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageXmp() async {
    String prettyJson;

    try {
      Map<String, dynamic> xmpData = await FlutterXmp.extractXMPFrom(url: url);
      final encoder = JsonEncoder.withIndent(" ");
      prettyJson = encoder.convert(xmpData);
    } on PlatformException {
      prettyJson = "Can't retrieve XMP data.";
    }

    setState(() {
      _xmpData = prettyJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter XMP'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(url),

              ElevatedButton(
                child: Text("Get data!"),
                onPressed: getImageXmp,
              ),

              Text(
                _xmpData
              )
            ],
          ),
        ),
      ),
    );
  }
}
