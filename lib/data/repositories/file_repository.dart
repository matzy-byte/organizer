import 'package:drift/drift.dart';
import 'package:organizer/core/models/file.dart';
import 'package:organizer/core/repositories/file_repository.dart';
import 'package:organizer/data/database/database.dart' hide File;

class FileRepositoryDrift extends FileRepository {
  final AppDatabase db;
  FileRepositoryDrift(this.db);

  @override
  Future<void> addFile(String path) async {
    await db.into(db.files).insert(FilesCompanion.insert(path: path));
  }

  @override
  Future<List<File>> getAllFiles() async {
    final rows = await (db.select(db.files)).get();
    return rows.map((t) => File(id: t.id, path: t.path)).toList();
  }

  @override
  Future<void> removeFile(int id) async {
    await (db.delete(db.files)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> updateFile(int id, String path) async {
    await (db.update(db.files)..where((t) => t.id.equals(id))).write(
      FilesCompanion(id: Value(id), path: Value(path)),
    );
  }
}
