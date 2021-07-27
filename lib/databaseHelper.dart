import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// IMPORTANT: Other parts of the app should interact with the SQLITE DB through
// the functions found in userData.dart.

class DatabaseHelper {
  // this is the email of whoever is logged in
  static String currentEmail;

  // update as database needs to be upgraded
  static const int DATABASE_VERSION = 3;

  // add more list items as database updates are added
  static const migrationScripts = [
    // UPDATE 0 - NOTHING, CREATION OF DB IS FIRST CREATION
    // Put empty item here to allow indices to work correctly in _onUpgrade.
    '',
    // UPDATE 1 - ACCURACY WAS ADDED
    'ALTER TABLE user_data ADD COLUMN accuracy INTEGER DEFAULT 0;',

    // UPDATE 2  - CASE DIFFICULTY TOGGLES ADDED
    'ALTER TABLE user_data ADD COLUMN easyOn INTEGER DEFAULT 1; ' +
        'ALTER TABLE user_data ADD COLUMN mediumOn INTEGER DEFAULT 1; ' +
        'ALTER TABLE user_data ADD COLUMN hardOn INTEGER DEFAULT 1;',
  ];

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

  _onCreate(Database myDB, int version) async {
    // Using + to make sqlite command more readable.
    // Make sure to update onCreate as database is updated, new users will
    // have whatever version of the database is created here.
    await myDB.execute('CREATE TABLE user_data(' +
        'email TEXT PRIMARY KEY, ' +
        'userName TEXT, ' +
        'numCorrect INTEGER DEFAULT 0, ' +
        'numAttempted INTEGER DEFAULT 0, ' +
        'numCHFMissed INTEGER DEFAULT 0, ' +
        'numCOPDMissed INTEGER DEFAULT 0, ' +
        'numPneumMissed INTEGER DEFAULT 0, ' +
        'numCHFCorrect INTEGER DEFAULT 0, ' +
        'numCOPDCorrect INTEGER DEFAULT 0, ' +
        'numPneumCorrect INTEGER DEFAULT 0, ' +
        'longestStreak INTEGER DEFAULT 0, ' +
        'currentStreak INTEGER DEFAULT 0, ' +
        'storePoints INTEGER DEFAULT 1500, ' +
        'accuracy INTEGER DEFAULT 0, ' +
        'background TEXT, ' +
        'hatAccessory TEXT, ' +
        'headband TEXT, ' +
        'labCoatColor TEXT, ' +
        'mask TEXT, ' +
        'pet TEXT, ' +
        'stethoscope TEXT, ' +
        'soundOn INTEGER DEFAULT 1, ' +
        'sabotageOn INTEGER DEFAULT 1, ' +
        'easyOn INTEGER DEFAULT 1, ' +
        'mediumOn INTEGER DEFAULT 1, ' +
        'hardOn INTEGER DEFAULT 1, ' +
        'UNIQUE(email))');
  }

  _onUpgrade(Database myDB, int oldVersion, int newVersion) async {
    print('Upgrading Database');
    switch (oldVersion) {
      case 1:
        {
          assert(newVersion == 2);
          // upgrading from version 1 to version 2
          // because list is zero indexed but versions are not, subtract one
          try {
            await myDB.execute(migrationScripts[newVersion - 1]);
          } catch (e) {
            print('Column already exists: $e');
          }
          setAccuracy(myDB);
        }
        break;
      case 2:
        {
          assert(newVersion == 3);
          // upgrading from version 2 to version 3
          // because list is zero indexed but versions are not, subtract one
          try {
            await myDB.execute(migrationScripts[newVersion - 1]);
          } catch (e) {
            print('Column already exists: $e');
          }
        }
        break;
      default:
        {
          print('This migration is not supported. Please make necessary ' +
              'changes to codebase.');
        }
    }
  }

  _onDowngrade(Database myDB, int oldVersion, int newVersion) async {
    // can be customized for development/testing purposes
  }

