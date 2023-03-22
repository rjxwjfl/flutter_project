import 'package:flutter/material.dart';

class CustomExtensionButton extends StatefulWidget {
  const CustomExtensionButton(
      {required this.color,
      required this.splashColor,
      required this.highLightColor,
      required this.content,
      required this.callback,
      required this.isLoading,
      Key? key})
      : super(key: key);

  final Color color;
  final Color splashColor;
  final Color highLightColor;
  final String content;
  final bool isLoading;
  final void Function() callback;

  @override
  State<CustomExtensionButton> createState() => _CustomExtensionButtonState();
}

class _CustomExtensionButtonState extends State<CustomExtensionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(37, 3, 37, 3),
      child: Card(
        elevation: 5.0,
        color: widget.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: widget.callback,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          splashColor: widget.splashColor,
          highlightColor: widget.highLightColor,
          child: Ink(
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: widget.isLoading
                    ? const CircularProgressIndicator()
                    : Text(widget.content),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
