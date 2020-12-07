import 'package:RESP2/databaseHelper.dart';

// Interfaces with database.

void createUser(String name, String email) async {
  final db = DatabaseHelper();
  await db.createUser(name, email);
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

Future<String> getName() {
  final db = DatabaseHelper();
  return db.name;
}

Future<String> changeName(String newName) async {
  final db = DatabaseHelper();
  db.updateName(newName);
  return newName;
}

Future<Map<String, dynamic>> getCustomizations() {
  final db = DatabaseHelper();
  return db.getCustomizations();
}

Future<int> getSoundSetting() async {
  final db = DatabaseHelper();
  return db.sound;
}

Future<int> getSabotageSetting() async {
  final db = DatabaseHelper();
  return db.sabotage;
}

void setSoundSetting(int isSoundOn) async {
  final db = DatabaseHelper();
  await db.setSound(isSoundOn);
}

void setSabotageSetting(int isSabotageOn) async {
  final db = DatabaseHelper();
  await db.setSabotage(isSabotageOn);
}
