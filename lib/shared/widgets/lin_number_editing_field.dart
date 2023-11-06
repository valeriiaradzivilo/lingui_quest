import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinNumberEditingField extends StatefulWidget {
  const LinNumberEditingField({super.key, this.label, required this.controller});
  final String? label;
  final TextEditingController controller;

  @override
  State<LinNumberEditingField> createState() => _LinNumberEditingFieldState();
}

class _LinNumberEditingFieldState extends State<LinNumberEditingField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(label: widget.label != null ? Text(widget.label!) : null),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLines: null,
      minLines: 1,
    );
  }
}
