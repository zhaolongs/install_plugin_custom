**题记**
  ——  执剑天涯，从你的点滴积累开始，所及之处，必精益求精，即是折腾每一天。
  
**重要消息**
*  [精通点的可以查看这里 精述](https://gitbook.cn/gitchat/author/5ae043915efcf9715e37c733)
* [Flutter 从入门实践到开发一个APP之UI基础篇  视频](https://edu.csdn.net/course/detail/25543)
* [Flutter 从入门实践到开发一个APP之开发实战基础篇](https://edu.csdn.net/course/detail/27035)
* [flutter从入门 到精通 系列文章](https://blog.csdn.net/zl18603543572/article/details/93532582)
***

> 本文章将讲述：
1、在 flutter 跨平台开发中，使用插件 install_plugin_custom,实现在 Android 平台调起自动安装，在 ios 平台跳转 appstore中更新
2、本升级插件 测试手机  
 iphone7 13.3.1 系统
  小米max MIUI 11.0.3 , Android 9
  华为 EMUI 8.2.0  Android 8.10 
  红米 MIUI 11.0.2 ,Android 9
  vivo x6  Android 5.0

***

flutter 跨平台实际应用开发中，app的升级效果如下
ios 平台：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200215181038962.gif)

Android 平台：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200215181433994.gif)

#### 1 引言
在APP开发方案中，一般我们会通过访问我们的服务平台来获取 APP 的版本信息，如版本号、版本名称、是否强制更新等等

在这里描述的是 在 Android 平台下载 apk 然后再调起应用程序的安装，在 ios 平台点击更新跳转 appstore 平台。

在这里下载 apk 使用的是 Dio ,安装 apk 使用的是 install_plugin_custom 插件，flutter 项目中的依赖

```xml
  # 权限申请
  permission_handler: 4.0.0
  # 网络请求
  dio: ^2.1.2
  #  APP升级安装组件 Android中调用自动安装 apk的程序 ios 调用打开APPStore
  install_plugin_custom:
    git:
      url: https://github.com/zhaolongs/install_plugin_custom.git
      ref: master
```

#### 2 flutter 中 Android 平台的更新
##### 2.1 SD 卡存储权限申请

```java

  Future<bool> _checkPermission(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

```

##### 2.2 SD 卡存存储路径获取

```java
  Future<String> _findLocalPath(BuildContext context) async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

```

##### 2.3 使用 Dio 下载 apk 

```java

     //apk 网络存储链接
     String apkNetUrl ="";
     //手机中sd卡上 apk 下载存储路径
     String localPath ="";

      Dio dio = Dio();
      //设置连接超时时间
      dio.options.connectTimeout = 1200000;
      //设置数据接收超时时间
      dio.options.receiveTimeout = 1200000;
      try {
        Response response = await dio
            .download(apkNetUrl, localPath
                onReceiveProgress: (int count, int total) {
          // count 当前已下载文件大小
          // total 需要下载文件的总大小
        });
        if (response.statusCode == 200) {
          print('下载请求成功');
          //"安装";
        } else {
          //"下载失败重试";
        }
      } catch (e) {
        //"下载失败重试";
        if (mounted) {
          setState(() {});
        }
      }
```

##### 2.4 使用 install_plugin_custom 安装 apk 

```java
//apk 的包名
String apkPackageName ="";
// 安装 
InstallPluginCustom.installApk(
              localPath,
              apkPackageName)
          .then((result) {
        print('install apk $result');
      }).catchError((error) {
        // "重试";
        installStatues = 2;
        setState(() {});
      });
```

#### 3 flutter 中 ios 平台的更新
如果 flutter 项目是运行在 ios 手机中，那么有更新信息的时候，直接跳转 appstore 中应用程序的页面更新

```java
if (Theme.of(context).platform == TargetPlatform.iOS) {
      InstallPluginCustom.gotoAppStore(
          "https://apps.apple.com/cn/app/id1472328992");
 } 
```

在使用的时候直接替换这里的跳转的链接就好。
