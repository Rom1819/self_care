import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();

    return _database;
  }

  //  Insert data into table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //  Read data from table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id = ?', whereArgs: [itemId]);
  }

  updateUser(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
}
