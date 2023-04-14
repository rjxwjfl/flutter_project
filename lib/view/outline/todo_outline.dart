import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/model/sql_model.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/sql_bloc.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/sql_repository.dart';
import 'package:intl/intl.dart';

class TodoOutline extends StatefulWidget {
  const TodoOutline({Key? key}) : super(key: key);

  @override
  State<TodoOutline> createState() => _TodoOutlineState();
}

class _TodoOutlineState extends State<TodoOutline> {
  final SqlBloc _sqlBloc = SqlBloc(SqlRepository());
  final DateFormat formatter = DateFormat("hh:mm a");

  @override
  void initState() {
    super.initState();
    _sqlBloc.overView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const Placeholder(
              fallbackHeight: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("PROJECT POPULARITY LIST"),
            ),
            const Placeholder(
              fallbackHeight: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("TODAY'S TODO"),
            ),
            SizedBox(
              child: todoListUI(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("CURRENT TASK"),
            ),
            const Placeholder(
              fallbackHeight: 400,
            ),
            const SizedBox(height: kToolbarHeight * 2)
          ]),
        ),
      ],
    ));
  }

  Widget todoListUI() {
    return Material(
      child: StreamBuilder<List<SqlModel>>(
        stream: _sqlBloc.overViewStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                const Text("개인 일정이 없습니다."),
                ElevatedButton(onPressed: () {}, child: const Text("추가")),
              ],
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                SqlModel data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Theme.of(context).colorScheme.onBackground)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [Text(data.title), Text(data.content), Text(formatter.format(data.startOn))],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
