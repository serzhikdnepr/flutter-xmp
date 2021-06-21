#import "FlutterXmpPlugin.h"
#if __has_include(<flutter_xmp/flutter_xmp-Swift.h>)
#import <flutter_xmp/flutter_xmp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_xmp-Swift.h"
#endif

@implementation FlutterXmpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterXmpPlugin registerWithRegistrar:registrar];
}
@end
