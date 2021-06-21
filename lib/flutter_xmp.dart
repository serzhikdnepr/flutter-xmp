import 'dart:async';

import 'package:flutter/services.dart';

/// Enum used to selct the provided URL type.
enum UrlType { local, remote }

/// A Flutter library to deal with Images XMP data extraction using native
/// implementation for both Android and iOS.
class FlutterXmp {
  static const MethodChannel _channel = const MethodChannel('flutter_xmp');

  /// Returns a [Map] with the extracted XMP data from a given URL.
  /// The data extraction is made on the native side.
  ///
  /// Obs: Currently supports only [UrlType.remote].
  static Future<Map<String, dynamic>> extractXMPFrom(
      {required String url, UrlType type = UrlType.remote}) async {
    try {
      if (type == UrlType.remote) {
        final xmpData =
            await _channel.invokeMethod("extractXmpFromRemote", {"url": url});

        return Map<String, dynamic>.from(xmpData);
      }

      throw (UnimplementedError());
    } catch (e, stack) {
      print(e);
      print(stack);

      throw (e);
    }
  }
}
