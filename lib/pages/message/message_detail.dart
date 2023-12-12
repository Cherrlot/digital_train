import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/message_entity.dart';
import '../../util/color_constant.dart';
import '../../util/string_constant.dart';

/// 消息详情
class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  late MessageEntity _data;

  @override
  void initState() {
    super.initState();
    _data = widget.params["param"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30.w),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                _data.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, color: ColorConstant.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 22.w,),
              Text(
                textAlign: TextAlign.start,
                _data.content ?? '',
                style: TextStyle(fontSize: 12.sp, color: ColorConstant.color666666),
              ),
            ],
          )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        StringConstant.message,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
