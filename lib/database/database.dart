import 'dart:async';
import 'package:cos_method/model/error.dart';
import 'package:cos_method/model/question.dart';
import 'package:cos_method/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseCollection{
  /**
   * The version of the database.
   * 
   */
  final int version = 1;

  /**
   * get an open database.
   * If the database is not created before, it will
   * init the database.
   */
 getopenDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'cosapp_database.db'),
    onCreate: (db, version) {
    return db.execute(
      //create error table
      "CREATE TABLE errors(id INTEGER PRIMARY KEY, subject TEXT, level INTEGER, name TEXT, book TEXT);"+
      //create questions table
      "CREATE TABLE questions(id INTEGER PRIMARY KEY, subject TEXT, level INTEGER, name TEXT);"+
      //create todos table
      "CREATE TABLE todos(id INTEGER PRIMARY KEY, rule TEXT, piority INTEGER, name TEXT)",
    );
    },
    version: version
  );
  
 }
/**
 * Insert an error
 */
 Future<void> insertError(Errors errors) async {
  final Database dbs = await getopenDatabase();
  await dbs.insert('errors', errors.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  
  }


  /**
   * Insert a question.
   */
  Future<void> insertQuestion(Questions questions) async {
  final Database db = await getopenDatabase();
  await db.insert(
    //table name
    'questions',
    questions.toMap(),
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


Future<List<Questions>> getAllQuestions() async {
  final Database db = await getopenDatabase();
  final List<Map<String, dynamic>> maps = await db.query('questions');
  return List.generate(maps.length, (i) {
    return Questions(
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
    return ToDos(
      id: maps[i]['id'],
      name: maps[i]['name'],
      rule: maps[i]['rule'],
      piority: maps[i]['piority']
    );
  });
}


Future<void> deleteError(int id) async {
  final database = await getopenDatabase();
  await database.delete(
    'errors',
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<void> deleteQuestion(int id) async {
  final database = await getopenDatabase();
  await database.delete(
    'questions',
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


Future<void> updateQuestion(Questions question) async {
  final db = await getopenDatabase();
  await db.update(
    'questions',
    question.toMap(),
    where: "id = ?",
    whereArgs: [question.id],
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