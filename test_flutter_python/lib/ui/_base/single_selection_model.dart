import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';

class SingleSelectionModel {
  String key;
  String value;
  bool cancelAction;
  Color textColor;

  SingleSelectionModel(
      {this.key = '',
      this.value = '',
      this.cancelAction = false,
      this.textColor = AppColor.blue_dark});
}
