import Flutter
import UIKit

public class SwiftFlutterXmpPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_xmp", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterXmpPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as! [String:String]
    
    if (call.method == "extractXmpFromRemote") {
        RemoteImageXmpFetcher.fetch(url: args["url"]!, completion: {
            metadata in result(metadata)
        })
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
