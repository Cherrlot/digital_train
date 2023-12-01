import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadmore/loadmore.dart';

import '../model/machine_entity.dart';
import '../net/url_cons.dart';
import '../util/image_constant.dart';
import '../widget/vip_banner.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageList = List.empty(growable: true); //图片地址
  List<String> titleList = List.empty(growable: true); //标题集合

  int get count => list.length;

  List<MachineEntity> list = [];

  int pageNum = 0;

  @override
  void initState() {
    super.initState();
    _getBannerData();
    load();
  }

  Future _getBannerData() async {
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(
        success: (List<MachineEntity> model) {
          List<String> imageList = List.empty(growable: true); //图片地址
          List<String> titleList = List.empty(growable: true); //标题集合
          var i = 0;
          for (var element in model) {
            if (i >= 4) {
              break;
            }
            titleList.add(element.category);
            if (i / 2 == 0) {
              imageList.add("https://www.vipandroid.cn/ming/image/gan.png");
            } else {
              imageList.add("https://www.vipandroid.cn/ming/image/zao.png");
            }
            i++;
          }
          setState(() {
            this.imageList.addAll(imageList);
            this.titleList.addAll(titleList);
          });
        },
        failure: (String msg, int code) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(ColorConstant.colorF1F6FF), Color(ColorConstant.colorF6F7F9)], //背景渐变色
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
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.w), topRight: Radius.circular(15.w))),
      child: Column(
        children: [_showMore(), _typeGrid(),
          // _lessonGrid()
        ],
      ),
    ));
  }

  Widget _typeGrid() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: GridView.extent(
          shrinkWrap: true,
          maxCrossAxisExtent: 110.w,
          childAspectRatio: 5,
          children: titleList
              .map((e) => Text(
            e,
            maxLines: 1,
            style: TextStyle(fontSize: 13.sp, color: const Color(ColorConstant.color999999)),
          ))
              .toList(),
        ));
  }

  // Widget _lessonGrid() {
  //   return Expanded(
  //     child: RefreshIndicator(
  //         onRefresh: _refresh,
  //         child: LoadMore(
  //           // isFinish: count >= 60,
  //           onLoadMore: _loadMore,
  //           // whenEmptyLoad: true,
  //           delegate: const DefaultLoadMoreDelegate(),
  //           textBuilder: DefaultLoadMoreTextBuilder.chinese,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Text(
  //                 list[index].category,
  //                 maxLines: 1,
  //                 style: TextStyle(fontSize: 13.sp, color: const Color(ColorConstant.color999999)),
  //               );
  //             },
  //             itemCount: count,
  //           ),
  //         )),
  //   );
  // }

  Future<bool> _loadMore() async {
    pageNum++;
    BotToast.showText(text: '查看更多$pageNum');
    load();
    return true;
  }

  Future<void> _refresh() async {
    pageNum = 0;
    BotToast.showText(text: '刷新$pageNum');
    load();
  }

  Future<void> load() async {
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(
        success: (List<MachineEntity> model) {
          setState(() {
            list.addAll(model);
          });
        },
        failure: (String msg, int code) {});
  }

  Widget _showMore() {
    return Row(
      children: [
        Text(
          '学习地图',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(ColorConstant.color212121)),
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {
                  // 查看更多
                  BotToast.showText(text: '查看更多');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '查看更多',
                      style: TextStyle(fontSize: 13.sp, color: const Color(ColorConstant.color999999)),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(ColorConstant.color999999),
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开学习地图');
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开PK赛');
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开考试');
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开课程分类');
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开问卷');
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageQuestion),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('问卷'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开排行榜');
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
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开证书');
                  },
                  child: Image(
                    image: const AssetImage(ImageConstant.imageCertificate),
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                const Text('证书'),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ///学习地图
                    BotToast.showText(text: '打开知识库');
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
          BotToast.showText(text: '打开公告：${position.toString()}');
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
            BotToast.showText(text: '打开消息列表');
          },
          icon: const ImageIcon(AssetImage(ImageConstant.imageMessage)),
        )
      ],
    );
  }
}
