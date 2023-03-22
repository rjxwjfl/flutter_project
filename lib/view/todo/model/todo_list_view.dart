import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../bloc/model/sql_model.dart';

class TodoItemView extends StatefulWidget {
  const TodoItemView({super.key, required this.data});

  final SqlModel data;

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {

  String formatter(DateTime date){
    return DateFormat("hh:mm a, EEE").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width > 318
            ? 318
            : MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text(widget.data.title)],
                  ),
                ),
                widget.data.completeAt == null
                    ? const Text("완료되지 않음")
                    : Text("${widget.data.completeAt}"),
                Text("${widget.data.expireOn}"),
                Text("${widget.data.state}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
