import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/machine_entity.dart';
import '../../util/string_constant.dart';

/// 课程详情
class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> with AutomaticKeepAliveClientMixin{
  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;
  BetterPlayerController? _betterPlayerController;
  /// 学习时长
  late DateTime _dateTime;

  /// 视频文件id
  late String _data;

  /// 视频地址
  // late String _url;
  String _url = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
  @override
  void initState() {
    // BetterPlayerConfiguration betterPlayerConfiguration =
    // BetterPlayerConfiguration(
    //     aspectRatio: 16 / 9,
    //     fit: BoxFit.contain,
    //     autoDetectFullscreenDeviceOrientation: true);
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network, _url);
    //     _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // _betterPlayerController?.setupDataSource(dataSource);

    super.initState();
    _dateTime = DateTime.now();
    _data = widget.params["param"];
    // setState(() {
    //   _url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    // });

    // _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(_url));
    // _videoPlayerController?.initialize();
    //
    // _chewieController = ChewieController(
    //   optionsTranslation: OptionsTranslation(playbackSpeedButtonText: StringConstant.playbackSpeed, cancelButtonText: StringConstant.cancel),
    //   videoPlayerController: _videoPlayerController!,
    //   autoInitialize: true,
    //   aspectRatio: 16 / 9,
    //   placeholder: const Center(
    //     child: SizedBox(
    //       height: 32,
    //       width: 32,
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    //   allowedScreenSleep: false,
    // );

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appBar(),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer.network(_url),
        // child: Chewie(controller: _chewieController!),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _videoPlayerController?.dispose();
  //   _chewieController?.dispose();
  // }

  // Widget _videoPlayer() {
  //   return Chewie(
  //       controller: ChewieController(
  //     aspectRatio: 16 / 9, //屏幕高宽比
  //     autoPlay: true, //是否自动播放
  //     looping: false, //是否循环播放
  //     videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(_url)),
  //   ));
  // }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.lessonDetail,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
