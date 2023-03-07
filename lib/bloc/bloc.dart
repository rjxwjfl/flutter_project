import 'dart:async';

import 'package:flutter_dowith/bloc/sql_dao.dart';
import 'package:flutter_dowith/model/database/sql_model.dart';

class Bloc {
  final SqlDao _sqlDao;
  final StreamController<List<SqlModel>> _todoController =
      StreamController<List<SqlModel>>.broadcast();

  get todoListStream => _todoController.stream;

  dispose() {
    _todoController.close();
  }

  Bloc(this._sqlDao) {
    getTodoList();
  }

  getTodoList() async {
    List<SqlModel> todoList = await _sqlDao.getTodoDB();
    _todoController.sink.add(todoList);
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
}
