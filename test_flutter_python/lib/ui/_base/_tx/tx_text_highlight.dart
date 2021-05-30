import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/widgets.dart';

class TXTextHighlight extends StatelessWidget {
  final String text;
  final String query;
  final Color markedColor;
  final Color noMarkedColor;
  final double fontSize;

  TXTextHighlight({
    this.text,
    this.query,
    this.noMarkedColor = AppColor.text_color,
    this.markedColor = AppColor.red,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: _getSpanChildren()),
    );
  }

  List<TextSpan> _getSpanChildren() {
    int index = -1;
    List<TextSpan> list = [];
    String aux;
    if (query != null) {
      aux = query.replaceAll('+', '');
      index = text.trim().indexOf(RegExp(aux.trim(), caseSensitive: false));
    }

    if (index < 0) {
      final firstSpan = TextSpan(text: text, style: _getNoMarkedStyle());
      list.add(firstSpan);
    } else {
      final realIndex = index >= 0 ? index : 0;
      final realQueryLength =
          realIndex + aux.length <= text.length ? realIndex + aux.length : 0;

      final prevPart = text.substring(0, realIndex);
      final markedPart = text.substring(realIndex, realQueryLength);
      final nextPart = text.substring(realQueryLength, text.length);

      final firstSpan = TextSpan(text: prevPart, style: _getNoMarkedStyle());
      final markedSpan = TextSpan(text: markedPart, style: _getMarkedStyle());
      final lastSpan = TextSpan(text: nextPart, style: _getNoMarkedStyle());
      list.add(firstSpan);
      list.add(markedSpan);
      list.add(lastSpan);
    }

    return list;
  }

  TextStyle _getMarkedStyle() {
    return TextStyle(
      color: markedColor,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle _getNoMarkedStyle() {
    return TextStyle(
      color: noMarkedColor,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
    );
  }
}
