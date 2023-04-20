import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectStatusSum extends StatelessWidget {
  const ProjectStatusSum({required this.padding, required this.icon, required this. iconSize, required this.text, required this.fontSize, Key? key}) : super(key: key);

  final EdgeInsets padding;
  final IconData icon;
  final double iconSize;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: iconSize,
            color: Theme.of(context).colorScheme.surface,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
