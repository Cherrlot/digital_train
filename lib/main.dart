import 'package:digital_train/routes/navigate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routes/on_generate_route.dart';
import 'routes/routes_data.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 929),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(), //1.调用BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).apply(
                bodyColor: Colors.black,
              ),
            ),
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
            navigatorKey: NavigatorProvider.navigatorKey,
          );
        });
  }
}
