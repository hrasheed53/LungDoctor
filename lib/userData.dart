import 'package:RESP2/databaseHelper.dart';

// Interfaces with database.

/* Future<String> changeName(String newName) async {
  // Get a reference to the database.
  final db = DatabaseHelper();
  db.updateName(userName, newName);
} */

void createUser(String name) async {
  final db = DatabaseHelper();
  //db.createUser(name).then((_val) => {});
  await db.createUser(name);
}

Future<Map<String, int>> getStatistics() {
  final db = DatabaseHelper();
  /* for most correct and incorrect diagnosed:
  0 - CHF
  1 - COPD
  2 - PNUEMONIA
  */
  return db.getStats();
}

void updateStatistics(
    String diagnosisAnswer, String difficultyLevel, bool correctVal) {
  final db = DatabaseHelper();
  db.updateStats(diagnosisAnswer, difficultyLevel, correctVal);
}

int spendPoints(int amount) {
  final db = DatabaseHelper();
  int newPointsVal;
  db.spendPoints(amount).then((value) => newPointsVal = value);
  return newPointsVal;
}

Future<int> getStorePoints() {
  final db = DatabaseHelper();
  //int storePointsVal;
  //db.storePoints.then((value) => storePointsVal = value);
  //return storePointsVal;
  return db.storePoints;
}

/*class UserData {
  String userName;
  int numCorrect;
  int numAttempted;
  int numCHFMissed;
  int numCOPDMissed;
  int numPneumMissed;
  int numCHFCorrect;
  int numCOPDCorrect;
  int numPneumCorrect;
  int longestStreak;
  int currentStreak;
  int storePoints;

  UserData(this.userName);

  Map<String, int> toMap() {
    return {
      'numCorrect': numCorrect,
      'numAttempted': numAttempted,
      'numCHFMissed': numCHFMissed,
      'numCOPDMissed': numCOPDMissed,
      'numPneumMissed': numPneumMissed,
      'numCHFCorrect': numCHFCorrect,
      'numCOPDCorrect': numCOPDCorrect,
      'numPneumCorrect': numPneumCorrect,
      'longestStreak': longestStreak,
      'currentStreak': currentStreak,
      'storePoints': storePoints,
    };
  }
}*/
