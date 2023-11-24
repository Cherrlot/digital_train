import 'package:flutter/material.dart';

class Util {
  static void showSnackBar(BuildContext context, String message, {int time = 1000}) {
    SnackBar snackBar = SnackBar(content: Text(message), duration: Duration(milliseconds: time));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}