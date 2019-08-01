import 'dart:async';
import 'package:cos_method/model/error.dart';
import 'package:cos_method/model/star.dart';
import 'package:cos_method/model/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// cc token 1ot1q5ffcf5k274hjb7d8qupc39bbmat5dcsib6
// ct       3dvuphnamsqkomm0o3cng2mdndp8nff1s92jqpf
class DatabaseCollection{
  /// The version of the database.
  final int version = 11;

  /// get an open database.

  /// If the database is not created before, it will

  /// init the database.

 getopenDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'cosapp_database.db'),
    onCreate: (db, version) {
      db.execute("CREATE TABLE errors(id INTEGER PRIMARY KEY, subject TEXT, level INTEGER, name TEXT, book TEXT)");
      db.execute("CREATE TABLE stars(id INTEGER PRIMARY KEY, subject TEXT, level INTEGER, name TEXT , book TEXT)");
      db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY, piority INTEGER , rule TEXT, name TEXT)");
    },
    onUpgrade: (db,v1,v2){
       db.execute('DROP TABLE todos');
       debugPrint('dropped!');
      db.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY, piority INTEGER , rule TEXT, name TEXT)');
    },
    version: version
  );
  return database;
 }
 ///
 /// Insert an error
 ///
 Future<void> insertError(Errors errors) async {
  final Database dbs = await getopenDatabase();
  await dbs.insert('errors', errors.toMap());
  }


  /// Insert a star .

  Future<void> insertStar(Stars stars) async {
  final Database db = await getopenDatabase();
  await db.insert(
    //table name
    'stars',
    stars.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  }
  /**
   * Insert a todo.
   */
  Future<void> insertToDo(ToDos todos) async {
  final Database db = await getopenDatabase();
  await db.insert(
    //table name
    'todos',
    todos.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Errors>> getAllErrors() async {
  final Database db = await getopenDatabase();
  final List<Map<String, dynamic>> maps = await db.query('errors');
  return List.generate(maps.length, (i) {
    return Errors(
      id: maps[i]['id'],
      name: maps[i]['name'],
      book: maps[i]['book'],
      level: maps[i]['level'],
      subject: maps[i]['subject']
    );
  });
}


Future<List<Stars>> getAllStars() async {
  final Database db = await getopenDatabase();
  final List<Map<String, dynamic>> maps = await db.query('stars');
  return List.generate(maps.length, (i) {
    return Stars(
      id: maps[i]['id'],
      name: maps[i]['name'],
      level: maps[i]['level'],
      subject: maps[i]['subject']
    );
  });
}

Future<List<ToDos>> getAllToDos() async {
  final Database db = await getopenDatabase();
  final List<Map<String, dynamic>> maps = await db.query('todos');
  return List.generate(maps.length, (i) {
    
    ToDos todo =  ToDos(
      id: maps[i]['id'],
      name: maps[i]['name'],
      rule: maps[i]['rule'],
      piority: maps[i]['piority']
    );
    return todo;
  });}


Future<void> deleteError(int id) async {
  final database = await getopenDatabase();
  await database.delete(
    'errors',
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<void> deleteStar(int id) async {
  final database = await getopenDatabase();
  await database.delete(
    'stars',
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<void> deleteToDo(int id) async {
  final database = await getopenDatabase();
  await database.delete(
    'todos',
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<void> updateError(Errors error) async {
  final db = await getopenDatabase();
  
  await db.update(
    'errors',
    error.toMap(),
    where: "id = ?",
    whereArgs: [error.id],
  );
}


Future<void> updateStar(Stars star) async {
  final db = await getopenDatabase();
  await db.update(
    'stars',
    star.toMap(),
    where: "id = ?",
    whereArgs: [star.id],
  );
}


Future<void> updateToDo(ToDos todo) async {
  final db = await getopenDatabase();
  await db.update(
    'todos',
    todo.toMap(),
    where: "id = ?",
    whereArgs: [todo.id],
  );
}

}