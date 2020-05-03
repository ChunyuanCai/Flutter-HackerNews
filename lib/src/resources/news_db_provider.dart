import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDBProvider implements Source, Cache {
  Database db;

  NewsDBProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "item.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
              CREATE TABLE Items
                ( 
                  id INTEGER PRIMARY KEY,
                  deleted INTEGER,
                  type TEXT,
                  by TEXT,
                  time INTEGER,
                  text TEXT,
                  dead INTEGER,
                  parent INTEGER,
                  kids BLOB,
                  url TEXT,
                  score = INTEGER,
                  title TEXT,
                  descendants TEXT
                )
          """);
    });
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDB(maps.first);
    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMap());
  }
}

final NewsDBProvider newsDBProvider = NewsDBProvider();