  // Opens database.
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user_data.db');
    print("database path $path");
    Database db = await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
    print("Current version of db: $DATABASE_VERSION");
    return db;
  }

  Future<void> createUser(String name, String email) async {
    // Sound effects and sabotage man initialized to ON!
    Map<String, dynamic> userMap = {
      "email": email,
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
      "accuracy": 0,
      "background": "none",
      "hatAccessory": "none",
      "headband": "none",
      "labCoatColor": "none",
      "mask": "none",
      "pet": "none",
      "stethoscope": "none",
      "soundOn": 1,
      "sabotageOn": 1,
      "easyOn": 1,
      "mediumOn": 1,
      "hardOn": 1,
    };

    Database db = await database;

    // Setting ConflictAlgorithm.ignore means no overwrite if user already exists.
    int id = await db.insert("user_data", userMap,
        conflictAlgorithm: ConflictAlgorithm.ignore);

    assert(id != -1);
    currentEmail = email;

    List<Map> list = await db.rawQuery('SELECT * from user_data');
    print("all user data $list");

    return;
  }

  Future<int> get correct async {
    Database db = await database;
    List<Map> correctVar = await db.query("user_data",
        columns: [
          "numCorrect",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return correctVar.first["numCorrect"];
  }

  Future<int> get attempted async {
    Database db = await database;
    List<Map> attemptedVar = await db.query("user_data",
        columns: [
          "numAttempted",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return attemptedVar.first["numAttempted"];
  }

  Future<int> get accuracy async {
    Database db = await database;
    List<Map> accuracyVar = await db.query("user_data",
        columns: [
          "accuracy",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return accuracyVar.first["accuracy"];
  }

  Future<void> setAccuracy(var myDatabase) async {
    int accuracyUpdate = 0;
    if (await attempted != 0) {
      accuracyUpdate = ((await correct / await attempted) * 100).round();
    }
    print(accuracyUpdate);
    await myDatabase.rawUpdate(
        "UPDATE user_data SET accuracy = ? WHERE email = ?",
        [accuracyUpdate, currentEmail]);
  }

  Future<int> get misdiagnosed async {
    Database db = await database;
    List<Map> missedVals = await db.query("user_data",
        columns: [
          "numCHFMissed",
          "numCOPDMissed",
          "numPneumMissed",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
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
    List<Map> correctVals = await db.query("user_data",
        columns: [
          "numCHFCorrect",
          "numCOPDCorrect",
          "numPneumCorrect",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
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
    List<Map> streakVar = await db.query("user_data",
        columns: [
          "longestStreak",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return streakVar.first["longestStreak"];
  }

  Future<int> get currentStreak async {
    Database db = await database;
    List<Map> streakVar = await db.query("user_data",
        columns: [
          "currentStreak",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return streakVar.first["currentStreak"];
  }

  Future<int> get storePoints async {
    Database db = await database;
    List<Map> storePointsVar = await db.query("user_data",
        columns: [
          "storePoints",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return storePointsVar.first["storePoints"];
  }

  Future<String> get name async {
    Database db = await database;
    List<Map> nameVar = await db.query("user_data",
        columns: ["userName"], where: 'email = ?', whereArgs: [currentEmail]);
    return nameVar.first["userName"];
  }

  Future<int> get sound async {
    Database db = await database;
    List<Map> soundVar = await db.query("user_data",
        columns: ["soundOn"], where: 'email = ?', whereArgs: [currentEmail]);
    return soundVar.first["soundOn"];
  }

  Future<int> get sabotage async {
    Database db = await database;
    List<Map> sabotageVar = await db.query("user_data",
        columns: ["sabotageOn"], where: 'email = ?', whereArgs: [currentEmail]);
    return sabotageVar.first["sabotageOn"];
  }

  Future<int> get easy async {
    Database db = await database;
    List<Map> sabotageVar = await db.query("user_data",
        columns: ["easyOn"], where: 'email = ?', whereArgs: [currentEmail]);
    return sabotageVar.first["easyOn"];
  }

  Future<int> get medium async {
    Database db = await database;
    List<Map> sabotageVar = await db.query("user_data",
        columns: ["mediumOn"], where: 'email = ?', whereArgs: [currentEmail]);
    return sabotageVar.first["mediumOn"];
  }

  Future<int> get hard async {
    Database db = await database;
    List<Map> sabotageVar = await db.query("user_data",
        columns: ["hardOn"], where: 'email = ?', whereArgs: [currentEmail]);
    return sabotageVar.first["hardOn"];
  }

  Future<void> setSound(int isSoundOn) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET soundOn = ? WHERE email = ?",
        [isSoundOn, currentEmail]);
    return;
  }

  Future<void> setSabotage(int isSabotageOn) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET sabotageOn = ? WHERE email = ?",
        [isSabotageOn, currentEmail]);
    return;
  }

  Future<void> setEasy(int isEasyOn) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET sabotageOn = ? WHERE email = ?",
        [isEasyOn, currentEmail]);
    return;
  }

  Future<void> setMedium(int isMediumOn) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET sabotageOn = ? WHERE email = ?",
        [isMediumOn, currentEmail]);
    return;
  }

  Future<void> setHard(int isHardOn) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET sabotageOn = ? WHERE email = ?",
        [isHardOn, currentEmail]);
    return;
  }

  Future<int> spendPoints(int amount) async {
    Database db = await database;
    // Amount is how many points we are decrementing storePoints.
    await db.rawUpdate(
        "UPDATE user_data SET storePoints = storePoints - ? WHERE email = ?",
        [amount, currentEmail]);
    List<Map> storePoints =
        await db.rawQuery("SELECT storePoints FROM user_data");
    // Returns new number of points value.
    return storePoints.first["storePoints"];
  }

  // num can handle doubles and ints for scalability in future
  Future<Map<String, num>> getStats() async {
    return {
      'numCorrect': await correct,
      'numAttempted': await attempted,
      'mostMisdiagnosed': await misdiagnosed,
      'mostCorrectlyDiagnosed': await correctDiagnosed,
      'longestStreak': await longestStreak,
      'currentStreak': await currentStreak,
      'storePoints': await storePoints,
      'accuracy': await accuracy,
    };
  }

  Future<Map<String, int>> getSettings() async {
    return {
      'soundSetting': await sound,
      'sabotageSetting': await sabotage,
      'easySetting': await easy,
      'mediumSetting': await medium,
      'hardSetting': await hard,
    };
  }

  Future<String> updateName(newName) async {
    Database db = await database;
    await db.rawUpdate("UPDATE user_data SET userName = ? WHERE email = ?",
        [newName, currentEmail]);
    List<Map> name = await db.rawQuery(
        "SELECT userName FROM user_data WHERE email = ?", [currentEmail]);
    return name.first["userName"];
  }

  Future<void> updateCustomization(customizationType, customizationItem) async {
    Database db = await database;
    if (customizationType == "background") {
      await db.rawUpdate("UPDATE user_data SET background = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "hatAccessory") {
      await db.rawUpdate(
          "UPDATE user_data SET hatAccessory = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "headband") {
      await db.rawUpdate("UPDATE user_data SET headband = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "labCoatColor") {
      await db.rawUpdate(
          "UPDATE user_data SET labCoatColor = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "mask") {
      await db.rawUpdate("UPDATE user_data SET mask = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "pet") {
      await db.rawUpdate("UPDATE user_data SET pet = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    } else if (customizationType == "stethoscope") {
      await db.rawUpdate("UPDATE user_data SET stethoscope = ? WHERE email = ?",
          [customizationItem, currentEmail]);
    }
    return;
  }

  Future<Map<String, dynamic>> getCustomizations() async {
    Database db = await database;
    var customizations = await db.query("user_data",
        columns: [
          "background",
          "hatAccessory",
          "headband",
          "labCoatColor",
          "mask",
          "pet",
          "stethoscope",
        ],
        where: 'email = ?',
        whereArgs: [currentEmail]);
    return customizations.first;
  }

  Future<void> updateStats(
      String diagnosis, String difficulty, bool isCorrect) async {
    Database db = await database;
    if (isCorrect) {
      await db.rawUpdate(
          "UPDATE user_data SET numCorrect = numCorrect + 1, " +
              "numAttempted = numAttempted + 1, " +
              "currentStreak = currentStreak + 1 WHERE email = ?",
          [currentEmail]);
      if (diagnosis == "CHF") {
        await db.rawUpdate(
            "UPDATE user_data SET numCHFCorrect = numCHFCorrect + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (diagnosis == "COPD") {
        await db.rawUpdate(
            "UPDATE user_data SET numCOPDCorrect = numCOPDCorrect + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (diagnosis == "PNEUMONIA") {
        await db.rawUpdate(
            "UPDATE user_data SET numPneumCorrect = numPneumCorrect + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      }
      if (difficulty == "Easy") {
        await db.rawUpdate(
            "UPDATE user_data SET storePoints = storePoints + 10 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (difficulty == "Medium") {
        await db.rawUpdate(
            "UPDATE user_data SET storePoints = storePoints + 20 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (difficulty == "Hard") {
        await db.rawUpdate(
            "UPDATE user_data SET storePoints = storePoints + 30 " +
                "WHERE email = ?",
            [currentEmail]);
      }
      int streakLongest = await longestStreak;
      int streakCurrent = await currentStreak;
      var newStreak = streakCurrent;
      if (streakCurrent > streakLongest) {
        await db.rawUpdate(
            "UPDATE user_data SET longestStreak = ? WHERE email = ?",
            [newStreak, currentEmail]);
      }
    } else {
      await db.rawUpdate(
          "UPDATE user_data SET numAttempted = numAttempted + 1, " +
              "currentStreak = 0 WHERE email = ?",
          [currentEmail]);
      if (diagnosis == "CHF") {
        await db.rawUpdate(
            "UPDATE user_data SET numCHFMissed = numCHFMissed + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (diagnosis == "COPD") {
        await db.rawUpdate(
            "UPDATE user_data SET numCOPDMissed = numCOPDMissed + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      } else if (diagnosis == "PNEUMONIA") {
        await db.rawUpdate(
            "UPDATE user_data SET numPneumMissed = numPneumMissed + 1 " +
                "WHERE email = ?",
            [currentEmail]);
      }
    }

    setAccuracy(db);

    var updated = await db.rawQuery('SELECT * FROM user_data');
    print("updated user data $updated");
  }
}
