import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TXDropdownWidget extends StatefulWidget {
  final String label;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String> onValueChange;
  final String initialValue;
  final FontWeight fontWeight;
  final double fontSize;
  final FormFieldValidator validator;

  TXDropdownWidget({
    this.label,
    this.items,
    this.onValueChange,
    this.initialValue,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.validator,
  });

  @override
  _TXDropdownWidgetState createState() => _TXDropdownWidgetState();
}

class _TXDropdownWidgetState extends State<TXDropdownWidget> {
  List<DropdownMenuItem<String>> menuItems = [];
  String currentValue;
  bool hasErrors = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentValue == null && widget.initialValue != null) {
      currentValue = widget.initialValue;
    }
    return DropdownButtonFormField<String>(
      items: widget.items,
      validator: (text) {
        final validatorMessage =
            widget.validator == null ? null : widget.validator(text);
        setHasErrors(validatorMessage != null);
        if (validatorMessage != null) return validatorMessage;
      },
      onChanged: (value) {
        widget.onValueChange(value);
        setState(() {
          currentValue = value;
        });
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            TextStyle(color: AppColor.text_color, fontStyle: FontStyle.italic),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: AppColor.blue_dark,
      ),
      value: currentValue,
    );
  }

  setHasErrors(bool errors) {
    setState(() {
      hasErrors = errors;
    });
  }
}
