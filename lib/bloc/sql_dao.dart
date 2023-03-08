import '../model/database/sql_data.dart';
import '../model/database/sql_model.dart';

class SqlDao {
  final sqlData = SqlData.sqlData;

  Future<List<SqlModel>> getTodoDB() async {
    final db = await sqlData.database;
    var toDo = await db.query(sqlTable, orderBy: 'startOn DESC');
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
    await db.update(sqlTable, todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteDB(int no) async {
    final db = await sqlData.database;
    await db.delete('database', where: 'id = ?', whereArgs: [no]);
  }
}
