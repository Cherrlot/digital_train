import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import '../../model/user_info_entity.dart';
import '../../net/url_cons.dart';
import '../../util/constant.dart';
import '../../util/sp_util.dart';
import 'home_page.dart';
import '../mine/mine_page.dart';

/// 首页导航
class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomeNavigationPageState();
}

class _MyHomeNavigationPageState extends State<HomeNavigationPage> {
  int _bottomNavigationIndex = 0; //底部导航的索引

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_bottomNavigationIndex], //页面切换
        bottomNavigationBar: _bottomNavigationBar() //底部导航
        );
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    var appResponse =
    await get<UserInfoEntity, List<UserInfoEntity>?>(userInfo, decodeType: UserInfoEntity(), data: {"ID": 0});
    appResponse.when(success: (List<UserInfoEntity>? model) {
      var userInfo = model?[0];
      if(userInfo != null) {
        SpUtil.setString(Constants.headUrl, userInfo.headImage ?? '');
        SpUtil.setString(Constants.userName, userInfo.name ?? '');
        SpUtil.setString(Constants.userPhone, userInfo.phone ?? '');
        SpUtil.setString(Constants.nickName, userInfo.nickname ?? '');
      }
    }, failure: (String msg, int code) {
    });
  }

  //底部导航-样式
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: items(),
      //底部导航-图标和文字的定义，封装到函数里
      currentIndex: _bottomNavigationIndex,
      onTap: (flag) {
        setState(() {
          _bottomNavigationIndex = flag; //使用底部导航索引
        });
      },
      //onTap 点击切换页面
      fixedColor: Colors.blue,
      //样式：图标选中时的颜色：蓝色
      type: BottomNavigationBarType.fixed, //样式：选中图标后的样式是固定的
    );
  }
}

//底部导航页-切换页面
final pages = [
  const HomePage(), //首页
  const MinePage(), //我的
];

//底部导航-图标和文字定义
List<BottomNavigationBarItem> items() {
  return [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '我的',
    ),
  ];
}
