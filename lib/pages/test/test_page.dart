import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../model/test_topic_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/string_constant.dart';
import '../../widget/my_radio_option.dart';

/// 考试详情
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<TestTopicItems> testList = [];
  int _selectPosition = 0;

  /// 当前题目
  TestTopicItems? selectTest;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() {
          BotToast.showText(text: '第${_selectPosition + 1}题，选择答案: $value');
          var bank = selectTest?.bank;
          if(bank == null) {
            return;
          }
          if(bank.type == Constants.typeCheck) {
            // 多选
            if(bank.selections.contains(value)) {
              bank.selections.remove(value);
            } else {
              bank.selections.add(value ?? '');
            }
          } else {
            // 单选，判断
            bank.selections.clear();
            bank.selections.add(value ?? '');
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
    var appResponse = await get<TestTopicEntity, List<TestTopicEntity>?>(testGet,
        decodeType: TestTopicEntity(), queryParameters: {"search": "self"});
    appResponse.when(success: (List<TestTopicEntity>? model) {
      var data = model?[0];
      _encodeInput(data);
      setState(() {
        if (data != null) {
          testList.addAll(data.items);
          selectTest = data.items[0];
        }
      });
      cancel();
    }, failure: (String msg, int code) {
      cancel();
      debugPrint("$msg, code: $code");
    });
  }

  _encodeInput(TestTopicEntity? data) {
    data?.items.forEach((element) {
      var bank = element.bank;
      var input = bank.input;
      var decode = jsonDecode(input);
      var type = decode['type'];
      bank.type = type;
      var list = decode['options'] as List;
      List<TestTopicItemsOption> options = [];
      for (var option in list) {
        var temp = TestTopicItemsOption();
        temp.value = option['value'];
        temp.label = option['label'];
        options.add(temp);
      }
      bank.options = options;
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
              Expanded(child: _getContent(_selectPosition)),
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
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 切换试题
        setState(() {
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
            behavior: HitTestBehavior.opaque,
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
                  ElevatedButton(
                    onPressed: () {
                      //上一题
                      _lastTopic();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ))),
                    child: Text(
                      StringConstant.testPre,
                      style: TextStyle(fontSize: 12.sp, color: ColorConstant.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //下一题
                      _nextTopic();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConstant.color3C94FD),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ))),
                    child: Text(
                      StringConstant.testNext,
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

  /// 上一题
  _lastTopic() {
    setState(() {
      if (0 < _selectPosition) {
        _selectPosition--;
        selectTest = testList[_selectPosition];
      } else {
        BotToast.showText(text: '当前为第一题');
      }
    });
  }

  /// 下一题
  _nextTopic() {
    setState(() {
      if (testList.length - 1 > _selectPosition) {
        _selectPosition++;
        selectTest = testList[_selectPosition];
      } else {
        BotToast.showText(text: '当前为最后一题');
      }
    });
  }

  Widget _getContent(index) {
    var bank = selectTest?.bank;
    if (bank?.options == null) {
      return const SizedBox();
    }
    return _getOptionContent(bank!);
  }

  /// 获取选项列表
  Widget _getOptionContent(TestTopicItemsBank bank) {
    var options = bank.options;
    return ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          return MyRadioOption<String>(
            value: options[index].value,
            groupValue: bank.selections,
            onChanged: _valueChangedHandler(),
            label: options[index].value,
            text: options[index].label,
          );
        });
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
                  _getTopicType(),
                  style: TextStyle(fontSize: 10.sp, color: ColorConstant.color3C94FD),
                ),
              )),
          WidgetSpan(
              child: SizedBox(
            width: 6.w,
          )),
          TextSpan(
            text: selectTest?.bank.descr,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstant.color333333),
          ),
        ])));
  }

  String _getTopicType() {
    var result = StringConstant.testJudge;
    if (selectTest?.bank.category != Constants.typeJudge) {
      if (selectTest?.bank.type == Constants.typeCheck) {
        result = StringConstant.testNulChoose;
      } else {
        result = StringConstant.testChoose;
      }
    }
    return result;
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
