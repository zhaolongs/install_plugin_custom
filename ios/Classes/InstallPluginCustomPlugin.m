#import "InstallPluginCustomPlugin.h"

@implementation InstallPluginCustomPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"install_plugin_custom"
            binaryMessenger:[registrar messenger]];
  InstallPluginCustomPlugin* instance = [[InstallPluginCustomPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"gotoAppStore" isEqualToString:call.method]) {
      NSDictionary *dict =call.arguments;
      NSString *appStoreUrl = dict[@"urlString"];
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
