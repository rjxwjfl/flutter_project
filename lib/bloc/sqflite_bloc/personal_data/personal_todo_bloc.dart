import 'dart:async';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/personal_todo_repository.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/sql_model.dart';

class PersonalDataBloc {
  final PersonalRepository _sqlDao;
  final StreamController<List<SqlModel>> _todoController =
      StreamController<List<SqlModel>>.broadcast();
  final StreamController<List<SqlModel>> _dailyController =
      StreamController<List<SqlModel>>.broadcast();
  final StreamController<List<SqlModel>> _todoControllerForOverView = StreamController.broadcast();
  late DateTime _today;

  get todoListStream => _todoController.stream;
  get dailyStream => _dailyController.stream;
  get overViewStream => _todoControllerForOverView.stream;

  set today(DateTime date) {
    _today = date;
    getTodoList();
  }

  dispose() {
    _todoController.close();
    _dailyController.close();
    _todoControllerForOverView.close();
  }

  PersonalDataBloc(this._sqlDao) {
    _today = DateTime.now();
    // checkExpire();
    getTodoList();
    overView();
  }

  overView() async{
    DateTime now = DateTime.now();
    int startOfDay =
        DateTime(now.year, now.month, now.day, 0, 0, 0, 000)
            .millisecondsSinceEpoch;
    int endOfDay =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
            .millisecondsSinceEpoch;

    List<SqlModel> data = await _sqlDao.getOverView();
    List<SqlModel> today = data.where((todo) {
      int startOn = todo.startOn.millisecondsSinceEpoch;
      return startOn >= startOfDay && startOn <= endOfDay;
    }).toList();
    _todoControllerForOverView.sink.add(today);
  }

  getTodoList() async {
    List<SqlModel> todoList = await _sqlDao.getTodoDB();
    _todoController.sink.add(todoList);

    int startOfDay =
        DateTime(_today.year, _today.month, _today.day, 0, 0, 0, 000)
            .millisecondsSinceEpoch;
    int endOfDay =
        DateTime(_today.year, _today.month, _today.day, 23, 59, 59, 999)
            .millisecondsSinceEpoch;

    List<SqlModel> dailyList = todoList.where((todo) {
      int startOn = todo.startOn.millisecondsSinceEpoch;
      return startOn >= startOfDay && startOn <= endOfDay;
    }).toList();
    _dailyController.sink.add(dailyList);
  }

  insertData(SqlModel todo) async {
    await _sqlDao.insertDB(todo);
    getTodoList();
    overView();
  }

  deleteTodo(int id) async {
    await _sqlDao.deleteDB(id);
    getTodoList();
  }

  updateTodo(SqlModel todo) async {
    await _sqlDao.updateDB(todo);
    getTodoList();
  }

  checkExpire() async {
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (await _sqlDao.checkExpire()) {
        getTodoList();
      }
    });
  }
}
