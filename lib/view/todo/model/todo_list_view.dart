import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../bloc/model/sql_model.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key, required this.data});

  final SqlModel data;

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {

  String formatter(DateTime date){
    return DateFormat("hh:mm a, EEE").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
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
