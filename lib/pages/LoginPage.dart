import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/string_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/login_entity.dart';
import '../model/user_info_entity.dart';
import '../net/net_util.dart';
import '../net/url_cons.dart';
import '../routes/route_name.dart';
import '../util/color_constant.dart';
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
  var cancel;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    _buttonCallback = () {
      setState(() {
        _handleLogin();
      });
    };
    accountController = TextEditingController(text: SpUtil.getString(Constants.account));
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
    cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    // var appResponse = await post<LoginEntity, LoginEntity>(serviceUrl['app_login']!,
        var appResponse = await post<LoginEntity, List<LoginEntity>>(serviceUrl['app_login']!,
        decodeType: LoginEntity(),
        // data: {"identifier": account, "credential": md5.convert(utf8.encode(pwd)).toString(), "loginType": "password"}
        // data: {"account": account, "pwd": pwd}
        data: {"identifier": account, "credential": pwd}
        );
    appResponse.when(success: (List<LoginEntity> model) {
    // appResponse.when(success: (LoginEntity model) {
      // var token = model.token;
      var token = model[0].token;
      NetDioUtil.initOptionWithToken(token);
      SpUtil.setString(Constants.token, token);
      SpUtil.setString(Constants.account, account);
      _getUserInfo();
      // Navigator.of(context).pushReplacementNamed(RouteName.homeNavigatePage);
    }, failure: (String msg, int code) {
      cancel();
    });
  }

  _getUserInfo() async {
    var appResponse =
        await get<UserInfoEntity, List<UserInfoEntity>?>(serviceUrl['user_info']!, decodeType: UserInfoEntity(), data: {"ID": 0});
    appResponse.when(success: (List<UserInfoEntity>? model) {
      var userInfo = model?[0];
      if(userInfo != null) {
        SpUtil.setString(Constants.headUrl, userInfo.headImage ?? '');
        SpUtil.setString(Constants.userName, userInfo.name ?? '');
        SpUtil.setString(Constants.userPhone, userInfo.phone ?? '');
        SpUtil.setString(Constants.nickName, userInfo.nickname ?? '');
      }

      cancel();
      Navigator.of(context).pushReplacementNamed(RouteName.homeNavigatePage);
    }, failure: (String msg, int code) {
      cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(color: ColorConstant.backColor),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().statusBarHeight,
            ),
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
                backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.w)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w), // 圆角半径
                  ),
                ),
              ),
              child: Text(
                '登录', // 按钮上显示的文
                style: TextStyle(fontSize: 18.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),// 字
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopWidget() {
    return Text(
      StringConstant.loginTitle,
      style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
    );
  }

  Widget buildAccountInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "账号",
        prefixIcon: Icon(Icons.person_outline),
      ),
      style: TextStyle(fontSize: 16.sp),
      // keyboardType: TextInputType.phone,
    );
  }

  Widget buildPasswordInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _isObscure ,
      decoration: InputDecoration(
        labelText: "用户密码",
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: _pwdIcon(),
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  Widget _pwdIcon() {
    return IconButton(
        icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        });
  }
}

//用户协议和隐私政策
class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<bool?> onChanged;

  @override
  State<StatefulWidget> createState() => _PrivacyWidgetState();
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
