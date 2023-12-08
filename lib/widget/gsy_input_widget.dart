import 'package:flutter/material.dart';

/// 带图标的输入框
class GSYInputWidget extends StatefulWidget {
  final bool obscureText;

  final TextInputAction? textInputAction;

  final String? hintText;

  final IconData? iconData;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final TextStyle? textStyle;

  final TextInputType? keyboardType;

  final TextEditingController? controller;
  final TextAlign textAlign;

  GSYInputWidget(
      {Key? super.key,
        this.hintText,
        this.iconData,
        this.onChanged,
        this.textStyle,
        this.controller,
        this.textInputAction,
        this.onSubmitted,
        this.obscureText = false, this.textAlign  = TextAlign.start, this.keyboardType});

  @override
  _GSYInputWidgetState createState() => new _GSYInputWidgetState();
}

/// State for [GSYInputWidget] widgets.
class _GSYInputWidgetState extends State<GSYInputWidget> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        textAlign: widget.textAlign,
        keyboardType: widget.keyboardType,
        maxLines: null,
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          icon: widget.iconData == null ? null : new Icon(widget.iconData),
        ),
        magnifierConfiguration: TextMagnifierConfiguration(magnifierBuilder: (
            BuildContext context,
            MagnifierController controller,
            ValueNotifier<MagnifierInfo> magnifierInfo,
            ) {
          return null;
        }));
  }
}