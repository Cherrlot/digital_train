import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/constant.dart';
import 'package:digital_train/util/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../net/net_util.dart';
import '../util/color_constant.dart';
import '../util/sp_util.dart';
import 'home/HomeNavigationPage.dart';
import 'LoginPage.dart';

/// 闪屏页。
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget child = const LoginPage();

  @override
  void initState() {
    super.initState();

    NetDioUtil.initOption();
    //检查更新
    _checkUpdate();
  }

  void _checkUpdate() async {
    await SpUtil.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    BotToast.showText(text: '版本号$version');

    _initAsync();
  }

  _updateDialog(String content, String downloadUrl) {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.updateApp,
      msg: content,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // 更新软件
            Navigator.of(context).pop();
            _update(downloadUrl);
          },
          text: StringConstant.confirm,
          color: ColorConstant.color3C94FD,
          textStyle: const TextStyle(color: ColorConstant.white),
        ),
        IconsOutlineButton(
          onPressed: () {
            // 取消
            Navigator.of(context).pop();
          },
          text: StringConstant.cancel,
          textStyle: const TextStyle(color: ColorConstant.color333333),
        ),
      ],
    );
  }

  _update(String downloadUrl) async {
    if (Platform.isIOS) {
      String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      try {
        OtaUpdate().execute(downloadUrl).listen((event) {
          print('status:${event.status},value:${event.value}');
          switch (event.status) {
            case OtaStatus.DOWNLOADING: // 下载中
              setState(() {
                // progress = '下载进度:${event.value}%';
              });
              break;
            case OtaStatus.INSTALLING: //安装中
              break;
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
              BotToast.showText(text: StringConstant.updatePermission);
              _requestPermission();
              break;
            default: // 其他问题
              break;
          }
        });
      } catch (e) {
        print('更新失败，请稍后再试');
      }
    }
  }

  _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        // 权限拒绝
        Permission.storage.request();
      }
    }
  }

  ///跳转
  _initAsync() async {
    setState(() {
      var token = SpUtil.getString(Constants.token);
      if (token == null || token.isEmpty) {
        // 跳转登录
        child = const LoginPage();
      } else {
        // 跳转主界面
        NetDioUtil.initOptionWithToken(token);
        child = const HomeNavigationPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      resizeToAvoidBottomInset: false,
    );
  }
}
