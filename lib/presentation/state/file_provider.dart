import 'package:flutter/material.dart';
import 'package:organizer/core/models/file.dart';
import 'package:organizer/core/services/file_service.dart';

class FileProvider with ChangeNotifier {
  final FileService fileService;

  FileProvider({required this.fileService});

  Future<List<File>> getAllFiles() async {
    return await fileService.getAllFiles();
  }
  Future<void> addFile(String name) async {
    await fileService.addFile(name);
  }
  Future<void> removeFile(int id) async {
    await fileService.removeFile(id);
  }
  Future<void> updateFile(int id, String name) async {
    await fileService.updateFile(id, name);
  }
}