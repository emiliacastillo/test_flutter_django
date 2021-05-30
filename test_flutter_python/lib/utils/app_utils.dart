import 'package:flutter/cupertino.dart';

class AppUtils {

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

  static String trunkString(String value, int maxSize, int trunkSize) =>
      value.length < maxSize ? value : '${value.substring(0, trunkSize)}...';
}
