import 'package:RESP2/databaseHelper.dart';

// Interfaces with database. Other parts of the app should interact with the
// SQLITE DB through the methods contained in this file.

void createUser(String name, String email) async {
  final db = DatabaseHelper();
  await db.createUser(name, email);
}

Future<Map<String, num>> getStatistics() {
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

// Type is customization category we are updating, item is asset URL of
// specific customization purchased. (e.g. mask -> assets/mask_1.png)
void setCustomization(String type, String item) async {
  final db = DatabaseHelper();
  await db.updateCustomization(type, item);
}

Future<Map<String, int>> settings() {
  final db = DatabaseHelper();
  return db.getSettings();
}

void setSoundSetting(int isSoundOn) {
  final db = DatabaseHelper();
  db.setSound(isSoundOn);
}

void setSabotageSetting(int isSabotageOn) {
  final db = DatabaseHelper();
  db.setSabotage(isSabotageOn);
}

void setEasySetting(int isEasyOn) {
    final db = DatabaseHelper();
  db.setSabotage(isEasyOn);
}

void setMediumSetting(int isMediumOn) {
    final db = DatabaseHelper();
  db.setSabotage(isMediumOn);
}

void setHardSetting(int isHardOn) {
    final db = DatabaseHelper();
  db.setSabotage(isHardOn);
}
