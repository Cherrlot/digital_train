import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 错误页面
class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key, this.params, this.title = "Error", this.errorText = "错误：未定义的路由"})
      : super(key: key);
  final params;

  /// 页面标题
  final String title;

  /// 页面内容
  final String errorText;

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(Icons.error, color: Colors.red, size: 66.w),
            ),
            SelectableText(
              widget.errorText,
              style: TextStyle(fontSize: 22.sp),
            ),
          ],
        ),
      ),
    );
  }
}
