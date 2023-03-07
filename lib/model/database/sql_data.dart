import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const sqlTable = 'database';

class SqlData {
  static final SqlData sqlData = SqlData();

  static Database? _database;

  Future<Database> get database async => _database ??= await _dataBase();

  Future<Database> _dataBase() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'todoDatabase.db');
    return await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  }

  void initDB(Database db, int version) async {
    await db
        .execute('CREATE TABLE database('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title TEXT, '
            'author TEXT, '
            'comment TEXT, '
            'state INTEGER, '
            'createAt INTEGER, '
            'startsOn INTEGER, '
            'expireOn INTEGER, '
            'completeAt INTEGER'
            ')')
        .then((value) {
      print('table created');
    }).catchError((e) {
      print('error when creating DB ${e.toString()}');
    });
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    // ** If you add a column, you must change the version. **
    if (oldVersion < newVersion){
      // ignore: todo
      // TODO: columns update.
    }
  }
}
