import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({required this.label,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.focusNode,
    required this.icon,
    this.switchVisible = false,
    this.keyboardType = TextInputType.text, super.key});

  final String label;
  final String hintText;
  final FocusNode focusNode;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool switchVisible;
  final TextInputType keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final _scheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: widget.switchVisible? !_isVisible : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: _scheme.onPrimary,
        prefixIcon: widget.icon,
        suffixIcon: widget.switchVisible? switchVisible(): null,
        labelText: widget.label,
        hintText: widget.hintText,
        labelStyle: TextStyle(color: _scheme.primary),
        contentPadding: const EdgeInsets.only(left: 40, top: 12, bottom: 12),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: _scheme.inversePrimary,
              width: 1.0
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: _scheme.inversePrimary,
            width: 1.0
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: _scheme.primary,
              width: 1.0
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: _scheme.error,
            width: 1.0
          ),
        )
      ),
      validator: widget.validator,
    );
  }
  Widget switchVisible(){
    return GestureDetector(
      onTap: (){
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: _isVisible? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye),
    );
  }
}