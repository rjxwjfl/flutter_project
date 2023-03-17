import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({required this.label,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.focusNode,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, super.key});

  final String label;
  final String hintText;
  final FocusNode focusNode;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 1.0
          )
        ),
      ),
      validator: validator,
    );
  }
}