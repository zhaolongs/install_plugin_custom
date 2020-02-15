import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:install_plugin_custom/install_plugin_custom.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:FlatButton(child: Text("打开appstore"),onPressed: (){
            InstallPluginCustom.gotoAppStore(
                "https://apps.apple.com/cn/app/id1472328992");
          },),
        ),
      ),
    );
  }
}
