import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {required this.title,
      this.color,
      this.callback,
      Key? key})
      : super(key: key);

  final String title;
  final Color? color;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        color: color ?? Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17,8,17,8),
          child: Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 15),)),
              const Icon(Icons.keyboard_arrow_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
