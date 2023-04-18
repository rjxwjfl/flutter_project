import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem(
      {required this.title,
      required this.icon,
      required this.callback,
      required this.selectState,
      Key? key})
      : super(key: key);

  final String title;
  final IconData icon;
  final void Function() callback;
  final bool selectState;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: widget.callback,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: scheme.primary),
            color: widget.selectState ? scheme.primary : scheme.onPrimary),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                color: widget.selectState ? scheme.onPrimary : scheme.primary,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 10,
                    color: widget.selectState ? scheme.onPrimary : scheme.primary,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
