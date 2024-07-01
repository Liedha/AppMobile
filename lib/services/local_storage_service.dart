import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/inspiration.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'inspiration.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE inspirations(id INTEGER PRIMARY KEY, text TEXT, author TEXT, imageUrl TEXT)",
        );
      },
    );
  }

  Future<void> insertInspiration(Inspiration inspiration) async {
    final db = await database;
    await db.insert('inspirations', {
      'text': inspiration.text,
      'author': inspiration.author,
    });
  }

  Future<List<Inspiration>> getInspirations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('inspirations');
    return List.generate(maps.length, (i) {
      return Inspiration(
        text: maps[i]['text'],
        author: maps[i]['author'],
      );
    });
  }
}
