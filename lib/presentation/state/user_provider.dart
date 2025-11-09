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
  Future<void> addUser(String name) async {
    await userService.addUser(name);
    await loadAllUsers();
  }
  Future<void> removeUser(int id) async {
    await userService.removeUser(id);
    await loadAllUsers();
  }
  Future<void> updateUser(int id, String name) async {
    await userService.updateUser(id, name);
    await loadAllUsers();
  }
}