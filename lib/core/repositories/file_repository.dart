import 'package:organizer/core/models/file.dart';

abstract class FileRepository {
  Future<List<File>> getAllFiles();
  Future<void> addFile(String name);
  Future<void> removeFile(int id);
  Future<void> updateFile(int id, String name);
}
