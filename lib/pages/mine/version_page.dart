import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/version_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/string_constant.dart';
import '../../util/util.dart';

/// 版本信息
class VersionPage extends StatefulWidget {
  const VersionPage({super.key});

  @override
  State<StatefulWidget> createState() => _VersionPageState();
}

class _VersionPageState extends State<VersionPage> {
  late String version;
  String? url;
  String? content;
  bool hasNew = false;
  String? progress = '';
  StateSetter? aState;

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  void _checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
    });

    var appResponse = await get<VersionEntity, List<VersionEntity>?>(versionCheck,
        decodeType: VersionEntity(), queryParameters: {"key": 'app.version'});
    appResponse.when(success: (List<VersionEntity>? model) {
      var data = model?[0];
      if (data != null) {
        var values = data.values;
        var netVersion = values.version;
        setState(() {
          url = values.url;
          content = values.update;
          if (Util.haveNewVersion(netVersion, version)) {
            // 有新版本
            hasNew = true;
          }
        });
      }
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: const BoxDecoration(color: ColorConstant.backColor),
          child: Column(children: [
            Text(
              StringConstant.nowVersion,
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color666666),
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              version,
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.color333333),
            ),
            SizedBox(
              height: 24.w,
            ),
            Text(
              content ?? '',
              style: TextStyle(fontSize: 16.sp, color: ColorConstant.color333333),
            ),
            SizedBox(
              height: 56.w,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: _button(),
            ))
          ]),
        ));
  }

  Widget _button() {
    return IgnorePointer(
        ignoring: hasNew ? false : true,
        child: ElevatedButton(
          onPressed: () {
            // 版本更新
            _updateDialog(content, url);
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.w)),
              backgroundColor: MaterialStateProperty.all(hasNew ? ColorConstant.color3C94FD : ColorConstant.dividerColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.w),
              ))),
          child: Text(
            hasNew ? StringConstant.updateNow : StringConstant.versionLatest,
            style: TextStyle(fontSize: 18.sp, color: hasNew ? ColorConstant.white : ColorConstant.mainTextColor),
          ),
        ));
  }

  _updateDialog(String? content, String? downloadUrl) {
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
            _update(downloadUrl ?? '');
          },
          text: StringConstant.startUpdate,
          color: ColorConstant.color3C94FD,
          textStyle: const TextStyle(color: ColorConstant.white),
        ),
        IconsOutlineButton(
          onPressed: () {
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

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.versionInfo,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
