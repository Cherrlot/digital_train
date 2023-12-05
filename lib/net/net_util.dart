import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import 'interceptor/error_interceptor.dart';
import 'my_http_decoder.dart';
import 'url_cons.dart';

class NetDioUtil {
  static void initOptionWithToken(String token) {
    NetOptions.instance
        // header
        .addHeaders({"Authorization": token})
        // baseUrl
        .setBaseUrl(baseUrl)
        //  全局解析器
        .setHttpDecoder(MyHttpDecoder.getInstance())
        //  超时时间
        .setConnectTimeout(const Duration(milliseconds: 15000))
        .setReceiveTimeout(const Duration(milliseconds: 15000))
        .addInterceptor(InterceptorsWrapper(
          onError: (e, handler) {
            ErrorInterceptor.handleError(e);
            handler.next(e);
          },
        ))
        // 允许打印log，默认未 true
        .enableLogger(true)
        .create();
  }

  static void initOption() {
    NetOptions.instance
        // baseUrl
        .setBaseUrl(baseUrl)
        //  全局解析器
        .setHttpDecoder(MyHttpDecoder.getInstance())
        //  超时时间
        .setConnectTimeout(const Duration(milliseconds: 15000))
        .setReceiveTimeout(const Duration(milliseconds: 15000))
        .addInterceptor(InterceptorsWrapper(
          onError: (e, handler) {
            ErrorInterceptor.handleError(e);
            handler.next(e);
          },
        ))
        // 允许打印log，默认未 true
        .enableLogger(true)
        .create();
  }
}
