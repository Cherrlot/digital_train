import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/my_radio_option.dart';

/// 考试详情
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<MachineEntity> testList = [];
  int _selectPosition = 0;
  MachineEntity? selectTest;

  String? _groupValue;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() {
          BotToast.showText(text: '第${_selectPosition + 1}题，选择答案: $value');
          _groupValue = null;

          // 下一题
          if (testList.length - 1 > _selectPosition) {
            _selectPosition++;
            selectTest = testList[_selectPosition];
          } else {
            BotToast.showText(text: '考试完毕');
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _getTest();
  }

  _getTest() async {
    var cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(success: (List<MachineEntity> model) {
      setState(() {
        testList.addAll(model);
        testList.addAll(model);
        selectTest = model[0];
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
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30.w),
          child: Column(
            children: [
              _getTitle(_selectPosition),
              SizedBox(
                height: 15.w,
              ),
              _getContent(_selectPosition),
              _getBottom(_selectPosition),
            ],
          )),
    );
  }

  _showDialog() {
    Dialogs.bottomMaterialDialog(
      context: context,
      customView: _topicGrid(),
    );
  }

  _showTestFinishDialog() {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.hint,
      msg: StringConstant.testConfirmContent,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              // 交卷
              Navigator.of(context).pushReplacementNamed(RouteName.testResult, arguments: {"param": 'data.id'});
            },
            text: StringConstant.testConfirm,
            color: ColorConstant.color3C94FD,
            textStyle: const TextStyle(color: ColorConstant.white),
          ),
          IconsOutlineButton(
            onPressed: () {
              // 取消
              Navigator.of(context).pop();
            },
            text: StringConstant.testContinue,
            textStyle: const TextStyle(color: ColorConstant.color333333),
          ),
        ],
    );
  }

  Widget _topicGrid() {
    return Expanded(
        child: GridView.count(
      padding: EdgeInsets.all(4.w),
      crossAxisCount: 6,
      shrinkWrap: true,
      crossAxisSpacing: 6.w,
      mainAxisSpacing: 20.w,
      children: testList.map((e) => _topicItem(e)).toList(),
    ));
  }

  Widget _topicItem(data) {
    var index = testList.indexOf(data);
    var border = index == _selectPosition
        ? Border.all(width: 0, style: BorderStyle.none)
        : Border.all(width: 1.w, style: BorderStyle.solid, color: ColorConstant.color333333);
    var decorationColor = index == _selectPosition ? ColorConstant.color3C94FD : ColorConstant.white;
    var textColor = index == _selectPosition ? ColorConstant.white : ColorConstant.color333333;

    return GestureDetector(
      onTap: () {
        // 切换试题
        setState(() {
          _groupValue = null;

          _selectPosition = index;
          selectTest = testList[_selectPosition];
        });
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: decorationColor,
          borderRadius: BorderRadius.all(Radius.circular(45.w)),
          border: border,
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBottom(index) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              // 打开题目列表
              _showDialog();
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //交卷
                      _showTestFinishDialog();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ))),
                    child: Text(
                      StringConstant.testAll,
                      style: TextStyle(fontSize: 12.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      Image(
                        image: const AssetImage(ImageConstant.imageTestGrid),
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        '${index + 1}',
                        style:
                            TextStyle(fontSize: 12.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        StringConstant.sp,
                        style:
                            TextStyle(fontSize: 12.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '50',
                        style:
                            TextStyle(fontSize: 12.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  Widget _getContent(index) {
    if (index % 2 == 1) {
      return _getJudgeContent(index);
    } else {
      return _getChooseContent(index);
    }
  }

  /// 判断题
  Widget _getJudgeContent(index) {
    return Column(
      children: [
        MyRadioOption<String>(
          value: 'A',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'A',
          text: StringConstant.testRight,
        ),
        MyRadioOption<String>(
          value: 'B',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'B',
          text: StringConstant.testWrong,
        ),
      ],
    );
  }

  /// 选择题
  Widget _getChooseContent(index) {
    return Column(
      children: [
        MyRadioOption<String>(
          value: 'A',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'A',
          text: StringConstant.testRight,
        ),
        MyRadioOption<String>(
          value: 'B',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'B',
          text: StringConstant.testWrong,
        ),
        MyRadioOption<String>(
          value: 'C',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'C',
          text: StringConstant.testRight,
        ),
        MyRadioOption<String>(
          value: 'D',
          groupValue: _groupValue,
          onChanged: _valueChangedHandler(),
          label: 'D',
          text: StringConstant.testWrong,
        ),
      ],
    );
  }

  Widget _getTitle(index) {
    return SizedBox(
        width: double.infinity,
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: '${_selectPosition + 1}、',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstant.color333333),
          ),
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: const BoxDecoration(color: ColorConstant.color663C94FD),
                child: Text(
                  StringConstant.testJudge,
                  style: TextStyle(fontSize: 10.sp, color: ColorConstant.color3C94FD),
                ),
              )),
          WidgetSpan(
              child: SizedBox(
            width: 6.w,
          )),
          TextSpan(
            text: selectTest?.category,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstant.color333333),
          ),
        ])));
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.test,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
