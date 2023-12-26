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

  static bool haveNewVersion(String? newVersion, String? old) {
    if (newVersion == null || newVersion.isEmpty || old == null || old.isEmpty) {
      return false;
    }
    int newVersionInt, oldVersion;
    var newList = newVersion.split('.');
    var oldList = old.split('.');
    if (newList.isEmpty || oldList.isEmpty) {
      return false;
    }
    for (int i = 0; i < newList.length; i++) {
      newVersionInt = int.parse(newList[i]);
      oldVersion = int.parse(oldList[i]);
      if (newVersionInt > oldVersion) {
        return true;
      } else if (newVersionInt < oldVersion) {
        return false;
      }
    }

    return false;
  }
}