import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/gsy_input_widget.dart';
import '../../widget/network_image.dart';

/// 用户资料
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late TextEditingController nickNameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nickNameController = TextEditingController(text: SpUtil.getString(Constants.nickName));
    phoneController = TextEditingController(text: SpUtil.getString(Constants.userPhone));
  }

  @override
  void dispose() {
    nickNameController.dispose();
    phoneController.dispose();
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            GestureDetector(
                onTap: () {
                  // 编辑头像
                },
                child:_userHeader()),
            SizedBox(height: 10.w,),
            Text(
              StringConstant.userHead,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color999999),
            ),
            SizedBox(height: 10.w,),
            buildNickNameInputWidget(nickNameController),
            SizedBox(height: 10.w,),
            buildPhoneInputWidget(phoneController),
            SizedBox(height: 50.w,),
            _button()
          ])),
    );
  }

  _showDialog() {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.hint,
      msg: StringConstant.userInfoHint,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // 修改用户资料
            String nickName = nickNameController.value.text;
            String phone = phoneController.value.text;
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

  Widget _button() {
    return ElevatedButton(
      onPressed: () {
        // 修改用户资料
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

  Widget _userHeader() {
    return ClipOval(
        child: NetworkImageWidget(
          height: 120.w,
          width: 120.w,
          fit: BoxFit.cover,
          imageUrl: SpUtil.getString(Constants.headUrl) ?? '',
          defaultImage: ImageConstant.imageHeadDefault,
        ));
  }

  Widget buildNickNameInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: StringConstant.nickname,
        prefixIcon: Icon(Icons.person_outline),
      ),
      style: TextStyle(fontSize: 16.sp),
      // keyboardType: TextInputType.phone,
    );
  }

  Widget buildPhoneInputWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: StringConstant.userPhone,
        prefixIcon: Icon(Icons.phone_android),
      ),
      style: TextStyle(fontSize: 16.sp),
      // keyboardType: TextInputType.phone,
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.userInfo,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
