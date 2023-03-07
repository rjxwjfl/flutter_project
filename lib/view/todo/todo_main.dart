import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/bloc.dart';
import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/model/database/sql_model.dart';
import 'package:intl/intl.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  late final DateTime today = DateTime.now();
  late DateTime _selectedDate;
  late final Bloc bloc;
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = Bloc(SqlDao());
    _selectedDate = today;
  }

  @override
  void dispose() {
    bloc.dispose();
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
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: DateFormat("dd").format(today).toString(),
                  style: TextStyle(
                      fontSize: 45,
                      color: Theme.of(context).colorScheme.inverseSurface)),
              TextSpan(
                  text: "일",
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.inverseSurface)),
            ],
          ),
        ),
        leading: IconButton(
            onPressed: () {
              addSql();
            },
            icon: const Icon(Icons.add)),
      ),
      body: Column(
        children: [
          returnCalendar(),
          Expanded(
            child: StreamBuilder(
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
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeIn);
                    });
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: data.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        SqlModel sqlData = data[index];
                        return Text("${sqlData.id}");
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget returnCalendar(){
    return CalendarTimeline(
      initialDate: _selectedDate,
      firstDate: DateTime(2010, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      onDateSelected: (date) => setState(() => _selectedDate = date),
      leftMargin: 20,
      monthColor: Colors.white70,
      dayColor: Colors.teal[200],
      dayNameColor: const Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: const Color(0xFF333A47),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'ko',
    );
  }
}
