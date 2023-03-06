import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.title, this.color, Key? key}) : super(key: key);

  final String title;
  final Colors? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [],
      ),
    );
  }
}
