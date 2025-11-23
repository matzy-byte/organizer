import 'package:organizer/core/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<void> addUser(String name, String color);
  Future<void> removeUser(int id);
  Future<void> updateUser(int id, String name, String color);
}
