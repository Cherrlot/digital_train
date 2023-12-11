import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/image_constant.dart';
import '../../util/sp_util.dart';
import '../../widget/network_image.dart';

/// 我的
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  String userName = "";
  String userPhone = "";
  String headUrl = "";

  @override
  void initState() {
    super.initState();
    _setUserInfo();
  }

  _setUserInfo() async {
    setState(() {
      userName = SpUtil.getString(Constants.userName) ?? "";
      userPhone = SpUtil.getString(Constants.userPhone) ?? "";
      headUrl = SpUtil.getString(Constants.headUrl) ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: ColorConstant.backColor),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image(
              image: const AssetImage(ImageConstant.imageMineBack),
              width: double.infinity,
              height: 277.w,
            ),
            Column(
              children: [
                SizedBox(
                  height: ScreenUtil().statusBarHeight,
                ),
                Center(
                  heightFactor: 2,
                  child: Text(
                    StringConstant.mine,
                    maxLines: 1,
                    style: TextStyle(fontSize: 17.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                GestureDetector(
                    onTap: () {
                      // 编辑用户资料
                      Navigator.of(context).pushNamed(RouteName.userInfoPage);
                    },
                    child: _userInfo()),
                _setting()
              ],
            ),
          ],
        ));
  }

  Widget _setting() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(14.w, 35.w, 14.w, 4.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
      child: Column(
        children: [
          _feed(),
          SizedBox(
            height: 15.w,
          ),
          Container(
            height: 1.w,
            decoration: const BoxDecoration(color: ColorConstant.dividerColor),
          ),
          SizedBox(
            height: 15.w,
          ),
          _set()
        ],
      ),
    );
  }

  Widget _set() {
    return GestureDetector(
        onTap: () {
          // 设置
          Navigator.of(context).pushNamed(RouteName.settingPage);
        },
        child: Row(
          children: [
            Image(
              image: const AssetImage(ImageConstant.imageSetting),
              width: 19.w,
              height: 19.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              StringConstant.setting,
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
            ),
            Expanded(
                child: Image(
              alignment: Alignment.centerRight,
              image: const AssetImage(ImageConstant.imageBackMine),
              width: 12.w,
              height: 12.w,
            ))
          ],
        ));
  }

  Widget _feed() {
    return GestureDetector(
        onTap: () {
          // 意见反馈
          Navigator.of(context).pushNamed(RouteName.advicePage);
        },
        child: Row(
          children: [
            Image(
              image: const AssetImage(ImageConstant.imageFeed),
              width: 19.w,
              height: 19.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              StringConstant.feed,
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333, fontWeight: FontWeight.w500),
            ),
            Expanded(
                child: Image(
              alignment: Alignment.centerRight,
              image: const AssetImage(ImageConstant.imageBackMine),
              width: 12.w,
              height: 12.w,
            ))
          ],
        ));
  }

  Widget _userInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
      margin: EdgeInsets.fromLTRB(14.w, 5.w, 14.w, 5.w),
      child: Row(
        children: [
          ClipOval(
              child: NetworkImageWidget(
            height: 60.w,
            width: 60.w,
            fit: BoxFit.cover,
            imageUrl: headUrl,
            defaultImage: ImageConstant.imageHeadDefault,
          )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                maxLines: 1,
                style: TextStyle(fontSize: 20.sp, color: ColorConstant.color333333, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.w,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10.w, 4.w, 10.w, 4.w),
                  decoration:
                      BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(20.w))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: ColorConstant.color3C94FD,
                        size: 10.w,
                      ),
                      Text(
                        userPhone,
                        style: TextStyle(fontSize: 12.sp, color: ColorConstant.color3C94FD),
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}