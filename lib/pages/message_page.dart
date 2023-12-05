import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/machine_entity.dart';
import '../net/url_cons.dart';
import '../util/color_constant.dart';
import '../util/image_constant.dart';
import '../util/string_constant.dart';

/// 消息列表
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MachineEntity> model = [];

  @override
  void initState() {
    super.initState();
    _getMessage();
  }

  _getMessage() async {
    var appResponse = await get<MachineEntity, List<MachineEntity>>(serviceUrl['machines']!,
        decodeType: MachineEntity(), queryParameters: {"orderby": "no"});
    appResponse.when(success: (List<MachineEntity> model) {
      setState(() {
        this.model.addAll(model);
      });
    }, failure: (String msg, int code) {
      debugPrint("$msg, code: $code");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
              decoration: const BoxDecoration(color: ColorConstant.backColor),
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.length,
                  itemBuilder: (context, index) {
                    return _itemView(index);
                  }))),
    );
  }

  Future<void> _refresh() async {
    _getMessage();
  }

  Widget _itemView(index) {
    var data = model[index];
    return GestureDetector(
        onTap: () {
          // 消息详情
          BotToast.showText(text: '打开消息详情 ${data.category}');
        },
        child: Container(
          padding: EdgeInsets.all(5.w),
          margin: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 5.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: Row(
            children: [
              Image(
                image: const AssetImage(ImageConstant.imageMap),
                width: 50.w,
                height: 50.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    data.category,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.sp, color: ColorConstant.mainTextColor),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    data.cdate,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14.sp, color: ColorConstant.color999999),
                  ),
                ],
              ))
            ],
          ),
        ));
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
