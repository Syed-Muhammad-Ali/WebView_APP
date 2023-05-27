// ignore_for_file: unused_field, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String addLinkTable = 'addLink';

  static Future<void> initDb() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'URL.db');

      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $addLinkTable(id INTEGER PRIMARY KEY AUTOINCREMENT,url TEXT)",
        );
      });
    } catch (e) {
      debugPrint('create db error :${e.toString()}');
    }
  }

  static Future<int> insert(dynamic modelData, String tablename) async {
    print("------------ is in 2nd");
    return await _db!.insert(tablename, modelData!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query(String tablename) async {
    print("------------ is in 5th");
    return _db!.query(tablename);
  }
}
