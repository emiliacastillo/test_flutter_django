import 'package:test_flutter_python/ui/_base/_tx/tx_icon_button.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TXTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final Widget prefixIcon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization inputCapitalization;
  final Color textColor;
  final double width;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onTextChange;
  final bool focusable;
  final bool enable;
  final bool isPasswordField;
  final int maxLines;
  final int maxLength;
  final String hint;
  final List<TextInputFormatter> inputFormatter;

  TXTextField(
      {@required this.label,
      @required this.controller,
      this.validator,
      this.prefixIcon,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.done,
      this.textColor = AppColor.text_color,
      this.width = 200,
      this.currentFocus,
      this.nextFocus,
      this.onFieldSubmitted,
      this.focusable = true,
      this.enable = true,
      this.isPasswordField = false,
      this.maxLines = 1,
      this.inputCapitalization = TextCapitalization.none,
      this.maxLength,
      this.inputFormatter,
      this.hint,
      this.onTextChange});

  @override
  _TXTextFieldState createState() => _TXTextFieldState();
}

class _TXTextFieldState extends State<TXTextField> {
  bool hasErrors = false;
  bool passwordVisible = false;
  Color iconColor = Colors.grey;

  IconData get currentIcon {
    if (widget.isPasswordField) {
      if (passwordVisible)
        return Icons.visibility_off;
      else
        return Icons.visibility;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.prefixIcon != null
              ? Container(
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.only(top: 20),
                  child: widget.prefixIcon,
                )
              : Container(),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              style: TextStyle(
                color: widget.textColor,
              ),
              validator: (text) {
                final validatorMessage =
                    widget.validator == null ? null : widget.validator(text);
                setHasErrors(validatorMessage != null);
                if (validatorMessage != null) return validatorMessage;
              },
              keyboardType: widget.inputType,
              textInputAction: widget.inputAction,
              enabled: widget.enable,
              focusNode: widget.currentFocus,
              textCapitalization: widget.inputCapitalization,
              decoration: InputDecoration(
                suffixIcon: getSuffixIcon(),
                labelText: widget.label,
                hintText: widget.hint,
                labelStyle: TextStyle(
                    color: widget.textColor, fontStyle: FontStyle.italic),
              ),
              onFieldSubmitted: widget.onFieldSubmitted ??
                  (term) {
                    if (widget.nextFocus != null) {
                      FocusScope.of(context).requestFocus(widget.nextFocus);
                    }
                  },
              onChanged: widget.onTextChange,
              obscureText: widget.isPasswordField && !passwordVisible,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatter,
            ),
          ),
        ],
      ),
    );
  }

  TXIconButton getSuffixIcon() {
    if (widget.isPasswordField) {
      return TXIconButton(
        icon: Icon(
          currentIcon,
          color: iconColor,
        ),
        onPressed: () {
          if (widget.isPasswordField) setPasswordVisible(!passwordVisible);
        },
      );
    } else {
      return null;
    }
  }

  setPasswordVisible(bool visible) {
    setState(() {
      passwordVisible = visible;
    });
  }

  setHasErrors(bool errors) {
    setState(() {
      hasErrors = errors;
    });
  }
}
