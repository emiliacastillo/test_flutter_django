import 'package:test_flutter_python/ui/_base/hide_keyboard_widget.dart';
import 'package:flutter/widgets.dart';

class OnInitWidget extends StatefulWidget {
  final Widget child;

  final Function(BuildContext) onInit;

  final bool hideKeyBoard;

  const OnInitWidget(
      {Key key,
      @required this.child,
      @required this.onInit,
      this.hideKeyBoard = true})
      : super(key: key);

  @override
  _OnInitWidgetState createState() => _OnInitWidgetState();
}

class _OnInitWidgetState extends State<OnInitWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) widget.onInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.hideKeyBoard
        ? HideKeyBoardWidget(
            child: widget.child,
          )
        : widget.child;
  }
}
