import 'package:flutter/cupertino.dart';

const String EMAILREGEXP =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

const String CIREGEXP = r'^\d+$';

class TXValidator {
  static FormFieldValidator password(BuildContext context) {
    FormFieldValidator validator = (value) {
      if (value.toString().isEmpty) {
        return 'Campo requerido';
      } else {
        return null;
      }
    };
    return validator;
  }

  static FormFieldValidator required(BuildContext context) {
    FormFieldValidator validator = (value) {
      if (value.toString().isEmpty) {
        return 'Campo requerido';
      } else {
        return null;
      }
    };
    return validator;
  }

  static FormFieldValidator requiredDropdown(BuildContext context,
      {String message = ''}) {
    FormFieldValidator validator = (value) {
      if (value == null || value.toString().isEmpty) {
        return message.isEmpty ? 'Campo requerido' : message;
      } else {
        return null;
      }
    };
    return validator;
  }

  static FormFieldValidator ageRequired(BuildContext context) {
    FormFieldValidator validator = (value) {
      try {
        int age = int.tryParse(value);
        if (value.toString().isEmpty) {
          return 'Campo requerido';
        } else if (age < 19 || age > 80) {
          return 'Rango válido 19 a 80';
        } else {
          return null;
        }
      } catch (ex) {
        print(ex);
        return 'Edad incorrecta';
      }
    };
    return validator;
  }

  static FormFieldValidator ciRequired(BuildContext context) {
    FormFieldValidator validator = (value) {
      if (value.toString().isEmpty) {
        return 'Campo requerido';
      } else if (value.toString().length != 11) {
        return 'CI no válido';
      } else if (_validateCI(value)) {
        return 'CI no válido';
      } else {
        return null;
      }
    };
    return validator;
  }

  static bool _validateCI(String value) {
    Pattern pattern = CIREGEXP;
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return true;
    else
      return false;
  }
}
