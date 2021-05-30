import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingFullPageWidget extends StatefulWidget {
  final Stream<bool> stream;
  final String title;

  LoadingFullPageWidget({
    @required this.stream,
    this.title,
  });

  @override
  _LoadingFullPageWidgetState createState() => _LoadingFullPageWidgetState();
}

class _LoadingFullPageWidgetState extends State<LoadingFullPageWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.data)
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColor.blue.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  if (widget.title != null)
                    TXText(
                      widget.title,
                      fontSize: 18,
                      color: AppColor.blue,
                    ),
                ],
              ),
            ),
          );
        else
          return Container();
      },
    );
  }
}
