import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_train/util/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/gsy_flex_button.dart';
import '../widget/issue_edit_dIalog.dart';
import 'color_constant.dart';
import 'navigator_utils.dart';

/**
 * 通用逻辑
 */

typedef StringList = List<String>;

class CommonUtils {
  static const double MILLIS_LIMIT = 1000.0;

  static const double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static const double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static const double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static const double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale? curLocale;

  static String getDateStr(DateTime? date) {
    if (date == null || date.toString() == "") {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTimes = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    return switch (subTimes) {
      < MILLIS_LIMIT => (curLocale != null)
          ? (curLocale!.languageCode != "zh")
              ? "right now"
              : "刚刚"
          : "刚刚",
      < SECONDS_LIMIT => (subTimes / MILLIS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale!.languageCode != "zh")
                  ? " seconds ago"
                  : " 秒前"
              : " 秒前"),
      < MINUTES_LIMIT => (subTimes / SECONDS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale!.languageCode != "zh")
                  ? " min ago"
                  : " 分钟前"
              : " 分钟前"),
      < HOURS_LIMIT => (subTimes / MINUTES_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale!.languageCode != "zh")
                  ? " hours ago"
                  : " 小时前"
              : " 小时前"),
      < DAYS_LIMIT => (subTimes / HOURS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale!.languageCode != "zh")
                  ? " days ago"
                  : " 天前"
              : " 天前"),
      _ => getDateStr(date)
    };
  }

  static getLocalPath() async {
    Directory? appDir;
    if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      appDir = await getExternalStorageDirectory();
    }

    var status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      if (statuses[Permission.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    String appDocPath = "${appDir!.path}/gsygithubappflutter";
    Directory appPath = Directory(appDocPath);
    await appPath.create(recursive: true);
    return appPath;
  }

  static getApplicationDocumentsPath() async {
    Directory appDir;
    if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      appDir = await getApplicationSupportDirectory();
    }
    String appDocPath = "${appDir.path}/gsygithubappflutter";
    Directory appPath = Directory(appDocPath);
    await appPath.create(recursive: true);
    return appPath.path;
  }

  static String? removeTextTag(String? description) {
    if (description != null) {
      String reg = "<g-emoji.*?>.+?</g-emoji>";
      RegExp tag = RegExp(reg);
      Iterable<Match> tags = tag.allMatches(description);
      for (Match m in tags) {
        String match = m.group(0)!.replaceAll(RegExp("<g-emoji.*?>"), "").replaceAll(RegExp("</g-emoji>"), "");
        description = description!.replaceAll(new RegExp(m.group(0)!), match);
      }
    }
    return description;
  }

  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  static getFullName(String? repository_url) {
    if (repository_url != null && repository_url.substring(repository_url.length - 1) == "/") {
      repository_url = repository_url.substring(0, repository_url.length - 1);
    }
    String fullName = '';
    if (repository_url != null) {
      StringList splicurl = repository_url.split("/");
      if (splicurl.length > 2) {
        fullName = splicurl[splicurl.length - 2] + "/" + splicurl[splicurl.length - 1];
      }
    }
    return fullName;
  }

  ///获取设备信息
  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return "";
    }
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.model;
  }

  static const IMAGE_END = [".png", ".jpg", ".jpeg", ".gif", ".svg"];

  static isImageEnd(path) {
    bool image = false;
    for (String item in IMAGE_END) {
      if (path.indexOf(item) + item.length == path.length) {
        image = true;
      }
    }
    return image;
  }

  static copy(String? data, BuildContext context) {
    if (data != null) {
      Clipboard.setData(ClipboardData(text: data));
      BotToast.showText(text: '复制成功');
    }
  }

  static launchOutURL(String? url, BuildContext context) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      BotToast.showText(text: '打开网址失败: ${url ?? ""}');
    }
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              color: Colors.transparent,
              child: PopScope(
                canPop: false,
                child: Center(
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(child: const SpinKitCubeGrid(color: ColorConstant.white)),
                        Container(height: 10.w),
                        Container(
                            child: Text(StringConstant.loadingText,
                                style: TextStyle(color: ColorConstant.white, fontSize: 14.sp))),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static Future<Null> showEditDialog(
    BuildContext context,
    String dialogTitle,
    ValueChanged<String>? onTitleChanged,
    ValueChanged<String> onContentChanged,
    VoidCallback onPressed, {
    TextEditingController? titleController,
    TextEditingController? valueController,
    bool needTitle = true,
  }) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new IssueEditDialog(
              dialogTitle,
              onTitleChanged,
              onContentChanged,
              onPressed,
              titleController: titleController,
              valueController: valueController,
              needTitle: needTitle,
            ),
          );
        });
  }

  ///列表item dialog
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String?>? commitMaps,
    ValueChanged<int> onTap, {
    width = 250.0,
    height = 400.0,
    List<Color>? colorList,
  }) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: ColorConstant.white,
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GSYFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null ? colorList[index] : Theme.of(context).primaryColor,
                      text: commitMaps![index],
                      textColor: ColorConstant.white,
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }

  ///版本更新
  static Future<Null> showUpdateDialog(BuildContext context, String contentMsg, String updateUrl) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(StringConstant.app_version_title),
            content: new Text(contentMsg),
            actions: <Widget>[
              new TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(StringConstant.app_cancel)),
              new TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(updateUrl));
                    Navigator.pop(context);
                  },
                  child: new Text(StringConstant.app_ok)),
            ],
          );
        });
  }
}
