import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_user');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);

    return database;
  }

  _onCreateDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, gender TEXT, weight DOUBLE, height DOUBLE, bmi DOUBLE, bmiSts TEXT)");
  }
}
