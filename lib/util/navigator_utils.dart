import 'package:flutter/material.dart';

import '../widget/never_overscroll_indicator.dart';

class NavigatorUtils {

  ///弹出 dialog
  static Future<T?> showGSYDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder? builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

            ///不受系统字体缩放影响
              data: MediaQueryData.fromView(
                  WidgetsBinding.instance.platformDispatcher.views.first)
                  .copyWith(),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: SafeArea(child: builder!(context)),
              ));
        });
  }
}