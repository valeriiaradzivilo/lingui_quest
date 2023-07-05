import 'package:flutter/material.dart';

class LinTextField extends StatelessWidget {
  const LinTextField({super.key, required this.controller, this.initialValue, this.isRequired = false, this.label});
  final TextEditingController controller;
  final String? initialValue;
  final bool isRequired;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: (value) {
        if (value?.isEmpty ?? isRequired) return 'This field must not be empty';
        return null;
      },
      decoration: InputDecoration(
        label: Text(label ?? ''),
      ),
    );
  }
}
