import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/validation_constant.dart';

enum TextFieldOption { undefined, email, password }

class LinTextField extends StatelessWidget {
  const LinTextField(
      {super.key,
      required this.controller,
      this.initialValue,
      this.isRequired = false,
      this.label,
      this.option = TextFieldOption.undefined});
  final TextEditingController controller;
  final String? initialValue;
  final bool isRequired;
  final String? label;
  final TextFieldOption option;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: option == TextFieldOption.password ? true : false,
      enableSuggestions: option == TextFieldOption.password ? false : true,
      autocorrect: option == TextFieldOption.password ? false : true,
      validator: (value) {
        if (value?.isEmpty ?? isRequired) {
          return 'This field must not be empty';
        } else if (option == TextFieldOption.email) {
          return ValidationConstant.email(value, context);
        } else if (option == TextFieldOption.password) {
          return ValidationConstant.password(value, context);
        }

        return null;
      },
      decoration: InputDecoration(
        label: Text(label ?? ''),
      ),
    );
  }
}
