import 'package:isar/isar.dart';
import 'package:organizer/data/models/category_isar.dart';
import 'package:organizer/data/models/fix_transaction_isar.dart';
import 'package:organizer/data/models/topic_isar.dart';
import 'package:organizer/data/models/var_transaction_isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarProvider {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        CategoryIsarSchema,
        TopicIsarSchema,
        FixTransactionIsarSchema,
        VarTransactionIsarSchema
      ],
      directory: dir.path,
    );
    return _isar!;
  }

  static Future<void> loadIsar() async {
    await instance;
  }

  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}