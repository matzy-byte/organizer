import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/repositories/user_repository.dart';

class UserService {
  final UserRepository repository;

  UserService(this.repository);

  Future<List<User>> getAllUsers() async {
    return await repository.getAllUsers();
  }

  Future<void> addUser(String name) async {
    await repository.addUser(name);
  }

  Future<void> removeUser(int id) async {
    await repository.removeUser(id);
  }

  Future<void> updateUser(int id, String name) async {
    await repository.updateUser(id, name);
  }
}
