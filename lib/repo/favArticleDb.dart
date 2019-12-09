import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final favArticleTABLE = 'favarticle';

class FavArticleDatabaseProvider {
  static final FavArticleDatabaseProvider dbProvider =
      FavArticleDatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favarticle.db');
    var database = await openDatabase(path, version: 1, onCreate: initDB);
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute(
        'CREATE TABLE $favArticleTABLE (id INTEGER PRIMARY KEY, title TEXT, content TEXT, image TEXT, video TEXT, author TEXT, avatar TEXT, category TEXT, date TEXT, link TEXT, catId INTEGER)');
  }
}
