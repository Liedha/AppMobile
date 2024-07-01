import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/inspiration.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'inspiration.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''
          CREATE TABLE inspirations(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            text TEXT, 
            author TEXT, 
            imageUrl TEXT
          )
          '''
        );
        await db.execute(
            '''
          CREATE TABLE users(
            email TEXT PRIMARY KEY, 
            password TEXT
          )
          '''
        );
      },
    );
  }

  // CRUD Operations for Inspiration
  Future<void> insertInspiration(Inspiration inspiration) async {
    final db = await database;
    await db.insert('inspirations', inspiration.toJson());
  }

  Future<List<Inspiration>> getInspirations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('inspirations');
    return List.generate(maps.length, (i) {
      return Inspiration.fromJson(maps[i]);
    });
  }

  Future<void> updateInspiration(Inspiration inspiration) async {
    final db = await database;
    await db.update(
      'inspirations',
      inspiration.toJson(),
      where: 'id = ?',
      whereArgs: [inspiration.id],
    );
  }

  Future<void> deleteInspiration(int id) async {
    final db = await database;
    await db.delete(
      'inspirations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Operations for User
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toJson());
  }

  Future<User?> getUser(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toJson(),
      where: 'email = ?',
      whereArgs: [user.email],
    );
  }

  Future<void> deleteUser(String email) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
