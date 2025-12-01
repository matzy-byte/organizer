import 'package:organizer/core/models/file.dart';
import 'package:organizer/core/repositories/file_repository.dart';

class FileService {
  final FileRepository repository;

  FileService(this.repository);

  Future<List<File>> getAllFiles() async {
    return await repository.getAllFiles();
  }

  Future<void> addFile(String name) async {
    await repository.addFile(name);
  }

  Future<void> removeFile(int id) async {
    await repository.removeFile(id);
  }

  Future<void> updateFile(int id, String name) async {
    await repository.updateFile(id, name);
  }
}
