import 'dart:async';

import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/bloc/model/sql_model.dart';

class InternalDbBloc {
  final SqlDao _sqlDao;
  final StreamController<List<SqlModel>> _todoController =
      StreamController<List<SqlModel>>.broadcast();
  final StreamController<List<SqlModel>> _dailyController =
      StreamController<List<SqlModel>>.broadcast();
  late DateTime _today;

  get todoListStream => _todoController.stream;
  get dailyStream => _dailyController.stream;

  set today(DateTime date) {
    _today = date;
    getTodoList();
  }

  dispose() {
    print("Bloc Dispose");
    _todoController.close();
    _dailyController.close();
  }

  InternalDbBloc(this._sqlDao) {
    _today = DateTime.now();
    checkExpire();
    getTodoList();
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
