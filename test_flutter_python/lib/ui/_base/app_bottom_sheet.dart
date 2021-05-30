import 'package:test_flutter_python/ui/_base/single_selection_model.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_tx/tx_text.dart';

void showZModalBottomSheet2({
  @required BuildContext context,
  @required WidgetBuilder builder,
  Color color = Colors.white,
  double marginTop = 0,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (b) => Container(
      color: color,
      width: double.infinity,
      margin: EdgeInsets.only(top: marginTop),
      child: Material(
        child: builder(context),
        color: color,
      ),
    ),
  );
}

void showZModalBottomSheet(
    {@required BuildContext context,
    List<SingleSelectionModel> list = const [],
    TextAlign textAlign = TextAlign.center,
    ValueChanged<SingleSelectionModel> onItemSelect}) {
  showCupertinoModalPopup(
    context: context,
    builder: (b) {
      return Material(
        child: SingleChildScrollView(
            child: Column(
          children: _conformItemList(list, onItemSelect, textAlign),
        )),
      );
    },
  );
}

List<Widget> _conformItemList(List<SingleSelectionModel> list,
    ValueChanged<SingleSelectionModel> onItemSelect, TextAlign textAlign) {
  List<Widget> resultList = [];

  list.forEach((model) {
    final w = InkWell(
      onTap: () {
        if (onItemSelect != null) onItemSelect(model);
      },
      child: Column(
        children: <Widget>[
          Container(
            color: AppColor.gray_dark,
            height: model.cancelAction ? .5 : 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TXText(
                    model.value,
                    textOverFlow: TextOverflow.ellipsis,
                    textAlign: textAlign,
                    color: model.textColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    resultList.add(w);
  });

  return resultList;
}
