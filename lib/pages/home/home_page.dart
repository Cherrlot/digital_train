import 'package:digital_train/util/color_constant.dart';
import 'package:digital_train/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/lesson_entity.dart';
import '../../model/lesson_type_entity.dart';
import '../../model/message_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/network_image.dart';
import '../../widget/vip_banner.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageList = List.empty(growable: true); //图片地址
  List<String> titleList = List.empty(growable: true); //标题集合
  final List<LessonEntity> _lessonList = [];
  final List<MessageEntity> _bannerList = [];
  final List<LessonTypeEntity> _lessonTypeList = [];

  @override
  void initState() {
    super.initState();
    _getBannerData();
    _getLessonType();
    _loadLessons();
  }

  /// 获取课程类型
  _getLessonType() async {
    var appResponse = await get<LessonTypeEntity, List<LessonTypeEntity>?>(
      lessonType,
      decodeType: LessonTypeEntity(),
    );
    appResponse.when(success: (List<LessonTypeEntity>? model) {
      List<LessonTypeEntity> data = [];
      model?.forEach((element) {
        data.add(element);
      });
      setState(() {
        _lessonTypeList.addAll(data);
      });
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  /// 获取公告
  Future _getBannerData() async {
    var appResponse = await get<MessageEntity, List<MessageEntity>?>(notice,
        decodeType: MessageEntity(), queryParameters: {"type": 1});
    appResponse.when(success: (List<MessageEntity>? model) {
      List<String> imageList = List.empty(growable: true); //图片地址
      List<String> titleList = List.empty(growable: true); //标题集合
      _bannerList.addAll(model ?? []);
      for (var element in model ?? []) {
        imageList.add(ImageUtil.getFullNetUrl(element.image));
        titleList.add(element.title ?? '');
      }
      setState(() {
        this.imageList.addAll(imageList);
        this.titleList.addAll(titleList);
      });
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [ColorConstant.colorF1F6FF, ColorConstant.colorF6F7F9], //背景渐变色
        begin: Alignment.topCenter, //颜色渐变从顶部居中开始
        end: Alignment.bottomCenter, //颜色渐变从底部居中结束
      )),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().statusBarHeight,
          ),
          _topView(),
          SizedBox(
            height: 10.w,
          ),
          _banner(),
          SizedBox(
            height: 20.w,
          ),
          _button(),
          SizedBox(
            height: 20.w,
          ),
          _bottom(),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(14.w),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.w), topRight: Radius.circular(15.w))),
      child: Column(
        children: [
          _showMore(),
          SizedBox(
            height: 10.w,
          ),
          _typeGrid(),
          SizedBox(
            height: 10.w,
          ),
          _lessonGrid()
        ],
      ),
    ));
  }

  Widget _typeGrid() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Container(
            alignment: Alignment.centerLeft,
            height: 30.w,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: _lessonTypeItem,
              scrollDirection: Axis.horizontal,
              itemCount: _lessonTypeList.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            )));
  }

  Widget _lessonTypeItem(context, index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 根据类型查看课程
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(5.w, 3.w, 5.w, 3.w),
            decoration:
                BoxDecoration(color: ColorConstant.colorF6F6F6, borderRadius: BorderRadius.all(Radius.circular(15.w))),
            child: Text(
              _lessonTypeList[index].name,
              maxLines: 1,
              style: TextStyle(fontSize: 13.sp, color: ColorConstant.color999999),
            )));
  }

  Widget _lessonGrid() {
    return Expanded(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: 6.w,
            crossAxisCount: 2,
            children: _lessonList.map((e) => _lessonItem(e)).toList(),
          )),
    );
  }

  Widget _lessonItem(LessonEntity data) {
    return Column(
      children: [
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.lessonDetailPage, arguments: {"param": data});
            },
            child: NetworkImageWidget(
              height: 105.w,
              fit: BoxFit.cover,
              imageUrl: data.cover,
              defaultImage: ImageConstant.imageLessonDefault,
            )),
        Text(
          data.title,
          maxLines: 1,
          style: TextStyle(fontSize: 13.sp, color: ColorConstant.color999999),
        )
      ],
    );
  }

  /// 获取课程列表
  _loadLessons() async {
    var appResponse = await get<LessonEntity, List<LessonEntity>?>(lessonList,
        decodeType: LessonEntity(), queryParameters: {"search": "self"});
    appResponse.when(success: (List<LessonEntity>? model) {
      setState(() {
        _lessonList.addAll(model ?? []);
      });
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  Widget _showMore() {
    return Row(
      children: [
        Text(
          StringConstant.lessonSelect,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorConstant.color212121),
        ),
        Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // 查看更多
                  Navigator.of(context).pushNamed(RouteName.lessonPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      StringConstant.seeMore,
                      style: TextStyle(fontSize: 13.sp, color: ColorConstant.color999999),
                    ),
                    Image(
                      alignment: Alignment.centerRight,
                      image: const AssetImage(ImageConstant.imageBackMine),
                      width: 12.w,
                      height: 12.w,
                    ),
                  ],
                )))
      ],
    );
  }

  Widget _button() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //垂直方向平分
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //主轴方向（横向）间距
          children: [
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///学习地图
                    Navigator.of(context).pushNamed(RouteName.studyMapPage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageMap),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('学习地图'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///打开PK赛
                    Navigator.of(context).pushNamed(RouteName.pkPage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imagePk),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('PK赛'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///打开考试
                    Navigator.of(context).pushNamed(RouteName.testPage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageTest),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('考试'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///打开课程分类
                    Navigator.of(context).pushNamed(RouteName.lessonPage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageType),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('课程分类'),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //主轴方向（横向）间距
          children: [
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///打开排行榜
                    Navigator.of(context).pushNamed(RouteName.rankPage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageRank),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('排行榜'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///打开知识库
                    Navigator.of(context).pushNamed(RouteName.knowledgePage);
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageKnowledge),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('知识库'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///学习地图
                    // BotToast.showText(text: '打开证书');
                  },
                  child: SizedBox(
                    width: 50.w,
                    height: 50.w,
                  ),
                  // child: Image(
                  //   image: const AssetImage(ImageConstant.imageCertificate),
                  //   width: 50.w,
                  //   height: 50.w,
                  // ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                // const Text('证书'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ///学习地图
                    // BotToast.showText(text: '打开问卷');
                  },
                  child: SizedBox(
                    width: 50.w,
                    height: 50.w,
                  ),
                  // child: Image(
                  //   image: const AssetImage(ImageConstant.imageQuestion),
                  //   width: 50.w,
                  //   height: 50.w,
                  // ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                // const Text('问卷'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  VipBanner _banner() {
    return VipBanner(
        height: 140.w,
        imageMarginLeft: 14.w,
        imageMarginRight: 14.w,
        titleList: titleList,
        radius: 10.w,
        titleAlignment: Alignment.centerRight,
        imageList: imageList,
        bannerClick: (position) {
          //条目点击
          Navigator.of(context).pushNamed(RouteName.bannerPage, arguments: {"param": _bannerList[position]});
        });
  }

  Stack _topView() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text('首页', style: TextStyle(fontSize: 16.sp), textAlign: TextAlign.center),
        ),
        IconButton(
          padding: EdgeInsets.all(3.w),
          onPressed: () {
            /// 打开消息列表
            Navigator.of(context).pushNamed(RouteName.messagePage);
          },
          icon: const ImageIcon(AssetImage(ImageConstant.imageMessage)),
        )
      ],
    );
  }
}
