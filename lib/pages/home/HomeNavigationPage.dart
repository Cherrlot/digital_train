import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:digital_train/util/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../model/lesson_entity.dart';
import '../../model/user_info_entity.dart';
import '../../model/version_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/constant.dart';
import '../../util/sp_util.dart';
import '../../util/util.dart';
import 'home_page.dart';
import '../mine/mine_page.dart';

/// 首页导航
class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomeNavigationPageState();
}

class _MyHomeNavigationPageState extends State<HomeNavigationPage> {
  DateTime? _dateTime;
  int _bottomNavigationIndex = 0; //底部导航的索引
  late StreamSubscription<LessonEntity> _sub;

  String? progress = '';
  StateSetter? aState;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_dateTime == null || DateTime.now().difference(_dateTime!) > const Duration(seconds: 2)) {
            BotToast.showText(text: StringConstant.exit);
            _dateTime = DateTime.now();
          } else {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: Scaffold(
            body: pages[_bottomNavigationIndex], //页面切换
            bottomNavigationBar: _bottomNavigationBar() //底部导航
            ));
  }

  @override
  void initState() {
    super.initState();
    //检查更新
    _checkUpdate();

    _getUserInfo();
    _sub = eventBus.on<LessonEntity>().listen((event) {
      _updateStudyTime(event);
    });
  }

  void _checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    var appResponse = await get<VersionEntity, List<VersionEntity>?>(versionCheck,
        decodeType: VersionEntity(), queryParameters: {"key": 'app.version'});
    appResponse.when(success: (List<VersionEntity>? model) {
      var data = model?[0];
      if (data != null) {
        var values = data.values;
        var netVersion = values.version;
        // 上次检查更新跳过的版本号
        var skipVersion = SpUtil.getString(Constants.skipVersion);
        setState(() {
          if (Util.haveNewVersion(netVersion, version) && skipVersion != netVersion) {
            _updateDialog(values.update, values.url, netVersion);
          }
        });
      }
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  _updateDialog(String content, String downloadUrl, String version) {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.updateApp,
      msg: content,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // 更新软件
            Navigator.of(context).pop();
            _downloadDialog();
            _update(downloadUrl);
          },
          text: StringConstant.startUpdate,
          color: ColorConstant.color3C94FD,
          textStyle: const TextStyle(color: ColorConstant.white),
        ),
        IconsOutlineButton(
          onPressed: () {
            // 取消, 跳过当前版本更新
            SpUtil.setString(Constants.skipVersion, version);
            Navigator.of(context).pop();
          },
          text: StringConstant.cancel,
          textStyle: const TextStyle(color: ColorConstant.color333333),
        ),
      ],
    );
  }

  _downloadDialog() {
    Dialogs.materialDialog(
      context: context,
      title: StringConstant.updateApp,
      actions: [
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            aState = setState;
            return Text(
              '${StringConstant.downloading} $progress %',
              style: const TextStyle(color: ColorConstant.color333333),
            );
          },
        ),
      ],
    );
  }

  _update(String downloadUrl) async {
    if (Platform.isIOS) {
      String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      try {
        OtaUpdate().execute(downloadUrl).listen((event) {
          switch (event.status) {
            case OtaStatus.DOWNLOADING: // 下载中
              if (aState != null) {
                aState!(() {
                  progress = event.value;
                });
              }
              break;
            case OtaStatus.INSTALLING: //安装中
              Navigator.of(context).pop();
              break;
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
              BotToast.showText(text: StringConstant.updatePermission);
              _requestPermission();
              break;
            default: // 其他问题
              Navigator.of(context).pop();
              break;
          }
        });
      } catch (e) {
        debugPrint('更新失败，请稍后再试');
      }
    }
  }

  _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        // 权限拒绝
        Permission.storage.request();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  _updateStudyTime(LessonEntity data) async {
    await post<VersionEntity, VersionEntity?>(studyTime,
        decodeType: VersionEntity(), data: {"courseId": data.iD, "duration": data.duration});
  }

  _getUserInfo() async {
    var appResponse =
        await get<UserInfoEntity, List<UserInfoEntity>?>(userInfo, decodeType: UserInfoEntity(), data: {"ID": 0});
    appResponse.when(
        success: (List<UserInfoEntity>? model) {
          var userInfo = model?[0];
          if (userInfo != null) {
            SpUtil.setString(Constants.headUrl, userInfo.headImage ?? '');
            SpUtil.setString(Constants.userName, userInfo.name ?? '');
            SpUtil.setString(Constants.userPhone, userInfo.phone ?? '');
            SpUtil.setString(Constants.nickName, userInfo.nickname ?? '');
          }
        },
        failure: (String msg, int code) {});
  }

  //底部导航-样式
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: items(),
      //底部导航-图标和文字的定义，封装到函数里
      currentIndex: _bottomNavigationIndex,
      onTap: (flag) {
        setState(() {
          _bottomNavigationIndex = flag; //使用底部导航索引
        });
      },
      //onTap 点击切换页面
      fixedColor: Colors.blue,
      //样式：图标选中时的颜色：蓝色
      type: BottomNavigationBarType.fixed, //样式：选中图标后的样式是固定的
    );
  }
}

//底部导航页-切换页面
final pages = [
  const HomePage(), //首页
  const MinePage(), //我的
];

//底部导航-图标和文字定义
List<BottomNavigationBarItem> items() {
  return [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '我的',
    ),
  ];
}
