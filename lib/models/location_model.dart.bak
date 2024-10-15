import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static final String _databaseName = "location.db";
  static final int _databaseVersion = 1;

  Database _database;

  Future<void> open() async {
    _database = await openDatabase(_databaseName, _databaseVersion,
        onCreate: (db, version) async {
      await db.execute("""
        CREATE TABLE location (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          region TEXT NOT NULL,
          countryCode TEXT,
          carrier TEXT,
          numberType TEXT,
          isLocalNumber INTEGER NOT NULL,
          phone_number TEXT NOT NULL
        )
      """);
    });
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<LocationData> insertLocation(LocationData location) async {
    await _database.insert("location", location.toMap());
    return location;
  }

  Future<List<LocationData>> getAllLocations() async {
    final List<Map<String, dynamic>> maps = await _database.query("location");
    return maps.map((map) => LocationData.fromMap(map)).toList();
  }

  Future<void> deleteLocation(int id) async {
    await _database.delete("location", where: "id = ?", whereArgs: [id]);
  }
}

class LocationData {
  final int id;
  final String region;
  final String countryCode;
  final String carrier;
  final String numberType;
  final bool isLocalNumber;
  final String phoneNumber;

  LocationData({
    this.id,
    required this.region,
    this.countryCode,
    required this.carrier,
    this.numberType,
    required this.isLocalNumber,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      "region": region,
      "countryCode": countryCode,
      "carrier": carrier,
      "numberType": numberType,
      "is_local_number": isLocalNumber ? 1 : 0,
      "phone_number": phoneNumber,
    };
  }

  static LocationData fromMap(Map<String, dynamic> map) {
    return LocationData(
      id: map["id"],
      region: map["region"],
      countryCode: map["countryCode"],
      carrier: map["carrier"],
      numberType: map["numberType"],
      isLocalNumber: map["is_local_number"] == 1,
      phoneNumber: map["phone_number"],
    );
  }
}
