import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/network_image.dart';

/// pk榜单详情
class PkDetailPage extends StatefulWidget {
  const PkDetailPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _PkDetailPageState();
}

class _PkDetailPageState extends State<PkDetailPage> {
  late String _dataId;
  List<MachineEntity> model = [];
  String pkType = '';

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
        pkType = model[0].co;
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
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [ColorConstant.color3C94FD, ColorConstant.color03C94FD], //背景渐变色
            begin: Alignment.topCenter, //颜色渐变从顶部居中开始
            end: Alignment.bottomCenter, //颜色渐变从底部居中结束
          )),
          child: Column(
            children: [
              Image(width: double.infinity, height: 215.w, image: const AssetImage(ImageConstant.imageRankBack)),
              // SizedBox(
              //   height: 229.w,
              // ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15.w), topRight: Radius.circular(15.w))),
                      child: Column(children: [
                        _topView(),
                        Expanded(
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.length,
                                itemBuilder: (context, index) {
                                  return _itemView(index);
                                })),
                      ]))),
            ],
          )),
    );
  }

  Widget _topView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textAlign: TextAlign.left,
          StringConstant.rank,
          style: TextStyle(fontSize: 14.sp, color: ColorConstant.color666666),
        ),
        Text(
          textAlign: TextAlign.left,
          StringConstant.nickName,
          style: TextStyle(fontSize: 14.sp, color: ColorConstant.color666666),
        ),
        Text(
          textAlign: TextAlign.left,
          pkType,
          style: TextStyle(fontSize: 14.sp, color: ColorConstant.color666666),
        ),
      ],
    );
  }

  Widget _itemView(index) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.w, 6.w, 0.w, 10.w),
      // margin: EdgeInsets.fromLTRB(14.w, 5.w, 14.w, 5.w),
      // decoration: BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _itemLeft(index),
            _itemMiddle(index),
            _itemRight(index),
          ],
        ),
        SizedBox(height: 9.w,),
        Container(
          height: 1.w,
          decoration: const BoxDecoration(color: ColorConstant.dividerColor),
        )
      ]),
    );
  }

  Widget _itemMiddle(index) {
    var data = model[index];
    return Container(
      alignment: Alignment.centerLeft,
        width: 80.w,
        child: Row(
          children: [
            ClipOval(
                child: NetworkImageWidget(
              height: 24.w,
              width: 24.w,
              fit: BoxFit.cover,
              imageUrl: '',
              defaultImage: ImageConstant.imageHeadDefault,
            )),
            SizedBox(
              width: 4.w,
            ),
            Text(
              // userPhone,
              data.co,
              style: TextStyle(fontSize: 12.sp, color: ColorConstant.color666666),
            ),
          ],
        ));
  }

  Widget _itemLeft(index) {
    switch (index) {
      case 0:
        {
          return Container(
            alignment: Alignment.center,
            width: 40.w,
            height: 40.w,
            child: Image(
              image: const AssetImage(ImageConstant.imageRank1),
              width: 36.w,
              height: 36.w,
            ),
          );
        }
      case 1:
        {
          return Container(
            alignment: Alignment.center,
            width: 40.w,
            height: 40.w,
            child: Image(
              image: const AssetImage(ImageConstant.imageRank2),
              width: 36.w,
              height: 36.w,
            ),
          );
        }
      case 2:
        {
          return Container(
            alignment: Alignment.center,
            width: 40.w,
            height: 40.w,
            child: Image(
              image: const AssetImage(ImageConstant.imageRank3),
              width: 36.w,
              height: 36.w,
            ),
          );
        }
      default:
        {
          return Container(
            alignment: Alignment.center,
            width: 40.w,
            height: 40.w,
            child: Text(
              textAlign: TextAlign.left,
              "${index + 1}",
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
            ),
          );
        }
    }
  }

  Widget _itemRight(index) {
    return Container(
      alignment: Alignment.center,
      width: 40.w,
      height: 40.w,
      child: Text(
        textAlign: TextAlign.left,
        "${index + 1}",
        maxLines: 1,
        style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
      ),
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
        StringConstant.pkDetail,
        style: TextStyle(
          color: ColorConstant.black,
        ),
      ),
      centerTitle: true,
    );
  }
}