import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/gsy_input_widget.dart';
import '../../widget/network_image.dart';

/// 重置密码
class ResetPwdPage extends StatefulWidget {
  const ResetPwdPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {
  late TextEditingController pwdController;
  late TextEditingController pwdConfirmNewController;
  late TextEditingController newPwdController;
  bool _isObscure = true;
  bool _isConfirmNewObscure = true;
  bool _isNewObscure = true;

  @override
  void initState() {
    super.initState();
    pwdController = TextEditingController();
    pwdConfirmNewController = TextEditingController();
    newPwdController = TextEditingController();
  }

  @override
  void dispose() {
    pwdController.dispose();
    pwdConfirmNewController.dispose();
    newPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: const BoxDecoration(color: ColorConstant.backColor),
          child: Column(children: [
            buildPasswordInputWidget(pwdController),
            SizedBox(height: 24.w,),
            buildNewPasswordInputWidget(newPwdController),
            SizedBox(height: 24.w,),
            buildConfirmNewPasswordInputWidget(pwdConfirmNewController),
            SizedBox(height: 56.w,),
            _button()
          ]),
        ));
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () {
        // 修改密码
        _showDialog();
      },
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.w)),
          backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.w),
          ))),
      child: Text(
        StringConstant.confirm,
        style: TextStyle(fontSize: 18.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  _showDialog() {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.hint,
      msg: StringConstant.pwdResetHint,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // 修改密码
            String pwd = pwdConfirmNewController.value.text;
            String pwdConfirm = newPwdController.value.text;
            if(pwd != pwdConfirm) {
              BotToast.showText(text: StringConstant.pwdConfirmError);
              Navigator.of(context).pop();
              return;
            }
          },
          text: StringConstant.confirm,
          color: ColorConstant.color3C94FD,
          textStyle: const TextStyle(color: ColorConstant.color333333),
        ),
        IconsOutlineButton(
          onPressed: () {
            // 取消
            Navigator.of(context).pop();
          },
          text: StringConstant.cancel,
          textStyle: const TextStyle(color: ColorConstant.white),
        ),
      ],
    );
  }

  Widget buildPasswordInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _isObscure ,
      decoration: InputDecoration(
        labelText: StringConstant.pwdInput,
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

  Widget buildNewPasswordInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _isNewObscure ,
      decoration: InputDecoration(
        labelText: StringConstant.pwdNew,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: _pwdNewIcon(),
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  Widget _pwdNewIcon() {
    return IconButton(
        icon: Icon(
            _isNewObscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isNewObscure = !_isNewObscure;
          });
        });
  }

  Widget buildConfirmNewPasswordInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _isConfirmNewObscure ,
      decoration: InputDecoration(
        labelText: StringConstant.pwdNewConfirm,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: _pwdConfirmNewIcon(),
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  Widget _pwdConfirmNewIcon() {
    return IconButton(
        icon: Icon(
            _isConfirmNewObscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isConfirmNewObscure = !_isConfirmNewObscure;
          });
        });
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.resetPwd,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
