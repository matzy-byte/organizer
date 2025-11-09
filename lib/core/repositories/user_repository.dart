import 'package:organizer/core/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<void> addUser(String name);
  Future<void> removeUser(int id);
  Future<void> updateUser(int id, String name);
}
