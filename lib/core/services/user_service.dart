import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/repositories/user_repository.dart';

class UserService {
  final UserRepository repository;

  UserService(this.repository);

  Future<List<User>> getAllUsers() async {
    return await repository.getAllUsers();
  }

  Future<void> addUser(String name, String color, DateTime lastEdit) async {
    await repository.addUser(name, color, lastEdit);
  }

  Future<void> deleteUser(int id) async {
    await repository.deleteUser(id);
  }

  Future<void> updateUser(int id, String name, String color, DateTime lastEdit) async {
    await repository.updateUser(id, name, color, lastEdit);
  }
}
