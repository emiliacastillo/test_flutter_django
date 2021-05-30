import 'package:flutter/widgets.dart';

class HideKeyBoardWidget extends StatelessWidget {
  final Widget child;

  HideKeyBoardWidget({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
