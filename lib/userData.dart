import 'package:RESP2/databaseHelper.dart';

// Interfaces with database.

void createUser(String name) async {
  final db = DatabaseHelper();
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

Future<int> spendPoints(int amount) {
  final db = DatabaseHelper();
  return db.spendPoints(amount);
}

Future<int> getStorePoints() {
  final db = DatabaseHelper();
  return db.storePoints;
}

// THIS COULD CAUSE ISSUE B/C NAME CHANGES WON'T MATCH WHEN LOGGING IN WITH OLD NAME
// POSSIBLE FIX - HAVE OG/LOGIN NAME OR EMAIL IN DB AND THEN DISPLAY NAME SEPARATELY?
Future<String> changeName(String newName) async {
  // Get a reference to the database.
  final db = DatabaseHelper();
  db.updateName(userName, newName);
  return newName;
}
