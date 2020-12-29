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
          child: Column(
            children: <Widget>[
              FlatButton(
                  child: Text("打开appstore"),
                  onPressed: () {
                    InstallPluginCustom.gotoAppStore(
                        "https://apps.apple.com/cn/app/id1472328992");
                  }),
              FlatButton(
                  child: Text("点击安装"),
                  onPressed: () {
                    InstallPluginCustom.gotoAppStore(
                        "https://apps.apple.com/cn/app/id1472328992");
                  }),
              FlatButton(
                  child: Text("Android 点击安装"),
                  onPressed: () {
                    InstallPluginCustom.installApk(
                            "/storage/emulated/0/Android/data/com.learn.coalx/filesrk.apk",
                            'com.learn.coalx')
                        .then((result) {
                      print('install apk $result');
                    }).catchError((error) {
                      print('install apk $error');
                      //安装失败
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
