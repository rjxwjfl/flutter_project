import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/sql_model.dart';
import 'package:flutter_dowith/utils/glow_remover.dart';
import 'package:flutter_dowith/view/todo/model/create_todo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dowith/view/todo/model/todo_list_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main.dart';

class PersonalTodoScreen extends StatefulWidget {
  const PersonalTodoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalTodoScreen> createState() => _PersonalTodoScreenState();
}

class _PersonalTodoScreenState extends State<PersonalTodoScreen> {
  late DateTime today;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat = CalendarFormat.week;
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    bloc.today = today;
    _focusedDay = today;
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool dayCheck() {
    return DateTime(today.year, today.month, today.day).isAfter(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // SizedBox(height: _flexibleSize),
          returnCalendar(),
          Expanded(child: todoListView()),
        ],
      ),
      floatingActionButton: dayCheck()
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTodo(today: _selectedDay)));
              },
              child: const Icon(FontAwesomeIcons.plus),
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
            if (dayCheck()) {
              return const Center(
                child: Text("Schedule is 텅"),
              );
            } else {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTodo(today: _selectedDay)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.note_add_rounded),
                          SizedBox(width: 10),
                          Text("새 일정 추가하기"),
                        ],
                      )),
                ),
              );
            }
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: ScrollConfiguration(
                behavior: ScrollGlowRemove(),
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
                            child: TodoItemView(data: sqlData)),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget returnCalendar() {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      margin: const EdgeInsets.only(left: 0, right: 0),
      elevation: 5.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.background,
          ),
          child: TableCalendar(
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            formatAnimationDuration: const Duration(milliseconds: 100),
            availableCalendarFormats: const {
              CalendarFormat.month: "2주 보기",
              CalendarFormat.week: "달력 보기",
              CalendarFormat.twoWeeks: "1주 보기"
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
              });
            },
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: scheme.secondary, shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: scheme.background, fontSize: 18, fontWeight: FontWeight.w400),
                selectedDecoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
                selectedTextStyle: TextStyle(color: scheme.background, fontSize: 18, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }

}
// *** Scroll tracker ***
// WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeIn);
// });
