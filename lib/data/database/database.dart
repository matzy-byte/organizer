import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:organizer/data/database/tables/categories.dart';
import 'package:organizer/data/database/tables/fix_transactions.dart';
import 'package:organizer/data/database/tables/topics.dart';
import 'package:organizer/data/database/tables/var_transactions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/interval_unit.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Categories, Topics, FixTransactions, VarTransactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> deleteAllData() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'organizer.db');
    print(path);
    return NativeDatabase(File(path));
  });
}
