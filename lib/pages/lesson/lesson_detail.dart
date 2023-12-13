import 'package:better_player/better_player.dart';
import 'package:digital_train/util/image_util.dart';
import 'package:flutter/material.dart';

import '../../model/lesson_entity.dart';

/// 课程详情
class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> with AutomaticKeepAliveClientMixin{
  /// 学习时长
  late DateTime _dateTime;

  /// 课程详情
  late LessonEntity _data;

  late String _title;

  /// 视频地址
  late String _url;
  // String _url = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _data = widget.params["param"];
    setState(() {
      _title = _data.title;
      _url = ImageUtil.getNetImageUrl(_data.vedio);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appBar(),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer.network(_url),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        _title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
