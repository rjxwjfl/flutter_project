import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({required this.assetPath, required this.callback, Key? key}) : super(key: key);

  final String assetPath;
  final void Function() callback;

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
          border: Border.all(color: Theme.of(context).colorScheme.primary)
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(assetPath, scale: 2.0,),
        ),
      ),
    );
  }
}
