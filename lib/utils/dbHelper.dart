import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_example/model/Person.dart';

import '../model/notes.dart';

class DataBaseHelper {
  static Database? _database;

  String notesTable = "notes";
  String personTable = "person";
  String clmnId = "id";
  String clmnTitle = "title";
  String clmnDescription = "description";
  String clmnPersonId = "personId";

  String clmnName = "name";
  String clmnLastName = "lastname";

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database?> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "notes.db");
    var notesDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return notesDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $notesTable ($clmnId integer primary key,$clmnPersonId integer ,$clmnTitle text ,$clmnDescription text) ");
    await db.execute(
        "CREATE TABLE $personTable ($clmnId integer primary key,$clmnName text,$clmnLastName text , $clmnTitle text)");
  }

  //Crud methods

  Future<int> insert(Notes note) async {
    Database? db = await database;

    var result = await db!.insert(notesTable, note.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await database;

    var result = await db!.rawDelete("delete from $notesTable where id=$id");

    return result;
  }

  Future<int> update(Notes note) async {
    Database? db = await database;

    var result = await db!
        .update(notesTable, note.toMap(), where: "id=?", whereArgs: [note.id]);

    //db.rawUpdate("UPDATE $notesTable set title=? where Id=?", [note.title, note.id]);
    //update notes set title="sila" ,description="ders"  where Id=4
    return result;
  }

  Future<List<Notes>> getAllNotes() async {
    Database? db = await database;

    var result = await db!.query(notesTable);
    //select * from notes

    // return List.generate(result.length, (i) {
    //   return Notes.fromMap(result[i]);
    // });

    List<Notes> lstnotes = <Notes>[];
    for (var item in result) {
      lstnotes.add(Notes.fromMap(item));
    }

    return lstnotes;
  }

  Future<int> insertPerson(Person person) async {
    Database? db = await database;
    int result = await db!.insert(personTable, person.toMap());

    return result;
  }

  Future<int> updatePerson(Person person) async {
    Database? db = await database;
    int result = await db!.update(personTable, person.toMap(),
        where: "$clmnId=?", whereArgs: [person.id]);

    return result;
  }

  Future<int> deletePerson(int id) async {
    Database? db = await database;
    int result = await db!.delete(personTable, where: "id=?", whereArgs: [id]);

    return result;
  }

  Future<List<Person>> getAllPerson() async {
    Database? db = await database;
    List<Person> lstPerson = <Person>[];

    var result = await db!.query(personTable);

    for (var item in result) {
      lstPerson.add(Person.getMap(item));
    }

    return lstPerson;
  }
}
