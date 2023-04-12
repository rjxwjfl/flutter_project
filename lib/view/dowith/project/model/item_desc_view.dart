import 'package:flutter/material.dart';

class ItemDescView extends StatelessWidget {
  const ItemDescView({required this.title, required this.content, Key? key}) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Text(content, style: TextStyle(color: Theme.of(context).colorScheme.onBackground))
        ],
      ),
    );
  }
}
