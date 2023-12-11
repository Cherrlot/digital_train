import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import '../../pages/LoginPage.dart';
import '../../routes/navigate_provider.dart';

class ErrorInterceptor {
  static handleError(DioException e) {
    var errorCode = e.response?.statusCode ?? -1;
    var errorData = e.response?.data;
    var error = e.error;
    String? errorMsg = "";
    try {
      if(e.type == DioExceptionType.unknown) {
        errorMsg = error.toString();
      } else {
        var errorJson = jsonDecode(errorData);
        errorMsg = errorJson['message'];
      }
    } catch(e) {
      errorMsg = errorData?.toString();
    }
    BotToast.showText(text:"$errorMsg errorCode: $errorCode");

    switch(errorCode) {
      case 401 : {
        // 跳转登录
        NavigatorState? navigatorState = NavigatorProvider.navigatorKey.currentState;
        if (navigatorState != null) {
          navigatorState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => route == false);
        }
        break;
      }
    }
  }
}
