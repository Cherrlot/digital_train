import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/login_entity.dart';
import '../net/net_util.dart';
import '../net/url_cons.dart';
import '../util/constant.dart';
import '../util/sp_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VoidCallback _buttonCallback;
  late TextEditingController accountController;
  late TextEditingController pwdController;
  bool checked = false;

  @override
  void initState() {
    super.initState();

    _buttonCallback = () {
      setState(() {
        _handleLogin();
      });
    };
    accountController = TextEditingController();
    pwdController = TextEditingController();
  }

  @override
  void dispose() {
    accountController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String account = accountController.value.text;
    String pwd = pwdController.value.text;
    if (account.isEmpty) {
      BotToast.showText(text: '请输入账号');
      return;
    }
    if (pwd.isEmpty) {
      BotToast.showText(text: '请输入密码');
      return;
    }
    if (!checked) {
      BotToast.showText(text: '请同意用户协议和隐私政策');
      return;
    }

    /// 登录
    var cancel = BotToast.showLoading();
    await SpUtil.getInstance();
    var appResponse = await post<LoginEntity, LoginEntity>(serviceUrl['app_login']!,
        decodeType: LoginEntity(), data: {"identifier": account, "credential": pwd});
    appResponse.when(success: (LoginEntity model) {
      var token = model.token;
      NetDioUtil.initOptionWithToken(token);
      SpUtil.setString(Constants.token, token);
      cancel();
    }, failure: (String msg, int code) {
      cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h,
            ),
            buildTopWidget(),
            SizedBox(
              height: 20.h,
            ),
            buildAccountInputWidget(accountController),
            SizedBox(
              height: 20.h,
            ),
            buildPasswordInputWidget(pwdController),
            SizedBox(
              height: 10.h,
            ),
            PrivacyWidget(
              onChanged: (value) {
                checked = value ?? false;
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            ElevatedButton(
              onPressed: (_buttonCallback),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.h)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h), // 圆角半径
                  ),
                ),
              ),
              child: const Text(
                '登录', // 按钮上显示的文字
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTopWidget() {
  return Text(
    '您好，欢迎登录',
    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800),
  );
}

Widget buildAccountInputWidget(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(
      labelText: "账号",
    ),
    style: TextStyle(fontSize: 16.sp),
    // keyboardType: TextInputType.phone,
  );
}

Widget buildPasswordInputWidget(TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: true,
    decoration: const InputDecoration(labelText: "用户密码"),
    style: TextStyle(fontSize: 16.sp),
  );
}

//用户协议和隐私政策
class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<bool?> onChanged;

  @override
  _PrivacyWidgetState createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  bool? checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: checked,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                checked = value;
              });
            }),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '同意',
                style: TextStyle(fontSize: 14.sp),
              ),
              TextSpan(
                  text: '<服务协议>',
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint('服务协议');
                    }),
              TextSpan(
                text: '和',
                style: TextStyle(fontSize: 14.sp),
              ),
              TextSpan(
                  text: '<隐私政策>',
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint('隐私政策');
                    }),
            ],
          ),
        ),
      ],
    );
  }
}
