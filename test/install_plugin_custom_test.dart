import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:install_plugin_custom/install_plugin_custom.dart';

void main() {
  const MethodChannel channel = MethodChannel('install_plugin_custom');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await InstallPluginCustom.platformVersion, '42');
  });
}
