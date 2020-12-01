import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /* This syntax allows user to believe they are creating an instance of class 
  when in reality they are just accessing the persistent database object */
  static DatabaseHelper _instance;
  DatabaseHelper._privateConstructor() {
    database;
  }
  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance;
  }

  // We only want to allow a single open database connection.
  static Database _database;
  // Getter for database.
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  // Opens database.
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user_data.db');
    print(path);
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database myDB, int version) async {
      // Using + to make sqlite command more readable.
      await myDB.execute('CREATE TABLE user_data(userName TEXT, numCorrect INTEGER DEFAULT 0, ' +
          'numAttempted INTEGER DEFAULT 0, numCHFMissed INTEGER DEFAULT 0, ' +
          'numCOPDMissed INTEGER DEFAULT 0, numPneumMissed INTEGER DEFAULT 0, ' +
          'numCHFCorrect INTEGER DEFAULT 0, numCOPDCorrect INTEGER DEFAULT 0, ' +
          'numPneumCorrect INTEGER DEFAULT 0, longestStreak INTEGER DEFAULT 0, ' +
          'currentStreak INTEGER DEFAULT 0, storePoints INTEGER DEFAULT 1500, ' +
          'UNIQUE(userName))');
    });
    return db;
  }

  Future<void> createUser(String name) async {
    var userMap = {
      "userName": name,
      "numCorrect": 0,
      "numAttempted": 0,
      "numCHFMissed": 0,
      "numCOPDMissed": 0,
      "numPneumMissed": 0,
      "numCHFCorrect": 0,
      "numCOPDCorrect": 0,
      "numPneumCorrect": 0,
      "longestStreak": 0,
      "currentStreak": 0,
      "storePoints": 1500,
    };

    Database db = await database;
    int id = await db.insert("user_data", userMap,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (id == -1) {
      print("ERROR IN INSERT INTO DB!");
    }
    List<Map> list = await db.rawQuery('SELECT * from user_data');
    print(list);
  }

  Future<int> get correct async {
    Database db = await database;
    List<Map> correctVar = await db.query(
      "user_data",
      columns: [
        "numCorrect",
      ],
    );
    return correctVar.first["numCorrect"];
  }

  Future<int> get attempted async {
    Database db = await database;
    List<Map> attemptedVar = await db.query(
      "user_data",
      columns: [
        "numAttempted",
      ],
    );
    return attemptedVar.first["numAttempted"];
  }

  Future<int> get misdiagnosed async {
    Database db = await database;
    List<Map> missedVals = await db.query(
      "user_data",
      columns: [
        "numCHFMissed",
        "numCOPDMissed",
        "numPneumMissed",
      ],
    );
    List<int> missed = [
      missedVals.first["numCHFMissed"],
      missedVals.first["numCOPDMissed"],
      missedVals.first["numPneumMissed"],
    ];
    // Get index of highest miss count value.
    int maxIndex = 0;
    if (missed[1] >= missed[0]) {
      maxIndex = 1;
    }
    if (missed[2] >= missed[maxIndex]) {
      maxIndex = 2;
    }
    if (missed[maxIndex] == 0) {
      // Represents no maximum yet.
      return 3;
    }
    return maxIndex;
  }

  Future<int> get correctDiagnosed async {
    Database db = await database;
    List<Map> correctVals = await db.query(
      "user_data",
      columns: [
        "numCHFCorrect",
        "numCOPDCorrect",
        "numPneumCorrect",
      ],
    );
    List<int> corrects = [
      correctVals.first["numCHFCorrect"],
      correctVals.first["numCOPDCorrect"],
      correctVals.first["numPneumCorrect"],
    ];
    // Get index of highest correct count value.
    int maxIndex = 0;
    if (corrects[1] >= corrects[0]) {
      maxIndex = 1;
    }
    if (corrects[2] >= corrects[maxIndex]) {
      maxIndex = 2;
    }
    if (corrects[maxIndex] == 0) {
      // Represents no maximum yet.
      return 3;
    }
    return maxIndex;
  }

  Future<int> get longestStreak async {
    Database db = await database;
    List<Map> streakVar = await db.query(
      "user_data",
      columns: [
        "longestStreak",
      ],
    );
    return streakVar.first["longestStreak"];
  }

  Future<int> get currentStreak async {
    Database db = await database;
    List<Map> streakVar = await db.query(
      "user_data",
      columns: [
        "currentStreak",
      ],
    );
    return streakVar.first["currentStreak"];
  }

  Future<int> get storePoints async {
    Database db = await database;
    List<Map> storePointsVar = await db.query(
      "user_data",
      columns: [
        "storePoints",
      ],
    );
    return storePointsVar.first["storePoints"];
  }

  Future<int> spendPoints(int amount) async {
    Database db = await database;
    // Amount is how many points we are decrementing storePoints.
    await db.rawUpdate(
        "UPDATE user_data SET storePoints = storePoints - ?, ", [amount]);
    List<Map> storePoints =
        await db.rawQuery("SELECT storePoints FROM user_data");
    // Returns new number of points value.
    return storePoints.first["storePoints"];
  }

  Future<Map<String, int>> getStats() async {
    return {
      'numCorrect': await correct,
      'numAttempted': await attempted,
      'mostMisdiagnosed': await misdiagnosed,
      'mostCorrectlyDiagnosed': await correctDiagnosed,
      'longestStreak': await longestStreak,
      'currentStreak': await currentStreak,
      'storePoints': await storePoints,
    };
  }

  Future<void> updateStats(
      String diagnosis, String difficulty, bool correct) async {
    Database db = await database;
    if (correct) {
      await db.rawUpdate("UPDATE user_data SET numCorrect = numCorrect + 1, " +
          "numAttempted = numAttempted + 1, " +
          "currentStreak = currentStreak + 1 ");
      if (diagnosis == "Heart failure") {
        await db.rawUpdate(
            "UPDATE user_data SET numCHFCorrect = numCHFCorrect + 1 ");
      } else if (diagnosis == "COPD") {
        await db.rawUpdate(
            "UPDATE user_data SET numCOPDCorrect = numCOPDCorrect + 1 ");
      } else if (diagnosis == "Pneumonia") {
        await db.rawUpdate(
            "UPDATE user_data SET numPneumCorrect = numPneumCorrect + 1 ");
      }
      if (difficulty == "Easy") {
        await db
            .rawUpdate("UPDATE user_data SET storePoints = storePoints + 10 ");
      } else if (difficulty == "Medium") {
        await db
            .rawUpdate("UPDATE user_data SET storePoints = storePoints + 20 ");
      } else if (difficulty == "Hard") {
        await db
            .rawUpdate("UPDATE user_data SET storePoints = storePoints + 30 ");
      }
      int streakLongest = await longestStreak;
      int streakCurrent = await currentStreak;
      if (streakCurrent > streakLongest) {
        await db.rawUpdate(
            "UPDATE user_data SET longestStreak = ? ", [currentStreak]);
      }
    } else {
      await db.rawUpdate(
          "UPDATE user_data SET numAttempted = numAttempted + 1, " +
              "currentStreak = 0");
      if (diagnosis == "Heart failure") {
        await db
            .rawUpdate("UPDATE user_data SET numCHFMissed = numCHFMissed + 1 ");
      } else if (diagnosis == "COPD") {
        await db.rawUpdate(
            "UPDATE user_data SET numCOPDMissed = numCOPDMissed + 1 ");
      } else if (diagnosis == "Pneumonia") {
        await db.rawUpdate(
            "UPDATE user_data SET numPneumMissed = numPneumMissed + 1 ");
      }
    }
  }
}
