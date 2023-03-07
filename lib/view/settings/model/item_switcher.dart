import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSwitcher extends StatelessWidget {
  const ItemSwitcher({super.key, this.color, required this.title, required this.value, required this.callback});

  final Color? color;
  final String title;
  final bool value;
  final void Function(bool) callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color ?? Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
        child: Row(
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontSize: 15),)),
            CupertinoSwitch(
              value: value,
              onChanged: callback,
              activeColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
