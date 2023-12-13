import 'package:digital_train/pages/LoginPage.dart';
import 'package:digital_train/util/constant.dart';
import 'package:digital_train/util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../net/net_util.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';

/// 设置
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: const BoxDecoration(color: ColorConstant.backColor),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(15.w),
                  decoration:
                      BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: _resetPwd()),
              SizedBox(
                height: 488.w,
              ),
              _button(),
            ],
          )),
    );
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () {
        // 退出登录
        _showDialog();
      },
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.w)),
          backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.w),
          ))),
      child: Text(
        StringConstant.logout,
        style: TextStyle(fontSize: 18.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  _showDialog() {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.hint,
      msg: StringConstant.logoutHint,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // 退出登录
            NetDioUtil.initOption();
            SpUtil.setString(Constants.token, '');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
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

  Widget _resetPwd() {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 修改密码
          Navigator.of(context).pushNamed(RouteName.resetPwdPage);
        },
        child: Row(
          children: [
            Image(
              image: const AssetImage(ImageConstant.imageResetPwd),
              width: 19.w,
              height: 19.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              StringConstant.resetPwd,
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
            ),
            Expanded(
                child: Image(
              alignment: Alignment.centerRight,
              image: const AssetImage(ImageConstant.imageBackMine),
              width: 12.w,
              height: 12.w,
            ))
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.setting,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
