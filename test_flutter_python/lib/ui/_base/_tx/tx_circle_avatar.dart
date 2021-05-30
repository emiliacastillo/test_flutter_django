import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TxCircleAvatar extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final Map<String, AlignmentGeometry> gradientAlignment;
  final double radius;
  final double fontSize;

  TxCircleAvatar({
    @required this.text,
    @required this.colors,
    @required this.gradientAlignment,
    this.radius = 20,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: gradientAlignment['begin'],
          end: gradientAlignment['end'],
        ),
      ),
      child: CircleAvatar(
        child: text.isNotEmpty
            ? Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize),
              )
            : Icon(
                CupertinoIcons.number,
                size: 22,
                color: Colors.white,
              ),
        radius: radius,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class TxCircleAvatarParamsProvider {
  static final Random _random = new Random();

  static final _alignments = [
    {
      'begin': Alignment.bottomLeft,
      'end': Alignment.topRight,
    },
    {
      'begin': Alignment.topLeft,
      'end': Alignment.bottomRight,
    },
    {
      'begin': Alignment.bottomRight,
      'end': Alignment.topLeft,
    },
    {
      'begin': Alignment.topRight,
      'end': Alignment.bottomLeft,
    }
  ];

  static Map<String, AlignmentGeometry> getGradientAlignment() {
    int randomIndex = _random.nextInt(_alignments.length);
    return _alignments[randomIndex];
  }
}
