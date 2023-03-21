import 'package:flutter/material.dart';

class CustomExtensionButton extends StatefulWidget {
  const CustomExtensionButton(
      {required this.controller,
      required this.color,
      required this.splashColor,
      required this.highLightColor,
      required this.content,
      required this.callback,
      required this.animation,
      Key? key})
      : super(key: key);

  final AnimationController controller;
  final Color color;
  final Color splashColor;
  final Color highLightColor;
  final String content;
  final Animation animation;
  final void Function() callback;

  @override
  State<CustomExtensionButton> createState() => _CustomExtensionButtonState();
}

class _CustomExtensionButtonState extends State<CustomExtensionButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 3, 40, 3),
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
                child: Text(
                  widget.content,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: widget.splashColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
