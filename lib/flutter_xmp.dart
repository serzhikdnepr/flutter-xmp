
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum UrlType {
  local,
  remote
}

class FlutterXmp {
  static const MethodChannel _channel =
      const MethodChannel('flutter_xmp');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String, dynamic>> extractXMPFrom({
    @required String url,
    UrlType type = UrlType.remote
  }) async {

    try {
      if (url == null) {
          throw(Exception("An URL must be provided"));
      }

      if (type == UrlType.remote) {
        final xmpData = await _channel.invokeMethod("extractXmpFromRemote", {
          "url": url
        });

        return Map<String, dynamic>.from(xmpData);
      }

      throw(UnimplementedError());
    } catch(e, stack) {
      print(e);
      print(stack);

      throw(e);
    }
  }
}
