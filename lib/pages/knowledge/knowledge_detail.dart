import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/machine_entity.dart';
import '../../net/url_cons.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';
import '../../widget/gsy_input_widget.dart';

/// 知识库详情
class KnowledgeDetailPage extends StatefulWidget {
  const KnowledgeDetailPage({key, this.params}) : super(key: key);
  final params;

  @override
  State<StatefulWidget> createState() => _KnowledgeDetailPageState();
}

class _KnowledgeDetailPageState extends State<KnowledgeDetailPage> {
  late MachineEntity _data;

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
                _data.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, color: ColorConstant.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 22.w,),
              Text(
                textAlign: TextAlign.start,
                _data.category + _data.category + _data.category,
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
        StringConstant.knowledge,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
