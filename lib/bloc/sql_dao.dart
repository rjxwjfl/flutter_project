import 'model/sql_data.dart';
import 'model/sql_model.dart';

class SqlDao {
  final sqlData = SqlData.sqlData;

  Future<List<SqlModel>> getTodoDB() async {
    final db = await sqlData.database;
    var toDo = await db.query(sqlTable, orderBy: 'startOn');
    List<SqlModel> todoList =
        toDo.isNotEmpty ? toDo.map((e) => SqlModel.fromMap(e)).toList() : [];
    return todoList;
  }

  Future<void> insertDB(SqlModel todo) async {
    final db = await sqlData.database;
    await db.insert(sqlTable, todo.toMap());
  }

  Future<void> updateDB(SqlModel todo) async {
    final db = await sqlData.database;
    await db
        .update(sqlTable, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteDB(int no) async {
    final db = await sqlData.database;
    await db.delete('database', where: 'id = ?', whereArgs: [no]);
  }


// add schedule reminders to expire in notification bar


  Future<bool> checkExpire() async {
    bool isUpdate = false;
    final db = await sqlData.database;
    final currentTime = DateTime.now();
    var toDo = await db.query(sqlTable);
    List<SqlModel> todoList =
        toDo.isNotEmpty ? toDo.map((e) => SqlModel.fromMap(e)).toList() : [];
    for (SqlModel todo in todoList) {
      if (currentTime.isAfter(todo.expireOn) && todo.state.index != 3) {
        todo.state = TodoState.expired;
        await updateDB(todo);
        isUpdate = true;
      }
    }
    print(isUpdate? "expired data changed.":"check progress...");
    return isUpdate;
  }
}
