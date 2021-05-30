import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';

class TXButton extends StatelessWidget {
  const TXButton({
    this.text = '',
    @required this.onPressed,
    this.color = AppColor.gray,
    this.borderSideColor = AppColor.blue,
    this.fontWeight = FontWeight.normal,
    this.borderRadius = 10,
    this.backgroundColor = AppColor.blue,
  });

  final GestureTapCallback onPressed;
  final String text;
  final Color color;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final Color borderSideColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: onPressed,
        disabledColor: AppColor.gray_bar,
        child: TXText(
          text.toUpperCase(),
          fontWeight: fontWeight,
          color: color,
        ),
        elevation: 0,
        padding: EdgeInsets.only(top: 14, bottom: 14),
        color: backgroundColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
              style: BorderStyle.solid, width: 0, color: borderSideColor),
        ),
      ),
    );
  }
}
