import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DatabaseConnectorInterface.dart';
import '../data_types/Activity.dart';
import '../data_types/Timeslot.dart';
import '../data_types/ActivityCategory.dart';
import 'dart:async';
import 'package:logger/logger.dart';

class DatabaseConnector implements DatabaseConnectorInterface {
  DatabaseConnector();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<void> removeDatabase() async {
    var logger = Logger();
    logger.d("removeDatabase() called");
    String path = join(await getDatabasesPath(), 'timetracking.db');
    logger.d("Deleting database $path");
    await deleteDatabase(path);
    logger.d("Deleted database");
}

  _initDatabase() async {
    var logger = Logger();
    logger.d("_initDatabase() called");
    // Set path to database
    String path = join(await getDatabasesPath(), 'timetracking.db');
    logger.d("Database path is $path");
    logger.d("Returning database");
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Contains the code to set up the tables
    var logger = Logger();
    logger.d("_onCreate() called");
    await db.execute('''
        CREATE TABLE timeslot(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        start DATETIME NOT NULL, 
        end DATETIME NOT NULL); 
        ''');
    logger.d("Table timeslot created");

    await db.execute('''
        CREATE TABLE activity_category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(255) NOT NULL,
        color_name VARCHAR(255) DEFAULT "grey");
        ''');
    logger.d("Table activity_category created");

    await db.execute('''
        CREATE TABLE activity(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(255) NOT NULL,
        category_id int,
        FOREIGN KEY(category_id) REFERENCES activity_category(id));
        ''');
    logger.d("Table activity created");

    await db.execute('''
        CREATE TABLE timeslot_activity(
        timeslot_id INTEGER,
        activity_id INTEGER,
        FOREIGN KEY(timeslot_id) REFERENCES timeslot(id),
        FOREIGN KEY(activity_id) REFERENCES activity(id));
        ''');

    logger.d("Table timeslot_activity created");
    logger.d("Tables created");

  }

  Future<void> insertActivity(Activity activity) async {
    // Inserts a row into the activity table
    // Return value is id of inserted row
    final Database db = await database;

    await db.insert(
      'activity',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTimeslot(Timeslot timeslot) async {
    final Database db = await database;

    await db.insert(
      'timeslot',
      timeslot.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertActivityCategory(ActivityCategory category) async {
    final Database db = await database;

    await db.insert(
      'activity_category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Activity>> getActivities() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activity');

    return List.generate(maps.length, (i) {
      return Activity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
      );
    });
  }

  Future<List<Timeslot>> getTimeslots(DateTime start, DateTime end) async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.rawQuery(
    '''
    SELECT * FROM timeslot WHERE
    start GREATER THAN ? AND
    end LESS THAN ?;
    ''',  [start, end]
    );

    return List.generate(maps.length, (i) {
      return Timeslot(
        id: maps[i]['id'],
        start: maps[i]['start'],
        end: maps[i]['end'],
        activity: maps[i]['activity']
      );
    });
  }

  Future<List<ActivityCategory>> getActivityCategories() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('activity_category');

    return List.generate(maps.length, (i) {
      return ActivityCategory(
        id: maps[i]['id'],
        name: maps[i]['name'],
        colorName: maps[i]['colorName'],
      );
    });
  }

  Future<void> updateActivity(Activity activity) async {
    final Database db = await database;

    await db.update(
      'activity',
      activity.toMap(),
      where: "id = ?",
      whereArgs: [activity.getId],
    );
  }

  Future<void> updateTimeslot(Timeslot timeslot) async {
    final Database db = await database;

    await db.update(
      'timeslot',
      timeslot.toMap(),
      where: "id = ?",
      whereArgs: [timeslot.getId],
    );
  }

  Future<void> updateActivityCategory(ActivityCategory category) async {
    final Database db = await database;

    await db.update(
      'activity_category',
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.getId],
    );
  }

  Future<void> deleteActivity(Activity activity) async {
    final Database db = await database;

    await db.delete(
      'activity',
      where: "id = ?",
      whereArgs: [activity.getId],
    );
  }

  Future<void> deleteActivityCategory(ActivityCategory category) async {
    final Database db = await database;

    await db.delete(
      'activity_category',
      where: "id = ?",
      whereArgs: [category.getId],
    );
  }

  Future<void> deleteTimeslot(Timeslot timeslot) async {
    final Database db = await database;

    await db.delete(
      'timeslot',
      where: "id = ?",
      whereArgs: [timeslot.getId],
    );
  }

}
