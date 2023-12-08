import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';

/// 考试结果
class TestResultPage extends StatefulWidget {
  const TestResultPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  late String _dataId;
  String point = '80';
  List<MachineEntity> model = [];

  @override
  void initState() {
    super.initState();
    _dataId = widget.params["param"];
    _getData();
  }

  _getData() async {
    var cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(success: (List<MachineEntity> model) {
      setState(() {
        this.model.addAll(model);
      });
      cancel();
    }, failure: (String msg, int code) {
      cancel();
      debugPrint("$msg, code: $code");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: ColorConstant.backColor),
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image(
                width: ScreenUtil().screenWidth,
                image: const AssetImage(ImageConstant.imageTestResult),
                fit: BoxFit.fitWidth,
              ),
              Column(children: [
                SizedBox(height: 50.w,),
                Text(
                  point,
                  style: TextStyle(fontSize: 50.sp, color: ColorConstant.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 9.w,),
                Text(
                  StringConstant.testPoint,
                  style: TextStyle(fontSize: 17.sp, color: ColorConstant.white),
                ),
              ],)
            ],
          )),
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
        StringConstant.testResult,
        style: TextStyle(
          color: ColorConstant.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
