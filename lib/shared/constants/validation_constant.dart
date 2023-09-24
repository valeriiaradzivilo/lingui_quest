import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';

class ValidationConstant {
  static String? email(String? email, BuildContext context) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (email == null) {
      return context.loc.enterValidEmail;
    } else if (!emailRegExp.hasMatch(email)) {
      return context.loc.enterValidEmail;
    }
    return null;
  }

  static String? password(String? password, BuildContext context) {
    if (password == null) {
      return context.loc.passwordMinLength;
    } else if (password.isEmpty || password.length < 8) {
      return context.loc.passwordMinLength;
    }

    return null;
  }
}
