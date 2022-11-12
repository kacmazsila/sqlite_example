import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? _database;

  String notesTable = "notes";
  String clmnId = "id";
  String clmnTitle = "title";
  String clmnDescription = "description";

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
        "Create table $notesTable ($clmnId integer primary key,$clmnTitle text ,$clmnDescription text) ");
  }
}
