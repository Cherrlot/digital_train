import '../pages/ErrorPage/ErrorPage.dart';
import 'package:flutter/material.dart';
import 'routes_data.dart'; // 路由页面定义

Route? onGenerateRoute(RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routesData[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      return MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
    } else {
      return MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
    }
  } else {
    return MaterialPageRoute(
      builder: (BuildContext context) => ErrorPage(params: settings.arguments),
      settings: settings,
    );
  }
}
