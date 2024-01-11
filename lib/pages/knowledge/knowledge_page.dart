import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/knowledge_entity.dart';
import '../../net/url_cons.dart';
import '../../routes/route_name.dart';
import '../../util/color_constant.dart';
import '../../util/image_constant.dart';
import '../../util/string_constant.dart';

/// 知识库
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final List<KnowledgeArticles> _knowledgeList = [];
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _getKnowledge(true);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  _getKnowledge(bool showLoading) async {
    _knowledgeList.clear();
    var search = searchController.value.text;
    CancelFunc? cancel;
    if(showLoading) {
      cancel = BotToast.showLoading(backButtonBehavior: BackButtonBehavior.close);
    }
    var appResponse = await get<KnowledgeArticles, List<KnowledgeArticles>?>(knowledgeList,
        decodeType: KnowledgeArticles(), queryParameters: {"tags": search});
    appResponse.when(success: (List<KnowledgeArticles>? model) {
      if(model != null && model.isNotEmpty) {
        // var data = model[0];
        _knowledgeList.addAll(model);
      }
      setState(() {
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
            child: Column(children: [
              Container(
                  margin: EdgeInsets.all(14.w),
                  padding: EdgeInsets.all(4.w),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: ColorConstant.white, borderRadius: BorderRadius.all(Radius.circular(15.w))),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: StringConstant.search,
                      icon: Icon(ImageConstant.ICON_SEARCH),
                    ),
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _getKnowledge(true),
                    style: TextStyle(fontSize: 14.sp, color: ColorConstant.color999999),
                  )),
              Expanded(
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _knowledgeList.length,
                      itemBuilder: (context, index) {
                        return _itemView(index);
                      })),
            ])),
      ),
    );
  }

  Future<void> _refresh() async {
    _getKnowledge(false);
  }

  Widget _itemView(index) {
    var data = _knowledgeList[index];
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 知识详情
          Navigator.of(context).pushNamed(RouteName.knowledgeDetailPage, arguments: {"param": data});
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
          margin: EdgeInsets.fromLTRB(14.w, 5.w, 14.w, 5.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, color: ColorConstant.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7.w,
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    data.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, color: ColorConstant.color666666),
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
        StringConstant.knowledge,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
