import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/sql_model.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/utils/todo_time_indicator.dart';
import 'package:flutter_dowith/view/dowith/main_screen/project_search.dart';
import 'package:flutter_dowith/view/todo/model/create_todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DateFormat formatter = DateFormat("hh:mm a");

  Color setProgressColor(TodoState state) {
    Color color;
    const map = {
      TodoState.scheduled: Colors.orangeAccent,
      TodoState.inProgress: Colors.yellowAccent,
      TodoState.complete: Colors.greenAccent,
      TodoState.expired: Colors.redAccent
    };
    color = map[state] ?? Colors.orangeAccent;
    return color;
  }

  String setProgressText(TodoState state) {
    String progress;
    const map = {TodoState.scheduled: "예정됨", TodoState.inProgress: "진행중", TodoState.complete: "완료", TodoState.expired: "만료됨"};
    progress = map[state] ?? "예정됨";
    return progress;
  }

  @override
  void initState() {
    super.initState();
    bloc.overView();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Scaffold(
        backgroundColor: ref.watch(theme).setMaterialColor(context),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                height: 40, width: 40, child: Image.asset("assets/icons/app_icon/android/mipmap-xxxhdpi/ic_launcher.png")),
          ),
          leadingWidth: 60.0,
          elevation: 0.0,
          title: Text("Do With",
              style: TextStyle(
                fontFamily: "QuickSand",
                color: scheme.onBackground,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              )),
          backgroundColor: scheme.background,
          foregroundColor: scheme.primary,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProjectSearch()));
                },
                icon: const Icon(FontAwesomeIcons.magnifyingGlass)),
            IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            bloc.overView();
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Placeholder(
                      fallbackHeight: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("TODAY'S TODO"),
                    ),
                    todoListUI(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("CURRENT TASK"),
                    ),
                    const Placeholder(
                      fallbackHeight: 400,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("PROJECT POPULARITY LIST"),
                    ),
                    const Placeholder(
                      fallbackHeight: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget todoListUI() {
    Size size = MediaQuery.of(context).size;
    ColorScheme scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50,maxHeight: 150),
      child: StreamBuilder<List<SqlModel>>(
        stream: bloc.overViewStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("개인 일정이 없습니다."),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => CreateTodo(today: DateTime.now())));
                    },
                    child: const Text("추가")),
              ],
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              SqlModel data = snapshot.data![index];
              return SizedBox(
                height: 80,
                width: size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: scheme.shadow),
                            color: scheme.background),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 5),
                              child: Container(
                                width: 3,
                                color: scheme.primary,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TodoTimeIndicator(time: data.startOn),
                                TodoTimeIndicator(time: data.expireOn),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 12),
                              child: Container(
                                width: 3,
                                color: scheme.primary,
                              ),
                            ),
                            Expanded(child: Center(child: Text(data.title))),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: setProgressColor(data.state)),
                            color: scheme.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            child: Text(
                              setProgressText(data.state),
                              style: TextStyle(fontFamily: "NotoSans", fontSize: 11, color: setProgressColor(data.state)),
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
