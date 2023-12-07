import 'package:digital_train/pages/home/HomeNavigationPage.dart';
import 'package:digital_train/pages/LoginPage.dart';
import 'package:digital_train/pages/home/home_page.dart';
import 'package:digital_train/pages/message/message_page.dart';
import 'package:digital_train/pages/mine_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/SplashPage.dart';
import '../pages/home/banner_detail.dart';
import '../pages/knowledge/knowledge_detail.dart';
import '../pages/knowledge/knowledge_page.dart';
import '../pages/lesson/lesson_page.dart';
import '../pages/map/study_map.dart';
import '../pages/message/message_detail.dart';
import '../pages/pk/pk_detail.dart';
import '../pages/pk/pk_page.dart';
import '../pages/rank_page.dart';
import '../pages/test/test_page.dart';
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
  RouteName.messageDetailPage: (BuildContext context, {params}) => MessageDetailPage(params: params),
  RouteName.knowledgePage: (BuildContext context, {params}) => const KnowledgePage(),
  RouteName.knowledgeDetailPage: (BuildContext context, {params}) =>  KnowledgeDetailPage(params: params),
  RouteName.pkDetailPage: (BuildContext context, {params}) =>  PkDetailPage(params: params),
  RouteName.bannerPage: (BuildContext context, {params}) =>  BannerDetailPage(params: params),
  RouteName.pkPage: (BuildContext context, {params}) =>  const PkPage(),
  RouteName.rankPage: (BuildContext context, {params}) =>  const RankPage(),
  RouteName.lessonPage: (BuildContext context, {params}) =>  const LessonPage(),
  RouteName.testPage: (BuildContext context, {params}) =>  const TestPage(),
  RouteName.studyMapPage: (BuildContext context, {params}) =>  const StudyMapPage(),
};
