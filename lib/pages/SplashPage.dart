import 'package:digital_train/util/constant.dart';
import 'package:flutter/material.dart';

import '../net/net_util.dart';
import '../util/sp_util.dart';
import 'LoginPage.dart';
import 'home/HomeNavigationPage.dart';

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
    _initAsync();
  }

  ///跳转
  _initAsync() async {
    await SpUtil.getInstance();
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
