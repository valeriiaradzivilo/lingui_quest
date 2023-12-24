import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';

class LinNumberEditingField extends StatefulWidget {
  const LinNumberEditingField({super.key, this.label, required this.controller, this.isRequired = false});
  final String? label;
  final TextEditingController controller;
  final bool isRequired;

  @override
  State<LinNumberEditingField> createState() => _LinNumberEditingFieldState();
}

class _LinNumberEditingFieldState extends State<LinNumberEditingField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(label: widget.label != null ? Text(widget.label!) : null, errorMaxLines: 3),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || (widget.isRequired && value.isEmpty)) {
          return context.loc.fieldShouldNotBeEmpty;
        }
        return null;
      },
      maxLines: null,
      minLines: 1,
    );
  }
}
