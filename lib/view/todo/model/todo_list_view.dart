import 'package:flutter/material.dart';

import '../../../model/database/sql_model.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key, required this.data});

  final SqlModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
