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

Map<String, Future<int>> getStatistics() {
  final db = DatabaseHelper();
  Future<int> correct = db.correct;
  Future<int> attempted = db.attempted;
  Future<int> mostMisdiagnosed = db.misdiagnosed;
  Future<int> mostCorrectlyDiagnosed = db.correctDiagnosed;
  Future<int> longestStreak = db.longestStreak;
  Future<int> currentStreak = db.currentStreak;
  Future<int> storePoints = db.storePoints;

  return {
    'numCorrect': correct,
    'numAttempted': attempted,
    'mostMisdiagnosed': mostMisdiagnosed,
    'mostCorrectlyDiagnosed': mostCorrectlyDiagnosed,
    'longestStreak': longestStreak,
    'currentStreak': currentStreak,
    'storePoints': storePoints,
  };
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

class UserData {
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
}
