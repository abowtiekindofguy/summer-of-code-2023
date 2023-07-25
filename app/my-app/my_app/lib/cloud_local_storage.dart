import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'package:path/path.dart';

final database =
      openDatabase(join(getDatabasesPath().toString(), 'local_store.db'),
      onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE items(id TEXT PRIMARY KEY, type TEXT)',
    );
  },
  version: 1,
  );

Future<void> insertDog(LocalItem item) async {
    final db = await database;
    await db.insert(
      item.type,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


Future<List<LocalItem>> dogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return LocalItem(
        id: maps[i]['id'],
        type: maps[i]['type']
      );
    });
  }


  Future<void> deleteDog(String id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

class LocalItem {
  final String id;
  final String type;
  const LocalItem({
    required this.id,
    required this.type,
  });
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'LocalItem{id: $id, type: $type}';
  }
}
