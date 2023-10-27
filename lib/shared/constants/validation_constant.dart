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
    final uppercaseRegExp = RegExp("[A-Z]+.+");
    final lowercaseRegExp = RegExp("[a-z]+.+");
    final digitsRegExp = RegExp("\\d+");
    final charactersRegExp = RegExp("[@!]+");
    final forbiddenCharactersRegExp = RegExp("[^!@a-zA-Z\\d]");
    if (password == null) {
      return context.loc.passwordMinLength;
    } else if (password.isEmpty || password.length < 8) {
      return context.loc.passwordMinLength;
    } else if (!lowercaseRegExp.hasMatch(password)) {
      return context.loc.passwordRulesLowercase;
    } else if (!uppercaseRegExp.hasMatch(password)) {
      return context.loc.passwordRulesUppercase;
    } else if (!digitsRegExp.hasMatch(password)) {
      return context.loc.passwordRulesDigit;
    } else if (!charactersRegExp.hasMatch(password)) {
      return context.loc.passwordRulesCharacters;
    } else if (forbiddenCharactersRegExp.hasMatch(password)) {
      return context.loc.passwordRulesOtherCharacters;
    }

    return null;
  }

  static String? name(String? name, BuildContext context) {
    if (name == null) {
      return context.loc.passwordMinLength;
    } else if (name.isEmpty) {
      return context.loc.fieldShouldNotBeEmpty;
    } else if (name.contains(" ")) {
      return context.loc.fieldShouldNotHaveSpaces;
    }

    return null;
  }
}
