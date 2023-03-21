import 'package:flutter/material.dart';

class CustomExtensionButton extends StatefulWidget {
  const CustomExtensionButton(
      {required this.controller,
      required this.color,
      required this.splashColor,
      required this.highLightColor,
      required this.content,
      Key? key})
      : super(key: key);

  final AnimationController controller;
  final Color color;
  final Color splashColor;
  final Color highLightColor;
  final String content;

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
          onTap: () {},
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          splashColor: widget.splashColor,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: widget.highLightColor,
          overlayColor: null,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Center(
              child: Container(
                color: widget.color,
                child: Text(widget.content),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
