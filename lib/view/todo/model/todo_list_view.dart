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
  bool _isDraggable = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              child: Text(DateFormat("EEE, hh:mm").format(widget.data.startOn))),
          Expanded(
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width > 318? 318: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onLongPress: () {
                  SnackBar snackBar = const SnackBar(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      '오른쪽으로 밀어내면 일정을 삭제합니다.',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    _isDraggable = true;
                  });
                },
                onLongPressMoveUpdate: (details) {
                  if (_isDraggable) {
                    setState(() {
                      if (details.localPosition.dx > 0) {
                        offsetX = details.localPosition.dx;
                      }
                    });
                  }
                },
                onLongPressUp: () {
                  if (_isDraggable && offsetX > 300.0) {
                    widget.bloc.deleteTodo(widget.data.id!);
                  }
                  setState(() {
                    _isDraggable = false;
                    offsetX = 0.0;
                  });
                },
                onTap: () {
                  // data details on new window
                },
                child: Transform.translate(
                  // *** If the last item is swiped, there is a problem that the afterimage of the letter remains. ***
                  offset: Offset(offsetX, 0),
                  child: Card(
                    elevation:  offsetX == 0.0? 3.0 : 0.0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${widget.data.id}"),
                            Text(widget.data.title)
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
          ),
        ],
      ),
    );
  }
}
