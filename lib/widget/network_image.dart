import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../util/image_constant.dart';
import '../util/image_util.dart';

/// 定制CachedNetworkImage
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? defaultImage;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const NetworkImageWidget({super.key, required this.imageUrl, this.width, this.height, this.fit, this.defaultImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager.instance,
      imageUrl: ImageUtil.getNetImageUrl(imageUrl),
      placeholder: (context, url) => _defaultImage(),
      errorWidget: (context, url, error) => _defaultImage(),
      width: width,
      height: height,
      fit: fit,
    );
  }

  Widget _defaultImage() {
    return Image(image: AssetImage(_getDefaultImage()), fit: fit);
  }

  _getDefaultImage() {
    if(defaultImage == null || defaultImage!.isEmpty) {
      return ImageConstant.imageDefault;
    } else {
      return defaultImage!;
    }
  }
}

/// 自定义缓存策略
class CustomCacheManager {
  static const key = 'image_cache_key';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );
}