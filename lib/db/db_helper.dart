import 'dart:ffi';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "schedule";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'schedule.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, _version) {
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "remind INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertTask(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }


  static Future<List<Map<String, dynamic>>> queryTask() async {
    print("query function called");
    List<Map<String, dynamic>> result = await _db!.query(_tableName);
    print("The result is: $result");
    print("The length is: ${result.length}");
    print("The future.value is ${Future.value(result)}");
    return result;
  }

  static Future<List<Map<String, dynamic>>> rawQueryTask() async {
    List<Map<String, dynamic>> result = await _db!.rawQuery('SELECT * FROM $_tableName');
    return result;
  }


  static Future<int?> deleteTask(Task? task) async {
    print("update function called");
    return await _db?.delete(_tableName,
        where: 'id = ?',
        whereArgs: [task?.id],);
  }

/*static Future<int?> updateTask(Task? task) async {
    print("update function called");
    return await _db?.update(_tableName,
        task?.toJson(),
        where: 'id = ?',
        whereArgs: [task?.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }*/

/*static Future<List<Task>?> queryTask() async {
    print("query function called");

    final List<Map<String, dynamic>> maps = await _db!.query(_tableName);

    if(maps.isEmpty) {
      return null;
    } else {
      return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
    }
  }*/

}