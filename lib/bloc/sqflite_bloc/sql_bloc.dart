import 'dart:async';

import 'model/sql_model.dart';
import 'sql_repository.dart';

class SqlBloc {
  final SqlRepository _sqlDao;
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
    _todoController.close();
    _dailyController.close();
  }

  SqlBloc(this._sqlDao) {
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
