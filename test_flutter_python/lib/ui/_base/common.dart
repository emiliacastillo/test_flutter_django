import 'package:test_flutter_python/ui/_base/_tx/tx_button.dart';
import 'package:test_flutter_python/ui/_base/app_bottom_sheet.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

void showAppModal({Widget child, Function action, BuildContext context}) {
  showZModalBottomSheet2(
      context: context,
      color: AppColor.gray.withOpacity(0.7),
      builder: (context) {
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                child,
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.maxFinite,
                  child: TXButton(
                    onPressed: () {
                      action();
                      NavigationUtils.pop(context);
                    },
                    color: Colors.white,
                    text: 'OK',
                  ),
                ),
                /*  SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  child: TXButton(
                    onPressed: () {
                      NavigationUtils.pop(context);
                    },
                    color: AppColor.blue,
                    backgroundColor: Colors.white,
                    text: 'Cancelar',
                  ),
                ), */
              ],
            ),
          ),
        );
      });
}
