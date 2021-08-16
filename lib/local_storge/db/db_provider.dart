import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();
  late final Database _database;

  factory DBProvider() {
    return _instance;
  }

  DBProvider._internal();

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_database.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE cart ('
            'product_id INTEGER,'
            'name_en TEXT,'
            'name_ar TEXT,'
            'info_en TEXT,'
            'info_ar TEXT,'
            'price INTEGER,'
            'quantity INTEGER,'
            'image_url TEXT,'
            'is_favorite TEXT,'
            'product_rate NUMERIC,'
            'overal_rate NUMERIC,'
            'sub_category_id TEXT,'
            ')');


      },

      // overalRate = data['overal_rate'];
        // subCategoryId = data['sub_category_id'];
        // productRate = data['product_rate'];
        // offerPrice = data['offer_price'];
        // isFavorite = data['is_favorite'];

      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
