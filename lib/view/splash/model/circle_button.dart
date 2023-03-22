import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {required this.assetPath,
      required this.callback,
      required this.isLoad,
      Key? key})
      : super(key: key);

  final String assetPath;
  final void Function() callback;
  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      customBorder: const CircleBorder(),
      splashColor: Theme.of(context).colorScheme.surfaceVariant,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: isLoad
              ? const Padding(
                  padding: EdgeInsets.all(7.0),
                  child: CircularProgressIndicator(),
                )
              : Image.asset(
                  assetPath,
                  scale: 2.0,
                ),
        ),
      ),
    );
  }
}
