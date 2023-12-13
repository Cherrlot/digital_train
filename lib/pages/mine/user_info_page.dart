import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../model/upload_image_entity.dart';
import '../../model/user_info_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/image_constant.dart';
import '../../util/image_util.dart';
import '../../util/string_constant.dart';
import '../../widget/network_image.dart';
import '../../main.dart';

/// 用户资料
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late TextEditingController nickNameController;
  late TextEditingController phoneController;
  UserInfoEntity? _userInfoEntity;

  final ImagePicker _picker = ImagePicker();

  String? _headImage;

  @override
  void initState() {
    super.initState();
    nickNameController = TextEditingController(text: SpUtil.getString(Constants.nickName));
    phoneController = TextEditingController(text: SpUtil.getString(Constants.userPhone));
    _getUserInfo();
  }

  _getUserInfo() async {
    var cancel = BotToast.showLoading();
    var appResponse =
    await get<UserInfoEntity, List<UserInfoEntity>?>(userInfo, decodeType: UserInfoEntity(), data: {"ID": 0});
    appResponse.when(success: (List<UserInfoEntity>? model) {
      var userInfo = model?[0];
      _userInfoEntity = userInfo;
      if(userInfo != null) {
        SpUtil.setString(Constants.headUrl, userInfo.headImage ?? '');
        SpUtil.setString(Constants.userName, userInfo.name ?? '');
        SpUtil.setString(Constants.userPhone, userInfo.phone ?? '');
        SpUtil.setString(Constants.nickName, userInfo.nickname ?? '');
        nickNameController.text = userInfo.nickname ?? userInfo.name ?? '';
        phoneController.text = userInfo.phone ?? '';
        _headImage = SpUtil.getString(Constants.headUrl) ?? '';
      }
      cancel();
    }, failure: (String msg, int code) {
      cancel();
    });
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
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // 编辑头像
                  _showSelectImageDialog();
                },
                child: _userHeader()),
            SizedBox(
              height: 10.w,
            ),
            Text(
              StringConstant.userHead,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color999999),
            ),
            SizedBox(
              height: 10.w,
            ),
            buildNickNameInputWidget(nickNameController),
            SizedBox(
              height: 10.w,
            ),
            buildPhoneInputWidget(phoneController),
            SizedBox(
              height: 50.w,
            ),
            _button()
          ])),
    );
  }

  _showSelectImageDialog() {
    Dialogs.bottomMaterialDialog(
        context: context,
        customView: Column(
          children: <Widget>[
            InkWell(
              onTap: () async {
                try {
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    // 获取图片路径
                    // 关闭弹窗
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    // 获取裁剪后地址
                    var cropperFile = await ImageUtil.cropImage(image: pickedFile.path,
                        cropStyle: CropStyle.circle,
                        aspectRatioPresets: [
                          CropAspectRatioPreset.original,
                          CropAspectRatioPreset.square,
                          CropAspectRatioPreset.ratio3x2,
                          CropAspectRatioPreset.ratio4x3,
                          CropAspectRatioPreset.ratio16x9
                        ]);
                    // 请求接口上传图片
                    if (cropperFile != null) {
                      _uploadImage(cropperFile.path);
                    }
                  }
                } catch (e) {}
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.w,
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black26))),
                child: const Text(StringConstant.camera),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    // 获取图片路径
                    // 关闭弹窗
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    // 获取裁剪后地址
                    var cropperFile = await ImageUtil.cropImage(image: pickedFile.path);
                    // 请求接口上传图片
                    if (cropperFile != null) {
                      _uploadImage(cropperFile.path);
                    }
                  }
                } catch (e) {}
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.w,
                child: const Text(StringConstant.gallery),
              ),
            )
          ],
        ));
  }

  _uploadImage(path) async {
    var cancel = BotToast.showLoading();
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(
          path,
          filename: name,
        )
      },
    );

    var appResponse = await post<UploadImageEntity, List<UploadImageEntity>?>(uploadImage,
        options: Options(contentType: 'multipart/form-data'), decodeType: UploadImageEntity(), data: formData);

    appResponse.when(success: (List<UploadImageEntity>? model) {
      var imagePath = model?[0].url;
      setState(() {
        _headImage = imagePath;
      });
      cancel();
    }, failure: (String msg, int code) {
      cancel();
      debugPrint("失败了：msg=$msg/code=$code");
    });
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
            Navigator.of(context).pop();
            _updateUserInfo();
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

  /// 修改用户资料
  _updateUserInfo() async {
    var cancel = BotToast.showLoading();
    String nickName = nickNameController.value.text;
    String phone = phoneController.value.text;
    var appResponse = await post<Object, Object?>(userInfoUpdate,
        decodeType: Object(),
        data: {"ID": _userInfoEntity?.iD, "nickName": nickName, 'phone': phone, 'headImage': _headImage}
    );
    appResponse.when(success: (data) {
      BotToast.showText(text: StringConstant.modifySuccess);
      eventBus.fire(_userInfoEntity);

      cancel();
    }, failure: (msg, code) {
      cancel();
    },);
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
        StringConstant.userInfoEdit,
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
      imageUrl: _headImage ?? SpUtil.getString(Constants.headUrl) ?? '',
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
