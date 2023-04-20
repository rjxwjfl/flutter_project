import 'package:sqflite/sqflite.dart';

class ScheduleSQL{
  void initDB(Database data, int ver) async{
    await data.execute('');
  }
}

// CREATE TABLE scheduled_task(
// id INTEGER PRIMARY KEY AUTOINCREMENT,
//
// )