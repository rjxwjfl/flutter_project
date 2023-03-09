import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/bloc/model/sql_model.dart';
import 'package:flutter_dowith/view/todo/model/todo_list_view.dart';
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
  late CalendarFormat _calendarFormat = CalendarFormat.week;
  late double _flexibleSize = 175.0;
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
        startOn: _selectedDay,
        expireOn: _selectedDay);
    bloc.insertData(sqlModel);
  }

  @override
  Widget build(BuildContext context) {
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
              appBarUI("TITLE"),
              returnCalendar(),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {addSql();},
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
                width: 170,
                child: ElevatedButton(
                    onPressed: () {
                      addSql();
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
                  SqlModel? sqlData = data[index];
                  if (sqlData == null){
                    return null;
                  }
                  return TodoListView(bloc:bloc, data: sqlData);
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
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.only(left: 0, right: 0),
      elevation: 5.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
              print("Select date : $_selectedDay");
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
                  _flexibleSize = 380;
                } else if (format.index == 1) {
                  _flexibleSize = 225;
                } else {
                  _flexibleSize = 175;
                }
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
      ),
    );
  }
}
