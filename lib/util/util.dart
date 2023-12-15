import 'package:flutter/material.dart';

class Util {
  static void showSnackBar(BuildContext context, String message, {int time = 1000}) {
    SnackBar snackBar = SnackBar(content: Text(message), duration: Duration(milliseconds: time));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// 插入排序
  static List insert(List l) {
    for (var i = 1; i < l.length; i++) {
      int insertVal = l[i];
      int insertIndex = i - 1;
      while (insertIndex >= 0 && insertVal < l[insertIndex]) {
        l[insertIndex + 1] = l[insertIndex];
        insertIndex--;
      }
      l[insertIndex + 1] = insertVal;
    }
    return l;
  }
}