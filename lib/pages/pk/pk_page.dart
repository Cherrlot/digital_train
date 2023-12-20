import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/pk_list_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/string_constant.dart';

/// pk
class PkPage extends StatefulWidget {
  const PkPage({super.key});

  @override
  State<StatefulWidget> createState() => _PkPageState();
}

class _PkPageState extends State<PkPage> {
  final List<PkListEntity> _pkList = [];

  @override
  void initState() {
    super.initState();
    _getPk(true);
  }

  _getPk(bool showLoading) async {
    CancelFunc? cancel;
    if(showLoading) {
      cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    }
    _pkList.clear();
    var appResponse = await get<PkListEntity, List<PkListEntity>?>(pkList,
        decodeType: PkListEntity(),queryParameters: {"search": "category"});
    appResponse.when(success: (List<PkListEntity>? model) {
      setState(() {
        _pkList.addAll(model?? []);
      });
      if(showLoading) {
        cancel!();
      }
    }, failure: (String msg, int code) {
      if(showLoading) {
        cancel!();
      }
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
                  itemCount: _pkList.length,
                  itemBuilder: (context, index) {
                    return _itemView(index);
                  }))),
    );
  }

  Future<void> _refresh() async {
    _getPk(false);
  }

  Widget _itemView(index) {
    var data = _pkList[index];
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // pk排行
          Navigator.of(context).pushNamed(RouteName.pkDetailPage, arguments: {"param": data.category});
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
          margin: EdgeInsets.fromLTRB(14.w, 5.w, 14.w, 5.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Text(
            textAlign: TextAlign.left,
            data.category,
            style: TextStyle(fontSize: 16.sp, color: ColorConstant.mainTextColor),
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
        StringConstant.pkDetail,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
