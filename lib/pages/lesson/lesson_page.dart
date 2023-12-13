import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/lesson_entity.dart';
import '../../model/lesson_type_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/network_image.dart';

/// 课程列表
class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final List<LessonTypeEntity> _lessonTypeList = [];
  final List<LessonEntity> _lessonList = [];
  int _selectType = 0;

  @override
  void initState() {
    super.initState();
    _getLessonType();
  }

  _getLessonType() async {
    var cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    var appResponse = await get<LessonTypeEntity, List<LessonTypeEntity>?>(
      lessonType,
      decodeType: LessonTypeEntity(),
    );
    appResponse.when(success: (List<LessonTypeEntity>? model) {
      var firstType = model?[0];
      if(firstType != null) {
        _getLessonList(firstType.iD, cancel);
      } else {
        cancel();
      }
      List<LessonTypeEntity> data = [];
      model?.forEach((element) {
        data.add(element);
      });
      setState(() {
        _lessonTypeList.addAll(data);
      });

    }, failure: (String msg, int code) {
      cancel();
      debugPrint("$msg, code: $code");
    });
  }

  _getLessonList(String id, CancelFunc cancel) async {
    var appResponse = await get<LessonEntity, List<LessonEntity>?>(lessonList,
        decodeType: LessonEntity(), queryParameters: {"search": "self", "type": id});
    appResponse.when(success: (List<LessonEntity>? model) {
      _lessonList.clear();
      setState(() {
        _lessonList.addAll(model ?? []);
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
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(color: ColorConstant.backColor),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(
                width: 95.w,
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _lessonTypeList.length,
                    itemBuilder: (context, index) {
                      return _itemTypeView(index);
                    })),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(color: ColorConstant.white),
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _lessonList.length,
                        itemBuilder: (context, index) {
                          return _lessonView(index);
                        }))),
          ])),
    );
  }

  Widget _itemTypeView(index) {
    var data = _lessonTypeList[index];
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 选择课程类型
          if (_selectType != index) {
            _getLessonList(data.iD, BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close));
            setState(() {
              _selectType = index;
            });
          }
        },
        child: _getTypeView(index));
  }

  Widget _getTypeView(index) {
    if (_selectType == index) {
      return _selectTypeView(index);
    } else {
      return _defaultTypeView(index);
    }
  }

  Widget _selectTypeView(index) {
    var data = _lessonTypeList[index];
    return Container(
      height: 50.w,
      width: 95.w,
      decoration: const BoxDecoration(color: ColorConstant.white),
      padding: EdgeInsets.fromLTRB(0, 0, 4.w, 0),
      child: Row(children: [
        Container(
          height: 50.w,
          width: 6.w,
          decoration: BoxDecoration(
              color: ColorConstant.color3C94FD,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(4.w), topRight: Radius.circular(4.w))),
        ),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
            child: Text(
          data.name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.sp, color: ColorConstant.black),
          overflow: TextOverflow.ellipsis,
        ))
      ]),
    );
  }

  Widget _defaultTypeView(index) {
    var data = _lessonTypeList[index];
    return Container(
      height: 50.w,
      width: 95.w,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
      child: Text(
        data.name,
        maxLines: 1,
        style: TextStyle(fontSize: 10.sp, color: ColorConstant.black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _lessonView(index) {
    var data = _lessonList[index];
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 课程详情
          Navigator.of(context).pushNamed(RouteName.lessonDetailPage, arguments: {"param": data});
        },
        child: Container(
          height: 78.w,
          padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(4.w),
                child: NetworkImageWidget(
                  height: 58.w,
                  width: 79.w,
                  fit: BoxFit.cover,
                  imageUrl: data.descr,
                  defaultImage: ImageConstant.imageLessonDefault,
                )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Container(
                    height: 60.w,
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.left,
                      data.title,
                      style: TextStyle(fontSize: 14.sp, color: ColorConstant.color212121),
                    )))
          ]),
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
        StringConstant.lessonType,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
