import 'package:path/path.dart';
import 'package:readit/data/models/book.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _db;
  Future<Database> get database async => _db ??= await _initDb();

  Future _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    //     final String path;
    // final String? title;
    // final String? author;
    // final Uint8List? cover;
    await db.execute('''
      CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      author TEXT,
      cover TEXT,
      path TEXT
      )
      ''');
  }

  Future getBooks() async {
    final db = await database;
    final rows = await db.query('books');
    return rows.map(Book.fromMap).toList();
  }
}
