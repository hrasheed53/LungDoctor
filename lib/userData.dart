import 'package:RESP2/databaseHelper.dart';

// Interfaces with database.

/* Future<String> changeName(String newName) async {
  // Get a reference to the database.
  final db = DatabaseHelper();
  db.updateName(userName, newName);
} */

void createUser(String name) {
  final db = DatabaseHelper();
  db.createUser(name).then((_val) => {});
}

Map<String, int> getStatistics() {
  final db = DatabaseHelper();
  int correct;
  db.correct.then((value) => correct = value);
  int attempted;
  db.attempted.then((value) => attempted = value);
  int mostMisdiagnosed;
  db.misdiagnosed.then((value) => mostMisdiagnosed = value);
  int mostCorrectlyDiagnosed;
  db.correctDiagnosed.then((value) => mostCorrectlyDiagnosed = value);
  int longestStreak;
  db.longestStreak.then((value) => longestStreak = value);
  int currentStreak;
  db.currentStreak.then((value) => currentStreak = value);
  int score;
  db.score.then((value) => score = value);

  return {
    'numCorrect': correct,
    'numAttempted': attempted,
    'mostMisdiagnosed': mostMisdiagnosed,
    'mostCorrectlyDiagnosed': mostCorrectlyDiagnosed,
    'longestStreak': longestStreak,
    'currentStreak': currentStreak,
    'score': score,
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
  int score;

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
    };
  }
}
