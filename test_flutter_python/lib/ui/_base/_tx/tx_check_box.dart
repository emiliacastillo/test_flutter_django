import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';

class TXCheckBox extends StatefulWidget {
  final String text;
  final bool initialValue;
  final ValueChanged<bool> onChange;
  final bool leading;
  final Color textColor;

  TXCheckBox({
    this.text,
    this.onChange,
    this.initialValue = false,
    this.leading = false,
    this.textColor = AppColor.text_color,
  });

  @override
  _TXCheckBoxState createState() => _TXCheckBoxState();
}

class _TXCheckBoxState extends State<TXCheckBox> {
  bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          checked = !checked;
        });
      },
      child: Container(
        child: widget.leading ? leading() : trailing(),
      ),
    );
  }

  Widget trailing() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: TXText(
              widget.text,
              color: widget.textColor,
            ),
          ),
          Checkbox(
            focusColor: AppColor.blue,
            activeColor: AppColor.blue_dark,
            onChanged: (value) {
              setState(() {
                checked = value;
              });
              widget?.onChange(value);
            },
            value: checked,
          )
        ],
      );

  Widget leading() => Row(
        children: <Widget>[
          Container(
            child: Checkbox(
              focusColor: AppColor.blue,
              activeColor: AppColor.blue_dark,
              onChanged: (value) {
                setState(() {
                  checked = value;
                });
                widget.onChange(value);
              },
              value: checked,
            ),
          ),
          Expanded(
            child: TXText(
              widget.text,
              color: widget.textColor,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
}
