import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/model/database/sql_model.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  late final DateTime today = DateTime.now();
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  late final Bloc bloc;
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = Bloc(SqlDao());
    _focusedDay = today;
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    bloc.dispose();
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
        startOn: DateTime.now(),
        expireOn: DateTime.now());
    bloc.insertData(sqlModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          returnCalendar(),
          Expanded(child: todoListView()),
        ],
      ),
    );
  }

  Widget todoListView() {
    return StreamBuilder(
      stream: bloc.todoListStream,
      builder: (context, AsyncSnapshot<List<SqlModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          if (data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Text("Empty..."),
                  ElevatedButton(
                      onPressed: () {
                        addSql();
                      },
                      child: const Text("새 데이터 추가하기")),
                ],
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
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  SqlModel sqlData = data[index];
                  return Text("${sqlData.id}");
                },
              ),
            );
          }
        }
      },
    );
  }

  Widget returnCalendar() {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: scheme.onPrimaryContainer)),
        child: TableCalendar(
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          formatAnimationDuration: const Duration(milliseconds: 100),
          availableCalendarFormats: const {
            CalendarFormat.month: "2주간",
            CalendarFormat.week: "월간",
            CalendarFormat.twoWeeks: "주간"
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
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          calendarStyle: CalendarStyle(
              todayDecoration:
                  BoxDecoration(color: scheme.secondary, shape: BoxShape.circle),
              todayTextStyle: TextStyle(
                  color: scheme.background,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              selectedDecoration:
                  BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
              selectedTextStyle: TextStyle(
                  color: scheme.background,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
