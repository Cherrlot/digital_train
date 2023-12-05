import 'package:digital_train/pages/HomeNavigationPage.dart';
import 'package:digital_train/pages/LoginPage.dart';
import 'package:digital_train/pages/home_page.dart';
import 'package:digital_train/pages/message_page.dart';
import 'package:digital_train/pages/mine_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/SplashPage.dart';
import 'route_name.dart';

const String initialRoute = RouteName.splashPage; // 初始默认显示的路由
final Map<String, WidgetBuilder> routesData = {
  RouteName.splashPage: (BuildContext context, {params}) => const SplashPage(),

  RouteName.error: (BuildContext context, {params}) =>
      ErrorPage(params: params),

  RouteName.homeNavigatePage: (BuildContext context, {params}) => const HomeNavigationPage(),
  RouteName.loginPage: (BuildContext context, {params}) => const LoginPage(),
  RouteName.homePage: (BuildContext context, {params}) => const HomePage(),
  RouteName.minePage: (BuildContext context, {params}) => const MinePage(),
  RouteName.messagePage: (BuildContext context, {params}) => const MessagePage(),
};
