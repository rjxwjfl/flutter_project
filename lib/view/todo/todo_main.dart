import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_dowith/bloc/bloc.dart';

import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/bloc/model/sql_model.dart';
import 'package:flutter_dowith/view/todo/model/todo_list_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> with AutomaticKeepAliveClientMixin {
  late final DateTime today = DateTime.now();
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat = CalendarFormat.week;
  late double _flexibleSize = 167.0;
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusedDay = today;
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void addSql() {
    SqlModel sqlModel = SqlModel(
        title: "title",
        content: "content",
        author: "author",
        state: TodoState.scheduled,
        createAt: DateTime.now(),
        startOn: _selectedDay,
        expireOn: _selectedDay);
    bloc.insertData(sqlModel);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: _flexibleSize),
              Expanded(child: todoListView()),
            ],
          ),
          Column(
            children: [
              // appBarUI("TITLE"),
              returnCalendar(),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {
            addSql();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget appBarUI(String title) {
    return Container(
      height: kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.background,
      child: Center(child: Text(title)),
    );
  }

  Widget todoListView() {
    return StreamBuilder(
      stream: bloc.dailyStream,
      builder: (context, AsyncSnapshot<List<SqlModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          if (data!.isEmpty) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.1,
                child: ElevatedButton(
                    onPressed: () {
                      addSql();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.note_add_rounded),
                        SizedBox(width: 10),
                        Text("??? ?????? ????????????"),
                      ],
                    )),
              ),
            );
          } else {
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   _scrollController.animateTo(
            //       _scrollController.position.maxScrollExtent,
            //       duration: const Duration(milliseconds: 100),
            //       curve: Curves.easeIn);
            // });
            return Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  SqlModel? sqlData = data[index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 100,
                        child: Center(child: Text(DateFormat("hh:mm").format(sqlData.startOn))),
                      ),
                      Dismissible(
                          key: ValueKey(sqlData.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (dir) {
                            setState(() {
                              if (dir == DismissDirection.startToEnd) {
                                bloc.deleteTodo(sqlData.id!);
                                data.remove(sqlData);
                              }
                            });
                          },
                          child: TodoListView(data: sqlData)),
                    ],
                  );
                },
              ),
            );
          }
        }
      },
    );
  }

  // 132 184 340

  Widget returnCalendar() {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      margin: const EdgeInsets.only(left: 0, right: 0),
      elevation: 5.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Column(
          children: [
            Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.background,
              child: const Center(child: Text("Text")),
            ),
            Container(
              decoration: BoxDecoration(
                color: scheme.background,
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                formatAnimationDuration: const Duration(milliseconds: 100),
                availableCalendarFormats: const {
                  CalendarFormat.month: "2??? ??????",
                  CalendarFormat.week: "?????? ??????",
                  CalendarFormat.twoWeeks: "1??? ??????"
                },
                firstDay: DateTime(2000, 1, 1),
                lastDay: DateTime(2100, 12, 31),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  bloc.today = _selectedDay;
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                    if (format.index == 0) {
                      _flexibleSize = 375;
                    } else if (format.index == 1) {
                      _flexibleSize = 219;
                    } else {
                      _flexibleSize = 167;
                    }
                  });
                },
                calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(color: scheme.secondary, shape: BoxShape.circle),
                    todayTextStyle: TextStyle(color: scheme.background, fontSize: 18, fontWeight: FontWeight.w400),
                    selectedDecoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
                    selectedTextStyle: TextStyle(color: scheme.background, fontSize: 18, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
