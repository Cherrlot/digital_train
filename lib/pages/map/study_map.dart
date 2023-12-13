import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/image_constant.dart';
import '../../util/sp_util.dart';
import '../../util/string_constant.dart';
import '../../widget/network_image.dart';

/// 学习地图
class StudyMapPage extends StatefulWidget {
  const StudyMapPage({super.key});

  @override
  State<StatefulWidget> createState() => _StudyMapPageState();
}

class _StudyMapPageState extends State<StudyMapPage> {
  List<MachineEntity> model = [];
  /// 用户头像
  String headUrl = "";
  ScrollController scrollController = ScrollController();
  /// 用户当前进度
  int topicNum = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      headUrl = SpUtil.getString(Constants.headUrl) ?? "";
    });
    _getStudyMap();
  }

  _getStudyMap() async {
    var cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(success: (List<MachineEntity> model) {
      setState(() {
        this.model.addAll(model);
        topicNum = 3;
        // 将listview滚动到底部
        Future.delayed(const Duration(milliseconds: 500), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        });
      });
      cancel();
    }, failure: (String msg, int code) {
      cancel();
      debugPrint("$msg, code: $code");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageConstant.imageStudyMapBack), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(),
        body: Row(
          children: [
            _left(),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Column(
              children: [
                Expanded(child: _mapView()),
                SizedBox(
                  height: 98.w,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _mapView() {
    return ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.length,
        itemBuilder: (context, index) {
          return _itemView(model.length - 1 - index);
        });
  }

  Widget _left() {
    return SizedBox(
      width: 68.w,
      child: Column(
        children: [
          SizedBox(
            height: 100.w,
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // 消息列表
                Navigator.of(context).pushNamed(RouteName.messagePage);
              },
              child: Image(
                image: const AssetImage(ImageConstant.imageStudyMapMsg),
                width: 48.w,
                height: 48.w,
              )),
          Text(
            StringConstant.message,
            style: TextStyle(fontSize: 12.sp, color: ColorConstant.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.w,
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // 排行
                Navigator.of(context).pushNamed(RouteName.rankPage);
              },
              child: Image(
                image: const AssetImage(ImageConstant.imageStudyMapRank),
                width: 48.w,
                height: 48.w,
              )),
          Text(
            StringConstant.rank,
            style: TextStyle(fontSize: 12.sp, color: ColorConstant.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _rightMapView(index) {
    return SizedBox(
        width: 230.w,
        height: 108.w,
        child: Stack(
          children: [
            Positioned(
              left: 23.w,
              top: 0,
              // 右折线
              child: Opacity(
                  opacity: index == model.length - 1 ? 0 : 1,
                  child: Image(
                    image: const AssetImage(ImageConstant.imageStudyMapLine1),
                    width: 177.w,
                    height: 97.w,
                  )),
            ),
            Positioned(
              left: 177.w,
              top: 69.w,
              // 水花
              child: Image(
                image: const AssetImage(ImageConstant.imageStudyMapWater),
                width: 46.w,
                height: 46.w,
              ),
            ),
            Positioned(
              left: 179.w,
              top: 12.w,
              // 锁
              child: Opacity(
                  opacity: index <= topicNum ? 0 : 1,
                  child: Image(
                    image: const AssetImage(ImageConstant.imageStudyMapLock),
                    width: 40.w,
                    height: 49.w,
                  )),
            ),
            Positioned(
              left: 179.w,
              top: 22.w,
              // 头像
              child: Opacity(
                  opacity: index == topicNum ? 1 : 0,
                  child: ClipOval(
                      child: NetworkImageWidget(
                    height: 40.w,
                    width: 40.w,
                    fit: BoxFit.cover,
                    imageUrl: headUrl,
                    defaultImage: ImageConstant.imageHeadDefault,
                  ))),
            ),
            Positioned(
              left: 190.w,
              top: 60.w,
              // 关号
              child: Text(
                '${index + 1}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24.sp, color: ColorConstant.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Widget _leftMapView(index) {
    return SizedBox(
        width: 230.w,
        height: 108.w,
        child: Stack(
          children: [
            Positioned(
              left: 23.w,
              top: 0,
              // 左折线
              child: Opacity(
                  opacity: index == model.length - 1 ? 0 : 1,
                  child: Image(
                    image: const AssetImage(ImageConstant.imageStudyMapLine2),
                    width: 177.w,
                    height: 97.w,
                  )),
            ),
            Positioned(
              left: 0,
              top: 69.w,
              // 水花
              child: Image(
                image: const AssetImage(ImageConstant.imageStudyMapWater),
                width: 46.w,
                height: 46.w,
              ),
            ),
            Positioned(
              left: 2.w,
              top: 12.w,
              // 锁
              child: Opacity(
                  opacity: index <= topicNum ? 0 : 1,
                  child: Image(
                    image: const AssetImage(ImageConstant.imageStudyMapLock),
                    width: 40.w,
                    height: 49.w,
                  )),
            ),
            Positioned(
              left: 2.w,
              top: 22.w,
              // 头像
              child: Opacity(
                  opacity: index == topicNum ? 1 : 0,
                  child: ClipOval(
                      child: NetworkImageWidget(
                    height: 40.w,
                    width: 40.w,
                    fit: BoxFit.cover,
                    imageUrl: headUrl,
                    defaultImage: ImageConstant.imageHeadDefault,
                  ))),
            ),
            Positioned(
              left: 19.w,
              top: 60.w,
              // 关号
              child: Text(
                '${index + 1}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24.sp, color: ColorConstant.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Widget _itemView(index) {
    if (index % 2 == 0) {
      return _leftMapView(index);
    } else {
      return _rightMapView(index);
    }
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: ColorConstant.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.studyMap,
        style: TextStyle(
          color: ColorConstant.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
