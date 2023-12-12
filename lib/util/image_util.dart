import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import '../net/url_cons.dart';
import 'color_constant.dart';
import 'format_util.dart';

class ImageUtil {
  ///裁切图片
  ///[image] 图片路径或文件
  ///[width] 宽度
  ///[height] 高度
  ///[aspectRatio] 比例
  ///[androidUiSettings]UI 参数
  ///[iOSUiSettings] ios的ui 参数
  static Future<CroppedFile?> cropImage(
      {required image,
      int? width,
      int? height,
      CropAspectRatio? aspectRatio,
      List<CropAspectRatioPreset> aspectRatioPresets = const [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      CropStyle cropStyle = CropStyle.rectangle,
      androidUiSettings,
      iOSUiSettings}) async {
    String imagePth = "";
    if (image is String) {
      imagePth = image;
    } else if (image is File) {
      imagePth = image.path;
    } else {
      throw ("文件路径错误");
    }
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePth,
      maxWidth: width == null ? null : FormatUtil.num2int(width),
      maxHeight: height == null ? null : FormatUtil.num2int(height),
      aspectRatio: aspectRatio,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatioPresets: aspectRatioPresets,
      cropStyle: cropStyle,
      uiSettings: [
        androidUiSettings ??
            AndroidUiSettings(
                toolbarTitle: '图片裁切',
                toolbarColor: ColorConstant.color3C94FD,
                toolbarWidgetColor: ColorConstant.white,
                initAspectRatio: CropAspectRatioPreset.original,
                hideBottomControls: false,
                lockAspectRatio: true),
        iOSUiSettings ??
            IOSUiSettings(
              title: '图片裁切',
            ),
      ],
    );
    return croppedFile;
  }

  /// 获取网络图片地址
  static String getNetImageUrl(String? imagePath) {
    if(imagePath == null || !imagePath.contains('.')) {
      return '';
    }
    if(imagePath.contains('http')) {
      return imagePath;
    }
    return '$baseUrl$basePort$imagePath';
  }
}
