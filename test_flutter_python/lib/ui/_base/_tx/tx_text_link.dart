import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';

class TXTextLink extends StatelessWidget {
  final VoidCallback action;
  final String title;
  final Color splashColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  const TXTextLink({
    @required this.action,
    @required this.title,
    this.splashColor,
    this.fontWeight = FontWeight.normal,
    this.textColor = AppColor.blue,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Text(
        title,
        style: TextStyle(
            color: textColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
      splashColor: splashColor,
    );
  }
}
