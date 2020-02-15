import 'dart:async';

import 'package:flutter/services.dart';

class InstallPluginCustom {
  static const MethodChannel _channel =
      const MethodChannel('install_plugin_custom');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<String> installApk(String filePath, String appId) async {
    Map<String, String> params = {'filePath': filePath, 'appId': appId};
    return await _channel.invokeMethod('installApk', params);
  }

  /// for iOS: go to app store by the url
  static Future<String> gotoAppStore(String urlString) async {
    Map<String, String> params = {'urlString': urlString};
    return await _channel.invokeMethod('gotoAppStore', params);
  }

}
