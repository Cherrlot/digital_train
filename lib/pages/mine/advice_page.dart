import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/gsy_input_widget.dart';

/// 意见反馈
class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<StatefulWidget> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  late TextEditingController adviceContentController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    adviceContentController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    adviceContentController.dispose();
    nameController.dispose();
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              StringConstant.adviceTitle,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7.w,
            ),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration:
                  BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
              height: 166.w,
              child: GSYInputWidget(
                controller: adviceContentController,
                textStyle: TextStyle(fontSize: 12.sp, color: ColorConstant.color333333),
                hintText: StringConstant.adviceHint,
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              StringConstant.contract,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6.w,
            ),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration:
                  BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 85.w,
                        child: Text(
                          StringConstant.name,
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 12.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: (GSYInputWidget(
                        controller: nameController,
                        textAlign: TextAlign.end,
                        textStyle: TextStyle(fontSize: 12.sp, color: ColorConstant.color333333),
                        hintText: StringConstant.nameHint,
                      )))
                    ],
                  ),
                  Divider(
                    height: 1.w,
                    color: ColorConstant.dividerColor,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 85.w,
                        child: Text(
                          StringConstant.phone,
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 12.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: (GSYInputWidget(
                        controller: phoneController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.phone,
                        textStyle: TextStyle(fontSize: 12.sp, color: ColorConstant.color333333),
                        hintText: StringConstant.phoneHint,
                      )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.w,
            ),
            ElevatedButton(
              onPressed: () {
                // 提交反馈
                String advice = adviceContentController.value.text;
                String name = nameController.value.text;
                String phone = phoneController.value.text;

                if(advice.isEmpty) {
                  BotToast.showText(text: StringConstant.adviceHint);
                  return;
                }
                if(name.isEmpty) {
                  BotToast.showText(text: StringConstant.nameHint);
                  return;
                }
                if(phone.isEmpty) {
                  BotToast.showText(text: StringConstant.contractHint);
                  return;
                }
                _showDialog();
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.w)),
                  backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.w),
                  ))),
              child: Text(
                StringConstant.confirmNow,
                style: TextStyle(fontSize: 18.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),
              ),
            ),
          ])),
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
            // 提交意见
            Navigator.of(context).pop();
            _createFeedback();
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

  /// 提交意见
  _createFeedback() async {
    var cancel = BotToast.showLoading();
    String advice = adviceContentController.value.text;
    String name = nameController.value.text;
    String phone = phoneController.value.text;
    var appResponse = await post<Object, Object?>(feedback,
        decodeType: Object(),
        data: {"name": name, "phone": phone, 'content': advice}
    );
    appResponse.when(success: (data) {
      BotToast.showText(text: StringConstant.commitSuccess);
      cancel();
      Navigator.of(context).pop();
    }, failure: (msg, code) {
      cancel();
    },);
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.advice,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
