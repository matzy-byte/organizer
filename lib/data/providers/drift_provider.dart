import 'package:organizer/data/database/database.dart';

class DriftProvider {
  static AppDatabase? _db;

  static Future<AppDatabase> get instance async {
    _db ??= AppDatabase();
    return _db!;
  }

  static Future<void> loadDrift() async => instance;
  static Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
