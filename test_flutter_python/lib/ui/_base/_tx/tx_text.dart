import 'package:flutter/material.dart';

class TXText extends StatelessWidget {
  const TXText(
    this.text, {
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.textOverFlow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.letterCount,
    this.maxLines,
    this.color,
  });

  final String text;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double fontSize;
  final textOverFlow;
  final letterSpacing;
  final letterCount;
  final maxLines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      _resolveText(text ?? '', letterCount),
      overflow: textOverFlow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        color: color,
      ),
    );
  }

  String _resolveText(String text, int letterCount) {
    String resultText = text;
    if (letterCount != null && letterCount > 1 && text.length > letterCount) {
      resultText = "${text.substring(0, letterCount - 1)}...";
    }
    return resultText;
  }
}
