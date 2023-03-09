import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../bloc/bloc.dart';
import '../../../bloc/model/sql_model.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key, required this.data, required this.bloc});

  final SqlModel data;
  final Bloc bloc;

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  double offsetX = 0.0;
  bool _isDragable = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 50,
            child: Text(DateFormat("EEE, hh:mm").format(widget.data.startOn))),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width - 50,
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                _isDragable = true;
              });
            },
            onLongPressMoveUpdate: (details) {
              if (_isDragable) {
                setState(() {
                  if (details.localPosition.dx > 0) {
                    offsetX = details.localPosition.dx;
                  }
                });
              }
            },
            onLongPressUp: () {
              if (_isDragable && offsetX > 300.0) {
                widget.bloc.deleteTodo(widget.data.id!);
              }
              setState(() {
                _isDragable = false;
                offsetX = 0.0;
              });
            },
            onTap: () {
              // data details on new window
            },
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${widget.data.id}"),
                        Text(widget.data.title)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.ad_units),
                        Row(),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          widget.bloc.deleteTodo(widget.data.id!);
                        },
                        icon: const Icon(Icons.delete_forever_rounded))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
