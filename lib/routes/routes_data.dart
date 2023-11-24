import 'package:digital_train/pages/HomePage.dart';
import 'package:digital_train/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';

import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/SplashPage.dart';
import 'route_name.dart';

const String initialRoute = RouteName.splashPage; // 初始默认显示的路由
final Map<String, WidgetBuilder> routesData = {
  RouteName.splashPage: (BuildContext context, {params}) => const SplashPage(),

  RouteName.error: (BuildContext context, {params}) =>
      ErrorPage(params: params),

  RouteName.homePage: (BuildContext context, {params}) => const HomePage(),
  RouteName.loginPage: (BuildContext context, {params}) => const LoginPage(),
};
