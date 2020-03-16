import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:want_attention_app1/models/hEntry.dart';

class DatabaseHelper {
  static DatabaseHelper
      _databaseHelper; //Singleton Databasehelper (only one instance will exist when the app is running)
  static Database _database; //Singleton Database

  String hEntryTable = 'note_Table';
  String colId = 'id';
  String colName = 'name';
  String colDate = 'date';
  String colDuration = 'duration';
  String colScore = 'score';

  DatabaseHelper._createInstance(); //Named constuctor to create instance of DatabaseHelper

  //when constructor is called with "factory" it can return a value
  factory DatabaseHelper() {
    if (_databaseHelper != null) {
      _databaseHelper = DatabaseHelper._createInstance(); //This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //get the directory path for both android and ios to store a database
    Directory directory = await getApplicationDocumentsDirectory(); //await because the directory is passed as a 'Future' type
    String path = directory.path + 'hEntry.db';

    //open/create the database at a given path
    var hEntryDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return hEntryDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $hEntryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDate TEXT,'
        '$colDuration TEXT, $colScore DOUBLE)'); //the above is just a regular SQL-statement
  }


  //Fetch Operation: Get all hEntry objects from database
  Future<List<Map<String, dynamic>>>getHEntryMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $hEntryTable order by $colId ASC');
    return result;
    // this is the same as above: var result = await db.query(hEntryTable, orderBy: '$colId ASC'); //but the above is in raw sql
  }

  //Insert Operation: Insert a hEntry object into database
  Future<int> insertHEntry(hEntry entry) async {
    Database db = await this.database;
    var result = await db.insert(hEntryTable, entry.toMap());
    return result;
  }

  //Update Operation: Update a hEntry object into database
  Future<int>updateHEntry(hEntry entry) async {
    Database db = await this.database;
    var result = await db.update(hEntryTable, entry.toMap(), where: '$colId = ?', whereArgs: [entry.id]);
    return result;
  }

  //Delete Operation: Delete a note object from database
  Future<int> deleteHEntry(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $hEntryTable WHERE $colId = $id');
    return result;
  }

  //Get number of hEntry objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $hEntryTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


  //Get the 'MapList' [List<Map> ] and convert it to 'hEntry List' [ List<hEntry> ]
  Future<List<hEntry>> getHEntryList() async {
    var hEntryMapList = await getHEntryMapList(); //get map list from database
    int count = hEntryMapList.length;             //count the number of map entries in db table

    List<hEntry> hEntryList = List<hEntry>();
    //'for-loop' to create a 'Note List' from a 'Map List'
    for(int i = 0; i < count; i++){
      hEntryList.add(hEntry.fromMapObject(hEntryMapList[i]));
    }

    return hEntryList;
  }



}
