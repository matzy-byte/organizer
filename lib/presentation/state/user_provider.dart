import 'package:flutter/material.dart';
import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService userService;
  List<User> _users = [];
  List<User> get users => _users;

  UserProvider({required this.userService});

  Future<void> loadAllUsers() async {
    _users = await getAllUsers();
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    return await userService.getAllUsers();
  }
  Future<void> addUser(String name, String color) async {
    await userService.addUser(name, color, DateTime.now());
    await loadAllUsers();
  }
  Future<void> removeUser(int id) async {
    await userService.deleteUser(id);
    await loadAllUsers();
  }
  Future<void> updateUser(int id, String name, String color) async {
    await userService.updateUser(id, name, color, DateTime.now());
    await loadAllUsers();
  }
}