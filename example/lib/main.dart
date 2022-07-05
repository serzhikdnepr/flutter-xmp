import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
  List<int>? _imageData;
  final url = "ADD-YOUR-URL-HERE";

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageXmp() async {
    String prettyJson;
    Map<String, dynamic>? xmpData;

    try {
      xmpData = await FlutterXmp.extractXMPFrom(url: url);
      final encoder = JsonEncoder.withIndent(" ");

      prettyJson = encoder.convert(xmpData["metadata"]);

    } on PlatformException {
      prettyJson = "Can't retrieve XMP data.";
    }

    setState(() {
      _xmpData = prettyJson;
      _imageData = xmpData!["image_data"];
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
              _imageData != null ? Image.memory(Uint8List.fromList(_imageData!)) : Container(),
              ElevatedButton(
                child: Text("Get data!"),
                onPressed: getImageXmp,
              ),ElevatedButton(
                child: Text("Get Locale!"),
                onPressed: getImageXmp,
              ),
              Text(_xmpData)
            ],
          ),
        ),
      ),
    );
  }
}
